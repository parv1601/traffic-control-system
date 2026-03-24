-- Drop views if they exist
DROP VIEW IF EXISTS traffic_state;
DROP VIEW IF EXISTS sensor_window_5min;

-- SENSOR WINDOW (last 5 minutes)
CREATE VIEW sensor_window_5min AS
SELECT *
FROM sensor_stream
WHERE ts >= NOW() - INTERVAL 5 MINUTE;

-- TRAFFIC STATE (aggregation)
CREATE VIEW traffic_state AS
SELECT 
    intersection_id,
    road_id,
    AVG(vehicle_count) AS avg_vehicles,
    AVG(avg_speed) AS avg_speed
FROM sensor_window_5min
GROUP BY intersection_id, road_id;