--문제1
select employee_id, last_name, e.department_id, department_name
from employees e left outer join departments d
on e.department_id=d.department_id;

--문제2
select department_id, department_name,city
from departments join locations
using(location_id);

--문제3
select employee_id, last_name, job_id
from employees join departments
using(department_id)
where department_name = (select department_name
                        from departments
                        where department_name like '%IT%');
                        
--문제4
create table PROF
(
PROFNO number(4) primary key,
NAME varchar2(15) constraint PROF_NAME_NN not null constraint PROF_NAME_UK unique,
ID varchar2(15) not null,
HIREDATE date,
PAY number(4),
DEPTNO number(4)
);

--문제5
alter table PROF
ADD constraint PROF_DEPTNO_FK foreign key(DEPTNO) references departments(department_id);

--문제6
select *
from user_constraints
where table_name = 'PROF';

--문제7
--1)
insert into prof values(1001,'차은우','c1001','17/03/01',800,10);
insert into prof values(1002,'김제니','k1002','20/11/28',750,10);
insert into prof values(1003,'손담비','s1003','21/03/02',(null),(null));
commit;
--2)
update prof SET pay = 1100 where profno=1001;
--3)
commit;

--문제8
--1)
create index PROF_ID_IX
on prof(id);
--2)
select index_name from user_indexes where table_name = 'PROF';
--3)
select count(*) from user_indexes where table_name='PROF';

--문제9
--1)
alter table prof add (gender char(3));
--2)
alter table prof modify (NAME varchar2(20));

--문제10
--1)
create view PROF_LIST_VU (교수번호, 교수이름, ID)
as
    select profno,name,id
    from prof;
--2)
create synonym P_VU
for PROF_LIST_VU;
--3)
create sequence prof_no_seq
    increment by 1
    start with 1005
    nomaxvalue
    nominvalue
    nocycle
    nocache;

--문제11
--1)
create or replace view PROF_LIST_VU (교수번호,교수이름,ID,입사일)
as 
    select profno,name,id,hiredate
    from prof;
--2)
alter sequence prof_no_seq
    increment by 2
        nomaxvalue
        nominvalue
        nocycle
        nocache;

--문제13
--2)
select *
from user_recyclebin
where original_name='PROF'
and type in ('INDEX','VIEW','SYNONYM');