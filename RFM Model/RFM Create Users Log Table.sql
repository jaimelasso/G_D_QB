DROP TABLE IF EXISTS BQ_RFM_usersLog;

CREATE TABLE BQ_RFM_usersLog (
   userId INT,
	rScore INT,
	fScore INT,
	mScore INT,	
	modified DATE,
   FOREIGN KEY (userId) REFERENCES users(id)
);