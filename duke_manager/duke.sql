CREATE DATABASE IF NOT EXISTS `fivem`;
USE fivem
CREATE TABLE users (
    username varchar(50) NOT NULL,
    license varchar(255) NOT NULL,
    balance int(255) NOT NULL DEFAULT 0,
    money int(100) NOT NULL DEFAULT 0,
    inventory varchar(255) NOT NULL DEFAULT "{}",
    entry boolean NOT NULL DEFAULT 0,
    permgroup boolean NOT NULL DEFAULT false,
    coords varchar(100) NOT NULL DEFAULT 0,
    style varchar(255) NOT NULL DEFAULT 0,
    job varchar(50) NOT NULL DEFAULT 0,
    id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id)
);

CREATE TABLE items (
    name varchar(100) NOT NULL,
    description varchar(500) NOT NULL,
    handler longtext DEFAULT NULL,
    id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id)
);
