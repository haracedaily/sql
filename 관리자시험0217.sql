--문제12
--1)
create user TEST identified by t2460;
--2)
grant connect, resource to TEST;
--3)
grant create view to TEST;
--4)
grant select on hr.prof_list_vu to TEST;

--문제13
--1)
drop table hr.prof purge;
--1) hr에서 drop table prof purge;