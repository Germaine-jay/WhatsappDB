-- Create Database
CREATE DATABASE WhatsappDB;
--	Use the database
USE WhatsAppDB;

-- Create End user table for one to many relationship between User and contacts 
CREATE TABLE End_user (
	UserId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	UserName VARCHAR(MAX) NOT NULL,
	User_mobile VARCHAR(50) NOT NULL UNIQUE,
	User_Bio VARCHAR(MAX) NULL,
)

CREATE TABLE Chats(
	ChatId INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	CreatedDate DATETIME NOT NULL,
	ChatTitle VARCHAR(50)NOT NULL,
)

-- Create End user chat table for many to many relationship between Users and chats
CREATE TABLE End_user_chat(
	ChatId INT NOT NULL,
	UserId INT NOT NULL,
	PRIMARY KEY(ChatId,UserId),
	FOREIGN KEY (ChatId) REFERENCES Chats(ChatId),
	FOREIGN KEY (UserId) REFERENCES End_user(UserId),
)

-- Create the message table
CREATE TABLE Message(	
	MessageId INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ChatId INT NOT NULL,
	UserId INT NOT NULL,
	MessageText VARCHAR(MAX) NOT NULL,
	MessageTime DATETIME NOT NULL,

	FOREIGN KEY (ChatId) REFERENCES Chats(ChatId),
	FOREIGN KEY (UserId) REFERENCES End_user(UserId),
)


--Populate the End_user table
INSERT INTO End_user VALUES('Germaine', '+2348187264726','Oluomachukwu');

-- Populate the End_user table
INSERT INTO End_user VALUES('Esther','+2349043430841','Bless God'),
						('Emmanuel','+2349043330842','Civil Engineer|Tech enthusiast'),
						('Alexander','+2349133345674','Falling higher');

--Populate the message table
INSERT INTO Message VALUES(1,1,'Hello Good morning. How are you', GETDATE()),
						(1,2,'Good Day. Check your mail to get new info', GETDATE()),
						(2,3,'Guy how far, you dn complete your task. send me link make I see', GETDATE());
INSERT INTO Message VALUES(2,1,'Hello Everyone, we are to meet by 11am. class will start with code review', GETDATE());

--Populate chats table
INSERT INTO Chats VALUES(GETDATE(),'Bezao cohot 3'),(GETDATE(),'My family'),(GETDATE(),'my padiz');
INSERT INTO Chats VALUES(GETDATE(),'my padiz'), (GETDATE(),'CVE class');

--Populate the chats table
INSERT INTO End_user_chat VALUES(1,1),(2,1),(3,2),(2,2),(3,1);

--Quarey the end_user table
SELECT * FROM End_user;

--Query the message table
SELECT * FROM Message;

--Query the End user chat table
SELECT * FROM End_user_chat;

SELECT name.UserName, message.MessageId, message.MessageText, message.MessageTime
FROM Message message JOIN End_user name ON message.UserId = name.UserId
WHERE message.ChatId = 1;


SELECT Eu.UserName 
FROM End_user_chat Euc JOIN End_user Eu ON Euc.UserId = Eu.UserId
WHERE Euc.ChatId = 1;
