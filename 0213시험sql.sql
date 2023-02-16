--1>
select employee_id, first_name, job_id, hire_date
from employees;


--2>
select distinct employee_id
from employees
where substr(job_id,-3,3)='MAN';

--3>
select employee_id, first_name, salary, department_id
from employees
where salary between 7000 and 12000
and last_name like 'H%';

--4>
select employee_id 사번, first_name 이름, hire_date 입사일, substr(email,1,3) EMAIL,length(email) EMAIL_LENGTH
from employees
where to_char(hire_date,'yyyy/mm/dd')>='2005/01/01';

--5>
select first_name 이름 , hire_date 입사일 , add_months(hire_date,6) 입사6개월후,next_day(hire_date,'금요일') "입사 후 첫 금요일",trunc(months_between(sysdate,hire_date))||'개월' 총_근무개월, trunc(add_months(hire_date,1),'mm') 첫급여일
from employees
order by hire_date;

--6>
select employee_id 사번, first_name 이름, to_char(hire_date,'dd/mm/yyyy day') 입사일, to_char(salary*commission_pct,'$99,999.99') "수당"
from employees
order by 수당 desc;

--7>
select employee_id 사번, first_name 이름, manager_id 업무ID, salary 급여, department_id 부서번호
from employees
where department_id between 50 and 60
and salary > 5000;

--8>
select employee_id 사번, manager_id 업무ID, phone_number 전화번호,department_id 부서번호
from employees
where substr(phone_number,1,3)=515;

--9>
select employee_id 사번, first_name 이름,
case when salary+salary*commission_pct is not null then (salary+salary*commission_pct)*12
    when salary+salary*commission_pct is null then salary*12
    end AS "연봉",
    to_char(hire_date,'yyyy')||'연도' 입사연도, nvl2(commission_pct,'COMM','NOCOMM') 비고
    from employees
    order by department_id, 연봉;
    
--10>
select employee_id 사번, first_name 이름, 
case when department_id = 20 then department_id||' '||'Canada'
    when department_id=80 then department_id||' '||'UK'
    else department_id||' '||'USA' end "부서번호 및 근무지역"
from employees;