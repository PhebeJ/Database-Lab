create table department(
dept_id serial primary key,
dept_name text not null
);

create table employee(
emp_id serial primary key,
name text not null,
dob date not null,
doj date not null,
sal money not null,
dept_id int not null references department(dept_id)
);

create table emp_backup(
emp_id int,
name text,
dob date,
doj date,
sal money,
dept_id int,
date_of_op date,
type_of_op text
);

create table income_tax(
emp_id int not null references employee(emp_id),
name text not null,
dob date not null,
doj date not null,
sal money not null,
dept_id int not null references department(dept_id),
tax_amount money not null
);

create or replace function cases()
returns trigger as
$$
begin
	new.name = upper(new.name);
	return new;
end;
$$
language plpgsql;

create trigger change_case before insert on employee for each row execute procedure cases();

create or replace function disp()
returns trigger as
$$
begin
	raise notice '% occured',TaOP;
	return 0;
end;
$$
language plpgsql;

create trigger disp before insert or update or delete on employee for each row execute procedure disp();
