select employee_id, first_name, salary, salary+salary*0.15 New_Salary
from employees;

select employee_id, first_name, salary, salary+salary*0.15 New_Salary,salary+salary*0.15-salary Increase
from employees;

select upper(first_name), length(first_name)
from employees
where substr(first_name,1,1)= any('J','A','M');

select first_name, round(months_between(sysdate,hire_date)) months_worked
from employees
order by months_worked;

select last_name, trunc((sysdate-hire_date)/7) tenure
from employees
where department_id=90
order by tenure desc;

select first_name, hire_date, add_months(hire_date,6) 급여검토일,to_char(next_day(add_months(hire_date,6),'월요일'),'yyyy.mm.dd day') REVIEW
from employees;

select first_name, nvl2(commission_pct,to_char(commission_pct),'No Commission') comm
from employees;

select job_id,
case job_id    when 'AD_PRES' then job_id||' A'
               when 'ST_MAN' then job_id||' B'
               when 'IT_PROG' then job_id||' C'
               when 'SA_REP' then job_id||' D'
               when 'ST_CLERK' then job_id||' E'
               else '0' end as glade
from employees;