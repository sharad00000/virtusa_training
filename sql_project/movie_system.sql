DROP TABLE IF EXISTS Watch_History;
DROP TABLE IF EXISTS Ratings;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INTEGER CHECK (age > 0)
);


CREATE TABLE Movies (
    movie_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    genre VARCHAR(100) NOT NULL
);

CREATE TABLE Ratings (
    user_id INTEGER,
    movie_id INTEGER,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    rating_date DATE,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE
);

CREATE TABLE Watch_History (
    user_id INTEGER,
    movie_id INTEGER,
    watch_date DATE,
    PRIMARY KEY (user_id, movie_id, watch_date),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE
);

INSERT INTO Users (user_id, name, age) VALUES (1, 'sharad', 22);
INSERT INTO Users (user_id, name, age) VALUES (2, 'siva', 32);
INSERT INTO Users (user_id, name, age) VALUES (3, 'sachin', 19);
INSERT INTO Users (user_id, name, age) VALUES (4, 'sushmitha', 21);
INSERT INTO Users (user_id, name, age) VALUES (5, 'goopi', 29);
INSERT INTO Users (user_id, name, age) VALUES (6, 'dharanish', 35);
select * from users;

INSERT INTO Movies (movie_id, title, genre) VALUES (101, 'master', 'Sci-Fi');
INSERT INTO Movies (movie_id, title, genre) VALUES (102, 'jananayagan', 'Action');
INSERT INTO Movies (movie_id, title, genre) VALUES (103, 'mersal', 'Sci-Fi');
INSERT INTO Movies (movie_id, title, genre) VALUES (104, 'theri', 'Drama');
INSERT INTO Movies (movie_id, title, genre) VALUES (105, 'leo', 'Drama');
INSERT INTO Movies (movie_id, title, genre) VALUES (106, 'beast', 'Action');
INSERT INTO Movies (movie_id, title, genre) VALUES (107, 'nanban', 'Comedy');
INSERT INTO Movies (movie_id, title, genre) VALUES (108, 'spiderman', 'Animation');
INSERT INTO Movies (movie_id, title, genre) VALUES (109, 'docter strange', 'Sci-Fi');
INSERT INTO Movies (movie_id, title, genre) VALUES (110, 'average', 'Action');
select * from movies;

INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (1, 101, 5, '2026-06-20');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (1, 103, 4, '2026-06-21');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (1, 109, 5, '2026-06-22');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (2, 101, 5, '2026-06-19');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (2, 102, 4, '2026-06-20');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (2, 103, 5, '2026-06-22');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (3, 107, 5, '2026-06-15');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (3, 108, 4, '2026-06-16');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (4, 105, 5, '2026-06-18');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (4, 106, 4, '2026-06-19');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (5, 101, 4, '2026-06-21');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (5, 103, 5, '2026-06-22');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (5, 109, 4, '2026-06-23');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (5, 102, 3, '2026-06-24');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (6, 101, 5, '2026-06-23');
INSERT INTO Ratings (user_id, movie_id, rating, rating_date) VALUES (6, 102, 5, '2026-06-24');
select * from ratings;

INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (1, 101, '2026-06-20');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (1, 103, '2026-06-21');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (1, 109, '2026-06-22');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (2, 101, '2026-06-19');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (2, 102, '2026-06-20');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (2, 103, '2026-06-22');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (3, 107, '2026-06-15');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (3, 108, '2026-06-16');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (4, 105, '2026-06-18');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (4, 106, '2026-06-19');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (5, 101, '2026-06-21');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (5, 103, '2026-06-22');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (5, 109, '2026-06-23');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (5, 102, '2026-06-24');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (6, 101, '2026-06-23');
INSERT INTO Watch_History (user_id, movie_id, watch_date) VALUES (6, 102, '2026-06-24');
select * from watch_history;

SELECT 
    m.movie_id, 
    m.title, 
    m.genre, 
    ROUND(AVG(r.rating), 2) AS average_rating, 
    COUNT(r.rating) AS rating_count
FROM Movies m
LEFT JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title, m.genre
HAVING COUNT(r.rating) > 0
ORDER BY average_rating desc, rating_count desc;


SELECT 
    m.genre, 
    COUNT(w.movie_id) AS total_watches,
    COUNT(DISTINCT w.user_id) AS unique_viewers
FROM Movies m
JOIN Watch_History w ON m.movie_id = w.movie_id
GROUP BY m.genre
ORDER BY total_watches DESC;

SELECT 
    m.genre, 
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.rating) AS total_ratings
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.genre
ORDER BY average_rating DESC;


WITH SimilarUsers AS (

    SELECT DISTINCT sim.user_id
    FROM Ratings target
    JOIN Ratings sim 
        ON target.movie_id = sim.movie_id 
        AND target.user_id = 1
        AND sim.user_id != 1
    WHERE target.rating >= 4
      AND sim.rating >= 4
)

SELECT 
    m.movie_id,
    m.title,
    m.genre,
    ROUND(AVG(r.rating), 2) AS average_rating_by_similar_users,
    COUNT(DISTINCT r.user_id) AS recommendation_strength
FROM SimilarUsers su
JOIN Ratings r ON su.user_id = r.user_id
JOIN Movies m ON r.movie_id = m.movie_id
WHERE r.rating >= 4

  AND r.movie_id NOT IN (
      SELECT movie_id FROM Watch_History WHERE user_id = 1
      UNION
      SELECT movie_id FROM Ratings WHERE user_id = 1
  )
GROUP BY m.movie_id, m.title, m.genre
ORDER BY recommendation_strength DESC, average_rating_by_similar_users DESC;

SELECT 
    CASE 
        WHEN u.age < 25 THEN 'Under 25'
        WHEN u.age BETWEEN 25 AND 35 THEN '25-35'
        ELSE '36 and older'
    END AS age_group,
    COUNT(DISTINCT u.user_id) AS total_users,
    COUNT(w.movie_id) AS total_watches,
    ROUND(AVG(r.rating), 2) AS average_given_rating
FROM Users u
LEFT JOIN Watch_History w ON u.user_id = w.user_id
LEFT JOIN Ratings r ON u.user_id = r.user_id AND w.movie_id = r.movie_id
GROUP BY 
    CASE 
        WHEN u.age < 25 THEN 'Under 25'
        WHEN u.age BETWEEN 25 AND 35 THEN '25-35'
        ELSE '36 and older'
    END
ORDER BY total_watches DESC;

SELECT 
    m.movie_id, 
    m.title, 
    m.genre, 
    COUNT(w.movie_id) AS recent_watch_count
FROM Movies m
JOIN Watch_History w ON m.movie_id = w.movie_id
WHERE w.watch_date >= (
    SELECT DATE(MAX(watch_date), '-7 days') FROM Watch_History
)
GROUP BY m.movie_id, m.title, m.genre
ORDER BY recent_watch_count DESC, m.title ASC;
