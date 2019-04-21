DROP TABLE IF EXISTS BQ_RFM_usersLog;

CREATE TABLE BQ_RFM_usersLog (
   userId INT,
	rScore INT,
	fScore INT,
	mScore INT,	
	modified DATE,
   FOREIGN KEY (userId) REFERENCES users(id)
);


INSERT INTO BQ_RFM_usersLog (userId, rScore, fScore, mScore, modified)
SELECT
	BQ_RFM.userId,
	BQ_RFM.rScore,
	BQ_RFM.fScore,
	BQ_RFM.mScore,
	"2019-02-01"
FROM
	BQ_RFM;


SELECT * FROM BQ_RFM_usersLog;