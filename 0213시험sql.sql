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
select employee_id ���, first_name �̸�, hire_date �Ի���, substr(email,1,3) EMAIL,length(email) EMAIL_LENGTH
from employees
where to_char(hire_date,'yyyy/mm/dd')>='2005/01/01';

--5>
select first_name �̸� , hire_date �Ի��� , add_months(hire_date,6) �Ի�6������,next_day(hire_date,'�ݿ���') "�Ի� �� ù �ݿ���",trunc(months_between(sysdate,hire_date))||'����' ��_�ٹ�����, trunc(add_months(hire_date,1),'mm') ù�޿���
from employees
order by hire_date;

--6>
select employee_id ���, first_name �̸�, to_char(hire_date,'dd/mm/yyyy day') �Ի���, to_char(salary*commission_pct,'$99,999.99') "����"
from employees
order by ���� desc;

--7>
select employee_id ���, first_name �̸�, manager_id ����ID, salary �޿�, department_id �μ���ȣ
from employees
where department_id between 50 and 60
and salary > 5000;

--8>
select employee_id ���, manager_id ����ID, phone_number ��ȭ��ȣ,department_id �μ���ȣ
from employees
where substr(phone_number,1,3)=515;

--9>
select employee_id ���, first_name �̸�,
case when salary+salary*commission_pct is not null then (salary+salary*commission_pct)*12
    when salary+salary*commission_pct is null then salary*12
    end AS "����",
    to_char(hire_date,'yyyy')||'����' �Ի翬��, nvl2(commission_pct,'COMM','NOCOMM') ���
    from employees
    order by department_id, ����;
    
--10>
select employee_id ���, first_name �̸�, 
case when department_id = 20 then department_id||' '||'Canada'
    when department_id=80 then department_id||' '||'UK'
    else department_id||' '||'USA' end "�μ���ȣ �� �ٹ�����"
from employees;