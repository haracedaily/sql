select concat('yedam','Database')
from dual;

select job_id
from employees
where lower(job_id) ='it_prog';

--����3-3 ���� üũ
select instr('welcometocodingworld','d',1,2)
from dual;

select substr('welcometocodingworld',8,2) say_to,
        substr('welcometocodingworld',-5,5)say_world,
        substr('welcometocodingworld',1,19)disapear_d --trim(trailing 'd' from 'welcomtocodingwolrd')
from dual;

--����4 length(last_name)/2 = 2? -> 5/2=�Ҽ��� ����;
select employee_id,last_name,replace(last_name,substr(last_name,2,3),'***') change_name
from employees
where length(last_name)=5;
--����5
select lpad(last_name,10,'*'),rpad(last_name,10,'#')
from employees;
--����6
select concat(concat(employee_id,last_name),first_name) employeer, length(concat(last_name,first_name)) how_long, instr(concat(last_name,first_name),'a') where_a, job_id
from employees
where substr(job_id,-3,3)='REP';
--alias = AS.... �� �ڲ� �ٸ��� ��������


select employee_id,concat(first_name,last_name) name,
        job_id,length(last_name) name_length, instr(last_name,'a') "Contains 'a'?"
from employees
where substr(job_id,4) ='REP';
--where ->row ���ϱ�