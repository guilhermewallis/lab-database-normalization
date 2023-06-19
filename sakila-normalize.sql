CREATE TABLE `film` (
  `film_id` smallint PRIMARY KEY,
  `title` varchar(128),
  `description` text,
  `release_year` year,
  `length` smallint,
  `rating` film_rating_enum,
  `special_features` SET('TRL','COM','DS','BTS'),
  `rental_duration` tinyint,
  `rental_rate` decimal(4,2),
  `replacement_cost` decimal(5,2),
  `last_update` timestamp
);

CREATE TABLE `film_category` (
  `category_id` tinyint,
  `film_id` smallint,
  `last_update` timestamp
);

CREATE TABLE `category` (
  `category_id` tinyint PRIMARY KEY,
  `name` varchar(25),
  `last_update` timestamp
);

CREATE TABLE `film_actor` (
  `actor_id` smallint,
  `film_id` smallint,
  `last_update` timestamp
);

CREATE TABLE `actor` (
  `actor_id` smallint PRIMARY KEY,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `last_update` timestamp
);

CREATE TABLE `film_language` (
  `language_id` tinyint,
  `original_language_id` tinyint,
  `film_id` smallint,
  `last_update` timestamp
);

CREATE TABLE `language` (
  `language_id` tinyint PRIMARY KEY,
  `name` char(20),
  `last_update` timestamp
);

CREATE TABLE `inventory` (
  `inventory_id` mediumint PRIMARY KEY,
  `film_id` smallint,
  `store_id` tinyint,
  `last_update` timestamp
);

CREATE TABLE `rental` (
  `rental_id` int PRIMARY KEY,
  `inventory_id` mediumint,
  `staff_id` tinyint,
  `customer_id` smallint,
  `rental_date` datetime,
  `return_date` datetime,
  `payment_amount` decimal(5,2),
  `payment_date` datetime,
  `last_update` timestamp
);

CREATE TABLE `store` (
  `store_id` tinyint PRIMARY KEY,
  `manager_staff_id` tinyint,
  `address_id` smallint,
  `last_update` timestamp
);

CREATE TABLE `staff` (
  `staff_id` tinyint PRIMARY KEY,
  `person_id` smallint,
  `picture` blob,
  `username` varchar(16),
  `password` varchar(40),
  `last_update` timestamp
);

CREATE TABLE `customer` (
  `customer_id` smallint PRIMARY KEY,
  `person_id` smallint,
  `create_date` datetime,
  `last_update` timestamp
);

CREATE TABLE `person` (
  `person_id` smallint PRIMARY KEY,
  `store_id` tinyint,
  `address_id` smallint,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `email` varchar(50),
  `active` boolean,
  `last_update` timestamp
);

CREATE TABLE `address` (
  `address_id` smallint PRIMARY KEY,
  `address` varchar(50),
  `address2` varchar(50),
  `district` varchar(20),
  `city_id` smallint,
  `postal_code` varchar(10),
  `phone` varchar(20),
  `last_update` timestamp
);

CREATE TABLE `city` (
  `city_id` smallint PRIMARY KEY,
  `country_id` smallint,
  `city` varchar(50),
  `last_update` timestamp
);

CREATE TABLE `country` (
  `country_id` smallint PRIMARY KEY,
  `country` varchar(50),
  `last_update` timestamp
);

ALTER TABLE `film_language` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `film_language` ADD FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`);

ALTER TABLE `film_language` ADD FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`);

ALTER TABLE `film_category` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `film_category` ADD FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

ALTER TABLE `film_actor` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `film_actor` ADD FOREIGN KEY (`actor_id`) REFERENCES `actor` (`actor_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `inventory` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `inventory` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

ALTER TABLE `store` ADD FOREIGN KEY (`manager_staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

ALTER TABLE `staff` ADD FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`);

ALTER TABLE `customer` ADD FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`);

ALTER TABLE `store` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

ALTER TABLE `person` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

ALTER TABLE `address` ADD FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

ALTER TABLE `city` ADD FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`);
