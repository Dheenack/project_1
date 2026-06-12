use mohan;
show tables;
select * from employee;
create view it_emp as select * from employee where department='it';
select * from it_emp;
show create view it_emp ;

create view emp_bonus as select emp_id,emp_name,salary,salary*0.10 as 'bonus' from employee; 
select * from emp_bonus;

-- list all views
show full tables ;
-- rename a view
rename table it_emp to it_staffs;
-- drop view
drop view view_name;

/*
view 			vs		table
stores data			stores query
occupies storage	minimal storage



-- to check table size
select table_name,round((data_length+index_length) / 1024/1024,2) as size from information_schema.tables where table_schema='mohan' and table_name='employee';
*/

explain select * from employee;


