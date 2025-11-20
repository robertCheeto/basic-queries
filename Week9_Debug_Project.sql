USE mangomusic;

-- REPORT 1: Daily Active Users Report
-- Business need: Track platform engagement day-by-day
-- Shows unique users who played at least one album each day for the past 30 days
SELECT *
FROM users;


SELECT 
    DATE(played_at) as activity_date,
    COUNT(DISTINCT user_id) as daily_active_users
FROM album_plays
WHERE played_at >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY DATE(played_at)
ORDER BY activity_date DESC;


-- REPORT 2: Top 10 Most Played Albums This Month
-- Business need: What albums are trending right now?
-- Shows album title, artist name, and play count for current month

SELECT 
    al.title as album_title,
    ar.name as artist_name,
    COUNT(*) as play_count
FROM album_plays ap
JOIN albums al ON ap.album_id = al.album_id
JOIN artists ar ON al.artist_id = ar.artist_id
WHERE YEAR(ap.played_at) = YEAR(CURDATE())
  AND MONTH(ap.played_at) = MONTH(CURDATE())
GROUP BY al.album_id, al.title, ar.name
ORDER BY play_count DESC
LIMIT 10;


-- REPORT 3: New User Retention (7-Day)
-- Business need: What % of new signups come back after 7 days?
-- Shows cohorts of users by signup week with their 7-day return rate

SELECT 
    DATE_FORMAT(u.signup_date, '%Y-%W') as signup_week,
    COUNT(DISTINCT u.user_id) as total_signups,
    COUNT(DISTINCT CASE 
        WHEN ap.played_at >= DATE_ADD(u.signup_date, INTERVAL 7 DAY)
         AND ap.played_at < DATE_ADD(u.signup_date, INTERVAL 14 DAY)
        THEN u.user_id 
    END) as retained_users,
    ROUND((COUNT(DISTINCT CASE 
        WHEN ap.played_at >= DATE_ADD(u.signup_date, INTERVAL 7 DAY)
         AND ap.played_at < DATE_ADD(u.signup_date, INTERVAL 14 DAY)
        THEN u.user_id 
    END) * 100.0 / COUNT(DISTINCT u.user_id)), 2) as retention_rate_percent
FROM users u
LEFT JOIN album_plays ap ON u.user_id = ap.user_id
WHERE u.signup_date >= DATE_SUB(CURDATE(), INTERVAL 900 DAY)
GROUP BY DATE_FORMAT(u.signup_date, '%Y-%W')
ORDER BY signup_week DESC;


-- REPORT 4: Monthly Active Users by Country
-- Business need: Geographic breakdown of engaged users
-- Count unique users who played at least one album per month, by country

SELECT 
    u.country,
    DATE_FORMAT(ap.played_at, '%Y-%m') AS activity_month,
    COUNT(DISTINCT u.user_id) AS monthly_active_users
FROM album_plays AS ap
JOIN users u ON ap.user_id = u.user_id
WHERE ap.played_at >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY u.country, DATE_FORMAT(ap.played_at, '%Y-%m')
ORDER BY activity_month DESC, monthly_active_users DESC;


-- REPORT 5: Artist Revenue Projection
-- Business need: Calculate estimated revenue per artist based on plays
-- Premium plays = $0.004 per play, Free plays = $0.001 per play

SELECT 
    ar.name as artist_name,
    ar.primary_genre,
    COUNT(ap.play_id) as total_plays,
    SUM(CASE WHEN u.subscription_type = 'premium' THEN 1 ELSE 0 END) as premium_plays,
    SUM(CASE WHEN u.subscription_type = 'free' THEN 1 ELSE 0 END) as free_plays,
    ROUND(
        SUM(CASE WHEN u.subscription_type = 'premium' THEN 4 ELSE 1 END) / 1000,
        2
    ) as estimated_revenue_usd
FROM album_plays ap
JOIN albums al ON ap.album_id = al.album_id
JOIN artists ar ON al.artist_id = ar.artist_id
JOIN users u ON ap.user_id = u.user_id
GROUP BY ar.artist_id, ar.name, ar.primary_genre
ORDER BY estimated_revenue_usd DESC
LIMIT 50;


-- REPORT 6: Churn Risk Users
-- Business need: Identify premium users at risk of canceling (haven't played in 14+ days)
-- Shows premium users, days since last play, and total lifetime plays

SELECT 
    u.user_id,
    u.username,
    u.email,
    u.country,
    DATEDIFF(CURDATE(), MAX(ap.played_at)) as days_since_last_play,
    COUNT(ap.play_id) as lifetime_plays,
    CASE 
        WHEN DATEDIFF(CURDATE(), MAX(ap.played_at)) >= 30 THEN 'High Risk'
        WHEN DATEDIFF(CURDATE(), MAX(ap.played_at)) >= 21 THEN 'Medium Risk'
        WHEN DATEDIFF(CURDATE(), MAX(ap.played_at)) >= 14 THEN 'Low Risk'
    END as churn_risk_level
FROM users u
LEFT JOIN album_plays ap ON u.user_id = ap.user_id
WHERE u.subscription_type = 'premium'
GROUP BY u.user_id, u.username, u.email, u.country
HAVING DATEDIFF(CURDATE(), MAX(ap.played_at)) >= 14 
ORDER BY days_since_last_play DESC;

SELECT user_id, MAX(played_at) FROM album_plays WHERE user_id IN (1, 2, 3) GROUP BY user_id;