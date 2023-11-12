-- 00 Exercise files

SELECT 'Hello, World';

USE scratch;
SHOW TABLES;

-- 02 Creating an index

USE scratch;
DROP TABLE IF EXISTS test;
CREATE TABLE test (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    string1 VARCHAR(128),
    string2 VARCHAR(128)
);

SHOW INDEX FROM test;

-- version 2.0: index on non-key column
DROP TABLE IF EXISTS test;
CREATE TABLE test (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    string1 VARCHAR(128),
    string2 VARCHAR(128),
    INDEX str1(string1)
);
SHOW INDEX FROM test;

CREATE INDEX str2 ON test(string2);
SHOW INDEX FROM test;

DROP TABLE IF EXISTS test;

-- 02(b): unique indexes
DROP TABLE IF EXISTS test;
CREATE TABLE test (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    string1 VARCHAR(128),
    string2 VARCHAR(128),
    UNIQUE INDEX str1(string1)
);

CREATE UNIQUE INDEX str2 ON test(string2);

SHOW INDEX FROM test;

-- 03 Showing indexes

USE scratch;
SHOW INDEX FROM customer;

SELECT DISTINCT table_name, index_name 
    FROM information_schema.statistics 
    WHERE table_schema = 'scratch';

-- 04 Dropping indexes

USE scratch;

DROP INDEX str1 ON test;

DESCRIBE customer;
SHOW INDEX FROM customer;
CREATE INDEX custzip ON customer(zip);
SHOW INDEX FROM customer;
DROP INDEX custzip ON customer;
SHOW INDEX FROM customer;

-- 05 multi-column indexes

USE scratch;
DROP TABLE IF EXISTS test;
CREATE TABLE test (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    string1 VARCHAR(128),
    string2 VARCHAR(128),
    INDEX twostrs (string1,string2)
);
INSERT INTO test (string1, string2) VALUES ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha');
SELECT string1, string2 FROM test ORDER BY string1, string2;

SHOW INDEX FROM test;

SELECT string1, string2 FROM test ORDER BY string1, string2;
EXPLAIN SELECT string1, string2 FROM test ORDER BY string1, string2;
DROP TABLE test;

-- 06 experiment about index on query performance
USE scratch;
DROP TABLE IF EXISTS test;
CREATE TABLE test (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    string1 VARCHAR(128),
    string2 VARCHAR(128),
    INDEX twostrs (string1,string2)
);
INSERT INTO test (string1, string2) 
  VALUES ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha'),
  ('foo', 'bar'), ('this', 'that'), ('another', 'row'), ('foo', 'alpha')
  ;
-- Using INDEX: record the query time  (0.0008 seconds)
SELECT string1, string2 
FROM test 
ORDER BY string1, string2;

-- NOT Using INDEX: record the query time (0.0018 seconds)
DROP INDEX twostrs ON test;
SELECT string1, string2 FROM test ORDER BY string1, string2;
