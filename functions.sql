int incr(int n){
  return n+1;
}
/* Function to increment a number */
CREATE OR REPLACE FUNCTION inc(n INT)
RETURNS INT AS 
$BODY$
BEGIN
  RETURN n+1;
END;
$BODY$
LANGUAGE plpgsql;

/* Function to calculate sum of two numbers */
CREATE OR REPLACE FUNCTION sum_of_two(a INT,b INT)
RETURNS INT AS
$BODY$
BEGIN
  RETURN a+b;
END;
$BODY$
LANGUAGE plpgsql;

/* Dont forget ; at the end of RETURN */

/* Function to calculate nth fibanocci series */
CREATE OR REPLACE FUNCTION fib(n INT)
RETURNS INT AS
$BODY$
DECLARE
  a INT = 0;
  b INT = 1;
  c INT = 0;
BEGIN
  IF n=1 THEN
    RETURN 0;
  ELSIF n=2 THEN
    RETURN 1;
  ELSE
    LOOP 
    EXIT WHEN n=2; 
     c=a+b;
     a=b;
     b=c;
     n=n-1;
    END LOOP;
    RETURN c;
  END IF;
END;
$BODY$
LANGUAGE plpgsql;


/* Function to divide 2 numbers */
CREATE OR REPLACE FUNCTION divide(n NUMERIC,m NUMERIC)
RETURNS NUMERIC AS
$BODY$
BEGIN
      IF m=0 THEN RAISE EXCEPTION 'Division by zero' USING HINT='Denominator cannnot be zero';
      ELSE
       RETURN n/m;
      END IF;
END;
$BODY$
LANGUAGE plpgsql;

-- Function to list students with strength grester than n
CREATE OR REPLACE FUNCTION dispp(n INT)
RETURNS TABLE(
  id INT,
  stuame VARCHAR,
  divis VARCHAR,
  s_cnt INT
  ) AS
$BODY$
BEGIN
    RETURN QUERY SELECT * FROM class_ WHERE st_cnt>n;
END;
$BODY$
LANGUAGE plpgsql;

-- Query to list students with fname like Aiswarya
CREATE OR REPLACE FUNCTION dispn(s VARCHAR)
RETURNS TABLE(
  id INT,
  fname VARCHAR,
  lname VARCHAR,
  c_id INT  
  )
  AS
  $$
  BEGIN
    RETURN QUERY SELECT * FROM student WHERE st_fname like s;
  END;
  $$
  LANGUAGE plpgsql;
  
  --Query to list the name and class
  CREATE OR REPLACE FUNCTION dispn2(s VARCHAR)
RETURNS TABLE(
  name VARCHAR,
  div VARCHAR
  )
  AS
  $$
  BEGIN
    RETURN QUERY SELECT st_fname,division FROM student NATURAL JOIN class_ WHERE st_fname like s;
  END;
  $$
  LANGUAGE plpgsql;
  
  
  CREATE OR REPLACE FUNCTION testcur()
  RETURNS VOID AS
  $$
  DECLARE
    cur CURSOR FOR SELECT st_fname, st_lname FROM student LIMIT 5;
  BEGIN
    FOR rec in cur
    LOOP 
        RAISE NOTICE 'fname: %,lname: %', rec.st_fname, rec.st_lname;
    END LOOP;
  END;
  $$
  LANGUAGE plpgsql;
  
  
  CREATE OR REPLACE FUNCTION maptr(
    cname VARCHAR,
    cdiv VARCHAR,
    tfname VARCHAR,
    tlname VARCHAR
    )
    AS
    $$
    DECLARE
       c_id VARCHAR;
       t_id VARCHAR;
       cur CURSOR FOR SELECT st_id FROM student NATURAL JOIN class_ WHERE class_name LIKE 'Ten' AND division LIKE 'C';
    BEGIN
      SELECT class_id FROM class_
      WHERE class_name LIKE 'Ten' AND division LIKE 'C' INTO c_id;
      SELECT tr_id FROM teacher 
      WHERE tr_fname LIKE 'Linda' AND tr_lname LIKE 'Max' INTO t_id;
      FOR rec IN cur
      LOOP
          INSERT INTO stud_class VALUES(rec.st_id,c_id,t_id);
      END LOOP;
    END;
    $$
    LANGUAGE plpgsql;
