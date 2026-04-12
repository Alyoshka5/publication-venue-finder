# Publication Venue Finder

## Setup

1. Clone the repository:

```bash
git clone git@github.com:Alyoshka5/publication-venue-finder.git
cd publication-venue-finder
```

2. Install the required tools locally:

- Node.js and npm
- Python 3
- MySQL

3. Set up MySQL and create the project database:

```bash
mysql -u root -p
```

Then run:

```sql
CREATE DATABASE publication_venue_finder_db;
EXIT;
```

4. Import the project schema and seed data:

```bash
mysql -u root -p publication_venue_finder_db < db/projectDump-FIXED.sql
```

5. Create `server/.env` and add your local MySQL credentials:

```env
DB_PASSWORD=your_mysql_root_password
```

Optional variables used by the recommender service:

```env
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_NAME=publication_venue_finder_db
```

6. Install frontend dependencies:

```bash
cd client
npm install
cd ..
```

7. Install backend dependencies:

```bash
cd server
npm install
cd ..
```

8. Create a Python virtual environment for the recommender service:

```bash
cd recommender
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cd ..
```

## Run

1. Start the React client:

```bash
cd client
npm run dev
```

2. In a second terminal, start the Express backend:

```bash
cd server
npm run dev
```

3. In a third terminal, start the recommender service:

```bash
cd recommender
source .venv/bin/activate
.venv/bin/python main.py
```

## Notes

- The backend reads `DB_PASSWORD` from `server/.env`.
- The recommender service also reads the database configuration from `server/.env`.
- The app expects the database name to be `publication_venue_finder_db`.
