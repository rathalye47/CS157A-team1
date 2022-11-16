CREATE DATABASE FeedMeUp;

CREATE TABLE FeedMeUp.Users (user_id INT NOT NULL, username VARCHAR(45) NOT NULL UNIQUE, password VARCHAR(45) NOT NULL, PRIMARY KEY (user_id));

INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (0,'jon_robbins',SHA('Gr3meg%*@xl'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (1,'sandy.williams',SHA('ks8(#HD[;:932pwq'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (2,'cgarcia',SHA('30-DFbr/?\'@88'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (3,'anthony-tran',SHA('CF1083dfmodRK'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (4,'rishis',SHA('$*%739JJFnr;;nvspW'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (5,'elizabeth.smith',SHA('fuenls49-<~&$VDrp'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (6,'kelly_cooper',SHA('>?834HKoerb'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (7,'nikki-singh',SHA('EB473*$ghwolm|,.qod$OE'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (8,'j_chang',SHA('7ODf39$%_NVsw/'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (9,'maria.mendoza',SHA('MS$%2*$0(dhF38'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (10,'jamesanderson',SHA('f8u#84(BVtuqzoRG7729'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (11,'paula.c',SHA('AQpf39-+{:Dje21102'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (12,'darryl_thompson',SHA('20_DFowrnc.#)='));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (13,'k_jones',SHA('[$@\\QCiegFtL33492SS89_XLPda'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (14,'ariel.zhang',SHA('FT8ei$(j49oWrri:-|!!'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (15,'rahul-patel',SHA('fDDoE48$%{\"fpeoCVEK'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (16,'s.evans',SHA('burFKS38$$ruud#?'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (17,'alexa_johnson',SHA('%3*$40dnvuwlMCjEoLx'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (18,'maddy.cruz',SHA('C7#44@hRTunZO09'));
INSERT INTO FeedMeUp.Users (user_id, username, password) VALUES (19,'m-wang',SHA('~HrSPxb48#7$->=62seB'));

CREATE TABLE FeedMeUp.General_Users (user_id INT NOT NULL, creation_date DATE NOT NULL, checked_by INT, PRIMARY KEY (user_id));

INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (0,'2022-11-02',10);
INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (1,'2022-11-02',11);
INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (2,'2022-11-02',12);
INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (3,'2022-11-02',13);
INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (4,'2022-11-02',14);
INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (5,'2022-11-02',15);
INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (6,'2022-11-02',16);
INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (7,'2022-11-02',17);
INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (8,'2022-11-02',18);
INSERT INTO FeedMeUp.General_Users (user_id, creation_date, checked_by) VALUES (9,'2022-11-02',19);

CREATE TABLE FeedMeUp.Admins (user_id INT NOT NULL, verify_status VARCHAR(5) NOT NULL, PRIMARY KEY (user_id));

INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (10,'true');
INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (11,'false');
INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (12,'false');
INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (13,'true');
INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (14,'false');
INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (15,'true');
INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (16,'true');
INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (17,'true');
INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (18,'false');
INSERT INTO FeedMeUp.Admins (user_id, verify_status) VALUES (19,'true');

CREATE TABLE FeedMeUp.rates (user_id INT NOT NULL, video_id INT NOT NULL, score INT NOT NULL, PRIMARY KEY (user_id, video_id));

INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (0,0,4);
INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (1,1,2);
INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (2,2,3);
INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (3,3,4);
INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (4,4,5);
INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (5,5,5);
INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (6,6,1);
INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (7,7,3);
INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (8,8,5);
INSERT INTO FeedMeUp.rates (user_id, video_id, score) VALUES (9,9,2);

CREATE TABLE FeedMeUp.Categories (category_id INT NOT NULL, category_name VARCHAR(15) NOT NULL UNIQUE, admin_id INT NOT NULL, PRIMARY KEY (category_id));

INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (0, 'Vegetarian', 19);
INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (1, 'Vegan', 18);
INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (2, 'Meat', 10);
INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (3, 'Dessert', 11);
INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (4, 'Sauces', 13);
INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (5, 'Soup', 14);
INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (6, 'Drink', 18);
INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (7, 'Snack', 15);
INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (8, 'Seafood', 18);
INSERT INTO FeedMeUp.Categories (category_id, category_name, admin_id) VALUES (9, 'Bread', 17);

CREATE TABLE FeedMeUp.prefers (user_id INT NOT NULL, category_id INT NOT NULL, PRIMARY KEY (user_id, category_id));

INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (0, 0);
INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (0, 1);
INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (0, 4);
INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (3, 3);
INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (3, 9);
INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (5, 3);
INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (5, 7);
INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (8, 4);
INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (8, 3);
INSERT INTO FeedMeUp.prefers (user_id, category_id) VALUES (8, 6);

CREATE TABLE FeedMeUp.save (user_id INT NOT NULL, video_id INT NOT NULL, PRIMARY KEY (user_id, video_id));

INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (1, 1);
INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (1, 9);
INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (1, 6);
INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (4, 8);
INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (4, 3);
INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (4, 5);
INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (9, 4);
INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (9, 8);
INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (7, 3);
INSERT INTO FeedMeUp.save (user_id, video_id) VALUES (7, 6);

CREATE TABLE FeedMeUp.report (reporter_user_id INT NOT NULL, reported_user_id INT NOT NULL, PRIMARY KEY (reporter_user_id, reported_user_id));

INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (3, 2);
INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (3, 9);
INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (5, 9);
INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (4, 1);
INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (6, 2);
INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (7, 1);
INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (6, 1);
INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (8, 1);
INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (4, 2);
INSERT INTO FeedMeUp.report (reporter_user_id, reported_user_id) VALUES (5, 2);

