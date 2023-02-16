select *
from employees;

select sum(salary), max(salary), min(salary), avg(salary)
from employees;

select sum(salary), max(salary), min(salary), avg(salary)
from employees
where department_id = 60;

--�ƽ�Ű�ڵ� ��ȯ ���� �� ���� ���� getbytes
select min(last_name), max(last_name)
from employees;

select min(hire_date), max(hire_date)
from employees;

select commission_pct
from employees;

select count(*)
from employees;

select count(commission_pct)
from employees;

--null���� ���ܵ� ī��Ʈ�� �����
select avg(commission_pct)
from employees;

--null�� ���� 0���� �� ��� �� ī��Ʈ�� ����Ǿ���
select avg(nvl(commission_pct,0))
from employees;

select count(*), count(department_id), count(distinct department_id)
from employees;

select avg(commission_pct) avg, avg(nvl(commission_pct,0)) allavg, sum(commission_pct)/count(commission_pct) avg, sum(commission_pct)/count(*) allof
from employees;

select max(salary),department_id
from employees
group by department_id;

select department_id, sum(salary), count(*)
from employees
group by department_id
order by 1;

--�μ��� ��å���� �� �޿��� �ο�
select department_id, job_id, sum(salary), count(*)
from employees
--�μ��� ��å����
group by department_id, job_id

order by 1,2;

--having

select department_id, job_id, sum(salary), count(*)
from employees
group by department_id, job_id
having count(*) <>1
order by 1,2;


--group�Լ� ��ø
select max(sum(salary))
from employees
group by department_id;

--�μ��� �����ε�, �� �߿� �ִ밪�� ������ ��� �μ����̵� ������ ����
--��, ���� �߻��� ���ְ� ������ ���ǹ����� �μ����̵� �ϳ��� �ٿ�����Ѵ�?<<nope
--group��ø �Լ��� �׷��Լ��� ������谡 �ֳ�..?
select max(sum(salary)), avg(department_id)
from employees
group by department_id;


desc employees;
desc departments;

--���������� ī�׽þ� ���δ�Ʈ <<-���ǹ� ���� ��� ��� ����� ���� ������ �� ������
select A.*, B.*
from employees A, departments B;

--join
--ī�׽þ� ���δ�Ʈ
select employee_id, last_name, department_name
from employees, departments;

select count(*)
from employees;

select count(*)
from departments;

select a.employee_id, a.last_name,a.department_id �μ�,b.department_name, b.department_id �μ�
from employees a, departments b
--�μ� ���̵� ���� �ֵ鳢�� �����ϰڴٴ� ���ǹ�(=equi join)
where a.department_id=b.department_id
order by b.department_id;

--1)equi join
select e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
from employees e, departments d
where e.department_id=d.department_id;

select employees.employee_id, employees.last_name, employees.department_id, departments.department_id, departments.location_id
from employees, departments
where employees.department_id=departments.department_id;

select count(*)
from employees;

select d.department_id �μ�, d.department_name, d.location_id ����,l.location_id ����,l.city
from departments d, locations l
where d.location_id=l.location_id;

select *
from employees;

--2) non equi join
select e.first_name, e.salary, e.job_id,j.job_title,j.min_salary,j.max_salary
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and e.job_id=j.job_id
order by j.job_title;

select *
from jobs;

select *
from job_grades;

select e.employee_id, e.last_name, e.salary, j.grade_level
from employees e, job_grades j
where e.salary between j.lowest_sal and highest_sal;

--select e.employee_id, e.last_name, e.salary, j.grade_level
--from employees e join job_grades j
--where e.salary between j.lowest_sal and highest_sal;

-- ����1) ������� �̸�, �μ���ȣ, �μ����� ����϶�
select e.last_name, e.department_id,department_name
from employees e, departments d
where e.department_id=d.department_id;

desc employees;
desc departments

-- ����2) ����̸��� �μ���� ������ ����ϴµ� ������ 3000 �̻��� ����� ����϶�
select last_name, department_name, salary
from employees e, departments d
where e.department_id=d.department_id
and salary>3000;

-- ����1) Ŀ�̼��� �޴� ����� �̸�, ����, �μ���ȣ,�μ����� ����϶�
select last_name, job_id, d.department_id, department_name
from employees e, departments d
where e.department_id=d.department_id
and commission_pct is not null;


-- ����2) ������ȣ 2500 ���� �ٹ��ϴ� ����� �̸�, ����,�μ���ȣ,�μ����� ����϶�
select last_name, job_id, d.department_id, department_name
from employees e, departments d
where e.department_id=d.department_id
and location_id=2500;

-- ����3) �̸��� A�� ���� ������� �̸��� �μ��̸��� ����϶�
select last_name, department_name
from employees e, departments d
where e.department_id=d.department_id
and upper(last_name) like '%A%';


-- ����4) ����̸��� �μ���� ������ ����ϴµ� ������ 3000 �̻��� ����� ����϶�
select last_name, department_name, salary
from employees e, departments d
where e.department_id = d.department_id
and salary>3000;

-- ����5) �޿��� 3000���� 5000������ ����� �̸��� �ҼӺμ��� ����϶�
select last_name, department_name
from employees e, departments d
where e.department_id = d.department_id
and salary between 3000 and 5000;

-- ����6) ACCOUNTING �μ� �Ҽ� ����� �̸��� �Ի��� ����϶�
select last_name, hire_date
from employees e, departments d
where e.department_id=d.department_id
and upper(department_name) = 'ACCOUNTING';


select employee_id, last_name, replace(last_name,substr(last_name,instr(last_name,'a',1,2),1),'*') AS result
from employees;



--replace����<< replace(�ش��ϴ� �Ӽ� column��,�ٲٰ� ���� ���ڿ� �Է�, �ٲ� ����) replace(last_name,substr(last_name, instr('b',2),2), '*')
