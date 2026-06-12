
-- create new user
create user 'username'@'localhost' identified by 'password';

-- view existing users
select user,host from mysql.user;


-- granting privileges
-- give permissions to user
-- syntax
grant privileges on databasename.tablename to 'username'@'localhost';

-- grant select
grant select on mohan.employee to 'mohan'@'localhost';

-- grant insert
grant insert on mohan.employee to 'mohan'@'localhost';

-- grant multiple privileges
grant select,insert,update on mohan.employee to 'mohan'@'localhost';

-- grant all privileges
grant all privileges on mohan.employees to 'mohan'@'localhost';

-- grant on all table in database
grant privileges on mohan.* to 'mohan'@'localhost';

-- grant on all database
grant privileges on *.* to 'mohan'@'localhost';

-- check granted permissions
show grants for 'mohan'@'localhost';


-- revoke privileges
revoke insert on mohan.employee from 'mohan'@'localhost';

-- change password
alter user (user_name) identified by 'newpassword';


