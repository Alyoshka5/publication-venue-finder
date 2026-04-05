# Feature: Recommender Algorithm implementation
# Version: v01.1
# Authors: Group 42 CMPT 354 Spring 2026

# Four Phase Pipeline: 
# LightFM-inspired hybrid algorithm: 
#  1. Connection: Same as database.ts but python
#  2. Data loading: Set up PDs dataframes
#       a) Pull venues/topics/interact hist
#  3. Algorithm (LightFM-inspired); via Scikit
#  4. Return ranked JSON (Flask endpoint)

# (1) Connect
# Import libraries
from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector
import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.preprocessing import MultiLabelBinarizer

# Flask app (like Express but all app.ts/venue.ts/controllers are minimized out of view)
# CORS again **MIGHT** need to change with Auth?
app = Flask(__name__)
CORS(app)

# Exactly like mysql.createPool but a fresh connection is created for every
# request --> we don't need to request frequently to update recommendations when 
# a user visits the page. 
# If we want to add a pool later we could but this should perform fine
def get_db():
    return mysql.connector.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="root",
        database="publication_venue_finder_db"
    )

# 2. Load + set up pandas
# Pandas is just the ML way of storing and parsing data if y'all are new

def load_venue_topics():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    
    # Collect venue instances + topics associated with each
    cursor.execute("""
            SELECT
                vi.SeriesID,
                vi.Year,
                vs.Acronym, 
                vs.Name as SeriesName,
                GROUP_CONCAT(DISTINCT t.Name ORDER BY t.Name SEPARATOR '|') as topics
            FROM VENUE_INSTANCE vi
            JOIN VENUE_SERIES vs ON vs.SeriesID = vi.SeriesID
            LEFT JOIN (
                SELECT itw.SeriesID, itw.Year, t.Name
                FROM INSTANCE_TAGGED_WITH itw
                JOIN TOPIC t ON t.TopicID = itw.TopicID
                UNION
                SELECT stw.SeriesID, vi2.Year, t.Name
                FROM SERIES_TAGGED_WITH stw
                JOIN TOPIC t ON t.TopicID = stw.TopicID
                JOIN VENUE_INSTANCE vi2 ON vi2.SeriesID = stw.SeriesID
            ) t ON t.SeriesID = vi.SeriesID AND t.Year = vi.Year
            GROUP BY vi.SeriesID, vi.Year, vs.Acronym, vs.Name
            """)
    venues = cursor.fetchall()
    cursor.close()
    db.close()
    return pd.DataFrame(venues)

""" 
load_user_interactions(): Builds a weighted topic profile for a user by
    assigning scores to each type of interaction based on what we believe
    has the most impact on likability of a topic. Here:
--> Bookmark: Bookmarking a venue tagged with a topic yields +3 to that topic
--> Viewing Venue Tagged with Topic: +1 to that topic
--> Dismissing a venue tagged with Topic: -2 to that topic
--> Directly interacting with a topic: +2 to that topic
Returns a ranked list of topics with net scores which gives us a quantified estimate
of which topics a user interacts with and why, assuming topics are the most informative
layer of info to perform inference against. 
"""

def load_user_interactions(user_id):
    db = get_db() # connect
    cursor = db.cursor(dictionary=True)
    
    # Get topics a user has interacted with & weight by the type of interaction
    # For computing a final LightFM-style hybrid score
    # Outer query takes inner query output, joins to TOPIC to get name,
    #   groups by topic and filters out negative scores
    # Inner query is a massive UNION ALL of seven subqueries extracting 
    #   info for each interaction type, keeping duplicates to sum scores
    cursor.execute("""
            SELECT t.Name as topic, SUM(score) as score
            FROM (
                SELECT itw.TopicID, 3.0 as score
                FROM BOOKMARKS b
                JOIN INSTANCE_TAGGED_WITH itw
                    ON itw.SeriesID = b.SeriesID AND itw.Year = b.Year
                WHERE b.UserID = %s
                UNION ALL
                SELECT stw.TopicID, 3.0 as score
                FROM BOOKMARKS b
                JOIN SERIES_TAGGED_WITH stw on stw.SeriesID = b.SeriesID
                WHERE b.UserID = %s
                UNION ALL
                SELECT itw.TopicID, 1.0 as score
                FROM VIEWS v
                JOIN INSTANCE_TAGGED_WITH itw
                    ON itw.SeriesID = v.SeriesID AND itw.Year = v.Year
                WHERE v.UserID = %s
                UNION ALL
                SELECT stw.TopicID, 1.0 as score
                FROM VIEWS v
                JOIN SERIES_TAGGED_WITH stw ON stw.SeriesID = v.SeriesID
                WHERE v.UserID = %s
                UNION ALL
                SELECT itw.TopicID, -2.0 as score
                FROM DISMISSES d
                JOIN INSTANCE_TAGGED_WITH itw
                    ON itw.SeriesID = d.SeriesID AND itw.Year = d.Year
                WHERE d.UserID = %s
                UNION ALL
                SELECT stw.TopicID, -2.0 as score
                FROM DISMISSES d
                JOIN SERIES_TAGGED_WITH stw ON stw.SeriesID = d.SeriesID
                WHERE d.UserID = %s
                UNION ALL
                SELECT iw.TopicID, 2.0 as score
                FROM INTERACTS_WITH iw
                WHERE iw.UserID = %s
            ) weighted
            JOIN TOPIC t ON t.TopicID = weighted.TopicID
            GROUP BY t.Name
            HAVING SUM(score) > 0 
            ORDER BY score DESC 
                   """, (user_id, user_id, user_id, user_id, user_id, user_id, user_id))
    interactions = cursor.fetchall()
    cursor.close()
    db.close()
    return pd.DataFrame(interactions) if interactions else pd.DataFrame(columns=['topic', 'score'])

# 3. Algorithm - LightFM inspired content-based (b) plus collaborative (a)
# 3 a)

def get_collaborative_scores(user_id, venues_df):
    db = get_db()
    cursor = db.cursor(dictionary=True)
    
    # Build an interaction matrix of all users X all users
    # Scoring System (we can tune this, and the one in (b), to 
    # give us the type of recommendations we want for demos)
    #   Score = 3 for bookmark (same as below)
    #         = 1 for view
    #         = -2 for dismiss (similar users)
    cursor.execute("""
            SELECT UserID, SeriesID, Year, CAST(3.0 AS FLOAT) as score FROM BOOKMARKS
            UNION ALL
            SELECT UserID, SeriesID, Year, CAST(1.0 AS FLOAT) as score FROM VIEWS
            UNION ALL
            SELECT UserID, SeriesID, Year, CAST(-2.0 AS FLOAT) as score FROM DISMISSES 
                   """)
    
    all_interactions = cursor.fetchall()
    cursor.close()
    db.close()
    
    if not all_interactions:
        return np.zeros(len(venues_df))
    
    # Convert to interactions dataframe with Pandas package
    interactions_df = pd.DataFrame(all_interactions)
    interactions_df['venue_key'] = (
        interactions_df['SeriesID'].astype(str) + '_' + 
        interactions_df['Year'].astype(str)
    )
    # Pivot to matrix with:
    #   Rows = Users
    #   Columns = Venues
    interaction_matrix = interactions_df.pivot_table(
        index='UserID',
        columns='venue_key',
        values='score',
        aggfunc='sum' # aggregation function
    ).fillna(0)
    
    # If a target user has zero interactions --> return zero matrix
    if user_id not in interaction_matrix.index:
        return np.zeros(len(venues_df))
    
    # Get target user's row from interaction_matrix
    user_row = interaction_matrix.loc[[user_id]].values
    # Get all users minus this user's interaction rows
    other_users = interaction_matrix.drop(index=user_id)
    if other_users.empty:
        return np.zeros(len(venues_df))

    # Cosine similarity (same as below in (b))
    #   for vectors A and B, CS = (A * B) / (|A| x |B|) fyi, b/w -1 and 1
    user_similarities = cosine_similarity(user_row, other_users.values)[0]
    # Yields us an array with One number per other user, between 0 and 1. 
    #       Where 0.91 means very similar, 0.15 means very different
    
    # Top-k users with k=3 (we can tune this parameter as we want)
    top_k = min(3, len(user_similarities))
    top_indices = np.argsort(user_similarities)[-top_k:]
    top_similarities = user_similarities[top_indices]
    top_users_matrix = other_users.values[top_indices]
    # if fewer than 3 we take however many there are
    
    # Get weighted average of top-k similar users' interactions
    if top_similarities.sum() == 0:
        return np.zeros(len(venues_df))
    
    weighted_interactions = np.average(
        top_users_matrix,
        axis=0,
        weights=top_similarities
    )
    # so we weight by the similar - someone with a similarity score of 0.9
    # has 9x the impact on recommendations of someone with score 0.1
    
    # Map back to venue scores in correct venues_df order
    collab_scores = np.zeros(len(venues_df))
    for i, (_, row) in enumerate(venues_df.iterrows()):
        venue_key = f"{row['SeriesID']}_{row['Year']}"
        if venue_key in interaction_matrix.columns:
            col_idx = list(interaction_matrix.columns).index(venue_key)
            collab_scores[i] = weighted_interactions[col_idx]
            
    return collab_scores


# 3 b)

def build_recommendations(user_id, top_n=200):
    venues_df = load_venue_topics()
    interactions_df = load_user_interactions(user_id)
    
    if venues_df.empty:
        return []
    
    # split strings on pipe
    venues_df['topic_list'] = venues_df['topics'].apply(
        lambda x: x.split('|') if x else []
    )
    
    # Matrix construction:
    # One row per venue / one column per topic
    # Each cell is 1 if  venue has a topic and 0 if not
    mlb = MultiLabelBinarizer() # 0 or 1
    # fit_transform: 1) FITS by learning all the unique topics across all venues, 
    #   which gives us the columns for venue_topic_matrix, and 
    #   2) converts the presence or absence of a topic (column) for each venue (row)
    #   into a 0 or a 1 in that cell
    venue_topic_matrix = mlb.fit_transform(venues_df['topic_list'])
   
    # User interest vectors:
    #   Identical shape to venu columns but populated with 0 initially,
    #   then with actual user's scores
    user_vector = np.zeros(len(mlb.classes_)) # numpy is a package for scientific
                                              # computing in Python ML
    if not interactions_df.empty:
        for _, row in interactions_df.iterrows(): # iterrows rocks and gives you
                                                   # you the row as a dictionary for
                                                   # each row
            topic = row['topic']
            score = row['score']
            if topic in mlb.classes_:
                idx = list(mlb.classes_).index(topic)
                user_vector[idx] = score
    
    # Computing Cosine similarity: computed between user vector and every venue
    #   and then sort by descending; cosine similarity being a super common way
    #   to quantify the 'distance' between two data points in a latent space
    # If no recent user interactions, return most recently active venues as 
    #   recommendations
    if user_vector.sum() == 0:
        # display most recently viewed
        venues_df['rec_score'] = 0.0
    else:
        similarities = cosine_similarity([user_vector], venue_topic_matrix)[0]
        # for vectors A and B, CS = (A * B) / (|A| x |B|) fyi, b/w -1 and 1
       
        # NEW: ADDING COLLABORATIVE FILTERING TO FORM WEIGHTED SCORE
        collab_scores = get_collaborative_scores(user_id, venues_df)
        # Normalize scores to fall within the same range as content-based  
        collab_max = np.abs(collab_scores).max() # actually the positive
                                                 # part of the range
        if collab_max > 0:
            collab_scores = collab_scores / collab_max
            
        # Compute the weighted score (final) for recommendations
        venues_df['rec_score'] = (0.7 * similarities) + (0.3 * collab_scores) 
         
        # So for 'similairities', cosine similarity takes the angle between two vectors
        #   If two vectors point the same directions (same interests) then 
        #   the score ends up near 1, or 0 in the opposite (diverging) case.
        #    Venues that score the closest (to 1) get the highest scores,
        #   and then later we order DESC v. ***ADDED: computes a weighted
        #   score (e.g. 70% content interactions-based, 30% similar users
        #   liked-based) - also uses cosine similarity, see above)
        
    # Sort DESC and then return top N recommendations
    top_venues = (
        venues_df
        .sort_values('rec_score', ascending=False)
        .head(top_n)
    )
    #
    #
    # DEBUGGING / VISUALIZATIONS
    # DEBUG BLOCK — comment out before final version
    print("\n=== VENUE-TOPIC MATRIX ===")
    topic_names = mlb.classes_
    matrix_df = pd.DataFrame(
        venue_topic_matrix,
        index=[f"{row['Acronym']} {row['Year']}" for _, row in venues_df.iterrows()],
        columns=topic_names
    )
    print(matrix_df.to_string())

    print("\n=== USER INTEREST VECTOR ===")
    user_vector_df = pd.DataFrame([user_vector], columns=topic_names)
    nonzero_cols = user_vector_df.columns[user_vector_df.iloc[0] != 0]
    print(user_vector_df[nonzero_cols].to_string())

    print("\n=== SIMILARITY SCORES ===")
    print(venues_df[['Acronym', 'Year', 'rec_score']]
        .sort_values('rec_score', ascending=False)
        .to_string())

    print("\n=== TOP RECOMMENDATIONS ===")
    print(top_venues[['Acronym', 'Year', 'rec_score', 'topics']].to_string())
    print("\n=== END DEBUG ===\n")
    # END DEBUG BLOCK
    #
    #
    
    
    # dictionary: 
    return [
        {
            'seriesId': int(row['SeriesID']),
            'year': int(row['Year']),
            'acronym': row['Acronym'],
            'title': row['SeriesName'],
            'score': round(float(row['rec_score']), 4),
            'topics': row['topics']
        }
        for _, row in top_venues.iterrows()
    ]
# 4. Flask 'n' Test
@app.route('/recommendations')
def recommendations():
    user_id = request.args.get('userId')
    
    if not user_id:
        return jsonify({'error': 'userID is required'}), 400
    
    try:
        user_id = int(user_id)
    except ValueError:
        return jsonify({'error': 'userId must be an integer'}), 400
    
    try:
        results = build_recommendations(user_id)
        return jsonify({
            'userId': user_id,
            'recommendations': results
        })
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
if __name__ == '__main__':
    app.run(port=5000, debug=True)
    