CREATE DATABASE FeedMeUp;
​
USE FeedMeUp;
​
CREATE TABLE Users (user_id INT NOT NULL, username VARCHAR(45) NOT NULL UNIQUE, password VARCHAR(45) NOT NULL, PRIMARY KEY (user_id));
​
INSERT INTO Users (user_id, username, password) VALUES (0,'jon_robbins',SHA('Gr3meg%*@xl'));
INSERT INTO Users (user_id, username, password) VALUES (1,'sandy.williams',SHA('ks8(#HD[;:932pwq'));
INSERT INTO Users (user_id, username, password) VALUES (2,'cgarcia',SHA('30-DFbr/?\'@88''));
INSERT INTO Users (user_id, username, password) VALUES (3,'anthony-tran',SHA('CF1083dfmodRK'));
INSERT INTO Users (user_id, username, password) VALUES (4,'rishis',SHA('$*%739JJFnr;;nvspW'));
INSERT INTO Users (user_id, username, password) VALUES (5,'elizabeth.smith',SHA('fuenls49-<~&$VDrp'));
INSERT INTO Users (user_id, username, password) VALUES (6,'kelly_cooper',SHA('>?834HKoerb'));
INSERT INTO Users (user_id, username, password) VALUES (7,'nikki-singh',SHA('EB473*$ghwolm|,.qod$OE'));
INSERT INTO Users (user_id, username, password) VALUES (8,'j_chang',SHA('7ODf39$%_NVsw/'));
INSERT INTO Users (user_id, username, password) VALUES (9,'maria.mendoza',SHA('MS$%2*$0(dhF38'));
INSERT INTO Users (user_id, username, password) VALUES (10,'jamesanderson',SHA('f8u#84(BVtuqzoRG7729'));
INSERT INTO Users (user_id, username, password) VALUES (11,'paula.c',SHA('AQpf39-+{:Dje21102'));
INSERT INTO Users (user_id, username, password) VALUES (12,'darryl_thompson',SHA('20_DFowrnc.#)='));
INSERT INTO Users (user_id, username, password) VALUES (13,'k_jones',SHA('[$@\\QCiegFtL33492SS89_XLPda'));
INSERT INTO Users (user_id, username, password) VALUES (14,'ariel.zhang',SHA('FT8ei$(j49oWrri:-|!!'));
INSERT INTO Users (user_id, username, password) VALUES (15,'rahul-patel',SHA('fDDoE48$%{\"fpeoCVEK'));
INSERT INTO Users (user_id, username, password) VALUES (16,'s.evans',SHA('burFKS38$$ruud#?'));
INSERT INTO Users (user_id, username, password) VALUES (17,'alexa_johnson',SHA('%3*$40dnvuwlMCjEoLx'));
INSERT INTO Users (user_id, username, password) VALUES (18,'maddy.cruz',SHA('C7#44@hRTunZO09'));
INSERT INTO Users (user_id, username, password) VALUES (19,'m-wang',SHA('~HrSPxb48#7$->=62seB'));
​
CREATE TABLE Admins (user_id INT NOT NULL, verify_status VARCHAR(5) NOT NULL, PRIMARY KEY (user_id));
​
INSERT INTO Admins (user_id, verify_status) VALUES (10,'true');
INSERT INTO Admins (user_id, verify_status) VALUES (11,'false');
INSERT INTO Admins (user_id, verify_status) VALUES (12,'false');
INSERT INTO Admins (user_id, verify_status) VALUES (13,'true');
INSERT INTO Admins (user_id, verify_status) VALUES (14,'false');
INSERT INTO Admins (user_id, verify_status) VALUES (15,'true');
INSERT INTO Admins (user_id, verify_status) VALUES (16,'true');
INSERT INTO Admins (user_id, verify_status) VALUES (17,'true');
INSERT INTO Admins (user_id, verify_status) VALUES (18,'false');
INSERT INTO Admins (user_id, verify_status) VALUES (19,'true');
​
CREATE TABLE General_Users (user_id INT NOT NULL, creation_date DATE NOT NULL, checked_by INT, PRIMARY KEY (user_id), FOREIGN KEY (checked_by) REFERENCES Admins(user_id) ON UPDATE CASCADE ON DELETE CASCADE);
​
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (0,'2022-11-02',10);
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (1,'2022-11-02',NULL);
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (2,'2022-11-02',12);
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (3,'2022-11-02',NULL);
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (4,'2022-11-02',14);
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (5,'2022-11-02',15);
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (6,'2022-11-02',16);
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (7,'2022-11-02',NULL);
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (8,'2022-11-02',18);
INSERT INTO General_Users (user_id, creation_date, checked_by) VALUES (9,'2022-11-02',19);
​
CREATE TABLE Categories (category_id INT NOT NULL, category_name VARCHAR(15) NOT NULL UNIQUE, admin_id INT NOT NULL, PRIMARY KEY (category_id), FOREIGN KEY (admin_id) REFERENCES Admins(user_id) ON UPDATE CASCADE ON DELETE CASCADE);
​
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (0, 'Vegetarian', 19);
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (1, 'Vegan', 18);
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (2, 'Meat', 10);
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (3, 'Dessert', 11);
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (4, 'Sauces', 13);
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (5, 'Soup', 14);
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (6, 'Drink', 18);
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (7, 'Snack', 15);
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (8, 'Seafood', 18);
INSERT INTO Categories (category_id, category_name, admin_id) VALUES (9, 'Bread', 17);
​
CREATE TABLE Recipes (recipe_id INT NOT NULL, recipe_name VARCHAR(45) NOT NULL, cuisine VARCHAR(45) NOT NULL, ingredients VARCHAR(100) NOT NULL, cost INT NOT NULL, time INT NOT NULL, steps VARCHAR(200) NOT NULL, PRIMARY KEY (recipe_id));
​
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (1, 'Pasta', 'Italian', 'flour, water, salt', 5, 30, '1.combine flour, water and salt');
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (2, 'Enchiladas', 'Mexican', 'tortillas, beans, cheese', 10, 45, '1.preheat the oven 350F 2.place tortillas on sheet and top with beans');
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (3, 'Beef Patties', 'American', 'beef, bread crumbs, salt', 15, 60, '1.preheat the oven 350F 2. mix together beef and bread crumbs');
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (4, 'Stir-fry Chicken', 'Chinese', 'rice, chicken, soy sauce', 20, 30, '1.cook rice according to package instructions 2. stir fry chicken');
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (5, 'Pad Thai', 'Thai', 'coconut milk, green curry, bamboo', 25, 45, '1.in pot, simmer coconut mulk and green curry paste');
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (6, 'Sushi', 'Japanese', 'sushi rice, nori, salmon', 30, 60, '1.cook sushi rice 2. place sheet of nori on bamboo mat');
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (7, 'Chicken Tikka Masala', 'Indian', 'chicken, yogurt, spices', 35, 75, '1.in pot, simmer chicken in yogurt and spices');
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (8, 'Baguette', 'French', 'flour, butter, milk', 40, 90, '1.in pot, make a roux by whisking butter and flour');
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (9, 'Spaghetti', 'Italian', 'tomatoes, garlic, basil, pasta', 45, 120, '1.in pot, simmer tomatoes, garlic, and basil');
INSERT INTO Recipes (recipe_id, recipe_name, cuisine, ingredients, cost, time, steps) VALUES (10, 'Pie', 'American', 'pie crust, sugar, cornstarch', 50, 150, '1.preheat oven to 375F 2. in bowl mix together sugar, cornstarch, cinnamon');
​
CREATE TABLE Videos (video_id INT NOT NULL, user_id INT NOT NULL, recipe_id INT NOT NULL, category_id INT NOT NULL, monitored_by INT, title VARCHAR(100) NOT NULL, file_path VARCHAR(100) NOT NULL, duration VARCHAR(5) NOT NULL, views INT NOT NULL, video_resolution VARCHAR(5) NOT NULL, language CHAR(2) NOT NULL, PRIMARY KEY (video_id), FOREIGN KEY(user_id) REFERENCES General_Users(user_id) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY(recipe_id) REFERENCES Recipes(recipe_id) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY(category_id) REFERENCES Categories(category_id) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY(monitored_by) REFERENCES Admins(user_id) ON UPDATE CASCADE ON DELETE CASCADE);
​
INSERT INTO Videos VALUES (1, 1, 2, 7, 15, '7 Recipes You Can Make in 5 Minutes', '/feedMeUpDB/assets/videos/video1.mp4', '1:10', 1233, '1080p', 'EN');
INSERT INTO Videos VALUES (10, 3, 7, 2, NULL, '''Sweetest'' Lemon Chicken out there', '/feedMeUpDB/assets/videos/video2.mp4', '1:11', 7654, '720p', 'EN');
INSERT INTO Videos VALUES (2, 5, 3, 2, 11, 'How to Make the PERFECT STEAK #shorts', '/feedMeUpDB/assets/videos/video3.mp4', '1:15', 1435265, '1080p', 'EN');
INSERT INTO Videos VALUES (3, 7, 9, 0, 15, 'Ratatouille #shorts', '/feedMeUpDB/assets/videos/video4.mp4', '1:15', 5325265, '1080p', 'EN');
INSERT INTO Videos VALUES (4, 4, 10, 9, 13, 'SANDWICH WITH MEATBALLS #shorts #asmr', '/feedMeUpDB/assets/videos/video5.mp4', '1:20', 943123, '720p', 'EN');
INSERT INTO Videos VALUES (5, 8, 5, 2, 11, 'Chicken pad Thai #shorts', '/feedMeUpDB/assets/videos/video6.mp4', '0:45', 1231543, '1080p', 'TR');
INSERT INTO Videos VALUES (6, 3, 4, 2, NULL, 'Duck Bao', '/feedMeUpDB/assets/videos/video7.mp4', '1:15', 1243256, '1080p', 'EN');
INSERT INTO Videos VALUES (7, 1, 6, 8, 15, 'Sushi #shorts', '/feedMeUpDB/assets/videos/video8.mp4', '1:45', 634501, '1080p', 'EN');
INSERT INTO Videos VALUES (8, 6, 8, 5, 19, 'Vietnamese pho #shorts', '/feedMeUpDB/assets/videos/video9.mp4', '1:15', 5325265, '1080p', 'VN');
INSERT INTO Videos VALUES (9, 9, 1, 5, 13, 'Cooking Basics For Students: Veggie Stock', '/feedMeUpDB/assets/videos/video10.mp4', '1:25', 65474652, '1080p', 'EN');
​
CREATE TABLE rates (user_id INT NOT NULL, video_id INT NOT NULL, score INT NOT NULL, FOREIGN KEY (user_id) REFERENCES General_Users (user_id) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (video_id) REFERENCES Videos(video_id) ON UPDATE CASCADE ON DELETE CASCADE);
​
INSERT INTO rates (user_id, video_id, score) VALUES (0,1,4);
INSERT INTO rates (user_id, video_id, score) VALUES (1,1,2);
INSERT INTO rates (user_id, video_id, score) VALUES (2,2,3);
INSERT INTO rates (user_id, video_id, score) VALUES (3,3,4);
INSERT INTO rates (user_id, video_id, score) VALUES (4,4,5);
INSERT INTO rates (user_id, video_id, score) VALUES (5,5,5);
INSERT INTO rates (user_id, video_id, score) VALUES (6,6,1);
INSERT INTO rates (user_id, video_id, score) VALUES (7,7,3);
INSERT INTO rates (user_id, video_id, score) VALUES (8,8,5);
INSERT INTO rates (user_id, video_id, score) VALUES (9,9,2);
​
CREATE TABLE prefers (user_id INT NOT NULL, category_id INT NOT NULL, FOREIGN KEY (user_id) REFERENCES General_Users (user_id) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON UPDATE CASCADE ON DELETE CASCADE);
​
INSERT INTO prefers (user_id, category_id) VALUES (0, 0);
INSERT INTO prefers (user_id, category_id) VALUES (0, 1);
INSERT INTO prefers (user_id, category_id) VALUES (0, 4);
INSERT INTO prefers (user_id, category_id) VALUES (3, 3);
INSERT INTO prefers (user_id, category_id) VALUES (3, 9);
INSERT INTO prefers (user_id, category_id) VALUES (5, 3);
INSERT INTO prefers (user_id, category_id) VALUES (5, 7);
INSERT INTO prefers (user_id, category_id) VALUES (8, 4);
INSERT INTO prefers (user_id, category_id) VALUES (8, 3);
INSERT INTO prefers (user_id, category_id) VALUES (8, 6);
​
CREATE TABLE save (user_id INT NOT NULL, video_id INT NOT NULL, FOREIGN KEY (user_id) REFERENCES General_Users (user_id) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (video_id) REFERENCES Videos(video_id) ON UPDATE CASCADE ON DELETE CASCADE);
​
INSERT INTO save (user_id, video_id) VALUES (1, 1);
INSERT INTO save (user_id, video_id) VALUES (1, 9);
INSERT INTO save (user_id, video_id) VALUES (1, 6);
INSERT INTO save (user_id, video_id) VALUES (4, 8);
INSERT INTO save (user_id, video_id) VALUES (4, 3);
INSERT INTO save (user_id, video_id) VALUES (4, 5);
INSERT INTO save (user_id, video_id) VALUES (9, 4);
INSERT INTO save (user_id, video_id) VALUES (9, 8);
INSERT INTO save (user_id, video_id) VALUES (7, 3);
INSERT INTO save (user_id, video_id) VALUES (7, 6);
​
CREATE TABLE report (reporter_user_id INT NOT NULL, reported_user_id INT NOT NULL, FOREIGN KEY (reporter_user_id) REFERENCES General_Users (user_id) ON UPDATE CASCADE ON DELETE CASCADE, FOREIGN KEY (reported_user_id) REFERENCES General_Users (user_id) ON UPDATE CASCADE ON DELETE CASCADE);
​
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (3, 2);
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (3, 9);
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (5, 9);
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (4, 1);
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (6, 2);
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (7, 1);
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (6, 1);
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (8, 1);
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (4, 2);
INSERT INTO report (reporter_user_id, reported_user_id) VALUES (5, 2);