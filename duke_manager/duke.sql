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
    number varchar(12) NOT NULL
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

CREATE TABLE apps (
  id int(11) NOT NULL,
  icon text NOT NULL,
  html longtext NOT NULL,
  js longtext NOT NULL,
  clientlua longtext NOT NULL,
  serverlua longtext NOT NULL,
  rmaccess text NOT NULL,
  defaultapp int(11) NOT NULL
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE player_apps (
  pkey int(11) NOT NULL,
  license varchar(255) NOT NULL,
  appId int(11) NOT NULL
  PRIMARY KEY (pkey)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE calllist (
  id int(11) NOT NULL,
  fromnumber text NOT NULL,
  tonumber text NOT NULL,
  date timestamp NOT NULL DEFAULT current_timestamp(),
  lic text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE contacts (
  id int(11) NOT NULL,
  owner text NOT NULL,
  name text NOT NULL,
  nr text NOT NULL
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `vehicles` (
  `owner` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `displayName` varchar(255) NOT NULL,
  `manifacturer` varchar(100) NOT NULL,
  `categorie` varchar(255) NOT NULL,
  `config` varchar(255) NOT NULL,
  `upgrades` varchar(255) DEFAULT '0',
  `currentStatus` varchar(5) NOT NULL DEFAULT 'in',
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `calllist`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);
