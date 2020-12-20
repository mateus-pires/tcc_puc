--create database

create database tcc

-- create user

CREATE USER 'tcc'@'%' IDENTIFIED BY 'tccdw!@20';

GRANT ALL PRIVILEGES ON tcc.* TO 'tcc'@'%';

-- Create table

CREATE TABLE `etl_trans_log_tcc` (
  `ID_BATCH` int(11) NOT NULL AUTO_INCREMENT,
  `CHANNEL_ID` varchar(255) DEFAULT NULL,
  `TRANSNAME` varchar(255) DEFAULT NULL,
  `STATUS` varchar(15) DEFAULT NULL,
  `LINES_READ` bigint(20) DEFAULT NULL,
  `LINES_WRITTEN` bigint(20) DEFAULT NULL,
  `LINES_UPDATED` bigint(20) DEFAULT NULL,
  `LINES_INPUT` bigint(20) DEFAULT NULL,
  `LINES_OUTPUT` bigint(20) DEFAULT NULL,
  `LINES_REJECTED` bigint(20) DEFAULT NULL,
  `ERRORS` bigint(20) DEFAULT NULL,
  `STARTDATE` datetime DEFAULT NULL,
  `ENDDATE` datetime DEFAULT NULL,
  `LOGDATE` datetime DEFAULT NULL,
  `DEPDATE` datetime DEFAULT NULL,
  `REPLAYDATE` datetime DEFAULT NULL,
  `LOG_FIELD` mediumtext,
  KEY `IDX_etl_trans_log_cach_1` (`ID_BATCH`),
  KEY `IDX_etl_trans_log_cach_2` (`ERRORS`,`STATUS`,`TRANSNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE INDEX IDX_etl_trans_log_tcc_1 ON etl_trans_log_tcc(ID_BATCH)
;
CREATE INDEX IDX_etl_trans_log_tcc_2 ON etl_trans_log_tcc(ERRORS, STATUS, TRANSNAME)
;
