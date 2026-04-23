-- EcoMetrics MySQL schema (minimal)
-- Run this once on your hosted MySQL database:
--   mysql -h <host> -u <user> -p <db_name> < schema.sql

CREATE TABLE IF NOT EXISTS stations (
  station_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  latitude DOUBLE NULL,
  longitude DOUBLE NULL
);

CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  middle_name VARCHAR(100) NULL,
  last_name VARCHAR(100) NOT NULL,
  user_name VARCHAR(100) NOT NULL UNIQUE,
  age INT NULL
);

CREATE TABLE IF NOT EXISTS pollutant_readings (
  record_id INT AUTO_INCREMENT PRIMARY KEY,
  station_id INT NOT NULL,
  location_name VARCHAR(255) NOT NULL,
  pm25_ug_m3 DOUBLE NULL,
  so2_ug_m3 DOUBLE NULL,
  no2_ug_m3 DOUBLE NULL,
  PM10 DOUBLE NULL,
  CO DOUBLE NULL,
  OZONE DOUBLE NULL,
  NH3 DOUBLE NULL,
  reading_date DATE NOT NULL,
  reading_time TIME NOT NULL,
  aqi INT NULL,
  INDEX idx_pollutant_station_time (location_name, reading_date, reading_time),
  CONSTRAINT fk_pollutant_station FOREIGN KEY (station_id) REFERENCES stations(station_id)
);

CREATE TABLE IF NOT EXISTS meteorological_data (
  record_id INT AUTO_INCREMENT PRIMARY KEY,
  temperature_c DOUBLE NULL,
  feels_like_c DOUBLE NULL,
  pressure_hpa DOUBLE NULL,
  grnd_level_hpa DOUBLE NULL,
  humidity_percent DOUBLE NULL,
  wind_kph DOUBLE NULL,
  wind_deg DOUBLE NULL,
  wind_gust DOUBLE NULL,
  visibility_km DOUBLE NULL,
  clouds_percent DOUBLE NULL,
  precipitation_prob DOUBLE NULL,
  rain_3h DOUBLE NULL,
  condition_main VARCHAR(100) NULL,
  condition_text VARCHAR(255) NULL,
  sunrise VARCHAR(20) NULL,
  sunset VARCHAR(20) NULL,
  record_date DATE NOT NULL,
  record_time TIME NOT NULL,
  station_id INT NOT NULL,
  station_name VARCHAR(255) NOT NULL,
  INDEX idx_meteo_station_time (station_name, record_date, record_time),
  CONSTRAINT fk_meteo_station FOREIGN KEY (station_id) REFERENCES stations(station_id)
);

