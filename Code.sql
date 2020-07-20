DROP DATABASE supermarket;
CREATE DATABASE supermarket;

\c supermarket

CREATE TABLE customer
(
	cust_id int,
	cust_name varchar(50) NOT NULL,
	phone bigint NOT NULL,
	email varchar(50),
	date_created date,
	date_last_trans date,
	PRIMARY KEY(cust_id),
	CONSTRAINT chk_email check (email like '%@%.___')
);

CREATE TABLE employee
(
	emp_id int,
	emp_name varchar(50) NOT NULL,
	phone bigint NOT NULL,
	salary int NOT NULL,
	date_end date,
	store_id int NOT NULL,
	address varchar(128),
	email varchar(50),
	date_start date NOT NULL,
	PRIMARY KEY(emp_id),
	CONSTRAINT chk_email check(email like '%@%.___')
);

CREATE TABLE dependents
(
	bdate date,
	name varchar(50) NOT NULL,
	email varchar(50),
	date_created date NOT NULL,
	emp_id int,
	relationship varchar(50),
	FOREIGN KEY(emp_id) REFERENCES employee(emp_id)
);

CREATE TABLE store
(
	store_id int,
	address varchar(128),
	mgr_id int NOT NULL,
	PRIMARY KEY(store_id),
	FOREIGN KEY(mgr_id) REFERENCES employee(emp_id)
);

CREATE TABLE checkout
(
	checkout_id int,
	cust_id int NOT NULL,
	store_id int NOT NULL,
	emp_id int NOT NULL,
	date_checkout date NOT NULL,
	total int,
	PRIMARY KEY(checkout_id),
	FOREIGN KEY(cust_id) REFERENCES customer(cust_id),
	FOREIGN KEY(store_id) REFERENCES store(store_id),
	FOREIGN KEY(emp_id) REFERENCES employee(emp_id),
	CONSTRAINT chk_total check(total > 0)
);

CREATE TABLE items
(
	item_id int,
	brand varchar(32) NOT NULL,
	item_name varchar(50) NOT NULL,
	item_cost int NOT NULL,
	item_weight int,
	PRIMARY KEY(item_id)
);

CREATE TABLE inventory
(
	store_id int NOT NULL,
	item_id int NOT NULL,
	quantity int NOT NULL,
	PRIMARY KEY(store_id, item_id),
	FOREIGN KEY(store_id) REFERENCES store(store_id),
	FOREIGN KEY(item_id) REFERENCES items(item_id),
	CONSTRAINT chk_qty check(quantity>0)
);

CREATE TABLE checkout_action
(
	checkout_id int NOT NULL,
	quantity int NOT NULL,
	item_id int NOT NULL,
	PRIMARY KEY (checkout_id, item_id),
	FOREIGN KEY(checkout_id) REFERENCES checkout(checkout_id),
	FOREIGN KEY(item_id) REFERENCES items(item_id),
	CONSTRAINT chk_qty check(quantity>0)
);

INSERT INTO customer(cust_id, cust_name, phone, email, date_created, date_last_trans)
VALUES
	(50, 'Bob Hope', 6615552485, 'bobhope@gmail.com', '2001-1-1', '2001-5-7'),
	(51, 'Renee Hicks', 4589854588, 'Dragonthing@aol.com', '2005-5-5', '2009-4-25'),
	(52, 'Scott Sheer', 4176521425, 'Scotts@hotmail.com', '2011-12-12', '2012-3-4'),
	(53, 'Colleen Mctyre', 9008752320, 'CMcT@ct.com', '2008-8-12', '2009-5-9'),
	(58, 'Bart Simpson', 9886652035, 'bart@gmail.com', '2001-6-6', '2007-8-25'),
	(67, 'Lisa Girl', 6619755896, 'lisa@gmail.com', '1999-4-9', '2000-4-6'),
	(99, 'Jeremy Scott', 4586895847, 'TheBigMan@gmail.com', '2000-1-9', '2001-10-10'),
	(105, 'Master Shake', 5555555555, 'MixMaster@crimefighter.org', '2000-8-25', '2001-8-18'),
	(178, 'Bruce Wayne', 6619872145, 'IamBatman@crimefighter.org', '2000-1-9', '2001-12-5'),
	(179, 'Seymoure Butes', 4789582145, 'SButes@education.edu', '2001-5-20', '2001-8-18'),
	(180, 'Daniel Radcliffe', 476889012, 'harrypotter@gmail.com', '2005-7-8', '2018-11-12'),	
	(182, 'George Raffe', 476889089, 'giraffe@gmail.com', '2005-9-8', '2018-11-12'),
	(190, 'Toby Elliot', 4768895432, 'telliotr@gmail.com', '2005-11-8', '2018-12-12'),
	(185, 'Donald Trump', 543289012, 'trump@gmail.com', '2005-12-8', '2018-12-21'),
	(207, 'Mary Poppins', 543289057, 'poppins@gmail.com', '2005-12-9', '2018-12-27'),
	(260, 'Drew Barrymore', 543283241, 'dmore@gmail.com', '2005-12-10', '2018-12-19'),
	(215, 'Amelia Earheart', 543289999, 'amelia@gmail.com', '2005-12-11', '2018-12-15'),
	(295, 'George Weasley', 543287777, 'weasley@gmail.com', '2005-12-12', '2018-12-13'),
	(301, 'Fred Weasley', 543288888, 'fred@gmail.com', '2005-12-12', '2018-12-30'),
	(302, 'Hermione Granger', 543289989, 'hermione@gmail.com', '2005-12-13', '2018-12-31');
	 

INSERT INTO employee(emp_id, emp_name, phone, salary, date_end, store_id, address, email, date_start)
VALUES
	(1, 'Darrel Philbin', 5489659874, 20, '2011-2-2', 854, '286 Clown St.', 'baldman@gmail.com', '1985-4-5'),
	(2, 'Ricky Tanner',  6988532587, 10000, '1999-6-10', 354, '1587 H St', 'omegaman@gmail.com', '1990-6-8'),
	(3, 'Susan Phillips',  9856984523, 1500, NULL, 696, '695 LMNOP St.', 'streetsmart@gmail.com', '1972-6-9'),
	(4, 'George Scott' , 2586521452, 42000, NULL, 159, '4521 Gold St.', 'gscott@gmail.com', '1999-7-25'),
	(5, 'Erin Abernathy', 5896583541, 30000, NULL, 674, '635 Numero Inn', 'drinkerster@gmail.com', '1998-12-20'),
	(6, 'Ted Smith',  4736593569, 50000, NULL, 369, '12 S st', NULL, '1989-6-8'),
	(7, 'Harry Buts', 2586584763, 12, NULL, 778, '1 wonder st', NULL, '1970-10-20'),
	(8, 'Maynar Teener', 2596573257, 9250, NULL, 989, '24 Nice Inn', 'meme69@gmail.com','2005-6-4'),
	(9, 'Matt Longfellow',  5249868525, 60000, NULL, 247, '6144 Computer Way', 'thisisshirt@gmail.com', '2000-9-21'),
	(10, 'Jerry Garcia', 6521458569, 52000, NULL, 348, '214 q st.', 'govlot@gmail.com', '1990-9-24'),
	(11, 'Lawarnce Tom', 9658745632, 15000, '2011-9-1', 348, '2154 Beech st', NULL, '1989-1-20'),
	(12, 'Dexter Robert', 1111111111, 12.25, NULL, 854, '365 Moon dr', 'dex@gmail.com', '1990-5-6'),
	(13, 'Mark Nick', 2225478512, 8250, NULL, 854, '65412 b St.', 'nick@gmail.com', '1998-2-5'),
	(14, 'Jeremy David',  2356895654, 16000, NULL, 159, '2 Molly Way', NULL, '2000-6-3'),
	(15, 'Luke Ted', 2144544123, 20000, NULL, 778,  'Southland Avy', 'luke@gmail.com', '2004-9-9');

INSERT INTO dependents(bdate, name, email, date_created, emp_id, relationship)
VALUES
	('1965-3-21', 'Darniel Philbin', 'baldman@gmail.com', '1985-4-5', 1, 'brother'),
	('1979-4-26', 'Ryan Tanner', 'omegaman@gmail.com', '1990-6-8', 2, 'father'),
	('1968-7-25', 'Susanna Philips', 'streetsmart@gmail.com', '1972-6-9', 3, 'wife'),
	('1980-5-4', 'Gelly Scott', NULL, '1999-7-25', 4, 'sister'),
	('1980-3-4', 'Eric Abernathy', 'drinkerstre@gmail.com','1998-12-20', 5, 'friend'),
	('1975-2-27', 'Teddy Smith', NULL, '1989-6-8', 6, 'husband'),
	('1950-3-30','Henry Buts', NULL, '1970-10-20', 7, 'friend'),
	('1996-11-18', ' May Teener', 'meme69@gmail.com', '2005-6-4', 8, 'sister'),
	('1973-10-14', 'Matthew Longfellow', 'thisisshirt@gmail.com', '2000-9-21', 9, 'husband'),
	('1981-12-31', 'Jeremy Garcia', 'govlot@gmail.com', '1990-9-24', 10, 'father'),
	('1969-12-13','Larry Tom', NULL, '1989-1-20', 11, 'son'),
	('1968-6-6', 'Dorothy Robert', NULL, '1990-5-6', 12, 'wife'),
	('1973-7-14', 'Manuel Nick', NULL, '1998-2-5', 13, 'son'),
	('1872-7-9', 'David David', NULL, '2000-6-3', 14, 'brother'),
	('1990-5-12', 'Bob Ted', NULL, '2004-9-9', 15, 'husband');

INSERT INTO store(store_id, address, mgr_id)
VALUES
	(854,'22556 Elm St', 13),
	(354,'820 Birch Rd', 2),
	(696,'710 Edison Dr', 3),
	(159,'13636 Fir St', 4),
	(674,'14496 Maple Way', 5),
	(369,'940 Green St', 6),
	(778,'341 Main St', 15),
	(989,'25459 Aspen Blvd', 8),
	(247,'13695 Alder St', 9),
	(348,'650 Beech St', 11);

INSERT INTO checkout (checkout_id, cust_id, store_id, emp_id, date_checkout, total)
VALUES
	(201, 50, 854, 2, '2011-6-10', 65.25),
	(32, 51, 354, 2, '2011-6-9', 115.25),
	(6589, 52, 696, 3, '2010-8-12', 66.52),
	(2147, 99, 159, 4, '2010-6-5', 500.25),
	(210, 179, 854, 5, '2009-11-5', 41.35),
	(2141, 105, 369, 6, '2007-4-5', 64.25),
	(3652, 178, 778, 6, '2011-12-12', 14.25),
	(125, 58, 989, 7, '2005-12-24', 80.85),
	(123, 182, 348, 10, '2018-12-30', 100),
	(124, 180, 348, 11, '2018-12-25', 60),
	(150, 52, 778, 2, '2018-12-26', 100);

INSERT INTO items(item_id, brand, item_name, item_cost, item_weight)
VALUES
	(12, 'Nabisco', 'Cookies', 2.25, 22.4),
	(658,'PhillpMorris','Cigarettes',5.00,89),
	(4587,'Kraft','Cheese',6.00,.11),
	(2365,'Kellogg','Cereal',1.99,18),
	(84854,'Quaker','Oatmeal',2.50,1),
	(3521,'Nabisco','Crackers',4.00,2),
	(355,'HomeBrand','Spagehetti',.99,3),
	(1566,'DelMonte','Canned Fruit',.50,5.2),
	(256,'Hersey','Cookies',3.99,52.8),
	(145,'Kleenex','Tissues',2.99,34);


INSERT INTO inventory(store_id, item_id, quantity)
VALUES
	(854,12,10),
	(854,658,10),
	(854, 4587, 23),
	(854, 2365, 10),
	(354, 3521, 4),
	(354,1566,4),
	(696,12,23),
	(696,658,38),
	(159,355,27),
	(159,1566,31),
	(674,4587,23),
	(674,2365,28),
	(369, 12, 50),
	(989, 658, 3),
	(247, 355, 12),
	(348, 145, 45),
	(348, 256, 17),
	(854, 84854, 10),
	(696, 256,100),
	(354, 256, 50),
	(778, 145, 200);

INSERT INTO checkout_action(checkout_id, quantity, item_id)
VALUES
	(210,2,12),
	(210,2,658),
	(32,2,84854),
	(32,2,3521),
	(6589,2,4587),
	(6589,2,2365),
	(2147,2,4587),
	(201,2,2365),
	(201,2,256),
	(123, 5, 145),
	(124, 2, 256);

CREATE OR REPLACE FUNCTION update()
	RETURNS trigger AS
$BODY$
BEGIN
	UPDATE inventory 
    SET quantity = quantity - new.quantity
	WHERE exists (SELECT * FROM inventory,
					(SELECT item_id, store_id FROM checkout, checkout_action 
					WHERE(new.checkout_id = checkout_action.checkout_id)) as interm 
				WHERE (inventory.item_id = interm.item_id AND inventory.store_id = interm.store_id)
				);
	RETURN NEW;
END;
$BODY$
language plpgsql;

CREATE TRIGGER update_stock
AFTER INSERT
ON checkout_action
FOR EACH ROW
EXECUTE PROCEDURE update();

/*
QUERIES:

	SIMPLE:
		1. Retrieve the nameand phone number of all the customers who made a single transaction >$100.
			SELECT cust_name, phone FROM customer as c, checkout as co WHERE(co.total>100 AND co.cust_id=c.cust_id);

		2. Find the second highest salary amongst the employees.
			SELECT min(sal.salary) FROM 
				(SELECT DISTINCT salary FROM employee ORDER BY salary desc LIMIT 2) AS sal;
		
	COMPLEX:

		1. Retreive the contact details of all the managers who manage a store with 2 or more employees.

			SELECT e.emp_name, e.phone, e.email FROM employee as e,
				(SELECT mgr_id as m_i FROM store as s,
					(SELECT store_id as s_i, COUNT(*) as emp_count FROM employee GROUP BY(store_id))as emp_per_store
				WHERE s.store_id = emp_per_store.s_i AND emp_per_store.emp_count>1 ) as mgr_list
			WHERE e.emp_id = mgr_list.m_i;

		2. Find the stock(quantity) of cookies across all the stores.

			SELECT SUM(quantity) FROM inventory as i 
			INNER JOIN (SELECT * FROM items WHERE item_name = 'Cookies') as cookie 
			ON i.item_id = cookie.item_id;
				
		3.Find the stock of all items across all inventories. Display item id, brand, name and stock.

			SELECT i.item_id, i.brand, i.item_name, stock
			FROM items as i 
			INNER JOIN (SELECT item_id, SUM(quantity) as stock FROM inventory GROUP BY(item_id)) AS stock_summary 
			ON i.item_id=stock_summary.item_id;

TRIGGER:

	INSERT INTO CHECKOUT_ACTION VALUES(150, 2, 145);
*/

