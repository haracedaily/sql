--outer join

select *
from departments left outer join employees
on (departments.department_id = employees.department_id);

--from join where group by having select distinct order by
--from on join where group by having select distinct order by
--on -> join �Ҷ� ���� ||where -> join �ϰ��� ������ �� ����

select *
from employees e, departments d --1>ī�׽þ� ������Ʈ �߻� ->��� ������ ������� ��� �� ����.
where e.department_id = d.department_id;--2>where �� ���ǿ� �´� �����͸� �����Ѵ�.

select *
from departments d join employees e
on (d.department_id = e.department_id)--join�Ҷ� �ش� ���ǿ� �´� �����͸� ������ �ͼ� ������ ����� ���
where d.department_id>50; --2>�μ� ��ȣ�� 50������ ū �μ��� ���ؼ��� ������ ����

--join�� on�� �� ��Ʈ

select *
from employees e left outer join departments d
on e.department_id=d.department_id
where e.department_id = d.department_id;

select e.employee_id, e.last_name,
    e.department_id, d.department_name
    from employees e left outer join departments d
    on e.department_id=d.department_id;
    
    --oracle�������� ǥ��
select e.employee_id, e.last_name,
    e.department_id, d.department_name
    from employees e, departments d
    where e.department_id=d.department_id(+);    
    
    
    select e.employee_id, e.last_name,
    e.department_id, d.department_name
    from employees e join departments d
    on e.department_id=d.department_id;
    
    
    select e.employee_id, e.last_name,
    e.department_id, d.department_name
    from employees e right outer join departments d
    on e.department_id=d.department_id;
--oracle����   
    select e.employee_id, e.last_name,
    e.department_id, d.department_name
    from employees e, departments d
    where e.department_id(+)=d.department_id;    
    
--oracle������ ������ full outer join�� ����x    
    select e.employee_id, e.last_name,
    e.department_id, d.department_name
    from employees e full outer join departments d
    on e.department_id=d.department_id;
    


--self join �ڰ� ����
--select '�����ȣ'||e.employee_id||'��'||e.last_name||'�� ����ڴ� �����ȣ'||m.employee_id||'��'||m.last_name||'�̴�'
--from employees e, employees m
--where e.manager_id=m.employee_id;

select e.employee_id, e.last_name, e.manager_id, m.last_name
from employees e left outer join employees m
on e.manager_id=m.employee_id
order by e.manager_id;

--cross join
--ī�׽þ� ���δ�Ʈ�� �����ϴ�
select last_name, department_name
from employees cross join departments;
--�����ϰ� on�� ����x
--where employees.department_id=departments.department_id;

--natural join(���� column�� �����ؾ߸� ��밡��)
select *
from departments;
select *
from locations;

--���ǹ��� ���� �ʾƵ� �˾Ƽ� �ߺ��Ǵ� �Ӽ��� �������� �ش��ϴ� �����͸� ����
select department_id, department_name, location_id, city
from departments natural join locations;

select employee_id, department_name,department_id, location_id, last_name
from employees natural join departments;

select employee_id, department_name,e.department_id, location_id, last_name
from employees e join departments d
on e.department_id=d.department_id;

--using �� using (); �ݵ�� ��ȣ �ο�
select employee_id, department_name,department_id, location_id, last_name
from employees join departments
--employees.department_id=departments.department_id�� ���� ����
using (department_id);

--on
select employee_id, department_name,employees.department_id, location_id, last_name
from employees join departments
on (employees.department_id=departments.department_id);

--3-way ����
--equi join
select e.employee_id,e.last_name, d.department_id,l.city
from employees e join departments d on(e.department_id=d.department_id)
join locations l on(d.location_id = l.location_id);

--������ �ϳ��� ������ ���ν�Ų�Ŷ� �����ϴ�~<<�̷��� �����ϼ̴��� ���ƿ䤷�� 
select d.department_id,l.city
from departments d join locations l on(d.location_id = l.location_id);

--outer join
select e.employee_id,e.last_name, d.department_id,l.city
--departments�� locations�� ���εǰ� employees�� ���εȴ�.
from employees e full outer join departments d on(e.department_id=d.department_id)
join locations l on(d.location_id = l.location_id);

--join�� group �Լ��� �ݶ�
select d.department_name, min(e.salary),max(e.salary),trunc(avg(e.salary))
from employees e join departments d
on e.department_id = d.department_id
group by d.department_name;
--department_name�� ���� �ֵ��� �׷쿡��

select d.department_name, e.salary
from employees e join departments d
on e.department_id = d.department_id;


--subquery
--'abel'�� ����� �޿����� ���� ����� ��� ������ ����ϼ���.
select last_name, salary
from employees
where last_name='Abel';

select *
from employees
where salary> 11000;

select *
from employees
where salary > (select salary
    from employees
    where last_name = 'Abel');

--������ �ΰ� �� ��������
--matos�� ����� ��å(����)�� ���� ������ ���� ����� ������ ����ض�
select job_id
from employees
where last_name = 'Matos';

select salary
from employees
where last_name = 'Matos';

select last_name, job_id, salary
from employees
where job_id='ST_CLERK'
and salary>2600;

select last_name, job_id, salary
from employees
where job_id=(select job_id
    from employees
    where last_name='Matos')
and salary>(select salary
    from employees
    where last_name = 'Matos');

--ȸ�翡�� �޿��� ���� ���� ����� ���� ���
select last_name, job_id, salary
from employees
where salary = (select max(salary)
    from employees);

--20�� �μ��� �ִ� �ο����� ���� �μ��� ������ ���
select count(*)
from employees
where department_id=20;

select department_id, count(*)
from employees
group by department_id
having count(*)>2;

select department_id, count(*)
from employees
group by department_id
having count(*)>
(select count(*)
from employees
where department_id=20);

--60�� �μ����� �ְ� �޿��� ���� �޿��� �޴� ����� ���� ���
select *
from employees
where salary = (select max(salary)
    from employees
    where department_id=60);

--�̰� �μ����� 60�� �μ����� �ְ�޿��� ���� ��
select max(salary),department_id
from employees
group by department_id
having max(salary) > (select max(salary)
from employees
where department_id=60);


--����
--select *
--from employees
--where salary = (select salary +100
--                from employees);

--�μ��� �ְ� �޿��� �޴� ����� ���� �޿��� �޴� ����� ������ ���
select max(salary)
from employees
group by department_id;

select last_name, job_id, salary
from employees
where salary = (select max(salary)
from employees
group by department_id);

select last_name, job_id, salary
from employees
--in == or   || �� ���� �� in(~ , ~ , ~)�� �Ȱ��� ����
where salary in (select max(salary)
from employees
group by department_id);

--any == or
--60�� �μ��� �������� �޿����� ���� ������� ���� ���
select salary
from employees
where department_id=60;

--any�� �ε�ȣ[>,<, = ,>=, etc..](��) ���迡�� ����Ѵ�. ������ ��쿡�� in���

select salary,last_name,job_id
from employees
where salary >any (select salary --4200���� ū salary��
    from employees
    where department_id=60);


--all == and; ��� ������ �����ؾ��Ҷ� ���|| =�� ������ �ε�ȣ�� �ڿ� ���
select salary,last_name,job_id
from employees
where salary >all (select salary --9000���� ū salary��
    from employees
    where department_id=60);


--���� �� ���� ���� non-pairwise��ֺ�(=����) pairwise�ֺ�(=¦��)
select salary, employee_id, last_name
from employees
--�ΰ� �̻��� column��� �� �ΰ� ��� �����ϴ� ��� ���� ����(=pairwise)
where (salary, employee_id)in(select salary, employee_id
    from employees
    where employee_id>105);
--and employee_id <202;

--non-pairwise || ¦���� ��� column ������ default�� and �θ� ����;
--������ ��� column ������ and or�� �������� �� �ִ�. �׸��� �������� ���̸� �� �� �ִ�.
select salary, employee_id, last_name
from employees
where salary in (select salary
    from employees
    where employee_id>105)
and employee_id in (select employee_id
    from employees
    where employee_id>=100);
    
--����� ver pairwise
select salary, nvl(commission_pct,-1)
from employees
where department_id=10;

select last_name, salary, commission_pct, department_id
from employees
where (salary, nvl(commission_pct,-1)) in (select salary, nvl(commission_pct,-1)
from employees
where department_id=60)
and department_id<>60;

--��� ��
select last_name, salary, commission_pct, department_id
from employees
where salary in (select salary
    from employees
    where department_id=60)
and nvl(commission_pct,-1)IN(select nvl(commission_pct,-1)
    from employees
    where department_id=60)
and department_id<>60;

--from ���� ���� ���� ���; inline - view

--���� ����
select last_name, job_id, salary
from employees
where salary>(
--���������� ���� none�� ��� ����� �ǵ� �����ʹ� x
    select salary
    from employees
    where last_name='Mark');

select employee_id, last_name
from employees
where employee_id IN (select manager_id
    from employees);

select employee_id, last_name
from employees
where employee_id NOT IN (select manager_id
    from employees);
    