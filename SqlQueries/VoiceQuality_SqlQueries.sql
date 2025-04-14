CREATE TABLE voice_call_quality (
    operator VARCHAR(100),
    inout_travelling VARCHAR(20),
    network_type VARCHAR(20),
    rating INT,
    calldrop_category VARCHAR(100),
    latitude DOUBLE,
    longitude DOUBLE,
    state_name VARCHAR(100)
);
-- data cleaning
DELETE FROM voice_call_quality
WHERE latitude = -1 AND longitude = -1;

-- best operator
SELECT 
    operator,
    inout_travelling,
    network_type,
    rating,
    calldrop_category,
    latitude,
    longitude,
    state_name,
    COUNT(*) AS duplicate_count
FROM voice_call_quality
GROUP BY 
    operator,
    inout_travelling,
    network_type,
    rating,
    calldrop_category,
    latitude,
    longitude,
    state_name
HAVING COUNT(*) > 1;


-- que1 overall best operator 
SELECT state_name, operator, AVG(rating) AS avg_rating
FROM voice_call_quality
WHERE state_name IS NOT NULL
GROUP BY state_name, operator
HAVING AVG(rating) = (
    SELECT MAX(avg_rating)
    FROM (
        SELECT state_name AS st, operator, AVG(rating) AS avg_rating
        FROM voice_call_quality
        WHERE state_name IS NOT NULL
        GROUP BY state_name, operator
    ) AS sub
    WHERE sub.st = voice_call_quality.state_name
);
-- Indoor performance
SELECT state_name, operator, AVG(rating) AS avg_rating
FROM voice_call_quality
WHERE state_name IS NOT NULL AND inout_travelling = 'Indoor'
GROUP BY state_name, operator
HAVING AVG(rating) = (
    SELECT MAX(avg_rating)
    FROM (
        SELECT state_name AS st, operator, AVG(rating) AS avg_rating
        FROM voice_call_quality
        WHERE state_name IS NOT NULL AND inout_travelling = 'Indoor'
        GROUP BY state_name, operator
    ) AS sub
    WHERE sub.st = voice_call_quality.state_name
);

-- outdoor performance
SELECT state_name, operator, AVG(rating) AS avg_rating
FROM voice_call_quality
WHERE state_name IS NOT NULL AND inout_travelling = 'Outdoor'
GROUP BY state_name, operator
HAVING AVG(rating) = (
    SELECT MAX(avg_rating)
    FROM (
        SELECT state_name AS st, operator, AVG(rating) AS avg_rating
        FROM voice_call_quality
        WHERE state_name IS NOT NULL AND inout_travelling = 'Outdoor'
        GROUP BY state_name, operator
    ) AS sub
    WHERE sub.st = voice_call_quality.state_name
);




-- Que 2 correlation between network type and rating
SELECT network_type,  
AVG(rating) as avg_rating, 
COUNT(*) as total_ratings 
FROM voice_call_quality 
GROUP BY network_type 
ORDER BY avg_rating DESC;


-- Distribution of ratings by network type 
SELECT network_type, rating, COUNT(*) as rating_count 
FROM voice_call_quality 
GROUP BY network_type, rating 
ORDER BY network_type, rating;

-- Question: 3 -- Average rating by call drop category 
SELECT calldrop_category,  
AVG(rating) as avg_rating, 
COUNT(*) as entry_count 
FROM voice_call_quality 
GROUP BY calldrop_category 
ORDER BY avg_rating;

-- Distribution of ratings for each call drop category 
SELECT calldrop_category, rating, COUNT(*) as count 
FROM voice_call_quality 
GROUP BY calldrop_category, rating 
ORDER BY calldrop_category, rating; 

-- Question: 4 -- Count of call drops by location 
SELECT inout_travelling,  
calldrop_category,  
COUNT(*) as drop_count 
FROM voice_call_quality 
GROUP BY inout_travelling, calldrop_category 
ORDER BY inout_travelling, calldrop_category;

-- Calculate percentages of call drops for indoor vs outdoor 
SELECT inout_travelling, 
SUM(CASE WHEN calldrop_category = 'Drop' THEN 1 ELSE 0 END) as drop_count, 
COUNT(*) as total_count, 
(SUM(CASE WHEN calldrop_category = 'Drop' THEN 1 ELSE 0 END) / COUNT(*)) * 100 
as drop_percentage 
FROM voice_call_quality 
GROUP BY inout_travelling; 

SELECT inout_travelling,
       COUNT(*) AS total_entries,
       SUM(CASE WHEN calldrop_category = 'Call Dropped' THEN 1 ELSE 0 END) AS call_drops,
       ROUND(100.0 * SUM(CASE WHEN calldrop_category = 'Call Dropped' THEN 1 ELSE 0 END) / COUNT(*), 2) AS call_drop_rate
FROM voice_call_quality 
WHERE state_name IS NOT NULL
GROUP BY inout_travelling;