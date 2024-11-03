CREATE TABLE Users (
    User_id SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    CHECK (Email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);
CREATE TABLE Trainers (
    Trainer_id SERIAL PRIMARY KEY,
    User_id INT REFERENCES Users (User_id) ON DELETE CASCADE,
    Experience INTEGER CHECK (Experience >= 0),
    Specialization VARCHAR(100)
);
CREATE TABLE Creativeusers (
    Creative_user_id SERIAL PRIMARY KEY,
    User_id INT REFERENCES Users (User_id) ON DELETE CASCADE,
    Age SMALLINT CHECK (Age > 0),
    Weight REAL CHECK (Weight > 0),
    Height REAL CHECK (Height > 0),
    Skill_level SMALLINT CHECK (Skill_level BETWEEN 1 AND 10)
);
CREATE TABLE Monitoringpanels (
    Panel_id SERIAL PRIMARY KEY,
    User_id INT REFERENCES Users (User_id) ON DELETE CASCADE,
    Status VARCHAR(50)
);
CREATE TABLE Metrics (
    Metric_id SERIAL PRIMARY KEY,
    Panel_id INT REFERENCES Monitoringpanels (Panel_id) ON DELETE CASCADE,
    Type VARCHAR(50) NOT NULL,
    Value REAL NOT NULL,
    Measure_unit VARCHAR(20),
    Measured_at DATE DEFAULT current_timestamp
);
CREATE TABLE Recommendations (
    Recommendation_id SERIAL PRIMARY KEY,
    Description TEXT,
    Type VARCHAR(50) NOT NULL,
    Importance SMALLINT CHECK (Importance BETWEEN 1 AND 5),
    Creature_user INT REFERENCES Users (User_id) ON DELETE CASCADE,
    Trener_id INT REFERENCES Trainers (User_id) ON DELETE CASCADE
);
