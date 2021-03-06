-- create users table with id, email and password
CREATE TABLE `live`.`users` ( `user_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT , `email` VARCHAR(255) NOT NULL , `password` VARCHAR(255) NOT NULL, UNIQUE (`email`)) ENGINE = INNODB;

-- create test user
INSERT INTO `users` (`user_id`, `email`, `password`) VALUES (NULL, 'johndoe@gmail.com', SHA1('123456'));

-- create users_data table
CREATE TABLE `live`.`users_data` ( `user_id` INT NOT NULL, `first_name` VARCHAR(50) NOT NULL , `last_name` VARCHAR(50) NOT NULL , `age` INT(100) NOT NULL , `country` VARCHAR(255) NOT NULL , `state` VARCHAR(255) NOT NULL , `street_address` VARCHAR(255) NOT NULL , `phone_number` VARCHAR(50) NOT NULL , `avatar` LONGBLOB NULL, `newsletter` BOOLEAN NOT NULL , FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create test user data
INSERT INTO `users_data` (`user_id`, `first_name`, `last_name`, `age`, `country`, `state`, `street_address`, `phone_number`, `avatar`, `newsletter`) VALUES ('1', 'john', 'doe', '22', 'Norway', 'More And Romsdal', 'Imaginary Street 123', '12345678', NULL, '1');

-- create users_auth table
CREATE TABLE `live`.`users_auth` ( `user_id` INT NOT NULL, `token` VARCHAR(128) NULL , `issued_at` BIGINT NULL , UNIQUE (`token`), FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create test users_auth data
INSERT INTO `users_auth` (`user_id`, `token`, `issued_at`) VALUES ('1', 'd81e0f58d1ea232c48ac237d885d79c9a2876397dfb5fc61b90949d86de5a4a8c07656563131061e73aa44874016d9c25a1ec55e5ff740baa7cf06b67b68592b', '1542679935801');

-- create forgot password table
CREATE TABLE `live`.`forgot_password` ( `user_id` INT NOT NULL , `reset_url` VARCHAR(128) NULL , PRIMARY KEY (`user_id`), UNIQUE (`reset_url`), FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create test forgot password data
INSERT INTO `forgot_password`(`user_id`, `reset_url`) VALUES (1,'d81e0f58d1ea232c48ac237d885d79c9a2876397dfb5fc61b90949d86de5a4a8c07656563131061e73aa44874016d9c25a1ec55e5ff740baa7cf06b67b68592b');

-- create helpers table
CREATE TABLE `live`.`helpers` ( `user_id` INT NOT NULL , `child_care` BOOLEAN NULL, `elder_care` BOOLEAN NULL, `animal_care` BOOLEAN NULL, `start_date` DATE NOT NULL, `end_date` DATE NOT NULL, `description` VARCHAR(200), `price` VARCHAR(10) NOT NULL, `latitude` DECIMAL(10, 8) NULL, `longitude` DECIMAL(11, 8) NULL, PRIMARY KEY (`user_id`), FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create helper statistic table
CREATE TABLE `live`.`help_offer_statistics` (`help_id` int(11) UNIQUE NOT NULL, `last_viewed` date NULL, `total_views` int(11) NULL, FOREIGN KEY (help_id) REFERENCES helpers (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create test offer data
INSERT INTO `helpers` (`user_id`, `child_care`, `elder_care`, `animal_care`, `start_date`, `end_date`, `description`, `price`, `latitude`, `longitude`) VALUES (2, 1, 1, 1, '2018-12-02', '2018-12-10', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere quam sed interdum vehicula. Pellentesque vel ligula ac risus tristique auctor.', 25, 36.65739,-121.79510);

-- create helper requests table
CREATE TABLE `live`.`helper_requests` (`help_id` int(11) NOT NULL, `user_requested` INT(11) NOT NULL, `message` VARCHAR(2000) NOT NULL, `child_care` BOOLEAN NULL, `elder_care` BOOLEAN NULL, `animal_care` BOOLEAN NULL, `date_requested` DATE NOT NULL, `accepted` TINYINT(1) NULL, `karma` INT NULL, FOREIGN KEY (help_id) REFERENCES helpers (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- only tables

-- create users table with id, email and password
CREATE TABLE `live`.`users` ( `user_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT , `email` VARCHAR(255) NOT NULL , `password` VARCHAR(255) NOT NULL, UNIQUE (`email`)) ENGINE = INNODB;

-- create users_data table
CREATE TABLE `live`.`users_data` ( `user_id` INT NOT NULL, `first_name` VARCHAR(50) NOT NULL , `last_name` VARCHAR(50) NOT NULL , `age` INT(100) NOT NULL , `country` VARCHAR(255) NOT NULL , `state` VARCHAR(255) NOT NULL , `street_address` VARCHAR(255) NOT NULL , `phone_number` VARCHAR(50) NOT NULL , `avatar` LONGBLOB NULL, `newsletter` BOOLEAN NOT NULL , FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create users_auth table
CREATE TABLE `live`.`users_auth` ( `user_id` INT NOT NULL, `token` VARCHAR(128) NULL , `issued_at` BIGINT NULL , UNIQUE (`token`), FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create forgot password table
CREATE TABLE `live`.`forgot_password` ( `user_id` INT NOT NULL , `reset_url` VARCHAR(128) NULL , PRIMARY KEY (`user_id`), UNIQUE (`reset_url`), FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create helpers table
CREATE TABLE `live`.`helpers` ( `user_id` INT NOT NULL , `child_care` BOOLEAN NULL, `elder_care` BOOLEAN NULL, `animal_care` BOOLEAN NULL, `start_date` DATE NOT NULL, `end_date` DATE NOT NULL, `description` VARCHAR(200), `price` VARCHAR(10) NOT NULL, `latitude` DECIMAL(10, 8) NULL, `longitude` DECIMAL(11, 8) NULL, PRIMARY KEY (`user_id`), FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create helper statistic table
CREATE TABLE `live`.`help_offer_statistics` (`help_id` int(11) UNIQUE NOT NULL, `last_viewed` date NULL, `total_views` int(11) NULL, FOREIGN KEY (help_id) REFERENCES helpers (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create helper requests table
CREATE TABLE `live`.`helper_requests` (`help_id` int(11) NOT NULL, `user_requested` INT(11) NOT NULL, `message` VARCHAR(2000) NOT NULL, `child_care` BOOLEAN NULL, `elder_care` BOOLEAN NULL, `animal_care` BOOLEAN NULL, `date_requested` DATE NOT NULL, `accepted` TINYINT(1) NULL, `karma` INT NULL, FOREIGN KEY (help_id) REFERENCES helpers (user_id) ON DELETE CASCADE ON UPDATE CASCADE) ENGINE = INNODB;

-- create 1000 test users
delimiter //

CREATE PROCEDURE insertNewUsers()
BEGIN
    DECLARE i int DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO `users` (`user_id`, `email`, `password`) VALUES (NULL, CONCAT('johndoe', i, '@gmail.com'), SHA1('123456'));
        SET i = i + 1;
    END WHILE;
END//

delimiter ;

CALL insertNewUsers();


delimiter //

CREATE PROCEDURE UDxxxx()
BEGIN
    DECLARE i int DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO `users_data` (`user_id`, `first_name`, `last_name`, `age`, `country`, `state`, `street_address`, `phone_number`, `avatar`, `newsletter`) VALUES (i, 'john', CONCAT('doe', i), '22', 'Norway', 'More And Romsdal', 'Imaginary Street 123', '12345678', NULL, '1');
        SET i = i + 1;
    END WHILE;
END//

delimiter ;

CALL UDxxxx();

delimiter //

CREATE PROCEDURE iiiiHxxx()
BEGIN
    DECLARE i int DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO `helpers` (`user_id`, `child_care`, `elder_care`, `animal_care`, `start_date`, `end_date`, `description`, `price`, `latitude`, `longitude`) VALUES (i, FLOOR((RAND() * (1-0+1))+0), FLOOR((RAND() * (1-0+1))+0), FLOOR((RAND() * (1-0+1))+0), '2018-12-02', '2018-12-28', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere quam sed interdum vehicula. Pellentesque vel ligula ac risus tristique auctor.', (CAST(RAND() * 1000 AS UNSIGNED) + 1), (RAND() * (38.677286 - 34.669355)) + 34.669355, (RAND() * (-123.785095 - -119.895508)) + -119.895508);
        SET i = i + 1;
    END WHILE;
END//

delimiter ;

CALL iiiiHxxx();

delimiter //

CREATE PROCEDURE iiSxx()
BEGIN
    DECLARE i int DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO `help_offer_statistics`(`help_id`, `last_viewed`, `total_views`) VALUES (i, null ,(CAST(RAND() * 1000 AS UNSIGNED) + 1));
        SET i = i + 1;
    END WHILE;
END//

delimiter ;

CALL iiSxx();