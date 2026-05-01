USE trial_analysisdb;

SELECT * FROM events LIMIT 10;

CREATE TABLE trial_goals AS
SELECT
    organization_id,

    COUNT(*) AS total_events_w1,

    COUNT(DISTINCT DATE(timestamp)) AS active_days_w1,

    MAX(CASE WHEN activity_name = 'Scheduling.Shift.Created' THEN 1 ELSE 0 END) AS goal_schedule_created,

    MAX(CASE WHEN activity_name = 'Mobile.Schedule.Loaded' THEN 1 ELSE 0 END) AS goal_schedule_viewed,

    MAX(CASE WHEN activity_name = 'Communication.Message.Created' THEN 1 ELSE 0 END) AS goal_team_engaged,

    MAX(CASE WHEN activity_name = 'PunchClock.PunchedIn' THEN 1 ELSE 0 END) AS goal_execution,

    MAX(CASE 
        WHEN activity_name IN (
            'Timesheets.BulkApprove.Confirmed',
            'Scheduling.Shift.Approved'
        )
        THEN 1 ELSE 0 END
    ) AS goal_admin

FROM events
WHERE TIMESTAMPDIFF(DAY, trial_start, timestamp) <= 7
GROUP BY organization_id;

SELECT * FROM trial_goals LIMIT 10;