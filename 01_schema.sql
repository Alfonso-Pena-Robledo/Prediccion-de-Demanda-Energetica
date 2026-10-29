DROP TABLE IF EXISTS raw_energy_consumption;

CREATE TABLE raw_energy_consumption (
    datetime TIMESTAMP WITHOUT TIME ZONE,
    pjme_mw DOUBLE PRECISION NOT NULL
);

COPY raw_energy_consumption(datetime, pjme_mw)
FROM 'C:/Users/USER/Desktop/PJME_hourly.csv'
DELIMITER ','
CSV HEADER;