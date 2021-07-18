create table branch(
b_id serial primary key,
bname text not null,
city text not null
);
create table customer(
cid serial primary key,
cname text not null, 
city text not null
);
create table deposit(
acc_no serial primary key,
cid int not null references customer(cid),
b_id int not null references branch(b_id),
amount numeric not null,
date date not null
);
create table borrow(
loan_no serial primary key,
cid int not null references customer(cid),
b_id int not null references branch(b_id),
amount money not null,
date date not null
);
insert into branch(bname,city) values ('XYS','ERTI'),('HDEWI','DFFB'),('DFBGDF','DBD');
insert into customer(cname,city) values ('ALICE','ERTI'),('BOB','DFFB');

insert into deposit(cid,b_id,amount,date) values (1,1,10000,'09-01-2018'),(2,1,20000,'09-01-2018'),(1,2,10000,'09-05-2018');

insert into borrow(cid,b_id,amount,date) values (1,1,10000,'09-01-2018'),(2,1,20000,'09-01-2018'),(1,2,10000,'09-05-2018');

/*Find the number of customers who have loan in each branch */
create or replace function num()
RETURNS TABLE(
bid int,
count bigint
) 
as
$$
begin
	RETURN QUERY select b_id,COUNT(*) from borrow group by b_id;
end;
$$
language plpgsql;

/*List all details of all customers*/
select * from customer;create or replace function details()
returns table(
id int,
name text,
city_name text
)
as
$$
begin
return query select * from customer;
end;
$$
language plpgsql;
