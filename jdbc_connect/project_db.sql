CREATE DATABASE FeedMeUp;
CREATE TABLE FeedMeUp.Users (user_id INT NOT NULL, username VARCHAR(25), passw VARCHAR(40));
INSERT INTO FeedMeUp.Users VALUES(1, 'user1', SHA('1sksfi32asdf'));
INSERT INTO FeedMeUp.Users VALUES(2, 'user2', SHA('saf03r7jknsw'));
INSERT INTO FeedMeUp.Users VALUES(3, 'user3', SHA('jk9sra2641sm'));
SELECT * FROM FeedMeUp.Users;