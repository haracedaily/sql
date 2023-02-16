select *
from locations;

select *
from countries;

--����1
select location_id, street_address, city, state_province,country_name
from countries natural join locations;

--����2
select last_name, department_id||' '||department_name "�μ���ȣ �� �μ��̸�"
from employees left outer join departments
using (department_id);

select *
from employees;

select *
from departments;

--����3
select last_name, job_id, e.department_id||' '||department_name
from employees e join departments d on e.department_id=d.department_id
join locations l on d.location_id=l.location_id
where  city = (select city from locations where city = 'Toronto');

--����4
select e.first_name Employee, e.employee_id Emp#, m.first_name Manager, m.employee_id Mgr#
from employees e join employees m
on e.manager_id=m.employee_id;

--����5
select e.first_name Employee, e.employee_id Emp#, m.first_name Manager, m.employee_id Mgr#
from employees e left outer join employees m
on e.manager_id=m.employee_id
order by Emp#;

--6�� ����
select e.first_name, e.department_id, s.first_name
from employees e left outer join employees s
on e.department_id=s.department_id
where e.employee_id<>s.employee_id;
--order by e.first_name;

--���� 1
select last_name, hire_date
from employees
where department_id in (select department_id
                        from employees
                        where last_name='Zlotkey')
and last_name not in('Zlotkey');

--���� 2
select employee_id, last_name
from employees
where salary > (select avg(salary)
                from employees)
order by salary;

--����3

select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees 
                        where last_name like '%u%');


--���� 4
select last_name, e.department_id, job_id
from employees e join departments d
on e.department_id=d.department_id
where e.department_id in (select d.department_id
                        from departments
                        where location_id = 1700);

--���� 5
select last_name, salary
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name='King');

--���� 6
select e.department_id, first_name, job_id
from employees e join departments d
on e.department_id=d.department_id
where e.department_id=(select d.department_id
                        from departments
                        where department_name ='Executive');
                        
--���� 7
select employee_id, last_name, salary
from employees
where department_id in(
                        select department_id
                        from employees 
                        where last_name like '%u%')
and salary > (select avg(salary)
                from employees)
order by salary;