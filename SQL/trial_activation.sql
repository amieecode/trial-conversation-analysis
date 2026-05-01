USE trial_analysisdb;

CREATE TABLE trial_activation AS
SELECT
    organization_id,

    total_events_w1,
    active_days_w1,

    goal_schedule_created,
    goal_schedule_viewed,
    goal_team_engaged,
    goal_execution,
    goal_admin,

    (
        goal_schedule_created +
        goal_schedule_viewed +
        goal_team_engaged +
        goal_execution +
        goal_admin
    ) AS goals_completed,

    CASE 
        WHEN total_events_w1 >= 15
         AND active_days_w1 >= 2
         AND (
            goal_schedule_created +
            goal_schedule_viewed +
            goal_team_engaged +
            goal_execution +
            goal_admin
         ) >= 3
        THEN 1
        ELSE 0
    END AS activated

FROM trial_goals;

SELECT 
    activated,
    COUNT(*) AS orgs
FROM trial_activation
GROUP BY activated;

SELECT 
    activated,
    AVG(goals_completed),
    AVG(total_events_w1)
FROM trial_activation
GROUP BY activated;