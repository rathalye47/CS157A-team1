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
