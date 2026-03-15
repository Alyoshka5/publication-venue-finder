-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost

-- 
-- Database: Publication Venue Catalog
-- 

-- --------------------------------------------------------

-- 
-- Table structure for `ORGANIZATION`
--

CREATE TABLE `ORGANIZATION` (
  `OrgID` int(8) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Website` varchar(255) NOT NULL,
  `Society` varchar(255),
  `Publisher` varchar(255),
  `University` varchar(255),
  PRIMARY KEY (OrgID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ORGANIZATION`
--

INSERT INTO `ORGANIZATION` (`OrgID`, `Name`, `Website`, `Society`, `Publisher`, `University`) VALUES
(1, 'IEEE', 'https://www.ieee.org', 'IEEE', 'IEEE Press', NULL),
(2, 'ACM', 'https://www.acm.org', 'ACM', 'ACM Digital Library', NULL),
(3, 'Springer', 'https://www.springer.com', NULL, 'Springer Nature', NULL),
(4, 'Elsevier', 'https://www.elsevier.com', NULL, 'Elsevier', NULL),
(5, 'USENIX', 'https://www.usenix.org', 'USENIX Association', 'USENIX', NULL),
(6, 'AAAI', 'https://www.aaai.org', 'AAAI', 'AAAI Press', NULL),
(7, 'ISOC', 'https://www.internetsociety.org', 'Internet Society', NULL, NULL),
(8, 'IACR', 'https://www.iacr.org', 'IACR', 'IACR', NULL),
(9, 'IFIP', 'https://www.ifip.org', 'IFIP', NULL, NULL),
(10, 'ACL', 'https://www.aclweb.org', 'ACL', 'ACL Anthology', NULL),
(11, 'ISCA', 'https://www.isca-speech.org', 'International Speech Communication Association', NULL, NULL),
(12, 'APS', 'https://www.psychologicalscience.org', 'Association for Psychological Science', NULL, NULL),
(13, 'Cognitive Science Society', 'https://cognitivesciencesociety.org', 'Cognitive Science Society', NULL, NULL),
(14, 'Cognitive Neuroscience Society', 'https://www.cogneurosociety.org', 'Cognitive Neuroscience Society', NULL, NULL),
(15, 'Nature Portfolio', 'https://www.nature.com', NULL, 'Springer Nature', NULL),
(16, 'MIT Press', 'https://mitpress.mit.edu', NULL, 'MIT Press', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for `VENUE_SERIES`
--

CREATE TABLE VENUE_SERIES (
  `SeriesID` int(8) NOT NULL,
  `OrgID` int(8) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Acronym` varchar(50),
  `Description` TEXT,
  `ActiveFlag` BOOLEAN DEFAULT TRUE,
  PRIMARY KEY (SeriesID),
  FOREIGN KEY (OrgID) REFERENCES ORGANIZATION(OrgID)
      ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `VENUE_SERIES`
--

INSERT INTO `VENUE_SERIES` (`SeriesID`, `OrgID`, `Name`, `Acronym`, `Description`, `ActiveFlag`) VALUES
-- IEEE
(1, 1, 'International Conference on Software Engineering', 'ICSE', 'Premier software engineering conference', TRUE),
(2, 1, 'IEEE Symposium on Security and Privacy', 'S&P', 'Top venue for security and privacy research', TRUE),
(3, 1, 'IEEE International Conference on Computer Communications', 'INFOCOM', 'Leading networking and communications conference', TRUE),
(4, 1, 'IEEE Conference on Computer Vision and Pattern Recognition', 'CVPR', 'Premier computer vision conference', TRUE),
(5, 1, 'IEEE International Conference on Data Mining', 'ICDM', 'Leading data mining conference', TRUE),
(26, 1, 'International Symposium on Computer Architecture', 'ISCA', 'Premier computer architecture conference', TRUE),
(27, 1, 'IEEE/ACM International Symposium on Microarchitecture', 'MICRO', 'Top microarchitecture conference', TRUE),
(31, 1, 'IEEE International Conference on Affective Computing and Intelligent Interaction', 'ACII', 'Premier affective computing conference', TRUE),
(33, 1, 'IEEE International Conference on Robotics and Automation', 'ICRA', 'Largest robotics conference', TRUE),
(34, 1, 'IEEE/RSJ International Conference on Intelligent Robots and Systems', 'IROS', 'Leading intelligent robots conference', TRUE),
(36, 1, 'IEEE International Conference on Acoustics, Speech and Signal Processing', 'ICASSP', 'Premier speech and signal processing conference', TRUE),
(38, 1, 'IEEE International Conference on Computer Vision', 'ICCV', 'Top computer vision conference, held biennially', TRUE),
(39, 1, 'European Conference on Computer Vision', 'ECCV', 'Leading European computer vision conference', TRUE),
(41, 1, 'IEEE International Conference on Image Processing', 'ICIP', 'Leading image processing conference', TRUE),
-- ACM
(6, 2, 'ACM Special Interest Group on Data Communication', 'SIGCOMM', 'Premier data networking conference', TRUE),
(7, 2, 'ACM SIGPLAN Conference on Programming Language Design and Implementation', 'PLDI', 'Top programming languages conference', TRUE),
(8, 2, 'ACM Symposium on Theory of Computing', 'STOC', 'Premier theory of computing conference', TRUE),
(9, 2, 'ACM Conference on Computer and Communications Security', 'CCS', 'Leading security conference', TRUE),
(10, 2, 'ACM SIGMOD International Conference on Management of Data', 'SIGMOD', 'Premier database conference', TRUE),
(11, 2, 'ACM Symposium on Operating Systems Principles', 'SOSP', 'Top operating systems conference', TRUE),
(12, 2, 'ACM CHI Conference on Human Factors in Computing Systems', 'CHI', 'Premier HCI conference', TRUE),
(13, 2, 'ACM SIGPLAN Symposium on Principles of Programming Languages', 'POPL', 'Leading PL theory conference', TRUE),
(14, 2, 'ACM International Conference on Architectural Support for Programming Languages and Operating Systems', 'ASPLOS', 'Top systems and architecture conference', TRUE),
(15, 2, 'ACM SIGKDD Conference on Knowledge Discovery and Data Mining', 'KDD', 'Premier data mining and KDD conference', TRUE),
(22, 2, 'Conference on Neural Information Processing Systems', 'NeurIPS', 'Premier ML and AI conference', TRUE),
(23, 2, 'International Conference on Machine Learning', 'ICML', 'Leading machine learning conference', TRUE),
(24, 2, 'International Conference on Learning Representations', 'ICLR', 'Top deep learning conference', TRUE),
(25, 2, 'International Conference on Very Large Data Bases', 'VLDB', 'Leading database systems conference', TRUE),
(29, 2, 'ACM SIGCSE Technical Symposium on Computer Science Education', 'SIGCSE', 'Premier CS education conference', TRUE),
(30, 2, 'ACM SIGMOD-SIGACT-SIGART Symposium on Principles of Database Systems', 'PODS', 'Leading database theory conference', TRUE),
(35, 2, 'ACM/IEEE International Conference on Human-Robot Interaction', 'HRI', 'Premier human-robot interaction conference', TRUE),
-- USENIX
(16, 5, 'USENIX Symposium on Operating Systems Design and Implementation', 'OSDI', 'Top systems conference', TRUE),
(17, 5, 'USENIX Security Symposium', 'USENIX Security', 'Leading security conference', TRUE),
(18, 5, 'USENIX Symposium on Networked Systems Design and Implementation', 'NSDI', 'Top networked systems conference', TRUE),
(19, 5, 'USENIX Annual Technical Conference', 'ATC', 'Broad systems research conference', TRUE),
-- AAAI
(20, 6, 'AAAI Conference on Artificial Intelligence', 'AAAI', 'Premier broad AI conference', TRUE),
(21, 6, 'Innovative Applications of Artificial Intelligence', 'IAAI', 'Applied AI conference', TRUE),
-- ISOC
(28, 7, 'Network and Distributed System Security Symposium', 'NDSS', 'Top network security conference', TRUE),
-- IACR
(42, 8, 'International Cryptology Conference', 'CRYPTO', 'Premier cryptography conference', TRUE),
(43, 8, 'European Cryptology Conference', 'EUROCRYPT', 'Leading European cryptography conference', TRUE),
-- ACL
(44, 10, 'Annual Meeting of the Association for Computational Linguistics', 'ACL', 'Premier NLP conference', TRUE),
(45, 10, 'Conference on Empirical Methods in Natural Language Processing', 'EMNLP', 'Top empirical NLP conference', TRUE),
(46, 10, 'North American Chapter of the ACL', 'NAACL', 'Leading North American NLP conference', TRUE),
-- Interspeech (ISCA org - need OrgID)
(37, 11, 'Interspeech', 'INTERSPEECH', 'Premier speech processing conference', TRUE),
-- Journals (CS)
(50, 2, 'Communications of the ACM', 'CACM', 'Flagship ACM publication covering all areas of CS', TRUE),
(51, 4, 'Journal of Artificial Intelligence Research', 'JAIR', 'Open-access journal covering all areas of AI', TRUE),
(52, 1, 'IEEE Transactions on Neural Networks and Learning Systems', 'TNNLS', 'IEEE journal on neural networks and ML', TRUE),
(53, 2, 'ACM Transactions on Programming Languages and Systems', 'TOPLAS', 'ACM journal on PL theory and implementation', TRUE),
(54, 4, 'Information and Computation', 'IC', 'Elsevier journal on theoretical CS and logic', TRUE),
-- Journals (Cog Sci / Neuro / Nature)
(55, 15, 'Nature', 'Nature', 'Premier multidisciplinary science journal', TRUE),
(56, 15, 'Nature Human Behaviour', 'NHB', 'Nature journal covering human behaviour research', TRUE),
(57, 15, 'Nature Neuroscience', 'NatNeuro', 'Nature journal on neuroscience', TRUE),
(58, 16, 'Cognitive Science', 'CogSci-J', 'Official journal of the Cognitive Science Society', TRUE),
(59, 16, 'Neural Computation', 'NeuralComp', 'MIT Press journal on computational neuroscience', TRUE),
-- Conferences (Cog Sci / Neuro / Psych)
(60, 13, 'Annual Conference of the Cognitive Science Society', 'CogSci', 'Premier interdisciplinary cognitive science conference', TRUE),
(61, 14, 'Annual Meeting of the Cognitive Neuroscience Society', 'CNS', 'Premier cognitive neuroscience conference', TRUE),
(62, 12, 'APS Annual Convention', 'APS', 'Premier psychological science convention', TRUE),
(63, 14, 'Conference on Cognitive Computational Neuroscience', 'CCN', 'Computational approaches to brain and cognition', TRUE),
(32, 1, 'IEEE Conference on Virtual Reality and 3D User Interfaces', 'IEEE VR', 'Premier conference on virtual and augmented reality', TRUE),
(40, 2, 'ACM SIGGRAPH Conference on Computer Graphics and Interactive Techniques', 'SIGGRAPH', 'Premier computer graphics and interactive techniques conference', TRUE),
(47, 1, 'IEEE International Conference on Quantum Computing and Engineering', 'IEEE Quantum Week', 'Leading quantum computing conference', TRUE),
(48, 1, 'IEEE International Conference on Bioinformatics and Biomedicine', 'BIBM', 'Premier bioinformatics and biomedicine conference', TRUE),
(49, 2, 'ACM Symposium on User Interface Software and Technology', 'UIST', 'Leading HCI and user interface conference', TRUE);

-- --------------------------------------------------------

-- 
-- Table structure for `CONFERENCE_SERIES`
--

CREATE TABLE CONFERENCE_SERIES (
  `SeriesID` int(8) NOT NULL,
  `TypicalMonth` int(8) NOT NULL,
  `TypicalCityPolicy` varchar(255) NOT NULL,
  PRIMARY KEY (SeriesID),
  FOREIGN KEY (SeriesID) REFERENCES VENUE_SERIES(SeriesID)
      ON DELETE CASCADE,
  CHECK (TypicalMonth BETWEEN 1 AND 12)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CONFERENCE_SERIES`
--

INSERT INTO `CONFERENCE_SERIES` (`SeriesID`, `TypicalMonth`, `TypicalCityPolicy`) VALUES
-- IEEE
(1, 4, 'Rotating international cities'),      -- ICSE: April
(2, 5, 'San Francisco, CA (fixed)'),           -- S&P: May
(3, 5, 'Rotating international cities'),       -- INFOCOM: May
(4, 6, 'Rotating US cities'),                  -- CVPR: June
(5, 11, 'Rotating international cities'),      -- ICDM: November
(26, 6, 'Rotating international cities'),      -- ISCA: June
(27, 10, 'Rotating international cities'),     -- MICRO: October
(31, 9, 'Rotating international cities'),      -- ACII: September
(33, 5, 'Rotating international cities'),      -- ICRA: May
(34, 10, 'Rotating international cities'),     -- IROS: October
(36, 4, 'Rotating international cities'),      -- ICASSP: April
(38, 10, 'Rotating international cities'),     -- ICCV: October (biennial)
(39, 9, 'Rotating European cities'),           -- ECCV: September (biennial)
(41, 9, 'Rotating international cities'),      -- ICIP: September
-- ACM
(6, 8, 'Rotating international cities'),       -- SIGCOMM: August
(7, 6, 'Rotating international cities'),       -- PLDI: June
(8, 6, 'Rotating international cities'),       -- STOC: June
(9, 11, 'Rotating international cities'),      -- CCS: November
(10, 6, 'Rotating international cities'),      -- SIGMOD: June
(11, 10, 'Rotating international cities'),     -- SOSP: October (biennial)
(12, 4, 'Rotating international cities'),      -- CHI: April
(13, 1, 'Rotating international cities'),      -- POPL: January
(14, 3, 'Rotating international cities'),      -- ASPLOS: March
(15, 8, 'Rotating international cities'),      -- KDD: August
(22, 12, 'New Orleans, LA / Vancouver, BC'),   -- NeurIPS: December
(23, 7, 'Rotating international cities'),      -- ICML: July
(24, 4, 'Rotating international cities'),      -- ICLR: April
(25, 8, 'Rotating international cities'),      -- VLDB: August
(29, 3, 'Rotating US/Canada cities'),          -- SIGCSE: March
(30, 6, 'Rotating international cities'),      -- PODS: June
(35, 3, 'Rotating international cities'),      -- HRI: March
-- USENIX
(16, 11, 'Rotating US cities'),                -- OSDI: November (biennial)
(17, 8, 'Rotating US cities'),                 -- USENIX Security: August
(18, 4, 'Rotating US cities'),                 -- NSDI: April
(19, 7, 'Rotating US cities'),                 -- ATC: July
-- AAAI
(20, 2, 'Rotating US cities'),                 -- AAAI: February
(21, 2, 'Rotating US cities'),                 -- IAAI: February
-- ISOC
(28, 2, 'San Diego, CA (fixed)'),              -- NDSS: February
-- IACR
(42, 8, 'Rotating international cities'),      -- CRYPTO: August
(43, 5, 'Rotating European cities'),           -- EUROCRYPT: May
-- ACL
(44, 7, 'Rotating international cities'),      -- ACL: July
(45, 11, 'Rotating international cities'),     -- EMNLP: November
(46, 6, 'Rotating North American cities'),     -- NAACL: June
-- ISCA
(37, 9, 'Rotating international cities'),      -- INTERSPEECH: September
-- COGS-type
(60, 7, 'Rotating international cities'),   -- CogSci: July
(61, 3, 'Rotating US/Canada cities'),        -- CNS: March/April
(62, 5, 'Rotating international cities'),    -- APS: May
(63, 8, 'Rotating international cities'),    -- CCN: August
(32, 3, 'Rotating international cities'),    -- IEEE VR: March
(40, 8, 'Rotating international cities'),    -- SIGGRAPH: August
(47, 9, 'Denver, CO (fixed)'),               -- IEEE Quantum Week: September
(48, 11, 'Rotating international cities'),   -- BIBM: November
(49, 10, 'Rotating international cities');   -- UIST: October

-- --------------------------------------------------------

-- 
-- Table structure for `JOURNAL`
--

CREATE TABLE JOURNAL (
  `SeriesID` int(8) NOT NULL,
  `PublicationFrequency` varchar(100) NOT NULL,
  PRIMARY KEY (SeriesID),
  FOREIGN KEY (SeriesID) REFERENCES VENUE_SERIES(SeriesID)
      ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `JOURNAL`
--

INSERT INTO `JOURNAL` (`SeriesID`, `PublicationFrequency`) VALUES
(50, 'Monthly'),
(51, 'Continuous (rolling)'),
(52, 'Monthly'),
(53, 'Quarterly'),
(54, 'Bimonthly'),
(55, 'Weekly'),
(56, 'Monthly'),
(57, 'Monthly'),
(58, 'Bimonthly'),
(59, 'Monthly');

-- --------------------------------------------------------

-- 
-- Table structure for `TOPIC`
--

CREATE TABLE TOPIC (
  TopicID int(8) NOT NULL,
  Name varchar(255) NOT NULL,
  PRIMARY KEY (TopicID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `TOPIC`
--
INSERT INTO `TOPIC` (`TopicID`, `Name`) VALUES
-- AI- / ML-related
(1, 'Machine Learning'),
(2, 'Deep Learning'),
(3, 'Reinforcement Learning'),
(4, 'Natural Language Processing'),
(5, 'Large Language Models'),
(6, 'Computer Vision'),
(7, 'Multimodal AI'),
(8, 'AI Ethics & Fairness'),
(9, 'AI for Science'),
(10, 'Embodied AI'),
(11, 'Neurosymbolic AI'),
(12, 'Joint Embedding Predictive Architecture'),
-- Perception / Signal Processing
(13, 'Speech Processing'),
(14, 'Audio & Music Computing'),
(15, 'Image Processing'),
(16, 'Video & Motion Analysis'),
(17, 'Affective Computing'),
-- Robotics / Interaction Subfields
(18, 'Robotics'),
(19, 'Human-Robot Interaction'),
(20, 'Human-Computer Interaction'),
(21, 'Mixed & Augmented Reality'),
(22, 'Ubiquitous Computing'),
-- Security / Cryptography
(23, 'Network Security'),
(24, 'Cryptography'),
(25, 'Privacy'),
(26, 'Malware & Forensics'),
(27, 'Dependable Systems'),
-- Systems / Architecture
(28, 'Operating Systems'),
(29, 'Computer Architecture'),
(30, 'Distributed Systems'),
(31, 'High Performance Computing'),
(32, 'Networking'),
-- Data (Retrieval, Manipulation, Storage, Systems)
(33, 'Databases'),
(34, 'Data Mining'),
(35, 'Information Retrieval'),
(36, 'Big Data'),
(37, 'Datasets & Benchmarks'),
-- Theory / Programming
(38, 'Algorithms & Complexity'),
(39, 'Programming Languages'),
(40, 'Formal Methods'),
(41, 'Software Engineering'),
(42, 'Logic in CS'),
-- Emerging / Frontier / Crossdisciplinary
(43, 'Quantum Computing'),
(44, 'CS Education'),
(45, 'AI Impacts & Society'),
-- Other
(46, 'Wireless & Mobile Computing'),
(47, 'Information Systems'),
(48, 'Computer Graphics & Animation'),
(49, 'Human Motion Analysis'),
(50, 'Parallel Computing'),
-- COGS / Neuro-type topics
(51, 'Cognitive Science'),
(52, 'Computational Neuroscience'),
(53, 'Psychological Science');

-- --------------------------------------------------------

-- 
-- Table structure for `VENUE_INSTANCE`
-- 

CREATE TABLE VENUE_INSTANCE (
  `SeriesID` int(8) NOT NULL,
  `Year` int(8) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `StartDate` DATE,
  `EndDate` DATE,
  `City` varchar(255) NOT NULL,
  `Country` varchar(255) NOT NULL,
  `SubmissionDeadline` DATE,
  `CFP_URL` varchar(255) NOT NULL,
  `CallForPapers` TEXT,
  `Reviewing` BOOLEAN,
  `Published` BOOLEAN,
  PRIMARY KEY (SeriesID, Year),
  FOREIGN KEY (SeriesID) REFERENCES VENUE_SERIES(SeriesID)
      ON DELETE CASCADE,
  CHECK (EndDate >= StartDate)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `VENUE_INSTANCE`
-- NOTE: CFP_URL should store the permanent series homepage (e.g. https://neurips.cc)
-- NOT year-specific CFP links. Permanent homepages redirect to the current year
-- and avoid link rot / breakage over time.
--
-- Database initialized with the current and prior year's
--
-- NOTES FOR ADDING TO VENUE_INSTANCE:
--    For biennial conferences (e.g. SOSP and ICCV use convention "2023/2025" etc.
--    Use placeholders for upcoming (e.g. ECCV is biennial so use 2024 and add a placeholder 2026)
-- Instances still under review or not yet published have Reviewing=TRUE, Published=FALSE
-- Instances that are upcoming/future have Reviewing=FALSE, Published=FALSE

INSERT INTO `VENUE_INSTANCE` (`SeriesID`, `Year`, `Title`, `StartDate`, `EndDate`, `City`, `Country`, `SubmissionDeadline`, `CFP_URL`, `CallForPapers`, `Reviewing`, `Published`) VALUES

-- ICSE (SeriesID 1)
(1, 2024, 'ICSE 2024', '2024-04-14', '2024-04-20', 'Lisbon', 'Portugal', '2023-09-01', 'https://conf.researchr.org/series/icse', 'The International Conference on Software Engineering', TRUE, TRUE),
(1, 2025, 'ICSE 2025', '2025-04-27', '2025-05-03', 'Ottawa', 'Canada', '2024-09-01', 'https://conf.researchr.org/series/icse', 'The International Conference on Software Engineering', TRUE, TRUE),

-- S&P (SeriesID 2)
(2, 2024, 'IEEE S&P 2024', '2024-05-19', '2024-05-23', 'San Francisco', 'USA', '2023-11-15', 'https://www.ieee-security.org/TC/SP2024/', 'IEEE Symposium on Security and Privacy', TRUE, TRUE),
(2, 2025, 'IEEE S&P 2025', '2025-05-12', '2025-05-15', 'San Francisco', 'USA', '2024-11-15', 'https://www.ieee-security.org/TC/SP2025/', 'IEEE Symposium on Security and Privacy', TRUE, TRUE),

-- INFOCOM (SeriesID 3)
(3, 2024, 'INFOCOM 2024', '2024-05-20', '2024-05-23', 'Vancouver', 'Canada', '2023-07-24', 'https://infocom2024.ieee-infocom.org', 'IEEE International Conference on Computer Communications', TRUE, TRUE),
(3, 2025, 'INFOCOM 2025', '2025-05-19', '2025-05-22', 'London', 'UK', '2024-07-24', 'https://infocom2025.ieee-infocom.org', 'IEEE International Conference on Computer Communications', TRUE, TRUE),

-- CVPR (SeriesID 4)
(4, 2024, 'CVPR 2024', '2024-06-17', '2024-06-21', 'Seattle', 'USA', '2023-11-03', 'https://cvpr.thecvf.com', 'IEEE/CVF Conference on Computer Vision and Pattern Recognition', TRUE, TRUE),
(4, 2025, 'CVPR 2025', '2025-06-11', '2025-06-15', 'Nashville', 'USA', '2024-11-14', 'https://cvpr.thecvf.com', 'IEEE/CVF Conference on Computer Vision and Pattern Recognition', TRUE, TRUE),

-- ICDM (SeriesID 5)
(5, 2024, 'ICDM 2024', '2024-11-11', '2024-11-14', 'Abu Dhabi', 'UAE', '2024-06-10', 'https://icdm2024.org', 'IEEE International Conference on Data Mining', TRUE, TRUE),
(5, 2025, 'ICDM 2025', '2025-11-12', '2025-11-15', 'Washington DC', 'USA', '2025-06-10', 'https://icdm.ieee.org', 'IEEE International Conference on Data Mining', TRUE, TRUE),

-- SIGCOMM (SeriesID 6)
(6, 2024, 'SIGCOMM 2024', '2024-08-04', '2024-08-08', 'Sydney', 'Australia', '2024-02-02', 'https://www.sigcomm.org/events/sigcomm-conference', 'ACM Special Interest Group on Data Communication', TRUE, TRUE),
(6, 2025, 'SIGCOMM 2025', '2025-09-08', '2025-09-11', 'Coimbra', 'Portugal', '2025-02-07', 'https://www.sigcomm.org/events/sigcomm-conference', 'ACM Special Interest Group on Data Communication', TRUE, TRUE),

-- PLDI (SeriesID 7)
(7, 2024, 'PLDI 2024', '2024-06-24', '2024-06-28', 'Copenhagen', 'Denmark', '2023-11-16', 'https://pldi.acm.org', 'ACM SIGPLAN Conference on Programming Language Design and Implementation', TRUE, TRUE),
(7, 2025, 'PLDI 2025', '2025-06-16', '2025-06-20', 'Seoul', 'South Korea', '2024-11-14', 'https://pldi.acm.org', 'ACM SIGPLAN Conference on Programming Language Design and Implementation', TRUE, TRUE),

-- STOC (SeriesID 8)
(8, 2024, 'STOC 2024', '2024-06-23', '2024-06-26', 'Vancouver', 'Canada', '2023-11-03', 'https://acm-stoc.org', 'ACM Symposium on Theory of Computing', TRUE, TRUE),
(8, 2025, 'STOC 2025', '2025-06-23', '2025-06-27', 'Prague', 'Czech Republic', '2024-11-04', 'https://acm-stoc.org', 'ACM Symposium on Theory of Computing', TRUE, TRUE),

-- CCS (SeriesID 9)
(9, 2024, 'CCS 2024', '2024-10-14', '2024-10-18', 'Salt Lake City', 'USA', '2024-05-15', 'https://www.sigsac.org/ccs.html', 'ACM Conference on Computer and Communications Security', TRUE, TRUE),
(9, 2025, 'CCS 2025', '2025-10-13', '2025-10-17', 'Taipei', 'Taiwan', '2025-05-15', 'https://www.sigsac.org/ccs.html', 'ACM Conference on Computer and Communications Security', TRUE, TRUE),

-- SIGMOD (SeriesID 10)
(10, 2024, 'SIGMOD 2024', '2024-06-09', '2024-06-15', 'Santiago', 'Chile', '2023-10-01', 'https://sigmod.org', 'ACM SIGMOD International Conference on Management of Data', TRUE, TRUE),
(10, 2025, 'SIGMOD 2025', '2025-06-22', '2025-06-27', 'Berlin', 'Germany', '2024-10-01', 'https://sigmod.org', 'ACM SIGMOD International Conference on Management of Data', TRUE, TRUE),

-- SOSP (SeriesID 11) -- biennial, so 2023 and 2025
(11, 2023, 'SOSP 2023', '2023-10-23', '2023-10-26', 'Koblenz', 'Germany', '2023-05-04', 'https://sosp.org', 'ACM Symposium on Operating Systems Principles', TRUE, TRUE),
(11, 2025, 'SOSP 2025', '2025-10-13', '2025-10-16', 'Prague', 'Czech Republic', '2025-04-24', 'https://sosp.org', 'ACM Symposium on Operating Systems Principles', TRUE, TRUE),

-- CHI (SeriesID 12)
(12, 2024, 'CHI 2024', '2024-05-11', '2024-05-16', 'Honolulu', 'USA', '2023-09-14', 'https://chi.acm.org', 'ACM CHI Conference on Human Factors in Computing Systems', TRUE, TRUE),
(12, 2025, 'CHI 2025', '2025-04-26', '2025-05-01', 'Yokohama', 'Japan', '2024-09-05', 'https://chi.acm.org', 'ACM CHI Conference on Human Factors in Computing Systems', TRUE, TRUE),

-- POPL (SeriesID 13)
(13, 2024, 'POPL 2024', '2024-01-17', '2024-01-19', 'London', 'UK', '2023-07-11', 'https://popl.mpi-sws.org', 'ACM SIGPLAN Symposium on Principles of Programming Languages', TRUE, TRUE),
(13, 2025, 'POPL 2025', '2025-01-19', '2025-01-24', 'Denver', 'USA', '2024-07-11', 'https://popl.mpi-sws.org', 'ACM SIGPLAN Symposium on Principles of Programming Languages', TRUE, TRUE),

-- ASPLOS (SeriesID 14)
(14, 2024, 'ASPLOS 2024', '2024-04-27', '2024-05-01', 'La Jolla', 'USA', '2023-08-04', 'https://asplos-conference.org', 'ACM International Conference on Architectural Support for Programming Languages and Operating Systems', TRUE, TRUE),
(14, 2025, 'ASPLOS 2025', '2025-03-30', '2025-04-03', 'Rotterdam', 'Netherlands', '2024-08-09', 'https://asplos-conference.org', 'ACM International Conference on Architectural Support for Programming Languages and Operating Systems', TRUE, TRUE),

-- KDD (SeriesID 15)
(15, 2024, 'KDD 2024', '2024-08-25', '2024-08-29', 'Barcelona', 'Spain', '2024-02-08', 'https://www.kdd.org/kdd2024/', 'ACM SIGKDD Conference on Knowledge Discovery and Data Mining', TRUE, TRUE),
(15, 2025, 'KDD 2025', '2025-08-03', '2025-08-07', 'Toronto', 'Canada', '2025-02-01', 'https://kdd.org', 'ACM SIGKDD Conference on Knowledge Discovery and Data Mining', TRUE, TRUE),

-- OSDI (SeriesID 16)
(16, 2024, 'OSDI 2024', '2024-07-10', '2024-07-12', 'Santa Clara', 'USA', '2023-12-05', 'https://www.usenix.org/conferences/byname/179', 'USENIX Symposium on Operating Systems Design and Implementation', TRUE, TRUE),
(16, 2025, 'OSDI 2025', '2025-07-07', '2025-07-09', 'Boston', 'USA', '2024-12-03', 'https://www.usenix.org/conferences/byname/179', 'USENIX Symposium on Operating Systems Design and Implementation', TRUE, TRUE),

-- USENIX Security (SeriesID 17)
(17, 2024, 'USENIX Security 2024', '2024-08-14', '2024-08-16', 'Philadelphia', 'USA', '2024-02-08', 'https://www.usenix.org/conferences/byname/108', 'USENIX Security Symposium', TRUE, TRUE),
(17, 2025, 'USENIX Security 2025', '2025-08-13', '2025-08-15', 'Seattle', 'USA', '2025-01-22', 'https://www.usenix.org/conferences/byname/108', 'USENIX Security Symposium', TRUE, TRUE),

-- NSDI (SeriesID 18)
(18, 2024, 'NSDI 2024', '2024-04-16', '2024-04-18', 'Santa Clara', 'USA', '2023-09-14', 'https://www.usenix.org/conferences/byname/135', 'USENIX Symposium on Networked Systems Design and Implementation', TRUE, TRUE),
(18, 2025, 'NSDI 2025', '2025-04-28', '2025-04-30', 'Philadelphia', 'USA', '2024-09-12', 'https://www.usenix.org/conferences/byname/135', 'USENIX Symposium on Networked Systems Design and Implementation', TRUE, TRUE),

-- ATC (SeriesID 19)
(19, 2024, 'USENIX ATC 2024', '2024-07-10', '2024-07-12', 'Santa Clara', 'USA', '2024-01-09', 'https://www.usenix.org/conferences/byname/131', 'USENIX Annual Technical Conference', TRUE, TRUE),
(19, 2025, 'USENIX ATC 2025', '2025-07-07', '2025-07-09', 'Boston', 'USA', '2025-01-14', 'https://www.usenix.org/conferences/byname/131', 'USENIX Annual Technical Conference', TRUE, TRUE),

-- AAAI (SeriesID 20)
(20, 2024, 'AAAI 2024', '2024-02-20', '2024-02-27', 'Vancouver', 'Canada', '2023-08-15', 'https://aaai.org/conference/aaai/', 'AAAI Conference on Artificial Intelligence', TRUE, TRUE),
(20, 2025, 'AAAI 2025', '2025-02-25', '2025-03-04', 'Philadelphia', 'USA', '2024-08-07', 'https://aaai.org/conference/aaai/', 'AAAI Conference on Artificial Intelligence', TRUE, TRUE),

-- IAAI (SeriesID 21)
(21, 2024, 'IAAI 2024', '2024-02-20', '2024-02-27', 'Vancouver', 'Canada', '2023-08-15', 'https://aaai.org/conference/aaai/aaai-24/iaai-24-call-for-papers/', 'Innovative Applications of Artificial Intelligence', TRUE, TRUE),
(21, 2025, 'IAAI 2025', '2025-02-25', '2025-03-04', 'Philadelphia', 'USA', '2024-08-07', 'https://aaai.org/conference/aaai/', 'Innovative Applications of Artificial Intelligence', TRUE, TRUE),

-- NeurIPS (SeriesID 22)
(22, 2024, 'NeurIPS 2024', '2024-12-09', '2024-12-15', 'Vancouver', 'Canada', '2024-05-22', 'https://neurips.cc', 'Conference on Neural Information Processing Systems', TRUE, TRUE),
(22, 2025, 'NeurIPS 2025', '2025-12-02', '2025-12-07', 'San Diego', 'USA', '2025-05-11', 'https://neurips.cc', 'Conference on Neural Information Processing Systems', TRUE, TRUE),

-- ICML (SeriesID 23)
(23, 2024, 'ICML 2024', '2024-07-21', '2024-07-27', 'Vienna', 'Austria', '2024-02-01', 'https://icml.cc', 'International Conference on Machine Learning', TRUE, TRUE),
(23, 2025, 'ICML 2025', '2025-07-13', '2025-07-19', 'Vancouver', 'Canada', '2025-01-23', 'https://icml.cc', 'International Conference on Machine Learning', TRUE, TRUE),

-- ICLR (SeriesID 24)
(24, 2024, 'ICLR 2024', '2024-05-07', '2024-05-11', 'Vienna', 'Austria', '2023-10-03', 'https://iclr.cc', 'International Conference on Learning Representations', TRUE, TRUE),
(24, 2025, 'ICLR 2025', '2025-04-24', '2025-04-28', 'Singapore', 'Singapore', '2024-10-01', 'https://iclr.cc', 'International Conference on Learning Representations', TRUE, TRUE),

-- VLDB (SeriesID 25)
(25, 2024, 'VLDB 2024', '2024-08-26', '2024-08-30', 'Guangzhou', 'China', '2023-10-01', 'https://vldb.org/pvldb/', 'International Conference on Very Large Data Bases', TRUE, TRUE),
(25, 2025, 'VLDB 2025', '2025-09-01', '2025-09-05', 'London', 'UK', '2024-10-01', 'https://vldb.org/pvldb/', 'International Conference on Very Large Data Bases', TRUE, TRUE),

-- ISCA (SeriesID 26)
(26, 2024, 'ISCA 2024', '2024-06-29', '2024-07-03', 'Buenos Aires', 'Argentina', '2023-11-17', 'https://iscaconf.org', 'International Symposium on Computer Architecture', TRUE, TRUE),
(26, 2025, 'ISCA 2025', '2025-06-21', '2025-06-25', 'Tokyo', 'Japan', '2024-11-15', 'https://iscaconf.org', 'International Symposium on Computer Architecture', TRUE, TRUE),

-- MICRO (SeriesID 27)
(27, 2024, 'MICRO 2024', '2024-11-02', '2024-11-06', 'Austin', 'USA', '2024-04-19', 'https://microarch.org', 'IEEE/ACM International Symposium on Microarchitecture', TRUE, TRUE),
(27, 2025, 'MICRO 2025', '2025-10-18', '2025-10-22', 'Seoul', 'South Korea', '2025-04-18', 'https://microarch.org', 'IEEE/ACM International Symposium on Microarchitecture', TRUE, TRUE),

-- NDSS (SeriesID 28)
(28, 2024, 'NDSS 2024', '2024-02-26', '2024-03-01', 'San Diego', 'USA', '2023-09-06', 'https://www.ndss-symposium.org', 'Network and Distributed System Security Symposium', TRUE, TRUE),
(28, 2025, 'NDSS 2025', '2025-02-24', '2025-02-28', 'San Diego', 'USA', '2024-09-05', 'https://www.ndss-symposium.org', 'Network and Distributed System Security Symposium', TRUE, TRUE),

-- SIGCSE (SeriesID 29)
(29, 2024, 'SIGCSE 2024', '2024-03-20', '2024-03-23', 'Portland', 'USA', '2023-09-08', 'https://sigcse.org/events/symposia/', 'ACM SIGCSE Technical Symposium on Computer Science Education', TRUE, TRUE),
(29, 2025, 'SIGCSE 2025', '2025-02-26', '2025-03-01', 'Pittsburgh', 'USA', '2024-09-06', 'https://sigcse.org/events/symposia/', 'ACM SIGCSE Technical Symposium on Computer Science Education', TRUE, TRUE),

-- PODS (SeriesID 30)
(30, 2024, 'PODS 2024', '2024-06-09', '2024-06-14', 'Santiago', 'Chile', '2023-12-04', 'https://databasetheory.org/PODS/', 'ACM SIGMOD-SIGACT-SIGART Symposium on Principles of Database Systems', TRUE, TRUE),
(30, 2025, 'PODS 2025', '2025-06-22', '2025-06-27', 'Berlin', 'Germany', '2024-12-06', 'https://databasetheory.org/PODS/', 'ACM SIGMOD-SIGACT-SIGART Symposium on Principles of Database Systems', TRUE, TRUE),

-- ACII (SeriesID 31)
(31, 2024, 'ACII 2024', '2024-09-15', '2024-09-18', 'Glasgow', 'UK', '2024-04-26', 'https://acii-conf.net', 'IEEE International Conference on Affective Computing and Intelligent Interaction', TRUE, TRUE),
(31, 2025, 'ACII 2025', '2025-09-22', '2025-09-25', 'Nara', 'Japan', '2025-04-25', 'https://acii-conf.net', 'IEEE International Conference on Affective Computing and Intelligent Interaction', TRUE, TRUE),

-- HRI (SeriesID 35)
(35, 2024, 'HRI 2024', '2024-03-11', '2024-03-14', 'Boulder', 'USA', '2023-10-02', 'https://humanrobotinteraction.org', 'ACM/IEEE International Conference on Human-Robot Interaction', TRUE, TRUE),
(35, 2025, 'HRI 2025', '2025-03-03', '2025-03-06', 'Melbourne', 'Australia', '2024-10-01', 'https://humanrobotinteraction.org', 'ACM/IEEE International Conference on Human-Robot Interaction', TRUE, TRUE),

-- ICASSP (SeriesID 36)
(36, 2024, 'ICASSP 2024', '2024-04-14', '2024-04-19', 'Seoul', 'South Korea', '2023-10-04', 'https://2024.ieeeicassp.org', 'IEEE International Conference on Acoustics, Speech and Signal Processing', TRUE, TRUE),
(36, 2025, 'ICASSP 2025', '2025-04-06', '2025-04-11', 'Hyderabad', 'India', '2024-10-02', 'https://2025.ieeeicassp.org', 'IEEE International Conference on Acoustics, Speech and Signal Processing', TRUE, TRUE),

-- INTERSPEECH (SeriesID 37)
(37, 2024, 'Interspeech 2024', '2024-09-01', '2024-09-05', 'Kos', 'Greece', '2024-03-02', 'https://www.interspeech2024.org', 'Annual Conference of the International Speech Communication Association', TRUE, TRUE),
(37, 2025, 'Interspeech 2025', '2025-08-17', '2025-08-21', 'Rotterdam', 'Netherlands', '2025-03-14', 'https://interspeech2025.org', 'Annual Conference of the International Speech Communication Association', TRUE, TRUE),

-- ICCV (SeriesID 38) -- biennial, 2023 and 2025
(38, 2023, 'ICCV 2023', '2023-10-02', '2023-10-06', 'Paris', 'France', '2023-03-08', 'https://iccv.thecvf.com', 'IEEE International Conference on Computer Vision', TRUE, TRUE),
(38, 2025, 'ICCV 2025', '2025-10-19', '2025-10-23', 'Honolulu', 'USA', '2025-03-03', 'https://iccv.thecvf.com', 'IEEE International Conference on Computer Vision', TRUE, TRUE),

-- ECCV (SeriesID 39) -- biennial, 2024 only
(39, 2024, 'ECCV 2024', '2024-09-29', '2024-10-04', 'Milan', 'Italy', '2024-03-07', 'https://eccv.ecva.net', 'European Conference on Computer Vision', TRUE, TRUE),
(39, 2026, 'ECCV 2026', '2026-09-01', '2026-09-05', 'TBD', 'TBD', '2026-03-01', 'https://eccv.ecva.net', 'European Conference on Computer Vision', TRUE, TRUE),

-- ICIP (SeriesID 41)
(41, 2024, 'ICIP 2024', '2024-10-27', '2024-10-30', 'Abu Dhabi', 'UAE', '2024-04-05', 'https://2024.ieeeicip.org', 'IEEE International Conference on Image Processing', TRUE, TRUE),
(41, 2025, 'ICIP 2025', '2025-09-14', '2025-09-17', 'Anchorage', 'USA', '2025-06-11', 'https://2025.ieeeicip.org', 'IEEE International Conference on Image Processing', TRUE, TRUE),

-- ICRA (SeriesID 33)
(33, 2024, 'ICRA 2024', '2024-05-13', '2024-05-17', 'Yokohama', 'Japan', '2023-09-15', 'https://2024.ieee-icra.org', 'IEEE International Conference on Robotics and Automation', TRUE, TRUE),
(33, 2025, 'ICRA 2025', '2025-05-19', '2025-05-23', 'Atlanta', 'USA', '2024-09-15', 'https://2025.ieee-icra.org', 'IEEE International Conference on Robotics and Automation', TRUE, TRUE),

-- IROS (SeriesID 34)
(34, 2024, 'IROS 2024', '2024-10-14', '2024-10-18', 'Abu Dhabi', 'UAE', '2024-03-01', 'https://iros2024-abudhabi.org', 'IEEE/RSJ International Conference on Intelligent Robots and Systems', TRUE, TRUE),
(34, 2025, 'IROS 2025', '2025-10-19', '2025-10-23', 'Hangzhou', 'China', '2025-03-01', 'https://iros2025.org', 'IEEE/RSJ International Conference on Intelligent Robots and Systems', TRUE, TRUE),

-- CRYPTO (SeriesID 42)
(42, 2024, 'CRYPTO 2024', '2024-08-18', '2024-08-22', 'Santa Barbara', 'USA', '2024-02-13', 'https://www.iacr.org/meetings/crypto/', 'International Cryptology Conference', TRUE, TRUE),
(42, 2025, 'CRYPTO 2025', '2025-08-17', '2025-08-21', 'Santa Barbara', 'USA', '2025-02-11', 'https://www.iacr.org/meetings/crypto/', 'International Cryptology Conference', TRUE, TRUE),

-- EUROCRYPT (SeriesID 43)
(43, 2024, 'EUROCRYPT 2024', '2024-05-26', '2024-05-30', 'Zurich', 'Switzerland', '2023-10-06', 'https://www.iacr.org/meetings/eurocrypt/', 'Annual International Conference on the Theory and Applications of Cryptographic Techniques', TRUE, TRUE),
(43, 2025, 'EUROCRYPT 2025', '2025-05-04', '2025-05-08', 'Madrid', 'Spain', '2024-10-04', 'https://www.iacr.org/meetings/eurocrypt/', 'Annual International Conference on the Theory and Applications of Cryptographic Techniques', TRUE, TRUE),

-- ACL (SeriesID 44)
(44, 2024, 'ACL 2024', '2024-08-11', '2024-08-16', 'Bangkok', 'Thailand', '2024-02-15', 'https://www.aclweb.org/anthology/', 'Annual Meeting of the Association for Computational Linguistics', TRUE, TRUE),
(44, 2025, 'ACL 2025', '2025-07-27', '2025-08-01', 'Vienna', 'Austria', '2025-02-15', 'https://www.aclweb.org/anthology/', 'Annual Meeting of the Association for Computational Linguistics', TRUE, TRUE),

-- EMNLP (SeriesID 45)
(45, 2024, 'EMNLP 2024', '2024-11-12', '2024-11-16', 'Miami', 'USA', '2024-06-01', 'https://aclanthology.org/venues/emnlp/', 'Conference on Empirical Methods in Natural Language Processing', TRUE, TRUE),
(45, 2025, 'EMNLP 2025', '2025-11-09', '2025-11-13', 'Suzhou', 'China', '2025-06-01', 'https://aclanthology.org/venues/emnlp/', 'Conference on Empirical Methods in Natural Language Processing', TRUE, TRUE),

-- NAACL (SeriesID 46)
(46, 2024, 'NAACL 2024', '2024-06-16', '2024-06-21', 'Mexico City', 'Mexico', '2023-12-15', 'https://aclanthology.org/venues/naacl/', 'Annual Conference of the North American Chapter of the ACL', TRUE, TRUE),
(46, 2025, 'NAACL 2025', '2025-04-29', '2025-05-04', 'Albuquerque', 'USA', '2024-10-15', 'https://aclanthology.org/venues/naacl/', 'Annual Conference of the North American Chapter of the ACL', TRUE, TRUE),
-- CogSci (SeriesID 60)
(60, 2024, 'CogSci 2024', '2024-07-24', '2024-07-27', 'Rotterdam', 'Netherlands', '2024-02-01', 'https://cognitivesciencesociety.org', 'Annual Conference of the Cognitive Science Society', TRUE, TRUE),
(60, 2025, 'CogSci 2025', '2025-07-23', '2025-07-26', 'Rio de Janeiro', 'Brazil', '2025-02-02', 'https://cognitivesciencesociety.org', 'Annual Conference of the Cognitive Science Society', TRUE, TRUE),

-- CNS (SeriesID 61)
(61, 2024, 'CNS 2024', '2024-04-13', '2024-04-16', 'Toronto', 'Canada', '2023-11-15', 'https://www.cogneurosociety.org/annual-meeting/', 'Annual Meeting of the Cognitive Neuroscience Society', TRUE, TRUE),
(61, 2025, 'CNS 2025', '2025-03-29', '2025-04-01', 'Boston', 'USA', '2024-11-15', 'https://www.cogneurosociety.org/annual-meeting/', 'Annual Meeting of the Cognitive Neuroscience Society', TRUE, TRUE),

-- APS (SeriesID 62)
(62, 2025, 'APS 2025', '2025-05-22', '2025-05-25', 'Washington DC', 'USA', '2024-12-18', 'https://www.psychologicalscience.org/conventions', 'APS Annual Convention', TRUE, TRUE),
(62, 2026, 'APS 2026', '2026-05-28', '2026-05-30', 'Barcelona', 'Spain', '2025-12-05', 'https://www.psychologicalscience.org/conventions', 'APS Annual Convention', TRUE, TRUE),

-- CCN (SeriesID 63)
(63, 2024, 'CCN 2024', '2024-08-06', '2024-08-09', 'Cambridge', 'USA', '2024-04-15', 'https://2024.ccneuro.org', 'Conference on Cognitive Computational Neuroscience', TRUE, TRUE),
(63, 2025, 'CCN 2025', '2025-08-12', '2025-08-15', 'Amsterdam', 'Netherlands', '2025-04-15', 'https://ccneuro.org', 'Conference on Cognitive Computational Neuroscience', TRUE, TRUE),
-- IEEE VR (SeriesID 32)
(32, 2024, 'IEEE VR 2024', '2024-03-16', '2024-03-21', 'Orlando', 'USA', '2023-10-06', 'https://ieeevr.org', 'IEEE Conference on Virtual Reality and 3D User Interfaces', TRUE, TRUE),
(32, 2025, 'IEEE VR 2025', '2025-03-08', '2025-03-12', 'Saint-Malo', 'France', '2024-10-04', 'https://ieeevr.org', 'IEEE Conference on Virtual Reality and 3D User Interfaces', TRUE, TRUE),

-- SIGGRAPH (SeriesID 40)
(40, 2024, 'SIGGRAPH 2024', '2024-07-28', '2024-08-01', 'Denver', 'USA', '2024-01-23', 'https://s2024.siggraph.org', 'ACM SIGGRAPH Conference on Computer Graphics and Interactive Techniques', TRUE, TRUE),
(40, 2025, 'SIGGRAPH 2025', '2025-08-10', '2025-08-14', 'Vancouver', 'Canada', '2025-01-22', 'https://siggraph.org', 'ACM SIGGRAPH Conference on Computer Graphics and Interactive Techniques', TRUE, TRUE),

-- IEEE Quantum Week (SeriesID 47)
(47, 2024, 'IEEE Quantum Week 2024', '2024-09-15', '2024-09-20', 'Montreal', 'Canada', '2024-04-12', 'https://qce.quantum.ieee.org', 'IEEE International Conference on Quantum Computing and Engineering', TRUE, TRUE),
(47, 2025, 'IEEE Quantum Week 2025', '2025-09-14', '2025-09-19', 'Albuquerque', 'USA', '2025-04-11', 'https://qce.quantum.ieee.org', 'IEEE International Conference on Quantum Computing and Engineering', TRUE, TRUE),

-- BIBM (SeriesID 48)
(48, 2024, 'BIBM 2024', '2024-12-03', '2024-12-06', 'Lisbon', 'Portugal', '2024-08-10', 'https://ieeebibm.org', 'IEEE International Conference on Bioinformatics and Biomedicine', TRUE, TRUE),
(48, 2025, 'BIBM 2025', '2025-11-17', '2025-11-20', 'Shenzhen', 'China', '2025-08-08', 'https://ieeebibm.org', 'IEEE International Conference on Bioinformatics and Biomedicine', TRUE, TRUE),

-- UIST (SeriesID 49)
(49, 2024, 'UIST 2024', '2024-10-13', '2024-10-16', 'Pittsburgh', 'USA', '2024-04-04', 'https://uist.acm.org', 'ACM Symposium on User Interface Software and Technology', TRUE, TRUE),
(49, 2025, 'UIST 2025', '2025-10-05', '2025-10-08', 'Busan', 'South Korea', '2025-04-03', 'https://uist.acm.org', 'ACM Symposium on User Interface Software and Technology', TRUE, TRUE),
-- -------------------------------------------------------
-- 2026 UPCOMING INSTANCES (Reviewing=FALSE, Published=FALSE)
-- -------------------------------------------------------

-- ICSE (SeriesID 1) - confirmed Apr 12-18, Rio de Janeiro
(1, 2026, 'ICSE 2026', '2026-04-12', '2026-04-18', 'Rio de Janeiro', 'Brazil', '2025-10-01', 'https://conf.researchr.org/series/icse', 'The International Conference on Software Engineering', FALSE, FALSE),

-- S&P (SeriesID 2) - confirmed May 18-21, San Francisco
(2, 2026, 'IEEE S&P 2026', '2026-05-18', '2026-05-21', 'San Francisco', 'USA', '2025-11-15', 'https://www.ieee-security.org/TC/SP2026/', 'IEEE Symposium on Security and Privacy', FALSE, FALSE),

-- CVPR (SeriesID 4) - confirmed Jun 6-12, Denver
(4, 2026, 'CVPR 2026', '2026-06-06', '2026-06-12', 'Denver', 'USA', '2025-11-07', 'https://cvpr.thecvf.com', 'IEEE/CVF Conference on Computer Vision and Pattern Recognition', FALSE, FALSE),

-- ASPLOS (SeriesID 14) - confirmed Mar 22-26, Pittsburgh
(14, 2026, 'ASPLOS 2026', '2026-03-22', '2026-03-26', 'Pittsburgh', 'USA', '2025-10-22', 'https://asplos-conference.org', 'ACM International Conference on Architectural Support for Programming Languages and Operating Systems', FALSE, FALSE),

-- SIGMOD (SeriesID 10) - confirmed May 31-Jun 5, Bengaluru
(10, 2026, 'SIGMOD 2026', '2026-05-31', '2026-06-05', 'Bengaluru', 'India', '2025-10-01', 'https://sigmod.org', 'ACM SIGMOD International Conference on Management of Data', FALSE, FALSE),

-- PODS (SeriesID 30) - co-located with SIGMOD, same dates
(30, 2026, 'PODS 2026', '2026-05-31', '2026-06-05', 'Bengaluru', 'India', '2025-12-06', 'https://databasetheory.org/PODS/', 'ACM SIGMOD-SIGACT-SIGART Symposium on Principles of Database Systems', FALSE, FALSE),

-- OSDI (SeriesID 16) - confirmed Jul 13-15, Seattle
(16, 2026, 'OSDI 2026', '2026-07-13', '2026-07-15', 'Seattle', 'USA', '2025-12-11', 'https://www.usenix.org/conferences/byname/179', 'USENIX Symposium on Operating Systems Design and Implementation', FALSE, FALSE),

-- ATC (SeriesID 19) - co-located with OSDI, Jul 13-15, Seattle
(19, 2026, 'USENIX ATC 2026', '2026-07-13', '2026-07-15', 'Seattle', 'USA', '2026-01-14', 'https://www.usenix.org/conferences/byname/131', 'USENIX Annual Technical Conference', FALSE, FALSE),

-- USENIX Security (SeriesID 17) - confirmed Aug 12-14, Baltimore
(17, 2026, 'USENIX Security 2026', '2026-08-12', '2026-08-14', 'Baltimore', 'USA', '2026-02-05', 'https://www.usenix.org/conferences/byname/108', 'USENIX Security Symposium', FALSE, FALSE),

-- NDSS (SeriesID 28) - confirmed Feb 23-27, San Diego (already happened!)
-- Note: NDSS 2026 already occurred Feb 23-27 2026, so mark TRUE TRUE
(28, 2026, 'NDSS 2026', '2026-02-23', '2026-02-27', 'San Diego', 'USA', '2025-09-05', 'https://www.ndss-symposium.org', 'Network and Distributed System Security Symposium', TRUE, TRUE),

-- SOSP (SeriesID 11) - confirmed Sep 29-Oct 2, Prague (biennial)
(11, 2026, 'SOSP 2026', '2026-09-29', '2026-10-02', 'Prague', 'Czech Republic', '2026-04-24', 'https://sosp.org', 'ACM Symposium on Operating Systems Principles', FALSE, FALSE),

-- CHI (SeriesID 12) - confirmed, Barcelona (co-located with APS!)
(12, 2026, 'CHI 2026', '2026-04-25', '2026-04-30', 'Barcelona', 'Spain', '2025-09-05', 'https://chi.acm.org', 'ACM CHI Conference on Human Factors in Computing Systems', FALSE, FALSE),

-- ICML (SeriesID 23) - confirmed Jul 6-12, Seoul
(23, 2026, 'ICML 2026', '2026-07-06', '2026-07-12', 'Seoul', 'South Korea', '2026-01-24', 'https://icml.cc', 'International Conference on Machine Learning', FALSE, FALSE),

-- ICLR (SeriesID 24) - confirmed May 1-5, Brazil
(24, 2026, 'ICLR 2026', '2026-05-01', '2026-05-05', 'Brasilia', 'Brazil', '2025-10-01', 'https://iclr.cc', 'International Conference on Learning Representations', FALSE, FALSE),

-- NeurIPS (SeriesID 22) - confirmed Dec 6+, Sydney
(22, 2026, 'NeurIPS 2026', '2026-12-06', '2026-12-12', 'Sydney', 'Australia', '2026-05-11', 'https://neurips.cc', 'Conference on Neural Information Processing Systems', FALSE, FALSE),

-- AAAI (SeriesID 20) - confirmed Jan 20-27, Singapore
(20, 2026, 'AAAI 2026', '2026-01-20', '2026-01-27', 'Singapore', 'Singapore', '2025-07-25', 'https://aaai.org/conference/aaai/', 'AAAI Conference on Artificial Intelligence', TRUE, TRUE),

-- IAAI (SeriesID 21) - co-located with AAAI
(21, 2026, 'IAAI 2026', '2026-01-20', '2026-01-27', 'Singapore', 'Singapore', '2025-07-25', 'https://aaai.org/conference/aaai/', 'Innovative Applications of Artificial Intelligence', TRUE, TRUE),

-- CRYPTO (SeriesID 42) - confirmed Aug 17-20, Santa Barbara
(42, 2026, 'CRYPTO 2026', '2026-08-17', '2026-08-20', 'Santa Barbara', 'USA', '2026-02-13', 'https://www.iacr.org/meetings/crypto/', 'International Cryptology Conference', FALSE, FALSE),

-- EUROCRYPT (SeriesID 43) - confirmed May 10-14, Rome
(43, 2026, 'EUROCRYPT 2026', '2026-05-10', '2026-05-14', 'Rome', 'Italy', '2025-10-04', 'https://www.iacr.org/meetings/eurocrypt/', 'Annual International Conference on the Theory and Applications of Cryptographic Techniques', FALSE, FALSE),

-- APS (SeriesID 62) - confirmed May 28-30, Barcelona (already in file!)
-- Already exists as (62, 2026...) - skip

-- CogSci (SeriesID 60) - confirmed Jul 22-25, Rio de Janeiro
(60, 2026, 'CogSci 2026', '2026-07-22', '2026-07-25', 'Rio de Janeiro', 'Brazil', '2026-02-02', 'https://cognitivesciencesociety.org', 'Annual Conference of the Cognitive Science Society', FALSE, FALSE),

-- CNS (SeriesID 61) - estimated Apr, Vancouver (confirmed 2026 location)
(61, 2026, 'CNS 2026', '2026-04-11', '2026-04-14', 'Vancouver', 'Canada', '2025-11-15', 'https://www.cogneurosociety.org/annual-meeting/', 'Annual Meeting of the Cognitive Neuroscience Society', FALSE, FALSE),

-- NSDI (SeriesID 18) - estimated Apr, based on pattern
(18, 2026, 'NSDI 2026', '2026-04-27', '2026-04-29', 'Raleigh', 'USA', '2025-09-12', 'https://www.usenix.org/conferences/byname/135', 'USENIX Symposium on Networked Systems Design and Implementation', FALSE, FALSE),

-- KDD (SeriesID 15) - confirmed Jul/Aug, Jeju Korea
(15, 2026, 'KDD 2026', '2026-08-02', '2026-08-06', 'Jeju', 'South Korea', '2026-02-01', 'https://kdd.org', 'ACM SIGKDD Conference on Knowledge Discovery and Data Mining', FALSE, FALSE),

-- INTERSPEECH (SeriesID 37) - confirmed Sep 1-4, Rome
(37, 2026, 'Interspeech 2026', '2026-09-01', '2026-09-04', 'Rome', 'Italy', '2026-03-14', 'https://interspeech2026.org', 'Annual Conference of the International Speech Communication Association', FALSE, FALSE),

-- ICASSP (SeriesID 36) - estimated Apr, based on pattern
(36, 2026, 'ICASSP 2026', '2026-04-12', '2026-04-17', 'Seoul', 'South Korea', '2025-10-04', 'https://2026.ieeeicassp.org', 'IEEE International Conference on Acoustics, Speech and Signal Processing', FALSE, FALSE);

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
-- NOTE - IMPORTANT INFORMATION REGARDING TUPLES: 
--
-- Excluding SERIES_TAGGED_WITH and INSTANCE_TAGGED_WITH, the 
-- following populated tuples are EXCLUSIVELY seed data to demonstrate a
-- minimally viable collection of interaction datapoints such that we can 
-- demonstrate a working recommender algorithm. 
-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------

-- 
-- Table structure for `USER`
--

CREATE TABLE `USER` (
  `UserID` int(8) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `DisplayName` varchar(255) NOT NULL,
  `CreatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (UserID),
  UNIQUE (Email)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER`


INSERT INTO `USER` (`UserID`, `Email`, `PasswordHash`, `DisplayName`, `CreatedAt`) VALUES
(1, 'alice_ml@fakemail.com', 'hash_alice_001', 'Alice_ML', '2024-01-15 09:00:00'),
(2, 'bob_sec@fakemail.com', 'hash_bob_002', 'Bob_Sec', '2024-01-16 10:30:00'),
(3, 'carol_nlp@fakemail.com', 'hash_carol_003', 'Carol_NLP', '2024-02-01 08:45:00'),
(4, 'dave_sys@fakemail.com', 'hash_dave_004', 'Dave_Sys', '2024-02-10 14:00:00'),
(5, 'eve_hci@fakemail.com', 'hash_eve_005', 'Eve_HCI', '2024-03-05 11:15:00'),
(6, 'frank_robot@fakemail.com', 'hash_frank_006', 'Frank_Robot', '2024-03-20 09:30:00'),
(7, 'grace_vision@fakemail.com', 'hash_grace_007', 'Grace_Vision', '2024-04-01 13:00:00'),
(8, 'hal_theory@fakemail.com', 'hash_hal_008', 'Hal_Theory', '2024-04-15 10:00:00'),
(9, 'iris_cogsci@fakemail.com', 'hash_iris_009', 'Iris_CogSci', '2024-05-01 08:00:00'),
(10, 'jules_data@fakemail.com', 'hash_jules_010', 'Jules_Data', '2024-05-10 15:30:00'),
(11, 'kai_rl@fakemail.com', 'hash_kai_011', 'Kai_RL', '2024-06-01 09:00:00'),
(12, 'luna_net@fakemail.com', 'hash_luna_012', 'Luna_Net', '2024-06-15 11:00:00'),
(13, 'max_quant@fakemail.com', 'hash_max_013', 'Max_Quant', '2024-07-01 10:00:00'),
(14, 'nina_ethics@fakemail.com', 'hash_nina_014', 'Nina_Ethics', '2024-07-15 14:00:00'),
(15, 'omar_multi@fakemail.com', 'hash_omar_015', 'Omar_Multi', '2024-08-01 09:30:00'),
(16, 'zoe_affect@fakemail.com', 'hash_zoe_016', 'Zoe_Affect', '2024-08-15 08:00:00'),
(17, 'orguser_01@fakemail.com', 'hash_org_017', 'OrgUser_01', '2024-09-01 10:00:00'),
(18, 'adminuser_01@fakemail.com', 'hash_admin_018', 'AdminUser_01', '2024-09-01 10:01:00'),
(19, 'adminuser_02@fakemail.com', 'hash_admin_019', 'AdminUser_02', '2024-09-02 10:00:00'),
(20, 'adminuser_03@fakemail.com', 'hash_admin_020', 'AdminUser_03', '2024-09-03 10:00:00'),
(21, 'adminuser_04@fakemail.com', 'hash_admin_021', 'AdminUser_04', '2024-09-04 10:00:00'),
(22, 'orguser_02@fakemail.com', 'hash_org_022', 'OrgUser_02', '2024-09-05 10:00:00'),
(23, 'orguser_03@fakemail.com', 'hash_org_023', 'OrgUser_03', '2024-09-06 10:00:00'),
(24, 'orguser_04@fakemail.com', 'hash_org_024', 'OrgUser_04', '2024-09-07 10:00:00'),
(25, 'orguser_05@fakemail.com', 'hash_org_025', 'OrgUser_05', '2024-09-08 10:00:00');
-- --------------------------------------------------------

-- 
-- Table structure for USER SUBCLASSES
--

CREATE TABLE RESEARCHER (
  `UserID` int(8) NOT NULL,
  PRIMARY KEY (UserID),
  FOREIGN KEY (UserID) REFERENCES `USER`(UserID)
      ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `RESEARCHER` (`UserID`) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16);

CREATE TABLE ADMIN (
  `UserID` int(8) NOT NULL,
  PRIMARY KEY (UserID),
  FOREIGN KEY (UserID) REFERENCES `USER`(UserID)
      ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `ADMIN` (`UserID`) VALUES
(16), (18), (19), (20), (21);

CREATE TABLE ORGANIZER (
  `UserID` int(8) NOT NULL,
  PRIMARY KEY (UserID),
  FOREIGN KEY (UserID) REFERENCES `USER`(UserID)
      ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `ORGANIZER` (`UserID`) VALUES
(17), (22), (23), (24), (25);

-- --------------------------------------------------------

-- 
-- Table structure for `COLLECTION`
--

CREATE TABLE COLLECTION (
  `CollectionID` int(8) NOT NULL,
  `CreatorUserID` int(8) NOT NULL,
  `Name` varchar(255),
  `Visibility` ENUM('Private','Public') DEFAULT 'Private',
  `CreatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (CollectionID),
  FOREIGN KEY (CreatorUserID) REFERENCES RESEARCHER(UserID)
      ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `COLLECTION`
--

INSERT INTO `COLLECTION` (`CollectionID`, `CreatorUserID`, `Name`, `Visibility`, `CreatedAt`) VALUES
(1, 1, 'My ML Conferences', 'Private', '2024-09-05 10:00:00'),
(2, 3, 'NLP Reading List', 'Public', '2024-09-10 11:00:00'),
(3, 9, 'CogSci & Neuro', 'Private', '2024-09-15 09:00:00'),
(4, 16, 'Affect & HRI Venues', 'Public', '2024-09-20 08:00:00'),
(5, 7, 'Vision Conferences', 'Private', '2024-10-01 10:00:00');

-- --------------------------------------------------------

-- 
-- Table structure for `REQUEST`
--

CREATE TABLE REQUEST (
  `RequestID` int(8) NOT NULL,
  `SubmittedByUserID` int(8) NOT NULL,
  `ReviewedByUserID` int(8) NOT NULL,
  `CreatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `PayloadJSON` JSON,
  `Status` varchar(50),
  `RequestType` varchar(100),
  PRIMARY KEY (RequestID),
  FOREIGN KEY (SubmittedByUserID) REFERENCES ORGANIZER(UserID),
  FOREIGN KEY (ReviewedByUserID) REFERENCES ADMIN(UserID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REQUEST`
--

INSERT INTO `REQUEST` (`RequestID`, `SubmittedByUserID`, `ReviewedByUserID`, `CreatedAt`, `PayloadJSON`, `Status`, `RequestType`) VALUES
(1, 17, 16, '2024-10-01 10:00:00', '{"action": "add_venue", "name": "Workshop on Affective AI"}', 'approved', 'add_venue'),
(2, 22, 18, '2024-10-15 11:00:00', '{"action": "add_venue", "name": "Symposium on Human-AI Teaming"}', 'pending', 'add_venue'),
(3, 23, 19, '2024-11-01 09:00:00', '{"action": "edit_venue", "seriesID": 31}', 'approved', 'edit_venue'),
(4, 24, 20, '2024-11-15 14:00:00', '{"action": "add_venue", "name": "Workshop on Quantum ML"}', 'rejected', 'add_venue'),
(5, 25, 21, '2024-12-01 10:00:00', '{"action": "add_venue", "name": "Forum on AI Safety"}', 'pending', 'add_venue');

-- --------------------------------------------------------

-- 
-- Table structure for `BOOKMARKS`
--

CREATE TABLE BOOKMARKS (
  `UserID` int(8) NOT NULL,
  `SeriesID` int(8) NOT NULL,
  `Year` int(8) NOT NULL,
  `BookmarkedTimestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (UserID, SeriesID, Year),
  FOREIGN KEY (UserID) REFERENCES RESEARCHER(UserID),
  FOREIGN KEY (SeriesID, Year) REFERENCES VENUE_INSTANCE(SeriesID, Year)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `BOOKMARKS`
--

INSERT INTO `BOOKMARKS` (`UserID`, `SeriesID`, `Year`, `BookmarkedTimestamp`) VALUES
-- Alice_ML
(1, 22, 2025, '2024-12-10 09:30:00'),
(1, 23, 2025, '2025-01-25 09:30:00'),
(1, 24, 2025, '2024-10-02 14:30:00'),
-- Bob_Sec
(2, 9, 2024, '2024-09-03 09:40:00'),
(2, 17, 2025, '2025-01-23 10:30:00'),
(2, 2, 2025, '2024-11-16 10:00:00'),
-- Carol_NLP
(3, 44, 2025, '2025-02-16 09:30:00'),
(3, 45, 2024, '2024-09-21 10:40:00'),
(3, 22, 2025, '2024-12-10 09:00:00'),
-- Dave_Sys
(4, 16, 2025, '2025-01-10 09:30:00'),
(4, 11, 2025, '2025-04-25 10:00:00'),
(4, 14, 2025, '2025-03-31 09:00:00'),
-- Eve_HCI
(5, 12, 2025, '2025-01-15 10:30:00'),
(5, 31, 2025, '2025-04-26 09:00:00'),
(5, 49, 2025, '2025-10-06 10:00:00'),
-- Frank_Robot
(6, 33, 2025, '2025-01-20 10:30:00'),
(6, 34, 2025, '2025-10-20 09:00:00'),
(6, 35, 2025, '2025-03-04 10:00:00'),
-- Grace_Vision
(7, 4, 2025, '2025-01-28 09:30:00'),
(7, 38, 2025, '2024-10-20 09:40:00'),
(7, 39, 2026, '2024-10-13 11:40:00'),
-- Hal_Theory
(8, 8, 2025, '2025-01-05 10:30:00'),
(8, 13, 2025, '2025-01-20 09:00:00'),
(8, 7, 2025, '2025-06-17 10:00:00'),
-- Iris_CogSci
(9, 60, 2025, '2025-02-03 09:30:00'),
(9, 62, 2026, '2024-10-17 14:40:00'),
(9, 63, 2025, '2025-08-13 10:00:00'),
-- Jules_Data
(10, 25, 2025, '2025-01-12 10:30:00'),
(10, 10, 2025, '2025-06-23 09:00:00'),
(10, 15, 2025, '2025-08-04 10:00:00'),
-- Kai_RL
(11, 22, 2025, '2025-01-18 10:30:00'),
(11, 23, 2025, '2025-07-14 09:00:00'),
(11, 24, 2025, '2025-04-25 10:00:00'),
-- Luna_Net
(12, 6, 2025, '2025-01-22 10:30:00'),
(12, 18, 2025, '2025-04-29 09:00:00'),
(12, 28, 2025, '2025-02-25 10:00:00'),
-- Max_Quant
(13, 47, 2025, '2025-01-26 09:30:00'),
(13, 26, 2025, '2025-06-22 10:00:00'),
(13, 27, 2025, '2025-10-19 09:00:00'),
-- Nina_Ethics
(14, 20, 2025, '2025-01-30 10:30:00'),
(14, 62, 2026, '2024-10-27 14:40:00'),
(14, 29, 2025, '2025-02-27 09:00:00'),
-- Omar_Multi
(15, 36, 2025, '2025-01-14 10:30:00'),
(15, 37, 2025, '2025-08-18 09:00:00'),
(15, 44, 2025, '2025-07-28 10:00:00'),
-- Zoe_Affect
(16, 31, 2025, '2025-04-26 09:30:00'),
(16, 62, 2026, '2025-01-16 10:30:00'),
(16, 60, 2025, '2025-07-24 09:00:00');

-- --------------------------------------------------------

-- 
-- Table structure for `DISMISSES`
--

CREATE TABLE DISMISSES (
  `UserID` int(8) NOT NULL,
  `SeriesID` int(8) NOT NULL,
  `Year` int(8) NOT NULL,
  `DismissedTimestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (UserID, SeriesID, Year),
  FOREIGN KEY (UserID) REFERENCES RESEARCHER(UserID),
  FOREIGN KEY (SeriesID, Year) REFERENCES VENUE_INSTANCE(SeriesID, Year)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DISMISSES`
--

INSERT INTO `DISMISSES` (`UserID`, `SeriesID`, `Year`, `DismissedTimestamp`) VALUES
-- Alice_ML dismisses security/systems venues
(1, 9, 2024, '2024-10-05 10:00:00'),
(1, 16, 2024, '2024-10-06 10:00:00'),
(1, 28, 2024, '2024-10-07 10:00:00'),
(1, 42, 2024, '2024-10-08 10:00:00'),
(1, 6, 2024, '2024-10-09 10:00:00'),
-- Bob_Sec dismisses ML/vision venues
(2, 22, 2024, '2024-10-05 11:00:00'),
(2, 4, 2024, '2024-10-06 11:00:00'),
(2, 23, 2024, '2024-10-07 11:00:00'),
(2, 38, 2025, '2024-10-08 11:00:00'),
(2, 60, 2024, '2024-10-09 11:00:00'),
-- Carol_NLP dismisses systems/architecture
(3, 16, 2024, '2024-10-05 12:00:00'),
(3, 26, 2024, '2024-10-06 12:00:00'),
(3, 27, 2024, '2024-10-07 12:00:00'),
(3, 47, 2024, '2024-10-08 12:00:00'),
(3, 48, 2024, '2024-10-09 12:00:00'),
-- Dave_Sys dismisses cog sci/HCI
(4, 60, 2024, '2024-10-05 13:00:00'),
(4, 62, 2025, '2024-10-06 13:00:00'),
(4, 31, 2024, '2024-10-07 13:00:00'),
(4, 49, 2024, '2024-10-08 13:00:00'),
(4, 63, 2024, '2024-10-09 13:00:00'),
-- Eve_HCI dismisses theory/systems
(5, 8, 2024, '2024-10-05 14:00:00'),
(5, 13, 2024, '2024-10-06 14:00:00'),
(5, 16, 2024, '2024-10-07 14:00:00'),
(5, 47, 2024, '2024-10-08 14:00:00'),
(5, 27, 2024, '2024-10-09 14:00:00');

-- --------------------------------------------------------

-- 
-- Table structure for `VIEWS`
--

CREATE TABLE VIEWS (
  `UserID` int(8) NOT NULL,
  `SeriesID` int(8) NOT NULL,
  `Year` int(8) NOT NULL,
  `ViewedTimestamp` TIMESTAMP,
  `DurationSec` int(8) NOT NULL,
  PRIMARY KEY (UserID, SeriesID, Year, ViewedTimestamp),
  FOREIGN KEY (UserID) REFERENCES RESEARCHER(UserID),
  FOREIGN KEY (SeriesID, Year) REFERENCES VENUE_INSTANCE(SeriesID, Year),
  CHECK (DurationSec >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `VIEWS`
--

INSERT INTO `VIEWS` (`UserID`, `SeriesID`, `Year`, `ViewedTimestamp`, `DurationSec`) VALUES
-- Alice_ML: NeurIPS, ICML, ICLR, occasional CVPR
(1, 22, 2024, '2024-09-01 10:10:00', 420),
(1, 22, 2025, '2024-12-10 09:00:00', 380),
(1, 23, 2024, '2024-09-02 11:00:00', 310),
(1, 24, 2025, '2024-10-02 14:00:00', 290),
(1, 4, 2024, '2024-10-20 10:00:00', 180),
(1, 23, 2025, '2025-01-25 09:00:00', 340),

-- Bob_Sec: CCS, S&P, USENIX Sec, NDSS, occasional SOSP
(2, 9, 2024, '2024-09-03 09:10:00', 390),
(2, 2, 2024, '2024-09-10 14:10:00', 420),
(2, 17, 2024, '2024-10-02 10:10:00', 360),
(2, 28, 2024, '2024-10-21 11:10:00', 310),
(2, 11, 2023, '2024-11-05 09:10:00', 150),
(2, 17, 2025, '2025-01-23 10:00:00', 400),

-- Carol_NLP: ACL, EMNLP, NAACL, NeurIPS, occasional CHI
(3, 44, 2024, '2024-09-04 08:10:00', 350),
(3, 45, 2024, '2024-09-21 10:10:00', 380),
(3, 46, 2024, '2024-10-06 09:10:00', 300),
(3, 22, 2024, '2024-10-26 14:10:00', 250),
(3, 12, 2024, '2024-11-10 11:10:00', 120),
(3, 44, 2025, '2025-02-16 09:00:00', 370),

-- Dave_Sys: OSDI, SOSP, ATC, NSDI, ASPLOS
(4, 16, 2024, '2024-09-05 10:10:00', 430),
(4, 11, 2023, '2024-09-19 13:10:00', 410),
(4, 19, 2024, '2024-10-03 09:10:00', 360),
(4, 18, 2024, '2024-10-23 11:10:00', 390),
(4, 14, 2024, '2024-11-08 10:10:00', 340),
(4, 16, 2025, '2025-01-10 09:00:00', 420),

-- Eve_HCI: CHI, UIST, ACII, IEEE VR
(5, 12, 2024, '2024-09-06 11:10:00', 400),
(5, 49, 2024, '2024-09-23 14:10:00', 370),
(5, 31, 2024, '2024-10-09 10:10:00', 350),
(5, 32, 2024, '2024-10-29 09:10:00', 320),
(5, 60, 2024, '2024-11-12 11:10:00', 200),
(5, 12, 2025, '2025-01-15 10:00:00', 380),

-- Frank_Robot: ICRA, IROS, HRI, NeurIPS, occasional CVPR
(6, 33, 2024, '2024-09-07 09:10:00', 440),
(6, 34, 2024, '2024-09-27 13:10:00', 410),
(6, 35, 2024, '2024-10-11 10:10:00', 380),
(6, 22, 2024, '2024-10-31 14:10:00', 280),
(6, 4, 2024, '2024-11-14 09:10:00', 160),
(6, 33, 2025, '2025-01-20 10:00:00', 430),

-- Grace_Vision: CVPR, ICCV, ECCV, ICIP
(7, 4, 2024, '2024-09-08 10:10:00', 450),
(7, 38, 2025, '2024-10-20 09:10:00', 420),
(7, 39, 2024, '2024-10-13 11:10:00', 400),
(7, 41, 2024, '2024-11-02 10:10:00', 350),
(7, 22, 2024, '2024-11-16 14:10:00', 200),
(7, 4, 2025, '2025-01-28 09:00:00', 440),

-- Hal_Theory: STOC, PLDI, POPL, PODS
(8, 8, 2024, '2024-09-09 09:10:00', 380),
(8, 7, 2024, '2024-09-29 13:10:00', 360),
(8, 13, 2024, '2024-10-15 10:10:00', 340),
(8, 30, 2024, '2024-11-04 11:10:00', 320),
(8, 10, 2024, '2024-11-18 09:10:00', 150),
(8, 8, 2025, '2025-01-05 10:00:00', 370),

-- Iris_CogSci: CogSci, CNS, APS, CCN, occasional NeurIPS
(9, 60, 2024, '2024-09-10 08:10:00', 420),
(9, 61, 2024, '2024-10-01 10:10:00', 400),
(9, 62, 2025, '2024-10-17 14:10:00', 380),
(9, 63, 2024, '2024-11-06 09:10:00', 360),
(9, 22, 2024, '2024-11-20 11:10:00', 200),
(9, 61, 2025, '2025-01-08 10:00:00', 390),

-- Jules_Data: SIGMOD, VLDB, KDD, PODS
(10, 10, 2024, '2024-09-11 10:10:00', 410),
(10, 25, 2024, '2024-10-02 13:10:00', 390),
(10, 15, 2024, '2024-10-19 10:10:00', 370),
(10, 30, 2024, '2024-11-08 11:10:00', 350),
(10, 8, 2024, '2024-11-22 09:10:00', 140),
(10, 25, 2025, '2025-01-12 10:00:00', 400),

-- Kai_RL: NeurIPS, ICML, ICLR, ICRA, occasional AAAI
(11, 22, 2024, '2024-09-12 09:10:00', 460),
(11, 23, 2024, '2024-10-04 13:10:00', 430),
(11, 24, 2024, '2024-10-21 10:10:00', 410),
(11, 33, 2024, '2024-11-10 11:10:00', 340),
(11, 20, 2024, '2024-11-24 09:10:00', 200),
(11, 22, 2025, '2025-01-18 10:00:00', 450),

-- Luna_Net: SIGCOMM, INFOCOM, NSDI, NDSS, occasional OSDI
(12, 6, 2024, '2024-09-13 10:10:00', 400),
(12, 3, 2024, '2024-10-06 13:10:00', 380),
(12, 18, 2024, '2024-10-23 10:10:00', 360),
(12, 28, 2024, '2024-11-12 11:10:00', 340),
(12, 16, 2024, '2024-11-26 09:10:00', 160),
(12, 6, 2025, '2025-01-22 10:00:00', 390),

-- Max_Quant: IEEE Quantum Week, ISCA, MICRO, occasional STOC
(13, 47, 2024, '2024-09-16 09:10:00', 420),
(13, 26, 2024, '2024-10-08 13:10:00', 390),
(13, 27, 2024, '2024-11-03 10:10:00', 370),
(13, 8, 2024, '2024-11-14 11:10:00', 200),
(13, 47, 2025, '2025-01-26 09:00:00', 410),

-- Nina_Ethics: AAAI, SIGCSE, APS, CHI, occasional NeurIPS
(14, 20, 2024, '2024-09-15 08:10:00', 390),
(14, 29, 2024, '2024-10-10 10:10:00', 370),
(14, 62, 2025, '2024-10-27 14:10:00', 350),
(14, 12, 2024, '2024-11-16 09:10:00', 320),
(14, 22, 2024, '2024-11-28 11:10:00', 180),
(14, 20, 2025, '2025-01-30 10:00:00', 380),

-- Omar_Multi: ICASSP, INTERSPEECH, ACL, ACII, occasional ICLR
(15, 36, 2024, '2024-09-16 10:10:00', 410),
(15, 37, 2024, '2024-10-12 13:10:00', 390),
(15, 44, 2024, '2024-10-29 10:10:00', 360),
(15, 31, 2024, '2024-11-18 11:10:00', 340),
(15, 24, 2024, '2024-12-01 09:10:00', 190),
(15, 36, 2025, '2025-01-14 10:00:00', 400),

-- Zoe_Affect: ACII, CogSci, CNS, CHI, HRI, APS, occasional NeurIPS
(16, 31, 2024, '2024-09-17 08:10:00', 440),
(16, 60, 2024, '2024-10-14 10:10:00', 420),
(16, 61, 2024, '2024-10-31 14:10:00', 400),
(16, 12, 2024, '2024-11-20 09:10:00', 380),
(16, 35, 2024, '2024-12-03 11:10:00', 360),
(16, 62, 2025, '2025-01-16 10:00:00', 420),
(16, 22, 2024, '2024-12-10 14:00:00', 240);

-- --------------------------------------------------------

-- 
-- Table structure for `CLICKS_EXT_LINK`
--

CREATE TABLE CLICKS_EXT_LINK (
  `UserID` int(8) NOT NULL,
  `SeriesID` int(8) NOT NULL,
  `Year` int(8) NOT NULL,
  `ClickedTimestamp` TIMESTAMP,
  `LinkType` varchar(100) NOT NULL,
  PRIMARY KEY (UserID, SeriesID, Year, ClickedTimestamp),
  FOREIGN KEY (UserID) REFERENCES RESEARCHER(UserID),
  FOREIGN KEY (SeriesID, Year) REFERENCES VENUE_INSTANCE(SeriesID, Year)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CLICKS_EXT_LINK`
--

INSERT INTO `CLICKS_EXT_LINK` (`UserID`, `SeriesID`, `Year`, `ClickedTimestamp`, `LinkType`) VALUES
-- Alice_ML clicks CFP links on ML venues
(1, 22, 2025, '2024-12-10 09:35:00', 'CFP'),
(1, 23, 2025, '2025-01-25 09:35:00', 'CFP'),
(1, 24, 2025, '2024-10-02 14:35:00', 'CFP'),
(1, 4, 2025, '2025-01-29 10:00:00', 'website'),
(1, 22, 2024, '2024-09-01 10:20:00', 'website'),
-- Bob_Sec
(2, 9, 2024, '2024-09-03 09:45:00', 'CFP'),
(2, 17, 2025, '2025-01-23 10:35:00', 'CFP'),
(2, 2, 2024, '2024-09-10 14:35:00', 'website'),
(2, 28, 2025, '2025-09-06 10:00:00', 'CFP'),
(2, 42, 2024, '2024-08-19 10:00:00', 'website'),
-- Carol_NLP
(3, 44, 2025, '2025-02-16 09:35:00', 'CFP'),
(3, 45, 2025, '2025-11-10 09:00:00', 'CFP'),
(3, 46, 2025, '2025-04-30 10:00:00', 'CFP'),
(3, 22, 2025, '2024-12-10 09:05:00', 'website'),
(3, 45, 2024, '2024-09-21 10:45:00', 'website'),
-- Frank_Robot
(6, 33, 2025, '2025-01-20 10:35:00', 'CFP'),
(6, 34, 2025, '2025-10-20 09:05:00', 'CFP'),
(6, 35, 2025, '2025-03-04 10:05:00', 'CFP'),
(6, 22, 2025, '2025-12-03 09:00:00', 'website'),
(6, 33, 2024, '2024-09-07 09:20:00', 'website'),
-- Zoe_Affect
(16, 31, 2025, '2025-04-26 09:35:00', 'CFP'),
(16, 62, 2026, '2025-01-16 10:35:00', 'CFP'),
(16, 60, 2025, '2025-07-24 09:05:00', 'CFP'),
(16, 61, 2025, '2025-03-30 10:00:00', 'website'),
(16, 12, 2025, '2025-04-27 09:00:00', 'website');

-- --------------------------------------------------------

-- 
-- Table structure for `INTERACTS_WITH`
--

CREATE TABLE INTERACTS_WITH (
  `UserID` int(8) NOT NULL,
  `TopicID` int(8) NOT NULL,
  `clickedTimestamp` TIMESTAMP,
  PRIMARY KEY (UserID, TopicID, clickedTimestamp),
  FOREIGN KEY (UserID) REFERENCES RESEARCHER(UserID),
  FOREIGN KEY (TopicID) REFERENCES TOPIC(TopicID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `INTERACTS_WITH`
--

INSERT INTO `INTERACTS_WITH` (`UserID`, `TopicID`, `clickedTimestamp`) VALUES
-- Alice_ML: ML, Deep Learning, RL
(1, 1, '2024-09-01 10:00:00'),
(1, 2, '2024-09-01 10:05:00'),
(1, 3, '2024-09-15 14:00:00'),
(1, 7, '2024-10-01 09:00:00'),
(1, 37, '2024-10-15 11:00:00'),

-- Bob_Sec: Network Security, Privacy, Cryptography, Malware
(2, 23, '2024-09-02 09:00:00'),
(2, 25, '2024-09-02 09:30:00'),
(2, 24, '2024-09-10 14:00:00'),
(2, 26, '2024-10-01 10:00:00'),
(2, 27, '2024-10-20 11:00:00'),

-- Carol_NLP: NLP, LLMs, Multimodal AI
(3, 4, '2024-09-03 08:00:00'),
(3, 5, '2024-09-03 08:15:00'),
(3, 7, '2024-09-20 10:00:00'),
(3, 37, '2024-10-05 09:00:00'),
(3, 1, '2024-10-25 14:00:00'),

-- Dave_Sys: OS, Distributed Systems, Architecture
(4, 28, '2024-09-04 10:00:00'),
(4, 30, '2024-09-04 10:30:00'),
(4, 29, '2024-09-18 13:00:00'),
(4, 31, '2024-10-02 09:00:00'),
(4, 27, '2024-10-22 11:00:00'),

-- Eve_HCI: HCI, Affective Computing, Mixed Reality
(5, 20, '2024-09-05 11:00:00'),
(5, 17, '2024-09-05 11:20:00'),
(5, 21, '2024-09-22 14:00:00'),
(5, 22, '2024-10-08 10:00:00'),
(5, 51, '2024-10-28 09:00:00'),

-- Frank_Robot: Robotics, Embodied AI, HRI
(6, 18, '2024-09-06 09:00:00'),
(6, 10, '2024-09-06 09:30:00'),
(6, 19, '2024-09-25 13:00:00'),
(6, 6, '2024-10-10 10:00:00'),
(6, 1, '2024-10-30 14:00:00'),

-- Grace_Vision: Computer Vision, Image Processing, Video
(7, 6, '2024-09-07 10:00:00'),
(7, 15, '2024-09-07 10:20:00'),
(7, 16, '2024-09-26 11:00:00'),
(7, 2, '2024-10-12 09:00:00'),
(7, 7, '2024-11-01 14:00:00'),

-- Hal_Theory: Algorithms, PL, Formal Methods, Logic
(8, 38, '2024-09-08 09:00:00'),
(8, 39, '2024-09-08 09:30:00'),
(8, 40, '2024-09-28 13:00:00'),
(8, 42, '2024-10-14 10:00:00'),
(8, 41, '2024-11-03 11:00:00'),

-- Iris_CogSci: Cognitive Science, Computational Neuroscience, Psych
(9, 51, '2024-09-09 08:00:00'),
(9, 52, '2024-09-09 08:30:00'),
(9, 53, '2024-09-30 10:00:00'),
(9, 17, '2024-10-16 14:00:00'),
(9, 9, '2024-11-05 09:00:00'),

-- Jules_Data: Databases, Data Mining, Information Retrieval
(10, 33, '2024-09-10 10:00:00'),
(10, 34, '2024-09-10 10:30:00'),
(10, 35, '2024-10-01 13:00:00'),
(10, 36, '2024-10-18 09:00:00'),
(10, 37, '2024-11-07 11:00:00'),

-- Kai_RL: Reinforcement Learning, Embodied AI, ML
(11, 3, '2024-09-11 09:00:00'),
(11, 10, '2024-09-11 09:30:00'),
(11, 1, '2024-10-03 13:00:00'),
(11, 2, '2024-10-20 10:00:00'),
(11, 12, '2024-11-09 14:00:00'),

-- Luna_Net: Networking, Distributed Systems, Security
(12, 32, '2024-09-12 10:00:00'),
(12, 30, '2024-09-12 10:30:00'),
(12, 46, '2024-10-05 13:00:00'),
(12, 23, '2024-10-22 09:00:00'),
(12, 28, '2024-11-11 11:00:00'),

-- Max_Quant: Quantum Computing, HPC, Architecture
(13, 43, '2024-09-13 09:00:00'),
(13, 31, '2024-09-13 09:30:00'),
(13, 29, '2024-10-07 13:00:00'),
(13, 38, '2024-10-24 10:00:00'),
(13, 50, '2024-11-13 14:00:00'),

-- Nina_Ethics: AI Ethics, Fairness, Society, CS Education
(14, 8, '2024-09-14 08:00:00'),
(14, 45, '2024-09-14 08:30:00'),
(14, 44, '2024-10-09 10:00:00'),
(14, 53, '2024-10-26 14:00:00'),
(14, 1, '2024-11-15 09:00:00'),

-- Omar_Multi: Speech, Audio, NLP, Multimodal, Affective
(15, 13, '2024-09-15 10:00:00'),
(15, 14, '2024-09-15 10:30:00'),
(15, 4, '2024-10-11 13:00:00'),
(15, 7, '2024-10-28 09:00:00'),
(15, 17, '2024-11-17 11:00:00'),

-- Zoe_Affect: Affective Computing, CogSci, Neuro, HRI, HCI
(16, 17, '2024-09-16 08:00:00'),
(16, 51, '2024-09-16 08:30:00'),
(16, 52, '2024-10-13 10:00:00'),
(16, 19, '2024-10-30 14:00:00'),
(16, 20, '2024-11-19 09:00:00');

-- --------------------------------------------------------

-- 
-- Table structure for `SERIES_TAGGED_WITH`
--

CREATE TABLE SERIES_TAGGED_WITH (
  `SeriesID` int(8) NOT NULL,
  `TopicID` int(8) NOT NULL,
  PRIMARY KEY (SeriesID, TopicID),
  FOREIGN KEY (SeriesID) REFERENCES VENUE_SERIES(SeriesID),
  FOREIGN KEY (TopicID) REFERENCES TOPIC(TopicID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SERIES_TAGGED_WITH`
--

INSERT INTO `SERIES_TAGGED_WITH` (`SeriesID`, `TopicID`) VALUES
-- ICSE (1): Software Engineering, Formal Methods, Programming Languages
(1, 41), (1, 40), (1, 39),

-- S&P (2): Network Security, Privacy, Malware & Forensics, Cryptography
(2, 23), (2, 25), (2, 26), (2, 24),

-- INFOCOM (3): Networking, Wireless & Mobile, Distributed Systems
(3, 32), (3, 46), (3, 30),

-- CVPR (4): Computer Vision, Deep Learning, Image Processing, Video & Motion Analysis
(4, 6), (4, 2), (4, 15), (4, 16),

-- ICDM (5): Data Mining, Machine Learning, Big Data, Datasets & Benchmarks
(5, 34), (5, 1), (5, 36), (5, 37),

-- SIGCOMM (6): Networking, Distributed Systems, Wireless & Mobile
(6, 32), (6, 30), (6, 46),

-- PLDI (7): Programming Languages, Formal Methods, Software Engineering
(7, 39), (7, 40), (7, 41),

-- STOC (8): Algorithms & Complexity, Logic in CS, Theory
(8, 38), (8, 42),

-- CCS (9): Network Security, Cryptography, Privacy, Malware & Forensics
(9, 23), (9, 24), (9, 25), (9, 26),

-- SIGMOD (10): Databases, Data Mining, Information Retrieval, Big Data
(10, 33), (10, 34), (10, 35), (10, 36),

-- SOSP (11): Operating Systems, Distributed Systems, Computer Architecture
(11, 28), (11, 30), (11, 29),

-- CHI (12): Human-Computer Interaction, Affective Computing, HRI, Ubiquitous Computing
(12, 20), (12, 17), (12, 19), (12, 22),

-- POPL (13): Programming Languages, Logic in CS, Formal Methods, Algorithms & Complexity
(13, 39), (13, 42), (13, 40), (13, 38),

-- ASPLOS (14): Computer Architecture, Operating Systems, Programming Languages
(14, 29), (14, 28), (14, 39),

-- KDD (15): Data Mining, Machine Learning, Big Data, Datasets & Benchmarks, Information Retrieval
(15, 34), (15, 1), (15, 36), (15, 37), (15, 35),

-- OSDI (16): Operating Systems, Distributed Systems, Computer Architecture
(16, 28), (16, 30), (16, 29),

-- USENIX Security (17): Network Security, Privacy, Malware & Forensics, Cryptography, Dependable Systems
(17, 23), (17, 25), (17, 26), (17, 24), (17, 27),

-- NSDI (18): Networking, Distributed Systems, Operating Systems
(18, 32), (18, 30), (18, 28),

-- ATC (19): Operating Systems, Distributed Systems, High Performance Computing
(19, 28), (19, 30), (19, 31),

-- AAAI (20): Machine Learning, Deep Learning, NLP, Reinforcement Learning, AI Ethics & Fairness, Neurosymbolic AI, Embodied AI
(20, 1), (20, 2), (20, 4), (20, 3), (20, 8), (20, 11), (20, 10),

-- IAAI (21): Machine Learning, AI Impacts & Society, AI Ethics & Fairness
(21, 1), (21, 45), (21, 8),

-- NeurIPS (22): Machine Learning, Deep Learning, Reinforcement Learning, NLP, Multimodal AI, JEPA, Neurosymbolic AI, Datasets & Benchmarks
(22, 1), (22, 2), (22, 3), (22, 4), (22, 7), (22, 12), (22, 11), (22, 37),

-- ICML (23): Machine Learning, Deep Learning, Reinforcement Learning, Algorithms & Complexity, Datasets & Benchmarks
(23, 1), (23, 2), (23, 3), (23, 38), (23, 37),

-- ICLR (24): Deep Learning, Machine Learning, NLP, Computer Vision, Multimodal AI, JEPA
(24, 2), (24, 1), (24, 4), (24, 6), (24, 7), (24, 12),

-- VLDB (25): Databases, Big Data, Data Mining, Information Retrieval
(25, 33), (25, 36), (25, 34), (25, 35),

-- ISCA (26): Computer Architecture, High Performance Computing, Operating Systems
(26, 29), (26, 31), (26, 28),

-- MICRO (27): Computer Architecture, High Performance Computing, Operating Systems
(27, 29), (27, 31), (27, 28),

-- NDSS (28): Network Security, Privacy, Malware & Forensics, Dependable Systems
(28, 23), (28, 25), (28, 26), (28, 27),

-- SIGCSE (29): CS Education, AI Ethics & Fairness, AI Impacts & Society
(29, 44), (29, 8), (29, 45),

-- PODS (30): Databases, Algorithms & Complexity, Logic in CS
(30, 33), (30, 38), (30, 42),

-- ACII (31): Affective Computing, Human-Computer Interaction, Speech Processing, Multimodal AI
(31, 17), (31, 20), (31, 13), (31, 7),

-- HRI (35): Human-Robot Interaction, Robotics, Human-Computer Interaction, Embodied AI
(35, 19), (35, 18), (35, 20), (35, 10),

-- ICASSP (36): Speech Processing, Audio & Music Computing, Image Processing, Machine Learning
(36, 13), (36, 14), (36, 15), (36, 1),

-- INTERSPEECH (37): Speech Processing, Audio & Music Computing, NLP, Affective Computing
(37, 13), (37, 14), (37, 4), (37, 17),

-- ICCV (38): Computer Vision, Deep Learning, Image Processing, Video & Motion Analysis
(38, 6), (38, 2), (38, 15), (38, 16),

-- ECCV (39): Computer Vision, Deep Learning, Image Processing, Video & Motion Analysis
(39, 6), (39, 2), (39, 15), (39, 16),

-- ICIP (41): Image Processing, Computer Vision, Video & Motion Analysis
(41, 15), (41, 6), (41, 16),

-- ICRA (33): Robotics, Embodied AI, Human-Robot Interaction, Computer Vision, Machine Learning
(33, 18), (33, 10), (33, 19), (33, 6), (33, 1),

-- IROS (34): Robotics, Embodied AI, Human-Robot Interaction, Computer Vision
(34, 18), (34, 10), (34, 19), (34, 6),

-- CRYPTO (42): Cryptography, Network Security, Privacy
(42, 24), (42, 23), (42, 25),

-- EUROCRYPT (43): Cryptography, Network Security, Privacy
(43, 24), (43, 23), (43, 25),

-- ACL (44): NLP, Large Language Models, Machine Learning, Multimodal AI, Datasets & Benchmarks
(44, 4), (44, 5), (44, 1), (44, 7), (44, 37),

-- EMNLP (45): NLP, Large Language Models, Machine Learning, Information Retrieval
(45, 4), (45, 5), (45, 1), (45, 35),

-- NAACL (46): NLP, Large Language Models, Machine Learning, Speech Processing
(46, 4), (46, 5), (46, 1), (46, 13),
-- CogSci (60): Cognitive Science, NLP, Neurosymbolic AI, HCI, Affective Computing, Psychological Science
(60, 51), (60, 4), (60, 11), (60, 20), (60, 17), (60, 53),

-- CNS (61): Computational Neuroscience, Cognitive Science, Machine Learning, AI for Science
(61, 52), (61, 51), (61, 1), (61, 9),

-- APS (62): Psychological Science, Cognitive Science, Affective Computing, AI Ethics & Fairness
(62, 53), (62, 51), (62, 17), (62, 8),

-- CCN (63): Computational Neuroscience, Machine Learning, Cognitive Science, Reinforcement Learning, Embodied AI
(63, 52), (63, 1), (63, 51), (63, 3), (63, 10),

-- CACM (50): Software Engineering, Algorithms & Complexity, Distributed Systems, AI Ethics & Fairness
(50, 41), (50, 38), (50, 30), (50, 8),

-- JAIR (51): Machine Learning, Deep Learning, NLP, Neurosymbolic AI, AI for Science
(51, 1), (51, 2), (51, 4), (51, 11), (51, 9),

-- TNNLS (52): Deep Learning, Machine Learning, Reinforcement Learning, Computational Neuroscience
(52, 2), (52, 1), (52, 3), (52, 52),

-- TOPLAS (53): Programming Languages, Formal Methods, Logic in CS
(53, 39), (53, 40), (53, 42),

-- IC (54): Formal Methods, Algorithms & Complexity, Logic in CS
(54, 40), (54, 38), (54, 42),

-- Nature (55): AI for Science, Computational Neuroscience, Cognitive Science, Datasets & Benchmarks
(55, 9), (55, 52), (55, 51), (55, 37),

-- Nature Human Behaviour (56): Psychological Science, Cognitive Science, Affective Computing, AI Ethics & Fairness
(56, 53), (56, 51), (56, 17), (56, 8),

-- Nature Neuroscience (57): Computational Neuroscience, Cognitive Science, AI for Science
(57, 52), (57, 51), (57, 9),

-- Cognitive Science Journal (58): Cognitive Science, NLP, Computational Neuroscience, Psychological Science
(58, 51), (58, 4), (58, 52), (58, 53),

-- Neural Computation (59): Computational Neuroscience, Machine Learning, Deep Learning, Cognitive Science
(59, 52), (59, 1), (59, 2), (59, 51),
-- IEEE VR (32): Mixed & Augmented Reality, HCI, Computer Vision, Embodied AI
(32, 21), (32, 20), (32, 6), (32, 10),

-- SIGGRAPH (40): Computer Graphics & Animation, Human Motion Analysis, Computer Vision, HCI
(40, 48), (40, 49), (40, 6), (40, 20),

-- IEEE Quantum Week (47): Quantum Computing, Algorithms & Complexity, Computer Architecture
(47, 43), (47, 38), (47, 29),

-- BIBM (48): AI for Science, Machine Learning, Datasets & Benchmarks, Computational Neuroscience
(48, 9), (48, 1), (48, 37), (48, 52),

-- UIST (49): HCI, Ubiquitous Computing, Mixed & Augmented Reality, Affective Computing
(49, 20), (49, 22), (49, 21), (49, 17);

-- --------------------------------------------------------

-- 
-- Table structure for `INSTANCE_TAGGED_WITH`
--

CREATE TABLE INSTANCE_TAGGED_WITH (
  `SeriesID` int(8) NOT NULL,
  `Year` int(8) NOT NULL,
  `TopicID` int(8) NOT NULL,
  PRIMARY KEY (SeriesID, Year, TopicID),
  FOREIGN KEY (SeriesID, Year) REFERENCES VENUE_INSTANCE(SeriesID, Year),
  FOREIGN KEY (TopicID) REFERENCES TOPIC(TopicID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `INSTANCE_TAGGED_WITH`
--

INSERT INTO `INSTANCE_TAGGED_WITH` (`SeriesID`, `Year`, `TopicID`) VALUES
-- NeurIPS 2024: spike in Embodied AI, RL, Datasets & Benchmarks
(22, 2024, 10),  -- Embodied AI
(22, 2024, 3),   -- Reinforcement Learning
(22, 2024, 37),  -- Datasets & Benchmarks
(22, 2024, 7),   -- Multimodal AI

-- NeurIPS 2025: LLM Reasoning, AI for Science, Multimodal dominant
(22, 2025, 5),   -- Large Language Models
(22, 2025, 9),   -- AI for Science
(22, 2025, 7),   -- Multimodal AI
(22, 2025, 8),   -- AI Ethics & Fairness (position paper track)

-- ICLR 2025: JEPA / world models pronounced
(24, 2025, 12),  -- JEPA
(24, 2025, 10),  -- Embodied AI

-- AAAI 2025: heavier ethics and societal impact
(20, 2025, 8),   -- AI Ethics & Fairness
(20, 2025, 45);  -- AI Impacts & Society

-- --------------------------------------------------------

-- 
-- Table structure for `COLLECTION_CONTAINS`
--

CREATE TABLE COLLECTION_CONTAINS (
  `CollectionID` INT,
  `SeriesID` INT,
  `Year` INT,
  PRIMARY KEY (CollectionID, SeriesID, Year),
  FOREIGN KEY (CollectionID) REFERENCES COLLECTION(CollectionID),
  FOREIGN KEY (SeriesID, Year) REFERENCES VENUE_INSTANCE(SeriesID, Year)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `COLLECTION_CONTAINS`
--

INSERT INTO `COLLECTION_CONTAINS` (`CollectionID`, `SeriesID`, `Year`) VALUES
-- Alice_ML's ML collection
(1, 22, 2025),
(1, 23, 2025),
(1, 24, 2025),
-- Carol_NLP's NLP collection
(2, 44, 2025),
(2, 45, 2024),
(2, 46, 2025),
-- Iris_CogSci's CogSci collection
(3, 60, 2025),
(3, 61, 2025),
(3, 63, 2025),
-- Zoe_Affect's collection
(4, 31, 2025),
(4, 62, 2026),
(4, 35, 2025),
-- Grace_Vision's collection
(5, 4, 2025),
(5, 38, 2025),
(5, 39, 2024);