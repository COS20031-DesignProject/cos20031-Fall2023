-- 02 transactions
-- test.db

DROP TABLE IF EXISTS widgetInventory;
CREATE TABLE widgetInventory (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  description TEXT,
  onhand INTEGER NOT NULL
);

DROP TABLE IF EXISTS widgetSales;
CREATE TABLE widgetSales (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  inv_id INTEGER,
  quan INTEGER,
  price INTEGER
);

INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'rock', 25 );
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'paper', 25 );
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'scissors', 25 );

SELECT * FROM widgetInventory;
SELECT * FROM widgetSales;

START TRANSACTION;
  INSERT INTO widgetSales ( inv_id, quan, price ) VALUES ( 1, 5, 500 );
  UPDATE widgetInventory SET onhand = ( onhand - 5 ) WHERE id = 1;
COMMIT;

START TRANSACTION;
INSERT INTO widgetInventory ( description, onhand ) VALUES ( 'toy', 25 );
ROLLBACK;
SELECT * FROM widgetInventory;

-- restore database
DROP TABLE IF EXISTS widgetInventory;
DROP TABLE IF EXISTS widgetSales;

-- 03 performance
-- test.db

CREATE TABLE test ( id INTEGER AUTO_INCREMENT PRIMARY KEY, data TEXT );

-- put this before the 1,000 INSERT statements
START TRANSACTION;

-- copy / paste 1,000 of these ...
INSERT INTO test ( data ) VALUES ( 'this is a good sized line of text.' );

-- put this after the 1,000 INSERT statements
COMMIT;

SELECT COUNT(*) FROM test;

-- restore database
DROP TABLE test;

