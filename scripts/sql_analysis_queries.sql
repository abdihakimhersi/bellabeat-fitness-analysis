-- BELLABEAT FITNESS DATA ANALYSIS
-- Google Data Analytics Certificate Case Study
-- SQL queries executed in Google BigQuery

-- =============================================
-- 1. USER ACTIVITY SEGMENTATION
-- =============================================
-- Classifies users by average daily steps
WITH user_activity AS (
  SELECT
    Id,
    AVG(TotalSteps) as avg_daily_steps,
    AVG(SedentaryMinutes) as avg_sedentary_min,
  FROM
    `my-first-project-462019.fitbit_data.daily_activity_raw`
  GROUP BY
    Id
)
SELECT
  CASE
    WHEN user_activity.avg_daily_steps < 5000 THEN 'Sedentary (>5000 steps)'
    WHEN user_activity.avg_daily_steps BETWEEN 5000 AND 7499 THEN 'Lightly Active (7499-5000 steps)'
    WHEN user_activity.avg_daily_steps BETWEEN 7500 AND 9999 THEN 'Moderatley Active (9999-7500 steps)'
    WHEN user_activity.avg_daily_steps >= 10000 THEN 'Very Active (<10000 steps)' 
  END
    as activity_segment,
  COUNT(*) as number_of_users,
  ROUND(AVG(avg_daily_steps),0) as avg_steps_in_segment,
  ROUND(AVG(avg_sedentary_min)/60,1) as avg_sedentary_hours
FROM
  user_activity
GROUP BY
  activity_segment
ORDER BY
  number_of_users DESC;
-- =============================================
-- 2. WEEKLY ACTIVITY PATTERNS  
-- =============================================
-- Analyzes step patterns by day of week
SELECT
  FORMAT_DATE('%A', ActivityDate) as day_of_the_week,
  ROUND(AVG(TotalSteps) ,0) as avg_steps,
  ROUND(AVG(VeryActiveMinutes),1) as avg_very_active_min,
  ROUND(AVG(FairlyActiveMinutes),1) as avg_fairly_active_min,
  ROUND(AVG(SedentaryMinutes)/60,1) as avg_sedentary_hrs,
FROM
  `my-first-project-462019.fitbit_data.daily_activity_raw`
GROUP BY
  day_of_the_week
ORDER BY
  CASE day_of_the_week
    WHEN 'Sunday' THEN 1 WHEN 'Monday' THEN 2 WHEN 'Tuesday' THEN 3 WHEN 'Wednesday' THEN 4
    WHEN 'Thursday' THEN 5 WHEN 'Friday' THEN 6 WHEN 'Saturday' THEN 7
  END;
-- =============================================
-- 3. HOURLY ACTIVITY TRENDS
-- =============================================
-- Shows peak activity hours throughout day
SELECT
EXTRACT(HOUR FROM PARSE_DATETIME ('%m/%d/%Y %I:%M:%S %P',hs.ActivityHour)) AS hour_of_day,
ROUND(AVG(StepTotal),0) AS avg_steps,
ROUND(AVG(TotalIntensity),1) AS avg_intensity,
ROUND(AVG(Calories),0) AS avg_calories
FROM
  `my-first-project-462019.fitbit_data.hourly_steps_raw` AS hs
JOIN
  `my-first-project-462019.fitbit_data.hourly_intensities_raw` AS hi
  ON hs.Id = hi.Id AND hs.ActivityHour = hi.ActivityHour
JOIN
  `my-first-project-462019.fitbit_data.hourly_calories_raw` AS hc
  ON hs.Id = hc.Id AND hi.ActivityHour = hc.ActivityHour
GROUP BY
  hour_of_day
ORDER BY
  hour_of_day
-- =============================================
-- 4. DEVICE USAGE CONSISTENCY
-- =============================================
-- Measures how often users wear devices
SELECT
  CASE
    WHEN usage_days >= 19 THEN 'Highly Enganged(+19 days)'
    WHEN usage_days BETWEEN 15 AND 18 THEN 'Very Consistent (15-18 days)'
    WHEN usage_days BETWEEN 12 AND 14 THEN 'Regular User (12-14 days)'
    WHEN usage_days BETWEEN 8 AND 11 THEN 'Ocassional User (8-11 days)'
    ELSE 'Infrequent User (0-7 days)'
  END as usage_frequency,
  ROUND(AVG(usage_days),1) AS avg_day_used,
  COUNT(*) AS user_count
FROM (
  SELECT
    Id,
    COUNT(DISTINCT(ActivityDate)) AS usage_days
  FROM
    `my-first-project-462019.fitbit_data.daily_activity_raw`
  GROUP BY
    Id
    )
GROUP BY
  usage_frequency
ORDER BY
  user_count DESC;
