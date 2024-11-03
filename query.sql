-- Створення таблиці користувачів
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Створення таблиці тренерів
CREATE TABLE Trainers (
    trainer_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    experience INTEGER CHECK (experience >= 0),
    specialization VARCHAR(100)
);

-- Створення таблиці творчих користувачів
CREATE TABLE CreativeUsers (
    creative_user_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    age SMALLINT CHECK (age > 0),
    weight REAL CHECK (weight > 0),
    height REAL CHECK (height > 0),
    skill_level SMALLINT CHECK (skill_level BETWEEN 1 AND 10)
);

-- Створення таблиці панелей моніторингу
CREATE TABLE MonitoringPanels (
    panel_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES Users(user_id) ON DELETE CASCADE,
    status VARCHAR(50)
);

-- Створення таблиці метрик
CREATE TABLE Metrics (
    metric_id SERIAL PRIMARY KEY,
    panel_id INT REFERENCES MonitoringPanels(panel_id) ON DELETE CASCADE,
    type VARCHAR(50) NOT NULL,
    value REAL NOT NULL,
    measure_unit VARCHAR(20),
    measured_at DATE DEFAULT current_timestamp
);

-- Створення таблиці рекомендацій
CREATE TABLE Recommendations (
    recommendation_id SERIAL PRIMARY KEY,
    description TEXT,
    type VARCHAR(50) NOT NULL,
    importance SMALLINT CHECK (importance BETWEEN 1 AND 5),
    creature_user INT REFERENCES Users(user_id) ON DELETE CASCADE,
    trener_id INT REFERENCES Trainers(user_id) ON DELETE CASCADE
);
