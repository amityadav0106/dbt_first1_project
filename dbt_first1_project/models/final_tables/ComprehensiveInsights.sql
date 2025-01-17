WITH TelemetryFeatures AS (
    SELECT * FROM {{ref('stg_telemetry_features')}}
),
AvgTelemetry AS (
    SELECT * FROM {{ref('stg_avg_telemetry')}}
),
ErrorData AS (
    SELECT * FROM {{ref('stg_error_data')}}
),
MaintenanceData AS (
    SELECT * FROM {{ref('stg_maintenance_data')}}
),
FailureData AS (
    SELECT * FROM {{ref('stg_failure_data')}}
),
ComprehensiveInsights AS (
    SELECT
        tf.DATETIME,
        tf.MACHINEID,
        tf.MODEL,
        tf.AGE,
        at.AVG_VOLT,
        at.AVG_ROTATE,
        at.AVG_PRESSURE,
        at.AVG_VIBRATION,
        ed.ERRORID,
        md.COMP,
        fd.FAILURE
    FROM
        TelemetryFeatures tf
    LEFT JOIN AvgTelemetry at ON tf.MACHINEID = at.MACHINEID
    LEFT JOIN ErrorData ed ON tf.MACHINEID = ed.MACHINEID AND tf.DATETIME = ed.DATETIME
    LEFT JOIN MaintenanceData md ON tf.MACHINEID = md.MACHINEID AND tf.DATETIME = md.DATETIME
    LEFT JOIN FailureData fd ON tf.MACHINEID = fd.MACHINEID AND tf.DATETIME = fd.DATETIME
)

SELECT * FROM ComprehensiveInsights
