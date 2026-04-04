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
  `OrgID` int(8) NOT NULL AUTO_INCREMENT,
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

INSERT INTO `ORGANIZATION` (`Name`, `Website`, `Society`, `Publisher`, `University`) VALUES
('IEEE', 'https://www.ieee.org', 'IEEE', 'IEEE Press', NULL),
('ACM', 'https://www.acm.org', 'ACM', 'ACM Digital Library', NULL),
('Springer', 'https://www.springer.com', NULL, 'Springer Nature', NULL),
('Elsevier', 'https://www.elsevier.com', NULL, 'Elsevier', NULL),
('USENIX', 'https://www.usenix.org', 'USENIX Association', 'USENIX', NULL),
('AAAI', 'https://www.aaai.org', 'AAAI', 'AAAI Press', NULL),
('ISOC', 'https://www.internetsociety.org', 'Internet Society', NULL, NULL),
('IACR', 'https://www.iacr.org', 'IACR', 'IACR', NULL),
('IFIP', 'https://www.ifip.org', 'IFIP', NULL, NULL),
('ACL', 'https://www.aclweb.org', 'ACL', 'ACL Anthology', NULL),
('ISCA', 'https://www.isca-speech.org', 'International Speech Communication Association', NULL, NULL),
('APS', 'https://www.psychologicalscience.org', 'Association for Psychological Science', NULL, NULL),
('Cognitive Science Society', 'https://cognitivesciencesociety.org', 'Cognitive Science Society', NULL, NULL),
('Cognitive Neuroscience Society', 'https://www.cogneurosociety.org', 'Cognitive Neuroscience Society', NULL, NULL),
('Nature Portfolio', 'https://www.nature.com', NULL, 'Springer Nature', NULL),
('MIT Press', 'https://mitpress.mit.edu', NULL, 'MIT Press', NULL),
('NeurIPS Foundation', 'https://neurips.cc', 'NeurIPS Foundation', NULL, NULL),
('IMLS', 'https://icml.cc', 'International Machine Learning Society', NULL, NULL),
('ICLR', 'https://iclr.cc', 'ICLR', NULL, NULL),
('VLDB Endowment', 'https://vldb.org', NULL, 'VLDB Endowment', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for `VENUE_SERIES`
--

CREATE TABLE VENUE_SERIES (
  `SeriesID` int(8) NOT NULL AUTO_INCREMENT,
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

INSERT INTO `VENUE_SERIES` (`OrgID`, `Name`, `Acronym`, `Description`, `ActiveFlag`) VALUES
-- IEEE
(1, 'International Conference on Software Engineering', 'ICSE', 'Premier software engineering conference', TRUE),
(1, 'IEEE Symposium on Security and Privacy', 'S&P', 'Top venue for security and privacy research', TRUE),
(1, 'IEEE International Conference on Computer Communications', 'INFOCOM', 'Leading networking and communications conference', TRUE),
(1, 'IEEE Conference on Computer Vision and Pattern Recognition', 'CVPR', 'Premier computer vision conference', TRUE),
(1, 'IEEE International Conference on Data Mining', 'ICDM', 'Leading data mining conference', TRUE),
(1, 'International Symposium on Computer Architecture', 'ISCA', 'Premier computer architecture conference', TRUE),
(1, 'IEEE/ACM International Symposium on Microarchitecture', 'MICRO', 'Top microarchitecture conference', TRUE),
(1, 'IEEE International Conference on Affective Computing and Intelligent Interaction', 'ACII', 'Premier affective computing conference', TRUE),
(1, 'IEEE International Conference on Robotics and Automation', 'ICRA', 'Largest robotics conference', TRUE),
(1, 'IEEE/RSJ International Conference on Intelligent Robots and Systems', 'IROS', 'Leading intelligent robots conference', TRUE),
(1, 'IEEE International Conference on Acoustics, Speech and Signal Processing', 'ICASSP', 'Premier speech and signal processing conference', TRUE),
(1, 'IEEE International Conference on Computer Vision', 'ICCV', 'Top computer vision conference, held biennially', TRUE),
(1, 'European Conference on Computer Vision', 'ECCV', 'Leading European computer vision conference', TRUE),
(1, 'IEEE International Conference on Image Processing', 'ICIP', 'Leading image processing conference', TRUE),
-- ACM
(2, 'ACM Special Interest Group on Data Communication', 'SIGCOMM', 'Premier data networking conference', TRUE),
(2, 'ACM SIGPLAN Conference on Programming Language Design and Implementation', 'PLDI', 'Top programming languages conference', TRUE),
(2, 'ACM Symposium on Theory of Computing', 'STOC', 'Premier theory of computing conference', TRUE),
(2, 'ACM Conference on Computer and Communications Security', 'CCS', 'Leading security conference', TRUE),
(2, 'ACM SIGMOD International Conference on Management of Data', 'SIGMOD', 'Premier database conference', TRUE),
(2, 'ACM Symposium on Operating Systems Principles', 'SOSP', 'Top operating systems conference', TRUE),
(2, 'ACM CHI Conference on Human Factors in Computing Systems', 'CHI', 'Premier HCI conference', TRUE),
(2, 'ACM SIGPLAN Symposium on Principles of Programming Languages', 'POPL', 'Leading PL theory conference', TRUE),
(2, 'ACM International Conference on Architectural Support for Programming Languages and Operating Systems', 'ASPLOS', 'Top systems and architecture conference', TRUE),
(2, 'ACM SIGKDD Conference on Knowledge Discovery and Data Mining', 'KDD', 'Premier data mining and KDD conference', TRUE),
(17, 'Conference on Neural Information Processing Systems', 'NeurIPS', 'Premier ML and AI conference', TRUE),
(18, 'International Conference on Machine Learning', 'ICML', 'Leading machine learning conference', TRUE),
(19, 'International Conference on Learning Representations', 'ICLR', 'Top deep learning conference', TRUE),
(20, 'International Conference on Very Large Data Bases', 'VLDB', 'Leading database systems conference', TRUE),
(2, 'ACM SIGCSE Technical Symposium on Computer Science Education', 'SIGCSE', 'Premier CS education conference', TRUE),
(2, 'ACM SIGMOD-SIGACT-SIGART Symposium on Principles of Database Systems', 'PODS', 'Leading database theory conference', TRUE),
(2, 'ACM/IEEE International Conference on Human-Robot Interaction', 'HRI', 'Premier human-robot interaction conference', TRUE),
-- USENIX
(5, 'USENIX Symposium on Operating Systems Design and Implementation', 'OSDI', 'Top systems conference', TRUE),
(5, 'USENIX Security Symposium', 'USENIX Security', 'Leading security conference', TRUE),
(5, 'USENIX Symposium on Networked Systems Design and Implementation', 'NSDI', 'Top networked systems conference', TRUE),
(5, 'USENIX Annual Technical Conference', 'ATC', 'Broad systems research conference', TRUE),
-- AAAI
(6, 'AAAI Conference on Artificial Intelligence', 'AAAI', 'Premier broad AI conference', TRUE),
(6, 'Innovative Applications of Artificial Intelligence', 'IAAI', 'Applied AI conference', TRUE),
-- ISOC
(7, 'Network and Distributed System Security Symposium', 'NDSS', 'Top network security conference', TRUE),
-- IACR
(8, 'International Cryptology Conference', 'CRYPTO', 'Premier cryptography conference', TRUE),
(8, 'European Cryptology Conference', 'EUROCRYPT', 'Leading European cryptography conference', TRUE),
-- ACL
(10, 'Annual Meeting of the Association for Computational Linguistics', 'ACL', 'Premier NLP conference', TRUE),
(10, 'Conference on Empirical Methods in Natural Language Processing', 'EMNLP', 'Top empirical NLP conference', TRUE),
(10, 'North American Chapter of the ACL', 'NAACL', 'Leading North American NLP conference', TRUE),
-- Interspeech (ISCA org - need OrgID)
(11, 'Interspeech', 'INTERSPEECH', 'Premier speech processing conference', TRUE),
-- Journals (CS)
(2, 'Communications of the ACM', 'CACM', 'Flagship ACM publication covering all areas of CS', TRUE),
(4, 'Journal of Artificial Intelligence Research', 'JAIR', 'Open-access journal covering all areas of AI', TRUE),
(1, 'IEEE Transactions on Neural Networks and Learning Systems', 'TNNLS', 'IEEE journal on neural networks and ML', TRUE),
(2, 'ACM Transactions on Programming Languages and Systems', 'TOPLAS', 'ACM journal on PL theory and implementation', TRUE),
(4, 'Information and Computation', 'IC', 'Elsevier journal on theoretical CS and logic', TRUE),
-- Journals (Cog Sci / Neuro / Nature)
(15, 'Nature', 'Nature', 'Premier multidisciplinary science journal', TRUE),
(15, 'Nature Human Behaviour', 'NHB', 'Nature journal covering human behaviour research', TRUE),
(15, 'Nature Neuroscience', 'NatNeuro', 'Nature journal on neuroscience', TRUE),
(16, 'Cognitive Science', 'CogSci-J', 'Official journal of the Cognitive Science Society', TRUE),
(16, 'Neural Computation', 'NeuralComp', 'MIT Press journal on computational neuroscience', TRUE),
-- Conferences (Cog Sci / Neuro / Psych)
(13, 'Annual Conference of the Cognitive Science Society', 'CogSci', 'Premier interdisciplinary cognitive science conference', TRUE),
(14, 'Annual Meeting of the Cognitive Neuroscience Society', 'CNS', 'Premier cognitive neuroscience conference', TRUE),
(12, 'APS Annual Convention', 'APS', 'Premier psychological science convention', TRUE),
(14, 'Conference on Cognitive Computational Neuroscience', 'CCN', 'Computational approaches to brain and cognition', TRUE),
(1, 'IEEE Conference on Virtual Reality and 3D User Interfaces', 'IEEE VR', 'Premier conference on virtual and augmented reality', TRUE),
(2, 'ACM SIGGRAPH Conference on Computer Graphics and Interactive Techniques', 'SIGGRAPH', 'Premier computer graphics and interactive techniques conference', TRUE),
(1, 'IEEE International Conference on Quantum Computing and Engineering', 'IEEE Quantum Week', 'Leading quantum computing conference', TRUE),
(1, 'IEEE International Conference on Bioinformatics and Biomedicine', 'BIBM', 'Premier bioinformatics and biomedicine conference', TRUE),
(2, 'ACM Symposium on User Interface Software and Technology', 'UIST', 'Leading HCI and user interface conference', TRUE);

-- --------------------------------------------------------

-- 
-- Table structure for `CONFERENCE_SERIES`
--

CREATE TABLE CONFERENCE_SERIES (
  `SeriesID` int(8) NOT NULL AUTO_INCREMENT,
  `TypicalMonth` int(8) NOT NULL,
  `TypicalCityPolicy` varchar(255) NOT NULL,
  `Tier` varchar(100),
  PRIMARY KEY (SeriesID),
  FOREIGN KEY (SeriesID) REFERENCES VENUE_SERIES(SeriesID)
      ON DELETE CASCADE,
  CHECK (TypicalMonth BETWEEN 1 AND 12)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CONFERENCE_SERIES`
--

INSERT INTO `CONFERENCE_SERIES` (`SeriesID`, `TypicalMonth`, `TypicalCityPolicy`, `Tier`) VALUES
(1, 4, 'Rotating international cities', '1'),
(2, 5, 'San Francisco, CA (fixed)', '1'),
(3, 5, 'Rotating international cities', '1'),
(4, 6, 'Rotating US cities', '1'),
(5, 11, 'Rotating international cities', '2'),
(6, 6, 'Rotating international cities', '1'),
(7, 10, 'Rotating international cities', '1'),
(8, 9, 'Rotating international cities', '3'),
(9, 5, 'Rotating international cities', '1'),
(10, 10, 'Rotating international cities', '1'),
(11, 4, 'Rotating international cities', '2'),
(12, 10, 'Rotating international cities', '1'),
(13, 9, 'Rotating European cities', '1'),
(14, 9, 'Rotating international cities', '2'),
(15, 8, 'Rotating international cities', '1'),
(16, 6, 'Rotating international cities', '1'),
(17, 6, 'Rotating international cities', '1'),
(18, 11, 'Rotating international cities', '1'),
(19, 6, 'Rotating international cities', '1'),
(20, 10, 'Rotating international cities', '1'),
(21, 4, 'Rotating international cities', '1'),
(22, 1, 'Rotating international cities', '1'),
(23, 3, 'Rotating international cities', '1'),
(24, 8, 'Rotating international cities', '1'),
(25, 12, 'New Orleans, LA / Vancouver, BC', '1'),
(26, 7, 'Rotating international cities', '1'),
(27, 4, 'Rotating international cities', '1'),
(28, 8, 'Rotating international cities', '1'),
(29, 3, 'Rotating US/Canada cities', '2'),
(30, 6, 'Rotating international cities', '1'),
(31, 3, 'Rotating international cities', '2'),
(32, 11, 'Rotating US cities', '1'),
(33, 8, 'Rotating US cities', '1'),
(34, 4, 'Rotating US cities', '1'),
(35, 7, 'Rotating US cities', '2'),
(36, 2, 'Rotating US cities', '1'),
(37, 2, 'Rotating US cities', '3'),
(38, 2, 'San Diego, CA (fixed)', '1'),
(39, 8, 'Rotating international cities', '1'),
(40, 5, 'Rotating European cities', '1'),
(41, 7, 'Rotating international cities', '1'),
(42, 11, 'Rotating international cities', '1'),
(43, 6, 'Rotating North American cities', '2'),
(44, 9, 'Rotating international cities', '2'),
(55, 7, 'Rotating international cities', '3'),
(56, 3, 'Rotating US/Canada cities', '3'),
(57, 5, 'Rotating international cities', '3'),
(58, 8, 'Rotating international cities', '3'),
(59, 3, 'Rotating international cities', '2'),
(60, 8, 'Rotating international cities', '1'),
(61, 9, 'Denver, CO (fixed)', '3'),
(62, 11, 'Rotating international cities', '3'),
(63, 10, 'Rotating international cities', '1');   -- UIST: October

-- --------------------------------------------------------

-- 
-- Table structure for `TOPIC`
--

CREATE TABLE TOPIC (
  TopicID int(8) NOT NULL AUTO_INCREMENT,
  Name varchar(255) NOT NULL,
  PRIMARY KEY (TopicID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `TOPIC`
--
INSERT INTO `TOPIC` (`Name`) VALUES
-- AI- / ML-related
('Machine Learning'),
('Deep Learning'),
('Reinforcement Learning'),
('Natural Language Processing'),
('Large Language Models'),
('Computer Vision'),
('Multimodal AI'),
('AI Ethics & Fairness'),
('AI for Science'),
('Embodied AI'),
('Neurosymbolic AI'),
('Joint Embedding Predictive Architecture'),
-- Perception / Signal Processing
('Speech Processing'),
('Audio & Music Computing'),
('Image Processing'),
('Video & Motion Analysis'),
('Affective Computing'),
-- Robotics / Interaction Subfields
('Robotics'),
('Human-Robot Interaction'),
('Human-Computer Interaction'),
('Mixed & Augmented Reality'),
('Ubiquitous Computing'),
-- Security / Cryptography
('Network Security'),
('Cryptography'),
('Privacy'),
('Malware & Forensics'),
('Dependable Systems'),
-- Systems / Architecture
('Operating Systems'),
('Computer Architecture'),
('Distributed Systems'),
('High Performance Computing'),
('Networking'),
-- Data (Retrieval, Manipulation, Storage, Systems)
('Databases'),
('Data Mining'),
('Information Retrieval'),
('Big Data'),
('Datasets & Benchmarks'),
-- Theory / Programming
('Algorithms & Complexity'),
('Programming Languages'),
('Formal Methods'),
('Software Engineering'),
('Logic in CS'),
-- Emerging / Frontier / Crossdisciplinary
('Quantum Computing'),
('CS Education'),
('AI Impacts & Society'),
-- Other
('Wireless & Mobile Computing'),
('Information Systems'),
('Computer Graphics & Animation'),
('Human Motion Analysis'),
('Parallel Computing'),
-- COGS / Neuro-type topics
('Cognitive Science'),
('Computational Neuroscience'),
('Psychological Science');

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
  `CFP_URL` varchar(255) NULL,
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
(15, 2024, 'SIGCOMM 2024', '2024-08-04', '2024-08-08', 'Sydney', 'Australia', '2024-02-02', 'https://www.sigcomm.org/events/sigcomm-conference', 'ACM Special Interest Group on Data Communication', TRUE, TRUE),
(15, 2025, 'SIGCOMM 2025', '2025-09-08', '2025-09-11', 'Coimbra', 'Portugal', '2025-02-07', 'https://www.sigcomm.org/events/sigcomm-conference', 'ACM Special Interest Group on Data Communication', TRUE, TRUE),

-- PLDI (SeriesID 7)
(16, 2024, 'PLDI 2024', '2024-06-24', '2024-06-28', 'Copenhagen', 'Denmark', '2023-11-16', 'https://pldi.acm.org', 'ACM SIGPLAN Conference on Programming Language Design and Implementation', TRUE, TRUE),
(16, 2025, 'PLDI 2025', '2025-06-16', '2025-06-20', 'Seoul', 'South Korea', '2024-11-14', 'https://pldi.acm.org', 'ACM SIGPLAN Conference on Programming Language Design and Implementation', TRUE, TRUE),

-- STOC (SeriesID 8)
(17, 2024, 'STOC 2024', '2024-06-23', '2024-06-26', 'Vancouver', 'Canada', '2023-11-03', 'https://acm-stoc.org', 'ACM Symposium on Theory of Computing', TRUE, TRUE),
(17, 2025, 'STOC 2025', '2025-06-23', '2025-06-27', 'Prague', 'Czech Republic', '2024-11-04', 'https://acm-stoc.org', 'ACM Symposium on Theory of Computing', TRUE, TRUE),

-- CCS (SeriesID 9)
(18, 2024, 'CCS 2024', '2024-10-14', '2024-10-18', 'Salt Lake City', 'USA', '2024-05-15', 'https://www.sigsac.org/ccs.html', 'ACM Conference on Computer and Communications Security', TRUE, TRUE),
(18, 2025, 'CCS 2025', '2025-10-13', '2025-10-17', 'Taipei', 'Taiwan', '2025-05-15', 'https://www.sigsac.org/ccs.html', 'ACM Conference on Computer and Communications Security', TRUE, TRUE),

-- SIGMOD (SeriesID 10)
(19, 2024, 'SIGMOD 2024', '2024-06-09', '2024-06-15', 'Santiago', 'Chile', '2023-10-01', 'https://sigmod.org', 'ACM SIGMOD International Conference on Management of Data', TRUE, TRUE),
(19, 2025, 'SIGMOD 2025', '2025-06-22', '2025-06-27', 'Berlin', 'Germany', '2024-10-01', 'https://sigmod.org', 'ACM SIGMOD International Conference on Management of Data', TRUE, TRUE),

-- SOSP (SeriesID 11) -- biennial, so 2023 and 2025
(20, 2023, 'SOSP 2023', '2023-10-23', '2023-10-26', 'Koblenz', 'Germany', '2023-05-04', 'https://sosp.org', 'ACM Symposium on Operating Systems Principles', TRUE, TRUE),
(20, 2025, 'SOSP 2025', '2025-10-13', '2025-10-16', 'Prague', 'Czech Republic', '2025-04-24', 'https://sosp.org', 'ACM Symposium on Operating Systems Principles', TRUE, TRUE),

-- CHI (SeriesID 12)
(21, 2024, 'CHI 2024', '2024-05-11', '2024-05-16', 'Honolulu', 'USA', '2023-09-14', 'https://chi.acm.org', 'ACM CHI Conference on Human Factors in Computing Systems', TRUE, TRUE),
(21, 2025, 'CHI 2025', '2025-04-26', '2025-05-01', 'Yokohama', 'Japan', '2024-09-05', 'https://chi.acm.org', 'ACM CHI Conference on Human Factors in Computing Systems', TRUE, TRUE),

-- POPL (SeriesID 13)
(22, 2024, 'POPL 2024', '2024-01-17', '2024-01-19', 'London', 'UK', '2023-07-11', 'https://popl.mpi-sws.org', 'ACM SIGPLAN Symposium on Principles of Programming Languages', TRUE, TRUE),
(22, 2025, 'POPL 2025', '2025-01-19', '2025-01-24', 'Denver', 'USA', '2024-07-11', 'https://popl.mpi-sws.org', 'ACM SIGPLAN Symposium on Principles of Programming Languages', TRUE, TRUE),

-- ASPLOS (SeriesID 14)
(23, 2024, 'ASPLOS 2024', '2024-04-27', '2024-05-01', 'La Jolla', 'USA', '2023-08-04', 'https://asplos-conference.org', 'ACM International Conference on Architectural Support for Programming Languages and Operating Systems', TRUE, TRUE),
(23, 2025, 'ASPLOS 2025', '2025-03-30', '2025-04-03', 'Rotterdam', 'Netherlands', '2024-08-09', 'https://asplos-conference.org', 'ACM International Conference on Architectural Support for Programming Languages and Operating Systems', TRUE, TRUE),

-- KDD (SeriesID 15)
(24, 2024, 'KDD 2024', '2024-08-25', '2024-08-29', 'Barcelona', 'Spain', '2024-02-08', 'https://www.kdd.org/kdd2024/', 'ACM SIGKDD Conference on Knowledge Discovery and Data Mining', TRUE, TRUE),
(24, 2025, 'KDD 2025', '2025-08-03', '2025-08-07', 'Toronto', 'Canada', '2025-02-01', 'https://kdd.org', 'ACM SIGKDD Conference on Knowledge Discovery and Data Mining', TRUE, TRUE),

-- OSDI (SeriesID 16)
(32, 2024, 'OSDI 2024', '2024-07-10', '2024-07-12', 'Santa Clara', 'USA', '2023-12-05', 'https://www.usenix.org/conferences/byname/179', 'USENIX Symposium on Operating Systems Design and Implementation', TRUE, TRUE),
(32, 2025, 'OSDI 2025', '2025-07-07', '2025-07-09', 'Boston', 'USA', '2024-12-03', 'https://www.usenix.org/conferences/byname/179', 'USENIX Symposium on Operating Systems Design and Implementation', TRUE, TRUE),

-- USENIX Security (SeriesID 17)
(33, 2024, 'USENIX Security 2024', '2024-08-14', '2024-08-16', 'Philadelphia', 'USA', '2024-02-08', 'https://www.usenix.org/conferences/byname/108', 'USENIX Security Symposium', TRUE, TRUE),
(33, 2025, 'USENIX Security 2025', '2025-08-13', '2025-08-15', 'Seattle', 'USA', '2025-01-22', 'https://www.usenix.org/conferences/byname/108', 'USENIX Security Symposium', TRUE, TRUE),

-- NSDI (SeriesID 18)
(34, 2024, 'NSDI 2024', '2024-04-16', '2024-04-18', 'Santa Clara', 'USA', '2023-09-14', 'https://www.usenix.org/conferences/byname/135', 'USENIX Symposium on Networked Systems Design and Implementation', TRUE, TRUE),
(34, 2025, 'NSDI 2025', '2025-04-28', '2025-04-30', 'Philadelphia', 'USA', '2024-09-12', 'https://www.usenix.org/conferences/byname/135', 'USENIX Symposium on Networked Systems Design and Implementation', TRUE, TRUE),

-- ATC (SeriesID 19)
(35, 2024, 'USENIX ATC 2024', '2024-07-10', '2024-07-12', 'Santa Clara', 'USA', '2024-01-09', 'https://www.usenix.org/conferences/byname/131', 'USENIX Annual Technical Conference', TRUE, TRUE),
(35, 2025, 'USENIX ATC 2025', '2025-07-07', '2025-07-09', 'Boston', 'USA', '2025-01-14', 'https://www.usenix.org/conferences/byname/131', 'USENIX Annual Technical Conference', TRUE, TRUE),

-- AAAI (SeriesID 20)
(36, 2024, 'AAAI 2024', '2024-02-20', '2024-02-27', 'Vancouver', 'Canada', '2023-08-15', 'https://aaai.org/conference/aaai/', 'AAAI Conference on Artificial Intelligence', TRUE, TRUE),
(36, 2025, 'AAAI 2025', '2025-02-25', '2025-03-04', 'Philadelphia', 'USA', '2024-08-07', 'https://aaai.org/conference/aaai/', 'AAAI Conference on Artificial Intelligence', TRUE, TRUE),

-- IAAI (SeriesID 21)
(37, 2024, 'IAAI 2024', '2024-02-20', '2024-02-27', 'Vancouver', 'Canada', '2023-08-15', 'https://aaai.org/conference/aaai/aaai-24/iaai-24-call-for-papers/', 'Innovative Applications of Artificial Intelligence', TRUE, TRUE),
(37, 2025, 'IAAI 2025', '2025-02-25', '2025-03-04', 'Philadelphia', 'USA', '2024-08-07', 'https://aaai.org/conference/aaai/', 'Innovative Applications of Artificial Intelligence', TRUE, TRUE),

-- NeurIPS (SeriesID 22)
(25, 2024, 'NeurIPS 2024', '2024-12-09', '2024-12-15', 'Vancouver', 'Canada', '2024-05-22', 'https://neurips.cc', 'Conference on Neural Information Processing Systems', TRUE, TRUE),
(25, 2025, 'NeurIPS 2025', '2025-12-02', '2025-12-07', 'San Diego', 'USA', '2025-05-11', 'https://neurips.cc', 'Conference on Neural Information Processing Systems', TRUE, TRUE),

-- ICML (SeriesID 23)
(26, 2024, 'ICML 2024', '2024-07-21', '2024-07-27', 'Vienna', 'Austria', '2024-02-01', 'https://icml.cc', 'International Conference on Machine Learning', TRUE, TRUE),
(26, 2025, 'ICML 2025', '2025-07-13', '2025-07-19', 'Vancouver', 'Canada', '2025-01-23', 'https://icml.cc', 'International Conference on Machine Learning', TRUE, TRUE),

-- ICLR (SeriesID 24)
(27, 2024, 'ICLR 2024', '2024-05-07', '2024-05-11', 'Vienna', 'Austria', '2023-10-03', 'https://iclr.cc', 'International Conference on Learning Representations', TRUE, TRUE),
(27, 2025, 'ICLR 2025', '2025-04-24', '2025-04-28', 'Singapore', 'Singapore', '2024-10-01', 'https://iclr.cc', 'International Conference on Learning Representations', TRUE, TRUE),

-- VLDB (SeriesID 25)
(28, 2024, 'VLDB 2024', '2024-08-26', '2024-08-30', 'Guangzhou', 'China', '2023-10-01', 'https://vldb.org/pvldb/', 'International Conference on Very Large Data Bases', TRUE, TRUE),
(28, 2025, 'VLDB 2025', '2025-09-01', '2025-09-05', 'London', 'UK', '2024-10-01', 'https://vldb.org/pvldb/', 'International Conference on Very Large Data Bases', TRUE, TRUE),

-- ISCA (SeriesID 26)
(6, 2024, 'ISCA 2024', '2024-06-29', '2024-07-03', 'Buenos Aires', 'Argentina', '2023-11-17', 'https://iscaconf.org', 'International Symposium on Computer Architecture', TRUE, TRUE),
(6, 2025, 'ISCA 2025', '2025-06-21', '2025-06-25', 'Tokyo', 'Japan', '2024-11-15', 'https://iscaconf.org', 'International Symposium on Computer Architecture', TRUE, TRUE),

-- MICRO (SeriesID 27)
(7, 2024, 'MICRO 2024', '2024-11-02', '2024-11-06', 'Austin', 'USA', '2024-04-19', 'https://microarch.org', 'IEEE/ACM International Symposium on Microarchitecture', TRUE, TRUE),
(7, 2025, 'MICRO 2025', '2025-10-18', '2025-10-22', 'Seoul', 'South Korea', '2025-04-18', 'https://microarch.org', 'IEEE/ACM International Symposium on Microarchitecture', TRUE, TRUE),

-- NDSS (SeriesID 28)
(38, 2024, 'NDSS 2024', '2024-02-26', '2024-03-01', 'San Diego', 'USA', '2023-09-06', 'https://www.ndss-symposium.org', 'Network and Distributed System Security Symposium', TRUE, TRUE),
(38, 2025, 'NDSS 2025', '2025-02-24', '2025-02-28', 'San Diego', 'USA', '2024-09-05', 'https://www.ndss-symposium.org', 'Network and Distributed System Security Symposium', TRUE, TRUE),

-- SIGCSE (SeriesID 29)
(29, 2024, 'SIGCSE 2024', '2024-03-20', '2024-03-23', 'Portland', 'USA', '2023-09-08', 'https://sigcse.org/events/symposia/', 'ACM SIGCSE Technical Symposium on Computer Science Education', TRUE, TRUE),
(29, 2025, 'SIGCSE 2025', '2025-02-26', '2025-03-01', 'Pittsburgh', 'USA', '2024-09-06', 'https://sigcse.org/events/symposia/', 'ACM SIGCSE Technical Symposium on Computer Science Education', TRUE, TRUE),

-- PODS (SeriesID 30)
(30, 2024, 'PODS 2024', '2024-06-09', '2024-06-14', 'Santiago', 'Chile', '2023-12-04', 'https://databasetheory.org/PODS/', 'ACM SIGMOD-SIGACT-SIGART Symposium on Principles of Database Systems', TRUE, TRUE),
(30, 2025, 'PODS 2025', '2025-06-22', '2025-06-27', 'Berlin', 'Germany', '2024-12-06', 'https://databasetheory.org/PODS/', 'ACM SIGMOD-SIGACT-SIGART Symposium on Principles of Database Systems', TRUE, TRUE),

-- ACII (SeriesID 31)
(8, 2024, 'ACII 2024', '2024-09-15', '2024-09-18', 'Glasgow', 'UK', '2024-04-26', 'https://acii-conf.net', 'IEEE International Conference on Affective Computing and Intelligent Interaction', TRUE, TRUE),
(8, 2025, 'ACII 2025', '2025-09-22', '2025-09-25', 'Nara', 'Japan', '2025-04-25', 'https://acii-conf.net', 'IEEE International Conference on Affective Computing and Intelligent Interaction', TRUE, TRUE),

-- HRI (SeriesID 35)
(31, 2024, 'HRI 2024', '2024-03-11', '2024-03-14', 'Boulder', 'USA', '2023-10-02', 'https://humanrobotinteraction.org', 'ACM/IEEE International Conference on Human-Robot Interaction', TRUE, TRUE),
(31, 2025, 'HRI 2025', '2025-03-03', '2025-03-06', 'Melbourne', 'Australia', '2024-10-01', 'https://humanrobotinteraction.org', 'ACM/IEEE International Conference on Human-Robot Interaction', TRUE, TRUE),

-- ICASSP (SeriesID 36)
(11, 2024, 'ICASSP 2024', '2024-04-14', '2024-04-19', 'Seoul', 'South Korea', '2023-10-04', 'https://2024.ieeeicassp.org', 'IEEE International Conference on Acoustics, Speech and Signal Processing', TRUE, TRUE),
(11, 2025, 'ICASSP 2025', '2025-04-06', '2025-04-11', 'Hyderabad', 'India', '2024-10-02', 'https://2025.ieeeicassp.org', 'IEEE International Conference on Acoustics, Speech and Signal Processing', TRUE, TRUE),

-- INTERSPEECH (SeriesID 37)
(44, 2024, 'Interspeech 2024', '2024-09-01', '2024-09-05', 'Kos', 'Greece', '2024-03-02', 'https://www.interspeech2024.org', 'Annual Conference of the International Speech Communication Association', TRUE, TRUE),
(44, 2025, 'Interspeech 2025', '2025-08-17', '2025-08-21', 'Rotterdam', 'Netherlands', '2025-03-14', 'https://interspeech2025.org', 'Annual Conference of the International Speech Communication Association', TRUE, TRUE),

-- ICCV (SeriesID 38) -- biennial, 2023 and 2025
(12, 2023, 'ICCV 2023', '2023-10-02', '2023-10-06', 'Paris', 'France', '2023-03-08', 'https://iccv.thecvf.com', 'IEEE International Conference on Computer Vision', TRUE, TRUE),
(12, 2025, 'ICCV 2025', '2025-10-19', '2025-10-23', 'Honolulu', 'USA', '2025-03-03', 'https://iccv.thecvf.com', 'IEEE International Conference on Computer Vision', TRUE, TRUE),

-- ECCV (SeriesID 39) -- biennial, 2024 only
(13, 2024, 'ECCV 2024', '2024-09-29', '2024-10-04', 'Milan', 'Italy', '2024-03-07', 'https://eccv.ecva.net', 'European Conference on Computer Vision', TRUE, TRUE),
(13, 2026, 'ECCV 2026', '2026-09-01', '2026-09-05', 'TBD', 'TBD', '2026-03-01', 'https://eccv.ecva.net', 'European Conference on Computer Vision', TRUE, TRUE),

-- ICIP (SeriesID 41)
(14, 2024, 'ICIP 2024', '2024-10-27', '2024-10-30', 'Abu Dhabi', 'UAE', '2024-04-05', 'https://2024.ieeeicip.org', 'IEEE International Conference on Image Processing', TRUE, TRUE),
(14, 2025, 'ICIP 2025', '2025-09-14', '2025-09-17', 'Anchorage', 'USA', '2025-06-11', 'https://2025.ieeeicip.org', 'IEEE International Conference on Image Processing', TRUE, TRUE),

-- ICRA (SeriesID 33)
(9, 2024, 'ICRA 2024', '2024-05-13', '2024-05-17', 'Yokohama', 'Japan', '2023-09-15', 'https://2024.ieee-icra.org', 'IEEE International Conference on Robotics and Automation', TRUE, TRUE),
(9, 2025, 'ICRA 2025', '2025-05-19', '2025-05-23', 'Atlanta', 'USA', '2024-09-15', 'https://2025.ieee-icra.org', 'IEEE International Conference on Robotics and Automation', TRUE, TRUE),

-- IROS (SeriesID 34)
(10, 2024, 'IROS 2024', '2024-10-14', '2024-10-18', 'Abu Dhabi', 'UAE', '2024-03-01', 'https://iros2024-abudhabi.org', 'IEEE/RSJ International Conference on Intelligent Robots and Systems', TRUE, TRUE),
(10, 2025, 'IROS 2025', '2025-10-19', '2025-10-23', 'Hangzhou', 'China', '2025-03-01', 'https://iros2025.org', 'IEEE/RSJ International Conference on Intelligent Robots and Systems', TRUE, TRUE),

-- CRYPTO (SeriesID 42)
(39, 2024, 'CRYPTO 2024', '2024-08-18', '2024-08-22', 'Santa Barbara', 'USA', '2024-02-13', 'https://www.iacr.org/meetings/crypto/', 'International Cryptology Conference', TRUE, TRUE),
(39, 2025, 'CRYPTO 2025', '2025-08-17', '2025-08-21', 'Santa Barbara', 'USA', '2025-02-11', 'https://www.iacr.org/meetings/crypto/', 'International Cryptology Conference', TRUE, TRUE),

-- EUROCRYPT (SeriesID 43)
(40, 2024, 'EUROCRYPT 2024', '2024-05-26', '2024-05-30', 'Zurich', 'Switzerland', '2023-10-06', 'https://www.iacr.org/meetings/eurocrypt/', 'Annual International Conference on the Theory and Applications of Cryptographic Techniques', TRUE, TRUE),
(40, 2025, 'EUROCRYPT 2025', '2025-05-04', '2025-05-08', 'Madrid', 'Spain', '2024-10-04', 'https://www.iacr.org/meetings/eurocrypt/', 'Annual International Conference on the Theory and Applications of Cryptographic Techniques', TRUE, TRUE),

-- ACL (SeriesID 44)
(41, 2024, 'ACL 2024', '2024-08-11', '2024-08-16', 'Bangkok', 'Thailand', '2024-02-15', 'https://www.aclweb.org/anthology/', 'Annual Meeting of the Association for Computational Linguistics', TRUE, TRUE),
(41, 2025, 'ACL 2025', '2025-07-27', '2025-08-01', 'Vienna', 'Austria', '2025-02-15', 'https://www.aclweb.org/anthology/', 'Annual Meeting of the Association for Computational Linguistics', TRUE, TRUE),

-- EMNLP (SeriesID 45)
(42, 2024, 'EMNLP 2024', '2024-11-12', '2024-11-16', 'Miami', 'USA', '2024-06-01', 'https://aclanthology.org/venues/emnlp/', 'Conference on Empirical Methods in Natural Language Processing', TRUE, TRUE),
(42, 2025, 'EMNLP 2025', '2025-11-09', '2025-11-13', 'Suzhou', 'China', '2025-06-01', 'https://aclanthology.org/venues/emnlp/', 'Conference on Empirical Methods in Natural Language Processing', TRUE, TRUE),

-- NAACL (SeriesID 46)
(43, 2024, 'NAACL 2024', '2024-06-16', '2024-06-21', 'Mexico City', 'Mexico', '2023-12-15', 'https://aclanthology.org/venues/naacl/', 'Annual Conference of the North American Chapter of the ACL', TRUE, TRUE),
(43, 2025, 'NAACL 2025', '2025-04-29', '2025-05-04', 'Albuquerque', 'USA', '2024-10-15', 'https://aclanthology.org/venues/naacl/', 'Annual Conference of the North American Chapter of the ACL', TRUE, TRUE),
-- CogSci (SeriesID 60)
(55, 2024, 'CogSci 2024', '2024-07-24', '2024-07-27', 'Rotterdam', 'Netherlands', '2024-02-01', 'https://cognitivesciencesociety.org', 'Annual Conference of the Cognitive Science Society', TRUE, TRUE),
(55, 2025, 'CogSci 2025', '2025-07-23', '2025-07-26', 'Rio de Janeiro', 'Brazil', '2025-02-02', 'https://cognitivesciencesociety.org', 'Annual Conference of the Cognitive Science Society', TRUE, TRUE),

-- CNS (SeriesID 61)
(56, 2024, 'CNS 2024', '2024-04-13', '2024-04-16', 'Toronto', 'Canada', '2023-11-15', 'https://www.cogneurosociety.org/annual-meeting/', 'Annual Meeting of the Cognitive Neuroscience Society', TRUE, TRUE),
(56, 2025, 'CNS 2025', '2025-03-29', '2025-04-01', 'Boston', 'USA', '2024-11-15', 'https://www.cogneurosociety.org/annual-meeting/', 'Annual Meeting of the Cognitive Neuroscience Society', TRUE, TRUE),

-- APS (SeriesID 62)
(57, 2025, 'APS 2025', '2025-05-22', '2025-05-25', 'Washington DC', 'USA', '2024-12-18', 'https://www.psychologicalscience.org/conventions', 'APS Annual Convention', TRUE, TRUE),
(57, 2026, 'APS 2026', '2026-05-28', '2026-05-30', 'Barcelona', 'Spain', '2025-12-05', 'https://www.psychologicalscience.org/conventions', 'APS Annual Convention', TRUE, TRUE),

-- CCN (SeriesID 63)
(58, 2024, 'CCN 2024', '2024-08-06', '2024-08-09', 'Cambridge', 'USA', '2024-04-15', 'https://2024.ccneuro.org', 'Conference on Cognitive Computational Neuroscience', TRUE, TRUE),
(58, 2025, 'CCN 2025', '2025-08-12', '2025-08-15', 'Amsterdam', 'Netherlands', '2025-04-15', 'https://ccneuro.org', 'Conference on Cognitive Computational Neuroscience', TRUE, TRUE),
-- IEEE VR (SeriesID 32)
(59, 2024, 'IEEE VR 2024', '2024-03-16', '2024-03-21', 'Orlando', 'USA', '2023-10-06', 'https://ieeevr.org', 'IEEE Conference on Virtual Reality and 3D User Interfaces', TRUE, TRUE),
(59, 2025, 'IEEE VR 2025', '2025-03-08', '2025-03-12', 'Saint-Malo', 'France', '2024-10-04', 'https://ieeevr.org', 'IEEE Conference on Virtual Reality and 3D User Interfaces', TRUE, TRUE),

-- SIGGRAPH (SeriesID 40)
(60, 2024, 'SIGGRAPH 2024', '2024-07-28', '2024-08-01', 'Denver', 'USA', '2024-01-23', 'https://s2024.siggraph.org', 'ACM SIGGRAPH Conference on Computer Graphics and Interactive Techniques', TRUE, TRUE),
(60, 2025, 'SIGGRAPH 2025', '2025-08-10', '2025-08-14', 'Vancouver', 'Canada', '2025-01-22', 'https://siggraph.org', 'ACM SIGGRAPH Conference on Computer Graphics and Interactive Techniques', TRUE, TRUE),

-- IEEE Quantum Week (SeriesID 47)
(61, 2024, 'IEEE Quantum Week 2024', '2024-09-15', '2024-09-20', 'Montreal', 'Canada', '2024-04-12', 'https://qce.quantum.ieee.org', 'IEEE International Conference on Quantum Computing and Engineering', TRUE, TRUE),
(61, 2025, 'IEEE Quantum Week 2025', '2025-09-14', '2025-09-19', 'Albuquerque', 'USA', '2025-04-11', 'https://qce.quantum.ieee.org', 'IEEE International Conference on Quantum Computing and Engineering', TRUE, TRUE),

-- BIBM (SeriesID 48)
(62, 2024, 'BIBM 2024', '2024-12-03', '2024-12-06', 'Lisbon', 'Portugal', '2024-08-10', 'https://ieeebibm.org', 'IEEE International Conference on Bioinformatics and Biomedicine', TRUE, TRUE),
(62, 2025, 'BIBM 2025', '2025-11-17', '2025-11-20', 'Shenzhen', 'China', '2025-08-08', 'https://ieeebibm.org', 'IEEE International Conference on Bioinformatics and Biomedicine', TRUE, TRUE),

-- UIST (SeriesID 49)
(63, 2024, 'UIST 2024', '2024-10-13', '2024-10-16', 'Pittsburgh', 'USA', '2024-04-04', 'https://uist.acm.org', 'ACM Symposium on User Interface Software and Technology', TRUE, TRUE),
(63, 2025, 'UIST 2025', '2025-10-05', '2025-10-08', 'Busan', 'South Korea', '2025-04-03', 'https://uist.acm.org', 'ACM Symposium on User Interface Software and Technology', TRUE, TRUE),
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
(23, 2026, 'ASPLOS 2026', '2026-03-22', '2026-03-26', 'Pittsburgh', 'USA', '2025-10-22', 'https://asplos-conference.org', 'ACM International Conference on Architectural Support for Programming Languages and Operating Systems', FALSE, FALSE),

-- SIGMOD (SeriesID 10) - confirmed May 31-Jun 5, Bengaluru
(19, 2026, 'SIGMOD 2026', '2026-05-31', '2026-06-05', 'Bengaluru', 'India', '2025-10-01', 'https://sigmod.org', 'ACM SIGMOD International Conference on Management of Data', FALSE, FALSE),

-- PODS (SeriesID 30) - co-located with SIGMOD, same dates
(30, 2026, 'PODS 2026', '2026-05-31', '2026-06-05', 'Bengaluru', 'India', '2025-12-06', 'https://databasetheory.org/PODS/', 'ACM SIGMOD-SIGACT-SIGART Symposium on Principles of Database Systems', FALSE, FALSE),

-- OSDI (SeriesID 16) - confirmed Jul 13-15, Seattle
(32, 2026, 'OSDI 2026', '2026-07-13', '2026-07-15', 'Seattle', 'USA', '2025-12-11', 'https://www.usenix.org/conferences/byname/179', 'USENIX Symposium on Operating Systems Design and Implementation', FALSE, FALSE),

-- ATC (SeriesID 19) - co-located with OSDI, Jul 13-15, Seattle
(35, 2026, 'USENIX ATC 2026', '2026-07-13', '2026-07-15', 'Seattle', 'USA', '2026-01-14', 'https://www.usenix.org/conferences/byname/131', 'USENIX Annual Technical Conference', FALSE, FALSE),

-- USENIX Security (SeriesID 17) - confirmed Aug 12-14, Baltimore
(33, 2026, 'USENIX Security 2026', '2026-08-12', '2026-08-14', 'Baltimore', 'USA', '2026-02-05', 'https://www.usenix.org/conferences/byname/108', 'USENIX Security Symposium', FALSE, FALSE),

-- NDSS (SeriesID 28) - confirmed Feb 23-27, San Diego (already happened!)
-- Note: NDSS 2026 already occurred Feb 23-27 2026, so mark TRUE TRUE
(38, 2026, 'NDSS 2026', '2026-02-23', '2026-02-27', 'San Diego', 'USA', '2025-09-05', 'https://www.ndss-symposium.org', 'Network and Distributed System Security Symposium', TRUE, TRUE),

-- SOSP (SeriesID 11) - confirmed Sep 29-Oct 2, Prague (biennial)
(20, 2026, 'SOSP 2026', '2026-09-29', '2026-10-02', 'Prague', 'Czech Republic', '2026-04-24', 'https://sosp.org', 'ACM Symposium on Operating Systems Principles', FALSE, FALSE),

-- CHI (SeriesID 12) - confirmed, Barcelona (co-located with APS!)
(21, 2026, 'CHI 2026', '2026-04-25', '2026-04-30', 'Barcelona', 'Spain', '2025-09-05', 'https://chi.acm.org', 'ACM CHI Conference on Human Factors in Computing Systems', FALSE, FALSE),

-- ICML (SeriesID 23) - confirmed Jul 6-12, Seoul
(26, 2026, 'ICML 2026', '2026-07-06', '2026-07-12', 'Seoul', 'South Korea', '2026-01-24', 'https://icml.cc', 'International Conference on Machine Learning', FALSE, FALSE),

-- ICLR (SeriesID 24) - confirmed May 1-5, Brazil
(27, 2026, 'ICLR 2026', '2026-05-01', '2026-05-05', 'Brasilia', 'Brazil', '2025-10-01', 'https://iclr.cc', 'International Conference on Learning Representations', FALSE, FALSE),

-- NeurIPS (SeriesID 22) - confirmed Dec 6+, Sydney
(25, 2026, 'NeurIPS 2026', '2026-12-06', '2026-12-12', 'Sydney', 'Australia', '2026-05-11', 'https://neurips.cc', 'Conference on Neural Information Processing Systems', FALSE, FALSE),

-- AAAI (SeriesID 20) - confirmed Jan 20-27, Singapore
(36, 2026, 'AAAI 2026', '2026-01-20', '2026-01-27', 'Singapore', 'Singapore', '2025-07-25', 'https://aaai.org/conference/aaai/', 'AAAI Conference on Artificial Intelligence', TRUE, TRUE),

-- IAAI (SeriesID 21) - co-located with AAAI
(37, 2026, 'IAAI 2026', '2026-01-20', '2026-01-27', 'Singapore', 'Singapore', '2025-07-25', 'https://aaai.org/conference/aaai/', 'Innovative Applications of Artificial Intelligence', TRUE, TRUE),

-- CRYPTO (SeriesID 42) - confirmed Aug 17-20, Santa Barbara
(39, 2026, 'CRYPTO 2026', '2026-08-17', '2026-08-20', 'Santa Barbara', 'USA', '2026-02-13', 'https://www.iacr.org/meetings/crypto/', 'International Cryptology Conference', FALSE, FALSE),

-- EUROCRYPT (SeriesID 43) - confirmed May 10-14, Rome
(40, 2026, 'EUROCRYPT 2026', '2026-05-10', '2026-05-14', 'Rome', 'Italy', '2025-10-04', 'https://www.iacr.org/meetings/eurocrypt/', 'Annual International Conference on the Theory and Applications of Cryptographic Techniques', FALSE, FALSE),

-- APS (SeriesID 62) - confirmed May 28-30, Barcelona (already in file!)
-- Already exists as (62, 2026...) - skip

-- CogSci (SeriesID 60) - confirmed Jul 22-25, Rio de Janeiro
(55, 2026, 'CogSci 2026', '2026-07-22', '2026-07-25', 'Rio de Janeiro', 'Brazil', '2026-02-02', 'https://cognitivesciencesociety.org', 'Annual Conference of the Cognitive Science Society', FALSE, FALSE),

-- CNS (SeriesID 61) - estimated Apr, Vancouver (confirmed 2026 location)
(56, 2026, 'CNS 2026', '2026-04-11', '2026-04-14', 'Vancouver', 'Canada', '2025-11-15', 'https://www.cogneurosociety.org/annual-meeting/', 'Annual Meeting of the Cognitive Neuroscience Society', FALSE, FALSE),

-- NSDI (SeriesID 18) - estimated Apr, based on pattern
(34, 2026, 'NSDI 2026', '2026-04-27', '2026-04-29', 'Raleigh', 'USA', '2025-09-12', 'https://www.usenix.org/conferences/byname/135', 'USENIX Symposium on Networked Systems Design and Implementation', FALSE, FALSE),

-- KDD (SeriesID 15) - confirmed Jul/Aug, Jeju Korea
(24, 2026, 'KDD 2026', '2026-08-02', '2026-08-06', 'Jeju', 'South Korea', '2026-02-01', 'https://kdd.org', 'ACM SIGKDD Conference on Knowledge Discovery and Data Mining', FALSE, FALSE),

-- INTERSPEECH (SeriesID 37) - confirmed Sep 1-4, Rome
(44, 2026, 'Interspeech 2026', '2026-09-01', '2026-09-04', 'Rome', 'Italy', '2026-03-14', 'https://interspeech2026.org', 'Annual Conference of the International Speech Communication Association', FALSE, FALSE),

-- ICASSP (SeriesID 36) - estimated Apr, based on pattern
(11, 2026, 'ICASSP 2026', '2026-04-12', '2026-04-17', 'Seoul', 'South Korea', '2025-10-04', 'https://2026.ieeeicassp.org', 'IEEE International Conference on Acoustics, Speech and Signal Processing', FALSE, FALSE);

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
  `UserID` int(8) NOT NULL AUTO_INCREMENT,
  `Email` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `DisplayName` varchar(255) NOT NULL,
  `CreatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (UserID),
  UNIQUE (Email)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `USER`


INSERT INTO `USER` (`Email`, `PasswordHash`, `DisplayName`, `CreatedAt`) VALUES
('alice_ml@fakemail.com', 'hash_alice_001', 'Alice_ML', '2024-01-15 09:00:00'),
('bob_sec@fakemail.com', 'hash_bob_002', 'Bob_Sec', '2024-01-16 10:30:00'),
('carol_nlp@fakemail.com', 'hash_carol_003', 'Carol_NLP', '2024-02-01 08:45:00'),
('dave_sys@fakemail.com', 'hash_dave_004', 'Dave_Sys', '2024-02-10 14:00:00'),
('eve_hci@fakemail.com', 'hash_eve_005', 'Eve_HCI', '2024-03-05 11:15:00'),
('frank_robot@fakemail.com', 'hash_frank_006', 'Frank_Robot', '2024-03-20 09:30:00'),
('grace_vision@fakemail.com', 'hash_grace_007', 'Grace_Vision', '2024-04-01 13:00:00'),
('hal_theory@fakemail.com', 'hash_hal_008', 'Hal_Theory', '2024-04-15 10:00:00'),
('iris_cogsci@fakemail.com', 'hash_iris_009', 'Iris_CogSci', '2024-05-01 08:00:00'),
('jules_data@fakemail.com', 'hash_jules_010', 'Jules_Data', '2024-05-10 15:30:00'),
('kai_rl@fakemail.com', 'hash_kai_011', 'Kai_RL', '2024-06-01 09:00:00'),
('luna_net@fakemail.com', 'hash_luna_012', 'Luna_Net', '2024-06-15 11:00:00'),
('max_quant@fakemail.com', 'hash_max_013', 'Max_Quant', '2024-07-01 10:00:00'),
('nina_ethics@fakemail.com', 'hash_nina_014', 'Nina_Ethics', '2024-07-15 14:00:00'),
('omar_multi@fakemail.com', 'hash_omar_015', 'Omar_Multi', '2024-08-01 09:30:00'),
('zoe_affect@fakemail.com', 'hash_zoe_016', 'Zoe_Affect', '2024-08-15 08:00:00'),
('orguser_01@fakemail.com', 'hash_org_017', 'OrgUser_01', '2024-09-01 10:00:00'),
('adminuser_01@fakemail.com', 'hash_admin_018', 'AdminUser_01', '2024-09-01 10:01:00'),
('adminuser_02@fakemail.com', 'hash_admin_019', 'AdminUser_02', '2024-09-02 10:00:00'),
('adminuser_03@fakemail.com', 'hash_admin_020', 'AdminUser_03', '2024-09-03 10:00:00'),
('adminuser_04@fakemail.com', 'hash_admin_021', 'AdminUser_04', '2024-09-04 10:00:00'),
('orguser_02@fakemail.com', 'hash_org_022', 'OrgUser_02', '2024-09-05 10:00:00'),
('orguser_03@fakemail.com', 'hash_org_023', 'OrgUser_03', '2024-09-06 10:00:00'),
('orguser_04@fakemail.com', 'hash_org_024', 'OrgUser_04', '2024-09-07 10:00:00'),
('orguser_05@fakemail.com', 'hash_org_025', 'OrgUser_05', '2024-09-08 10:00:00');
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
  `CollectionID` int(8) NOT NULL AUTO_INCREMENT,
  `CreatorUserID` int(8) NOT NULL,
  `Name` varchar(255),
  `CreatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (CollectionID),
  FOREIGN KEY (CreatorUserID) REFERENCES RESEARCHER(UserID)
      ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `COLLECTION`
--

INSERT INTO `COLLECTION` (`CollectionID`, `CreatorUserID`, `Name`, `CreatedAt`) VALUES
(1, 1, 'My ML Conferences', '2024-09-05 10:00:00'),
(2, 3, 'NLP Reading List', '2024-09-10 11:00:00'),
(3, 9, 'CogSci & Neuro', '2024-09-15 09:00:00'),
(4, 16, 'Affect & HRI Venues', '2024-09-20 08:00:00'),
(5, 7, 'Vision Conferences', '2024-10-01 10:00:00');

-- --------------------------------------------------------

-- 
-- Table structure for `REQUEST`
--

CREATE TABLE REQUEST (
  `RequestID` int(8) NOT NULL AUTO_INCREMENT,
  `SubmittedByUserID` int(8) NOT NULL,
  `ReviewedByUserID` int(8),
  `CreatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `PayloadJSON` JSON,
  `Status` ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `RequestType` varchar(100),
  PRIMARY KEY (RequestID),
  FOREIGN KEY (SubmittedByUserID) REFERENCES ORGANIZER(UserID),
  FOREIGN KEY (ReviewedByUserID) REFERENCES ADMIN(UserID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REQUEST`
--

INSERT INTO `REQUEST` (`SubmittedByUserID`, `ReviewedByUserID`, `CreatedAt`, `PayloadJSON`, `Status`, `RequestType`) VALUES
(17, 16, '2024-10-01 10:00:00', '{"action": "add_venue", "name": "Workshop on Affective AI"}', 'approved', 'add_venue'),
(22, 18, '2024-10-15 11:00:00', '{"action": "add_venue", "name": "Symposium on Human-AI Teaming"}', 'pending', 'add_venue'),
(23, 19, '2024-11-01 09:00:00', '{"action": "edit_venue", "seriesID": 31}', 'approved', 'edit_venue'),
(24, 20, '2024-11-15 14:00:00', '{"action": "add_venue", "name": "Workshop on Quantum ML"}', 'rejected', 'add_venue'),
(25, 21, '2024-12-01 10:00:00', '{"action": "add_venue", "name": "Forum on AI Safety"}', 'pending', 'add_venue');

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
(1, 25, 2025, '2024-12-10 09:30:00'),
(1, 26, 2025, '2025-01-25 09:30:00'),
(1, 27, 2025, '2024-10-02 14:30:00'),
-- Bob_Sec
(2, 18, 2024, '2024-09-03 09:40:00'),
(2, 33, 2025, '2025-01-23 10:30:00'),
(2, 2, 2025, '2024-11-16 10:00:00'),
-- Carol_NLP
(3, 41, 2025, '2025-02-16 09:30:00'),
(3, 42, 2024, '2024-09-21 10:40:00'),
(3, 25, 2025, '2024-12-10 09:00:00'),
-- Dave_Sys
(4, 32, 2025, '2025-01-10 09:30:00'),
(4, 20, 2025, '2025-04-25 10:00:00'),
(4, 23, 2025, '2025-03-31 09:00:00'),
-- Eve_HCI
(5, 21, 2025, '2025-01-15 10:30:00'),
(5, 8, 2025, '2025-04-26 09:00:00'),
(5, 63, 2025, '2025-10-06 10:00:00'),
-- Frank_Robot
(6, 9, 2025, '2025-01-20 10:30:00'),
(6, 10, 2025, '2025-10-20 09:00:00'),
(6, 31, 2025, '2025-03-04 10:00:00'),
-- Grace_Vision
(7, 4, 2025, '2025-01-28 09:30:00'),
(7, 12, 2025, '2024-10-20 09:40:00'),
(7, 13, 2026, '2024-10-13 11:40:00'),
-- Hal_Theory
(8, 17, 2025, '2025-01-05 10:30:00'),
(8, 22, 2025, '2025-01-20 09:00:00'),
(8, 16, 2025, '2025-06-17 10:00:00'),
-- Iris_CogSci
(9, 55, 2025, '2025-02-03 09:30:00'),
(9, 57, 2026, '2024-10-17 14:40:00'),
(9, 58, 2025, '2025-08-13 10:00:00'),
-- Jules_Data
(10, 28, 2025, '2025-01-12 10:30:00'),
(10, 19, 2025, '2025-06-23 09:00:00'),
(10, 24, 2025, '2025-08-04 10:00:00'),
-- Kai_RL
(11, 25, 2025, '2025-01-18 10:30:00'),
(11, 26, 2025, '2025-07-14 09:00:00'),
(11, 27, 2025, '2025-04-25 10:00:00'),
-- Luna_Net
(12, 15, 2025, '2025-01-22 10:30:00'),
(12, 34, 2025, '2025-04-29 09:00:00'),
(12, 38, 2025, '2025-02-25 10:00:00'),
-- Max_Quant
(13, 61, 2025, '2025-01-26 09:30:00'),
(13, 6, 2025, '2025-06-22 10:00:00'),
(13, 7, 2025, '2025-10-19 09:00:00'),
-- Nina_Ethics
(14, 36, 2025, '2025-01-30 10:30:00'),
(14, 57, 2026, '2024-10-27 14:40:00'),
(14, 29, 2025, '2025-02-27 09:00:00'),
-- Omar_Multi
(15, 11, 2025, '2025-01-14 10:30:00'),
(15, 44, 2025, '2025-08-18 09:00:00'),
(15, 41, 2025, '2025-07-28 10:00:00'),
-- Zoe_Affect
(16, 8, 2025, '2025-04-26 09:30:00'),
(16, 57, 2026, '2025-01-16 10:30:00'),
(16, 55, 2025, '2025-07-24 09:00:00');

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
(1, 18, 2024, '2024-10-05 10:00:00'),
(1, 32, 2024, '2024-10-06 10:00:00'),
(1, 38, 2024, '2024-10-07 10:00:00'),
(1, 39, 2024, '2024-10-08 10:00:00'),
(1, 15, 2024, '2024-10-09 10:00:00'),
-- Bob_Sec dismisses ML/vision venues
(2, 25, 2024, '2024-10-05 11:00:00'),
(2, 4, 2024, '2024-10-06 11:00:00'),
(2, 26, 2024, '2024-10-07 11:00:00'),
(2, 12, 2025, '2024-10-08 11:00:00'),
(2, 55, 2024, '2024-10-09 11:00:00'),
-- Carol_NLP dismisses systems/architecture
(3, 32, 2024, '2024-10-05 12:00:00'),
(3, 6, 2024, '2024-10-06 12:00:00'),
(3, 7, 2024, '2024-10-07 12:00:00'),
(3, 61, 2024, '2024-10-08 12:00:00'),
(3, 62, 2024, '2024-10-09 12:00:00'),
-- Dave_Sys dismisses cog sci/HCI
(4, 55, 2024, '2024-10-05 13:00:00'),
(4, 57, 2025, '2024-10-06 13:00:00'),
(4, 8, 2024, '2024-10-07 13:00:00'),
(4, 63, 2024, '2024-10-08 13:00:00'),
(4, 58, 2024, '2024-10-09 13:00:00'),
-- Eve_HCI dismisses theory/systems
(5, 17, 2024, '2024-10-05 14:00:00'),
(5, 22, 2024, '2024-10-06 14:00:00'),
(5, 32, 2024, '2024-10-07 14:00:00'),
(5, 61, 2024, '2024-10-08 14:00:00'),
(5, 7, 2024, '2024-10-09 14:00:00');

-- --------------------------------------------------------

-- 
-- Table structure for `VIEWS`
--

CREATE TABLE VIEWS (
  `UserID` int(8) NOT NULL,
  `SeriesID` int(8) NOT NULL,
  `Year` int(8) NOT NULL,
  `ViewedTimestamp` TIMESTAMP NOT NULL,
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
(1, 25, 2024, '2024-09-01 10:10:00', 420),
(1, 25, 2025, '2024-12-10 09:00:00', 380),
(1, 26, 2024, '2024-09-02 11:00:00', 310),
(1, 27, 2025, '2024-10-02 14:00:00', 290),
(1, 4, 2024, '2024-10-20 10:00:00', 180),
(1, 26, 2025, '2025-01-25 09:00:00', 340),

-- Bob_Sec: CCS, S&P, USENIX Sec, NDSS, occasional SOSP
(2, 18, 2024, '2024-09-03 09:10:00', 390),
(2, 2, 2024, '2024-09-10 14:10:00', 420),
(2, 33, 2024, '2024-10-02 10:10:00', 360),
(2, 38, 2024, '2024-10-21 11:10:00', 310),
(2, 20, 2023, '2024-11-05 09:10:00', 150),
(2, 33, 2025, '2025-01-23 10:00:00', 400),

-- Carol_NLP: ACL, EMNLP, NAACL, NeurIPS, occasional CHI
(3, 41, 2024, '2024-09-04 08:10:00', 350),
(3, 42, 2024, '2024-09-21 10:10:00', 380),
(3, 43, 2024, '2024-10-06 09:10:00', 300),
(3, 25, 2024, '2024-10-26 14:10:00', 250),
(3, 21, 2024, '2024-11-10 11:10:00', 120),
(3, 41, 2025, '2025-02-16 09:00:00', 370),

-- Dave_Sys: OSDI, SOSP, ATC, NSDI, ASPLOS
(4, 32, 2024, '2024-09-05 10:10:00', 430),
(4, 20, 2023, '2024-09-19 13:10:00', 410),
(4, 35, 2024, '2024-10-03 09:10:00', 360),
(4, 34, 2024, '2024-10-23 11:10:00', 390),
(4, 23, 2024, '2024-11-08 10:10:00', 340),
(4, 32, 2025, '2025-01-10 09:00:00', 420),

-- Eve_HCI: CHI, UIST, ACII, IEEE VR
(5, 21, 2024, '2024-09-06 11:10:00', 400),
(5, 63, 2024, '2024-09-23 14:10:00', 370),
(5, 8, 2024, '2024-10-09 10:10:00', 350),
(5, 59, 2024, '2024-10-29 09:10:00', 320),
(5, 55, 2024, '2024-11-12 11:10:00', 200),
(5, 21, 2025, '2025-01-15 10:00:00', 380),

-- Frank_Robot: ICRA, IROS, HRI, NeurIPS, occasional CVPR
(6, 9, 2024, '2024-09-07 09:10:00', 440),
(6, 10, 2024, '2024-09-27 13:10:00', 410),
(6, 31, 2024, '2024-10-11 10:10:00', 380),
(6, 25, 2024, '2024-10-31 14:10:00', 280),
(6, 4, 2024, '2024-11-14 09:10:00', 160),
(6, 9, 2025, '2025-01-20 10:00:00', 430),

-- Grace_Vision: CVPR, ICCV, ECCV, ICIP
(7, 4, 2024, '2024-09-08 10:10:00', 450),
(7, 12, 2025, '2024-10-20 09:10:00', 420),
(7, 13, 2024, '2024-10-13 11:10:00', 400),
(7, 14, 2024, '2024-11-02 10:10:00', 350),
(7, 25, 2024, '2024-11-16 14:10:00', 200),
(7, 4, 2025, '2025-01-28 09:00:00', 440),

-- Hal_Theory: STOC, PLDI, POPL, PODS
(8, 17, 2024, '2024-09-09 09:10:00', 380),
(8, 16, 2024, '2024-09-29 13:10:00', 360),
(8, 22, 2024, '2024-10-15 10:10:00', 340),
(8, 30, 2024, '2024-11-04 11:10:00', 320),
(8, 19, 2024, '2024-11-18 09:10:00', 150),
(8, 17, 2025, '2025-01-05 10:00:00', 370),

-- Iris_CogSci: CogSci, CNS, APS, CCN, occasional NeurIPS
(9, 55, 2024, '2024-09-10 08:10:00', 420),
(9, 56, 2024, '2024-10-01 10:10:00', 400),
(9, 57, 2025, '2024-10-17 14:10:00', 380),
(9, 58, 2024, '2024-11-06 09:10:00', 360),
(9, 25, 2024, '2024-11-20 11:10:00', 200),
(9, 56, 2025, '2025-01-08 10:00:00', 390),

-- Jules_Data: SIGMOD, VLDB, KDD, PODS
(10, 19, 2024, '2024-09-11 10:10:00', 410),
(10, 28, 2024, '2024-10-02 13:10:00', 390),
(10, 24, 2024, '2024-10-19 10:10:00', 370),
(10, 30, 2024, '2024-11-08 11:10:00', 350),
(10, 17, 2024, '2024-11-22 09:10:00', 140),
(10, 28, 2025, '2025-01-12 10:00:00', 400),

-- Kai_RL: NeurIPS, ICML, ICLR, ICRA, occasional AAAI
(11, 25, 2024, '2024-09-12 09:10:00', 460),
(11, 26, 2024, '2024-10-04 13:10:00', 430),
(11, 27, 2024, '2024-10-21 10:10:00', 410),
(11, 9, 2024, '2024-11-10 11:10:00', 340),
(11, 36, 2024, '2024-11-24 09:10:00', 200),
(11, 25, 2025, '2025-01-18 10:00:00', 450),

-- Luna_Net: SIGCOMM, INFOCOM, NSDI, NDSS, occasional OSDI
(12, 15, 2024, '2024-09-13 10:10:00', 400),
(12, 3, 2024, '2024-10-06 13:10:00', 380),
(12, 34, 2024, '2024-10-23 10:10:00', 360),
(12, 38, 2024, '2024-11-12 11:10:00', 340),
(12, 32, 2024, '2024-11-26 09:10:00', 160),
(12, 15, 2025, '2025-01-22 10:00:00', 390),

-- Max_Quant: IEEE Quantum Week, ISCA, MICRO, occasional STOC
(13, 61, 2024, '2024-09-16 09:10:00', 420),
(13, 6, 2024, '2024-10-08 13:10:00', 390),
(13, 7, 2024, '2024-11-03 10:10:00', 370),
(13, 17, 2024, '2024-11-14 11:10:00', 200),
(13, 61, 2025, '2025-01-26 09:00:00', 410),

-- Nina_Ethics: AAAI, SIGCSE, APS, CHI, occasional NeurIPS
(14, 36, 2024, '2024-09-15 08:10:00', 390),
(14, 29, 2024, '2024-10-10 10:10:00', 370),
(14, 57, 2025, '2024-10-27 14:10:00', 350),
(14, 21, 2024, '2024-11-16 09:10:00', 320),
(14, 25, 2024, '2024-11-28 11:10:00', 180),
(14, 36, 2025, '2025-01-30 10:00:00', 380),

-- Omar_Multi: ICASSP, INTERSPEECH, ACL, ACII, occasional ICLR
(15, 11, 2024, '2024-09-16 10:10:00', 410),
(15, 44, 2024, '2024-10-12 13:10:00', 390),
(15, 41, 2024, '2024-10-29 10:10:00', 360),
(15, 8, 2024, '2024-11-18 11:10:00', 340),
(15, 27, 2024, '2024-12-01 09:10:00', 190),
(15, 11, 2025, '2025-01-14 10:00:00', 400),

-- Zoe_Affect: ACII, CogSci, CNS, CHI, HRI, APS, occasional NeurIPS
(16, 8, 2024, '2024-09-17 08:10:00', 440),
(16, 55, 2024, '2024-10-14 10:10:00', 420),
(16, 56, 2024, '2024-10-31 14:10:00', 400),
(16, 21, 2024, '2024-11-20 09:10:00', 380),
(16, 31, 2024, '2024-12-03 11:10:00', 360),
(16, 57, 2025, '2025-01-16 10:00:00', 420),
(16, 25, 2024, '2024-12-10 14:00:00', 240);

-- --------------------------------------------------------

-- 
-- Table structure for `CLICKS_EXT_LINK`
--

CREATE TABLE CLICKS_EXT_LINK (
  `UserID` int(8) NOT NULL,
  `SeriesID` int(8) NOT NULL,
  `Year` int(8) NOT NULL,
  `ClickedTimestamp` TIMESTAMP NOT NULL,
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
(1, 25, 2025, '2024-12-10 09:35:00', 'CFP'),
(1, 26, 2025, '2025-01-25 09:35:00', 'CFP'),
(1, 27, 2025, '2024-10-02 14:35:00', 'CFP'),
(1, 4, 2025, '2025-01-29 10:00:00', 'website'),
(1, 25, 2024, '2024-09-01 10:20:00', 'website'),
-- Bob_Sec
(2, 18, 2024, '2024-09-03 09:45:00', 'CFP'),
(2, 33, 2025, '2025-01-23 10:35:00', 'CFP'),
(2, 2, 2024, '2024-09-10 14:35:00', 'website'),
(2, 38, 2025, '2025-09-06 10:00:00', 'CFP'),
(2, 39, 2024, '2024-08-19 10:00:00', 'website'),
-- Carol_NLP
(3, 41, 2025, '2025-02-16 09:35:00', 'CFP'),
(3, 42, 2025, '2025-11-10 09:00:00', 'CFP'),
(3, 43, 2025, '2025-04-30 10:00:00', 'CFP'),
(3, 25, 2025, '2024-12-10 09:05:00', 'website'),
(3, 42, 2024, '2024-09-21 10:45:00', 'website'),
-- Frank_Robot
(6, 9, 2025, '2025-01-20 10:35:00', 'CFP'),
(6, 10, 2025, '2025-10-20 09:05:00', 'CFP'),
(6, 31, 2025, '2025-03-04 10:05:00', 'CFP'),
(6, 25, 2025, '2025-12-03 09:00:00', 'website'),
(6, 9, 2024, '2024-09-07 09:20:00', 'website'),
-- Zoe_Affect
(16, 8, 2025, '2025-04-26 09:35:00', 'CFP'),
(16, 57, 2026, '2025-01-16 10:35:00', 'CFP'),
(16, 55, 2025, '2025-07-24 09:05:00', 'CFP'),
(16, 56, 2025, '2025-03-30 10:00:00', 'website'),
(16, 21, 2025, '2025-04-27 09:00:00', 'website');

-- --------------------------------------------------------

-- 
-- Table structure for `INTERACTS_WITH`
--

CREATE TABLE INTERACTS_WITH (
  `UserID` int(8) NOT NULL,
  `TopicID` int(8) NOT NULL,
  `ClickedTimestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (UserID, TopicID, ClickedTimestamp),
  FOREIGN KEY (UserID) REFERENCES RESEARCHER(UserID),
  FOREIGN KEY (TopicID) REFERENCES TOPIC(TopicID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `INTERACTS_WITH`
--

INSERT INTO `INTERACTS_WITH` (`UserID`, `TopicID`, `ClickedTimestamp`) VALUES
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
(15, 32), (15, 30), (15, 46),

-- PLDI (7): Programming Languages, Formal Methods, Software Engineering
(16, 39), (16, 40), (16, 41),

-- STOC (8): Algorithms & Complexity, Logic in CS, Theory
(17, 38), (17, 42),

-- CCS (9): Network Security, Cryptography, Privacy, Malware & Forensics
(18, 23), (18, 24), (18, 25), (18, 26),

-- SIGMOD (10): Databases, Data Mining, Information Retrieval, Big Data
(19, 33), (19, 34), (19, 35), (19, 36),

-- SOSP (11): Operating Systems, Distributed Systems, Computer Architecture
(20, 28), (20, 30), (20, 29),

-- CHI (12): Human-Computer Interaction, Affective Computing, HRI, Ubiquitous Computing
(21, 20), (21, 17), (21, 19), (21, 22),

-- POPL (13): Programming Languages, Logic in CS, Formal Methods, Algorithms & Complexity
(22, 39), (22, 42), (22, 40), (22, 38),

-- ASPLOS (14): Computer Architecture, Operating Systems, Programming Languages
(23, 29), (23, 28), (23, 39),

-- KDD (15): Data Mining, Machine Learning, Big Data, Datasets & Benchmarks, Information Retrieval
(24, 34), (24, 1), (24, 36), (24, 37), (24, 35),

-- OSDI (16): Operating Systems, Distributed Systems, Computer Architecture
(32, 28), (32, 30), (32, 29),

-- USENIX Security (17): Network Security, Privacy, Malware & Forensics, Cryptography, Dependable Systems
(33, 23), (33, 25), (33, 26), (33, 24), (33, 27),

-- NSDI (18): Networking, Distributed Systems, Operating Systems
(34, 32), (34, 30), (34, 28),

-- ATC (19): Operating Systems, Distributed Systems, High Performance Computing
(35, 28), (35, 30), (35, 31),

-- AAAI (20): Machine Learning, Deep Learning, NLP, Reinforcement Learning, AI Ethics & Fairness, Neurosymbolic AI, Embodied AI
(36, 1), (36, 2), (36, 4), (36, 3), (36, 8), (36, 11), (36, 10),

-- IAAI (21): Machine Learning, AI Impacts & Society, AI Ethics & Fairness
(37, 1), (37, 45), (37, 8),

-- NeurIPS (22): Machine Learning, Deep Learning, Reinforcement Learning, NLP, Multimodal AI, JEPA, Neurosymbolic AI, Datasets & Benchmarks
(25, 1), (25, 2), (25, 3), (25, 4), (25, 7), (25, 12), (25, 11), (25, 37),

-- ICML (23): Machine Learning, Deep Learning, Reinforcement Learning, Algorithms & Complexity, Datasets & Benchmarks
(26, 1), (26, 2), (26, 3), (26, 38), (26, 37),

-- ICLR (24): Deep Learning, Machine Learning, NLP, Computer Vision, Multimodal AI, JEPA
(27, 2), (27, 1), (27, 4), (27, 6), (27, 7), (27, 12),

-- VLDB (25): Databases, Big Data, Data Mining, Information Retrieval
(28, 33), (28, 36), (28, 34), (28, 35),

-- ISCA (26): Computer Architecture, High Performance Computing, Operating Systems
(6, 29), (6, 31), (6, 28),

-- MICRO (27): Computer Architecture, High Performance Computing, Operating Systems
(7, 29), (7, 31), (7, 28),

-- NDSS (28): Network Security, Privacy, Malware & Forensics, Dependable Systems
(38, 23), (38, 25), (38, 26), (38, 27),

-- SIGCSE (29): CS Education, AI Ethics & Fairness, AI Impacts & Society
(29, 44), (29, 8), (29, 45),

-- PODS (30): Databases, Algorithms & Complexity, Logic in CS
(30, 33), (30, 38), (30, 42),

-- ACII (31): Affective Computing, Human-Computer Interaction, Speech Processing, Multimodal AI
(8, 17), (8, 20), (8, 13), (8, 7),

-- HRI (35): Human-Robot Interaction, Robotics, Human-Computer Interaction, Embodied AI
(31, 19), (31, 18), (31, 20), (31, 10),

-- ICASSP (36): Speech Processing, Audio & Music Computing, Image Processing, Machine Learning
(11, 13), (11, 14), (11, 15), (11, 1),

-- INTERSPEECH (37): Speech Processing, Audio & Music Computing, NLP, Affective Computing
(44, 13), (44, 14), (44, 4), (44, 17),

-- ICCV (38): Computer Vision, Deep Learning, Image Processing, Video & Motion Analysis
(12, 6), (12, 2), (12, 15), (12, 16),

-- ECCV (39): Computer Vision, Deep Learning, Image Processing, Video & Motion Analysis
(13, 6), (13, 2), (13, 15), (13, 16),

-- ICIP (41): Image Processing, Computer Vision, Video & Motion Analysis
(14, 15), (14, 6), (14, 16),

-- ICRA (33): Robotics, Embodied AI, Human-Robot Interaction, Computer Vision, Machine Learning
(9, 18), (9, 10), (9, 19), (9, 6), (9, 1),

-- IROS (34): Robotics, Embodied AI, Human-Robot Interaction, Computer Vision
(10, 18), (10, 10), (10, 19), (10, 6),

-- CRYPTO (42): Cryptography, Network Security, Privacy
(39, 24), (39, 23), (39, 25),

-- EUROCRYPT (43): Cryptography, Network Security, Privacy
(40, 24), (40, 23), (40, 25),

-- ACL (44): NLP, Large Language Models, Machine Learning, Multimodal AI, Datasets & Benchmarks
(41, 4), (41, 5), (41, 1), (41, 7), (41, 37),

-- EMNLP (45): NLP, Large Language Models, Machine Learning, Information Retrieval
(42, 4), (42, 5), (42, 1), (42, 35),

-- NAACL (46): NLP, Large Language Models, Machine Learning, Speech Processing
(43, 4), (43, 5), (43, 1), (43, 13),
-- CogSci (60): Cognitive Science, NLP, Neurosymbolic AI, HCI, Affective Computing, Psychological Science
(55, 51), (55, 4), (55, 11), (55, 20), (55, 17), (55, 53),

-- CNS (61): Computational Neuroscience, Cognitive Science, Machine Learning, AI for Science
(56, 52), (56, 51), (56, 1), (56, 9),

-- APS (62): Psychological Science, Cognitive Science, Affective Computing, AI Ethics & Fairness
(57, 53), (57, 51), (57, 17), (57, 8),

-- CCN (63): Computational Neuroscience, Machine Learning, Cognitive Science, Reinforcement Learning, Embodied AI
(58, 52), (58, 1), (58, 51), (58, 3), (58, 10),

-- CACM (50): Software Engineering, Algorithms & Complexity, Distributed Systems, AI Ethics & Fairness
(45, 41), (45, 38), (45, 30), (45, 8),

-- JAIR (51): Machine Learning, Deep Learning, NLP, Neurosymbolic AI, AI for Science
(46, 1), (46, 2), (46, 4), (46, 11), (46, 9),

-- TNNLS (52): Deep Learning, Machine Learning, Reinforcement Learning, Computational Neuroscience
(47, 2), (47, 1), (47, 3), (47, 52),

-- TOPLAS (53): Programming Languages, Formal Methods, Logic in CS
(48, 39), (48, 40), (48, 42),

-- IC (54): Formal Methods, Algorithms & Complexity, Logic in CS
(49, 40), (49, 38), (49, 42),

-- Nature (55): AI for Science, Computational Neuroscience, Cognitive Science, Datasets & Benchmarks
(50, 9), (50, 52), (50, 51), (50, 37),

-- Nature Human Behaviour (56): Psychological Science, Cognitive Science, Affective Computing, AI Ethics & Fairness
(51, 53), (51, 51), (51, 17), (51, 8),

-- Nature Neuroscience (57): Computational Neuroscience, Cognitive Science, AI for Science
(52, 52), (52, 51), (52, 9),

-- Cognitive Science Journal (58): Cognitive Science, NLP, Computational Neuroscience, Psychological Science
(53, 51), (53, 4), (53, 52), (53, 53),

-- Neural Computation (59): Computational Neuroscience, Machine Learning, Deep Learning, Cognitive Science
(54, 52), (54, 1), (54, 2), (54, 51),
-- IEEE VR (32): Mixed & Augmented Reality, HCI, Computer Vision, Embodied AI
(59, 21), (59, 20), (59, 6), (59, 10),

-- SIGGRAPH (40): Computer Graphics & Animation, Human Motion Analysis, Computer Vision, HCI
(60, 48), (60, 49), (60, 6), (60, 20),

-- IEEE Quantum Week (47): Quantum Computing, Algorithms & Complexity, Computer Architecture
(61, 43), (61, 38), (61, 29),

-- BIBM (48): AI for Science, Machine Learning, Datasets & Benchmarks, Computational Neuroscience
(62, 9), (62, 1), (62, 37), (62, 52),

-- UIST (49): HCI, Ubiquitous Computing, Mixed & Augmented Reality, Affective Computing
(63, 20), (63, 22), (63, 21), (63, 17);

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
(25, 2024, 10),  -- Embodied AI
(25, 2024, 3),   -- Reinforcement Learning
(25, 2024, 37),  -- Datasets & Benchmarks
(25, 2024, 7),   -- Multimodal AI

-- NeurIPS 2025: LLM Reasoning, AI for Science, Multimodal dominant
(25, 2025, 5),   -- Large Language Models
(25, 2025, 9),   -- AI for Science
(25, 2025, 7),   -- Multimodal AI
(25, 2025, 8),   -- AI Ethics & Fairness (position paper track)

-- ICLR 2025: JEPA / world models pronounced
(27, 2025, 12),  -- JEPA
(27, 2025, 10),  -- Embodied AI

-- AAAI 2025: heavier ethics and societal impact
(36, 2025, 8),   -- AI Ethics & Fairness
(36, 2025, 45);  -- AI Impacts & Society

-- --------------------------------------------------------

-- 
-- Table structure for `COLLECTION_CONTAINS`
--

CREATE TABLE COLLECTION_CONTAINS (
  `CollectionID` int(8) NOT NULL,
  `SeriesID` int(8) NOT NULL,
  `Year` int(8) NOT NULL,
  PRIMARY KEY (CollectionID, SeriesID, Year),
  FOREIGN KEY (CollectionID) REFERENCES COLLECTION(CollectionID),
  FOREIGN KEY (SeriesID, Year) REFERENCES VENUE_INSTANCE(SeriesID, Year)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `COLLECTION_CONTAINS`
--

INSERT INTO `COLLECTION_CONTAINS` (`CollectionID`, `SeriesID`, `Year`) VALUES
-- Alice_ML's ML collection
(1, 25, 2025),
(1, 26, 2025),
(1, 27, 2025),
-- Carol_NLP's NLP collection
(2, 41, 2025),
(2, 42, 2024),
(2, 43, 2025),
-- Iris_CogSci's CogSci collection
(3, 55, 2025),
(3, 56, 2025),
(3, 58, 2025),
-- Zoe_Affect's collection
(4, 8, 2025),
(4, 57, 2026),
(4, 31, 2025),
-- Grace_Vision's collection
(5, 4, 2025),
(5, 12, 2025),
(5, 13, 2024);


-- ============================================================
-- SEED ADDENDUM: Demo interactions + loginable user + extra venues
-- Authors: Zoe Stanley, Group 42, 2026-04-04
-- All SeriesIDs use AUTO_INCREMENT assigned values
-- ============================================================

-- Loginable demo user (password: zoezoezoe)
INSERT INTO `USER` (`Email`, `PasswordHash`, `DisplayName`, `CreatedAt`) VALUES
('zoe@zoe.com', 'b18dff1b226ec30a4df6400ae20640e5c778435ab5bf16c4ccd1613d136fca59', 'Zoe', '2026-04-04 00:00:00');

INSERT INTO `RESEARCHER` (`UserID`) VALUES (LAST_INSERT_ID());

-- ============================================================
-- MISSING 2026 VENUE INSTANCES
-- ============================================================
INSERT INTO `VENUE_INSTANCE` (`SeriesID`, `Year`, `Title`, `StartDate`, `EndDate`, `City`, `Country`, `SubmissionDeadline`, `CFP_URL`, `CallForPapers`, `Reviewing`, `Published`) VALUES
(18, 2026, 'CCS 2026', '2026-10-12', '2026-10-16', 'Salt Lake City', 'USA', '2026-05-15', 'https://www.sigsac.org/ccs.html', 'ACM Conference on Computer and Communications Security', FALSE, FALSE),
(8, 2026, 'ACII 2026', '2026-09-14', '2026-09-17', 'TBD', 'TBD', '2026-04-25', 'https://acii-conf.net', 'IEEE International Conference on Affective Computing and Intelligent Interaction', FALSE, FALSE),
(58, 2026, 'CCN 2026', '2026-08-11', '2026-08-14', 'TBD', 'TBD', '2026-04-15', 'https://ccneuro.org', 'Conference on Cognitive Computational Neuroscience', FALSE, FALSE),
(41, 2026, 'ACL 2026', '2026-07-26', '2026-07-31', 'TBD', 'TBD', '2026-02-15', 'https://www.aclweb.org/anthology/', 'Annual Meeting of the Association for Computational Linguistics', FALSE, FALSE),
(42, 2026, 'EMNLP 2026', '2026-11-08', '2026-11-12', 'TBD', 'TBD', '2026-06-01', 'https://aclanthology.org/venues/emnlp/', 'Conference on Empirical Methods in Natural Language Processing', FALSE, FALSE),
(9, 2026, 'ICRA 2026', '2026-05-18', '2026-05-22', 'TBD', 'TBD', '2025-09-15', 'https://2026.ieee-icra.org', 'IEEE International Conference on Robotics and Automation', FALSE, FALSE),
(31, 2026, 'HRI 2026', '2026-03-09', '2026-03-12', 'TBD', 'TBD', '2025-10-01', 'https://humanrobotinteraction.org', 'ACM/IEEE International Conference on Human-Robot Interaction', FALSE, FALSE),
(59, 2026, 'IEEE VR 2026', '2026-03-14', '2026-03-18', 'TBD', 'TBD', '2025-10-10', 'https://ieeevr.org', 'IEEE Conference on Virtual Reality and 3D User Interfaces', FALSE, FALSE),
(61, 2026, 'IEEE Quantum Week 2026', '2026-09-13', '2026-09-18', 'Denver', 'USA', '2026-04-12', 'https://qce.quantum.ieee.org', 'IEEE International Conference on Quantum Computing and Engineering', FALSE, FALSE),
(29, 2026, 'SIGCSE 2026', '2026-03-18', '2026-03-21', 'TBD', 'TBD', '2025-09-12', 'https://sigcse.org/events/symposia/', 'ACM SIGCSE Technical Symposium on Computer Science Education', FALSE, FALSE),
(60, 2026, 'SIGGRAPH 2026', '2026-08-09', '2026-08-13', 'TBD', 'TBD', '2026-01-22', 'https://siggraph.org', 'ACM SIGGRAPH Conference on Computer Graphics and Interactive Techniques', FALSE, FALSE),
(63, 2026, 'UIST 2026', '2026-10-11', '2026-10-14', 'TBD', 'TBD', '2026-04-04', 'https://uist.acm.org', 'ACM Symposium on User Interface Software and Technology', FALSE, FALSE),
(62, 2026, 'BIBM 2026', '2026-11-16', '2026-11-19', 'TBD', 'TBD', '2026-08-08', 'https://ieeebibm.org', 'IEEE International Conference on Bioinformatics and Biomedicine', FALSE, FALSE),
(10, 2026, 'IROS 2026', '2026-10-18', '2026-10-22', 'TBD', 'TBD', '2026-03-01', 'https://iros2026.org', 'IEEE/RSJ International Conference on Intelligent Robots and Systems', FALSE, FALSE),
(17, 2026, 'STOC 2026', '2026-06-22', '2026-06-25', 'TBD', 'TBD', '2025-11-04', 'https://acm-stoc.org', 'ACM Symposium on Theory of Computing', FALSE, FALSE),
(16, 2026, 'PLDI 2026', '2026-06-15', '2026-06-19', 'TBD', 'TBD', '2025-11-14', 'https://pldi.acm.org', 'ACM SIGPLAN Conference on Programming Language Design and Implementation', FALSE, FALSE),
(28, 2026, 'VLDB 2026', '2026-09-07', '2026-09-11', 'TBD', 'TBD', '2025-10-01', 'https://vldb.org/pvldb/', 'International Conference on Very Large Data Bases', FALSE, FALSE),
(43, 2026, 'NAACL 2026', '2026-06-21', '2026-06-26', 'TBD', 'TBD', '2026-01-15', 'https://aclanthology.org/venues/naacl/', 'Annual Conference of the North American Chapter of the ACL', FALSE, FALSE),
(25, 2027, 'NeurIPS 2027', '2027-12-05', '2027-12-11', 'TBD', 'TBD', '2027-05-10', 'https://neurips.cc', 'Conference on Neural Information Processing Systems', FALSE, FALSE),
(26, 2027, 'ICML 2027', '2027-07-11', '2027-07-17', 'TBD', 'TBD', '2027-01-23', 'https://icml.cc', 'International Conference on Machine Learning', FALSE, FALSE),
(27, 2027, 'ICLR 2027', '2027-05-01', '2027-05-05', 'TBD', 'TBD', '2026-10-01', 'https://iclr.cc', 'International Conference on Learning Representations', FALSE, FALSE),
(39, 2027, 'CRYPTO 2027', '2027-08-16', '2027-08-19', 'Santa Barbara', 'USA', '2027-02-12', 'https://www.iacr.org/meetings/crypto/', 'International Cryptology Conference', FALSE, FALSE),
(40, 2027, 'EUROCRYPT 2027', '2027-05-09', '2027-05-13', 'TBD', 'TBD', '2026-10-04', 'https://www.iacr.org/meetings/eurocrypt/', 'European Cryptology Conference', FALSE, FALSE),
(55, 2027, 'CogSci 2027', '2027-07-21', '2027-07-24', 'TBD', 'TBD', '2027-02-01', 'https://cognitivesciencesociety.org', 'Annual Conference of the Cognitive Science Society', FALSE, FALSE),
(21, 2027, 'CHI 2027', '2027-04-24', '2027-04-29', 'TBD', 'TBD', '2026-09-05', 'https://chi.acm.org', 'ACM CHI Conference on Human Factors in Computing Systems', FALSE, FALSE),
(2, 2027, 'IEEE S&P 2027', '2027-05-17', '2027-05-20', 'San Francisco', 'USA', '2026-11-15', 'https://www.ieee-security.org', 'IEEE Symposium on Security and Privacy', FALSE, FALSE),
(36, 2027, 'AAAI 2027', '2027-02-23', '2027-03-02', 'TBD', 'TBD', '2026-08-07', 'https://aaai.org/conference/aaai/', 'AAAI Conference on Artificial Intelligence', FALSE, FALSE),
(57, 2027, 'APS 2027', '2027-05-27', '2027-05-29', 'TBD', 'TBD', '2026-12-05', 'https://www.psychologicalscience.org/conventions', 'APS Annual Convention', FALSE, FALSE);

-- ============================================================
-- ALICE_ML (UserID=1)
-- ============================================================
INSERT INTO `BOOKMARKS` (`UserID`, `SeriesID`, `Year`, `BookmarkedTimestamp`) VALUES
(1, 25, 2026, '2025-05-12 09:30:00'),
(1, 26, 2026, '2025-02-01 10:00:00'),
(1, 27, 2026, '2025-10-02 14:30:00'),
(1, 25, 2027, '2026-01-10 09:00:00'),
(1, 26, 2027, '2026-01-11 09:00:00');

INSERT INTO `VIEWS` (`UserID`, `SeriesID`, `Year`, `ViewedTimestamp`, `DurationSec`) VALUES
(1, 25, 2026, '2025-05-12 09:00:00', 400),
(1, 26, 2026, '2025-02-01 09:00:00', 360),
(1, 27, 2026, '2025-10-02 14:00:00', 310),
(1, 36, 2026, '2025-07-26 10:00:00', 200),
(1, 25, 2027, '2026-01-10 08:00:00', 380),
(1, 26, 2027, '2026-01-11 08:00:00', 350);

INSERT INTO `DISMISSES` (`UserID`, `SeriesID`, `Year`, `DismissedTimestamp`) VALUES
(1, 39, 2026, '2025-03-01 10:00:00'),
(1, 18, 2026, '2025-03-02 10:00:00'),
(1, 55, 2026, '2025-03-03 10:00:00');

-- ============================================================
-- BOB_SEC (UserID=2)
-- ============================================================
INSERT INTO `BOOKMARKS` (`UserID`, `SeriesID`, `Year`, `BookmarkedTimestamp`) VALUES
(2, 39, 2026, '2025-02-14 10:00:00'),
(2, 40, 2026, '2025-10-05 10:00:00'),
(2, 2, 2026, '2025-11-17 10:00:00'),
(2, 39, 2027, '2026-02-14 10:00:00'),
(2, 2, 2027, '2026-02-15 10:00:00');

INSERT INTO `VIEWS` (`UserID`, `SeriesID`, `Year`, `ViewedTimestamp`, `DurationSec`) VALUES
(2, 39, 2026, '2025-02-14 09:00:00', 420),
(2, 40, 2026, '2025-10-05 09:00:00', 400),
(2, 2, 2026, '2025-11-17 09:00:00', 380),
(2, 18, 2026, '2025-09-04 10:00:00', 350),
(2, 39, 2027, '2026-02-14 08:00:00', 410),
(2, 2, 2027, '2026-02-15 08:00:00', 390);

INSERT INTO `DISMISSES` (`UserID`, `SeriesID`, `Year`, `DismissedTimestamp`) VALUES
(2, 25, 2026, '2025-03-01 11:00:00'),
(2, 55, 2026, '2025-03-02 11:00:00'),
(2, 21, 2026, '2025-03-03 11:00:00');

-- ============================================================
-- ZOE_AFFECT (UserID=16)
-- ============================================================
INSERT INTO `BOOKMARKS` (`UserID`, `SeriesID`, `Year`, `BookmarkedTimestamp`) VALUES
(16, 55, 2026, '2025-02-03 09:30:00'),
(16, 56, 2026, '2025-11-16 09:00:00'),
(16, 8, 2026, '2025-04-26 09:30:00'),
(16, 55, 2027, '2026-02-03 09:00:00'),
(16, 21, 2027, '2026-02-04 09:00:00');

INSERT INTO `VIEWS` (`UserID`, `SeriesID`, `Year`, `ViewedTimestamp`, `DurationSec`) VALUES
(16, 55, 2026, '2025-02-03 09:00:00', 440),
(16, 56, 2026, '2025-11-16 08:00:00', 420),
(16, 21, 2026, '2025-04-26 09:00:00', 400),
(16, 8, 2026, '2025-04-27 10:00:00', 380),
(16, 58, 2026, '2025-08-12 09:00:00', 360),
(16, 55, 2027, '2026-02-03 08:00:00', 430),
(16, 21, 2027, '2026-02-04 08:00:00', 410);

INSERT INTO `DISMISSES` (`UserID`, `SeriesID`, `Year`, `DismissedTimestamp`) VALUES
(16, 39, 2026, '2025-03-01 08:00:00'),
(16, 18, 2026, '2025-03-02 08:00:00'),
(16, 32, 2026, '2025-03-03 08:00:00');

-- ============================================================
-- COLLABORATIVE FILTERING OVERLAP
-- ============================================================
INSERT INTO `VIEWS` (`UserID`, `SeriesID`, `Year`, `ViewedTimestamp`, `DurationSec`) VALUES
(9, 55, 2026, '2025-02-04 09:00:00', 430),
(9, 56, 2026, '2025-11-17 10:00:00', 410),
(9, 58, 2026, '2025-08-14 09:00:00', 390),
(9, 55, 2027, '2026-02-04 09:00:00', 420);

INSERT INTO `BOOKMARKS` (`UserID`, `SeriesID`, `Year`, `BookmarkedTimestamp`) VALUES
(9, 55, 2026, '2025-02-04 09:30:00'),
(9, 58, 2026, '2025-08-14 10:00:00'),
(9, 55, 2027, '2026-02-04 09:30:00');

INSERT INTO `VIEWS` (`UserID`, `SeriesID`, `Year`, `ViewedTimestamp`, `DurationSec`) VALUES
(11, 25, 2026, '2025-05-13 09:00:00', 450),
(11, 26, 2026, '2025-02-02 10:00:00', 420),
(11, 27, 2026, '2025-10-03 14:00:00', 400),
(11, 25, 2027, '2026-01-12 09:00:00', 440);

INSERT INTO `BOOKMARKS` (`UserID`, `SeriesID`, `Year`, `BookmarkedTimestamp`) VALUES
(11, 25, 2026, '2025-05-13 09:30:00'),
(11, 27, 2026, '2025-10-03 14:30:00'),
(11, 25, 2027, '2026-01-12 09:30:00');

INSERT INTO `VIEWS` (`UserID`, `SeriesID`, `Year`, `ViewedTimestamp`, `DurationSec`) VALUES
(13, 39, 2026, '2025-02-15 09:00:00', 380),
(13, 40, 2026, '2025-10-06 10:00:00', 360),
(13, 39, 2027, '2026-02-15 09:00:00', 370);

INSERT INTO `BOOKMARKS` (`UserID`, `SeriesID`, `Year`, `BookmarkedTimestamp`) VALUES
(13, 39, 2026, '2025-02-15 09:30:00'),
(13, 39, 2027, '2026-02-15 09:30:00');
