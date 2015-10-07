CREATE DATABASE IF NOT EXISTS web;
CREATE DATABASE IF NOT EXISTS api;
CREATE DATABASE IF NOT EXISTS memservices;
GRANT ALL ON web.* TO 'web'@'localhost' identified by 'web';
GRANT ALL ON api.* TO 'api'@'localhost' identified by 'api';
GRANT ALL ON memservices.* TO 'api'@'localhost';
