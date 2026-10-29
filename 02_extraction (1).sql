WITH cleaned_data AS (
    SELECT 
        datetime,
        pjme_mw,
        ROW_NUMBER() OVER (PARTITION BY datetime ORDER BY datetime) AS rn
    FROM raw_energy_consumption
    WHERE pjme_mw IS NOT NULL AND pjme_mw > 0
)
SELECT 
    datetime,
    pjme_mw,
    AVG(pjme_mw) OVER (PARTITION BY DATE(datetime)) AS daily_avg_mw
FROM cleaned_data
WHERE rn = 1
ORDER BY datetime ASC;