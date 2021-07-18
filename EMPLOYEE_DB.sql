create table employee(
emp_id serial not null,
name varchar(15) not null,
dob date not null,
doj date not null,
sal money not null,
dept_id int not null references department(dept_id)
);

create table department(
dept_id serial primary key,
dept_name varchar(15) not null
);

insert into department(dept_name) values('HR'),('IT'),('Program');

insert into employee(name,dob,sal,dept_id) values('sukumaran','01-01-1998','01-01-2017',10000,1),('abhilash','01-01-1998','01-01-2018',100000,2),
('nidhi','08-17-1998','01-01-2016',200000,2),('varsha','12-15-1998','01-01-2015',10000000,1);

/*Write a function for updating the salary of employees working in the department with dept_id=10 by 20% */
create or replace function changer()
returns void as
$$
begin
	update employee set sal=sal+sal*20/100 where dept_id=1;
end;
$$
language plpgsql;

/* Write a function for employee table which accepts dept_id and returns the highest salary in that department. */
create or replace function max_(i int)
returns table(
maxx money
)
 as
$$ 
begin
	return query select max(sal) from employee group by dept_id having dept_id=i;
end;
$$
language plpgsql;

/* Write a function which accepts emp_id and returns employee experience */
create or replace function expe(i int)
returns interval as 
$$
declare
joindate date;
experience interval;
begin
	select doj from employee where emp_id=i into joindate;
	experience = age(joindate,date(now()));
	return experience;
end;
$$
language plpgsql;
