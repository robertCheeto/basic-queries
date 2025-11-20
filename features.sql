USE mangomusic;


-- Feature 1: Listening Activity by Subscription Type

SELECT
	U.subscription_type,
	COUNT(AP.play_id) AS total_plays,
    COUNT(DISTINCT AP.user_id) AS total_users,
    ROUND(COUNT(AP.play_id) / COUNT(DISTINCT AP.user_id), 2) AS avg_plays_per_user
FROM
	album_plays AS AP
JOIN 
	users AS U ON (AP.user_id = U.user_id)
GROUP BY U.subscription_type
ORDER BY U.subscription_type;


-- Feature 2: Most Active Countries Report

SELECT
	U.country,
    COUNT(DISTINCT AP.user_id) AS total_users,
    COUNT(AP.play_id) AS total_plays,
    ROUND(COUNT(AP.play_id) / COUNT(DISTINCT AP.user_id), 2) AS avg_plays_per_user
FROM
	album_plays AS AP
JOIN
	users AS U ON (AP.user_id = U.user_id)
GROUP BY U.country
ORDER BY total_plays DESC
LIMIT 15;


-- Feature 3: Genre Popularity Rankings

    
SELECT 
	ar.primary_genre, 
	COUNT(ap.play_id) AS total_plays,
    COUNT(DISTINCT al.album_id) AS total_albums,
    COUNT(DISTINCT ar.name) AS total_artists
FROM 
	album_plays AS ap 
JOIN 
	albums AS al ON (ap.album_id = al.album_id) 
    JOIN 
		artists AS ar ON (al.artist_id = ar.artist_id) 
        GROUP BY ar.primary_genre 
        ORDER BY total_plays DESC;
        

-- Feature 4: User Growth by Month Report
-- Error Code: 1140. In aggregated query without GROUP BY, 
-- expression #1 of SELECT list contains nonaggregated column 'mangomusic.users.signup_date'; this is incompatible with sql_mode=only_full_group_by


SELECT
	DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    SUM(CASE WHEN subscription_type = 'free' THEN 1 ELSE 0 END) AS free_signups,
    SUM(CASE WHEN subscription_type = 'premium' THEN 1 ELSE 0 END) AS premium_signups,
    COUNT(user_id) AS total_new_users
FROM
	users
WHERE signup_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY signup_month
ORDER BY signup_month;


-- Feature 5: Album Completion Rate Summary

-- SELECT
-- 	SUM(CASE WHEN completed = 1 THEN 'completed' ELSE 'incomplete' END) AS play_status,
-- 	COUNT(play_id) AS total_plays,
-- 	ROUND((play_id / play_status), 2)


