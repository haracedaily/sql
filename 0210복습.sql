select employee_id, salary
from employees;

select *
from employees;

select employee_id 사원번호, last_name 사원이름, salary
from employees;

select last_name|| '의 월급은 '|| salary||' 달러입니다.' 월급
from employees;

select distinct(job_id)
from employees;

select last_name,salary
from employees
order by salary;

select last_name, salary, job_id
from employees
where salary = 3000;

select first_name, salary, job_id,hire_date,department_id
from employees
where first_name = 'Steven';

select first_name, salary,(salary+salary*nvl(commission_pct,0))*12 연봉, salary*nvl(commission_pct,0) 수당
from employees;

select first_name, salary, job_id, department_id
from employees
where salary<=12000;

select first_name, department_id, job_id
from employees
where job_id not in('SA_MAN');

select first_name, salary
from employees
where salary between 1000 and 3000;

select first_name, salary
from employees
where salary not between 1000 and 3000;

select first_name, hire_date
from employees
where to_char(hire_date,'yyyy')='2006';

select first_name, salary
from employees
where first_name like 'S%';

select first_name, salary
from employees
where first_name like '%t';

select first_name, salary
from employees
where first_name like '_m%';

select concat(first_name,last_name) name
from employees
where concat(first_name, last_name) like '%a%'
or concat(first_name, last_name)like 'A%';

select first_name, commission_pct
from employees
where commission_pct is null;

select first_name, salary, job_id
from employees
where job_id in('SA_MAN','PU_CLERK', 'IT_PROG');

select first_name, salary, job_id
from employees
where job_id not in('SA_MAN','PU_CLERK', 'IT_PROG');

select first_name, salary, job_id
from employees
where job_id in('SA_MAN')
and salary >= 1200;

select upper(first_name) 대문자, lower(last_name)소문자,initcap(first_name) 첫글자만
from employees;

select first_name, salary
from employees
where lower(first_name)='alexander';

select substr('SMITH',1,3)
from dual;

select first_name||' - ' ||length(first_name) "이름과 개수"
from employees;

select instr(first_name,'a') "a의 위치", first_name
from employees;

select first_name, rpad(salary,10,'*')
from employees;

select first_name, replace(salary,100,'■') "100은 네모",salary
from employees;

select round(876.567,1)
from dual;

select trunc(876.567,1)
from dual;

select mod(10,3)
from dual;

select employee_id,
    case when mod(employee_id,2)=1 then '1'
        else '2' end 홀짝
from employees;

select employee_id, first_name
from employees
where mod(employee_id,2)=0;

select first_name, month_between(sysdate,hire_date)
from employees;
