--outer join

select *
from departments left outer join employees
on (departments.department_id = employees.department_id);

--from join where group by having select distinct order by
--from on join where group by having select distinct order by
--on -> join 할때 조건 ||where -> join 하고나서 선택할 때 조건

select *
from employees e, departments d --1>카테시아 포르덕트 발생 ->모든 데이터 결과물을 출력 한 다음.
where e.department_id = d.department_id;--2>where 절 조건에 맞는 데이터만 추출한다.

select *
from departments d join employees e
on (d.department_id = e.department_id)--join할때 해당 조건에 맞는 데이터만 가지고 와서 데이터 결과물 출력
where d.department_id>50; --2>부서 번호가 50번보다 큰 부서에 대해서만 데이터 추출

--join과 on은 한 세트

select *
from employees e left outer join departments d
on e.department_id=d.department_id
where e.department_id = d.department_id;

select e.employee_id, e.last_name,
    e.department_id, d.department_name
    from employees e left outer join departments d
    on e.department_id=d.department_id;
    
    --oracle문법으로 표현
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
--oracle문법   
    select e.employee_id, e.last_name,
    e.department_id, d.department_name
    from employees e, departments d
    where e.department_id(+)=d.department_id;    
    
--oracle문법상 별도로 full outer join은 존재x    
    select e.employee_id, e.last_name,
    e.department_id, d.department_name
    from employees e full outer join departments d
    on e.department_id=d.department_id;
    


--self join 자가 참조
--select '사원번호'||e.employee_id||'인'||e.last_name||'의 상급자는 사원번호'||m.employee_id||'인'||m.last_name||'이다'
--from employees e, employees m
--where e.manager_id=m.employee_id;

select e.employee_id, e.last_name, e.manager_id, m.last_name
from employees e left outer join employees m
on e.manager_id=m.employee_id
order by e.manager_id;

--cross join
--카테시아 프로덕트와 동일하다
select last_name, department_name
from employees cross join departments;
--유일하게 on과 연결x
--where employees.department_id=departments.department_id;

--natural join(같은 column이 존재해야만 사용가능)
select *
from departments;
select *
from locations;

--조건문을 주지 않아도 알아서 중복되는 속성을 기준으로 해당하는 데이터만 추출
select department_id, department_name, location_id, city
from departments natural join locations;

select employee_id, department_name,department_id, location_id, last_name
from employees natural join departments;

select employee_id, department_name,e.department_id, location_id, last_name
from employees e join departments d
on e.department_id=d.department_id;

--using 절 using (); 반드시 괄호 부여
select employee_id, department_name,department_id, location_id, last_name
from employees join departments
--employees.department_id=departments.department_id랑 같은 문법
using (department_id);

--on
select employee_id, department_name,employees.department_id, location_id, last_name
from employees join departments
on (employees.department_id=departments.department_id);

--3-way 조인
--equi join
select e.employee_id,e.last_name, d.department_id,l.city
from employees e join departments d on(e.department_id=d.department_id)
join locations l on(d.location_id = l.location_id);

--이퀄로 하나씩 나눠서 조인시킨거랑 동일하다~<<이렇게 강의하셨던거 같아요ㅇㅇ 
select d.department_id,l.city
from departments d join locations l on(d.location_id = l.location_id);

--outer join
select e.employee_id,e.last_name, d.department_id,l.city
--departments와 locations가 조인되고 employees가 조인된다.
from employees e full outer join departments d on(e.department_id=d.department_id)
join locations l on(d.location_id = l.location_id);

--join과 group 함수의 콜라보
select d.department_name, min(e.salary),max(e.salary),trunc(avg(e.salary))
from employees e join departments d
on e.department_id = d.department_id
group by d.department_name;
--department_name이 같은 애들의 그룹에서

select d.department_name, e.salary
from employees e join departments d
on e.department_id = d.department_id;


--subquery
--'abel'인 사람의 급여보다 많은 사람의 사원 정보를 출력하세요.
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

--조건이 두개 인 서브쿼리
--matos인 사람의 직책(직업)과 같고 연봉이 높은 사람의 정보를 출력해라
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

--회사에서 급여가 제일 높은 사람의 정보 출력
select last_name, job_id, salary
from employees
where salary = (select max(salary)
    from employees);

--20번 부서에 있는 인원보다 많은 부서의 정보를 출력
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

--60번 부서에서 최고 급여와 같은 급여를 받는 사람의 정보 출력
select *
from employees
where salary = (select max(salary)
    from employees
    where department_id=60);

--이건 부서별로 60번 부서보다 최고급여가 많은 곳
select max(salary),department_id
from employees
group by department_id
having max(salary) > (select max(salary)
from employees
where department_id=60);


--오류
--select *
--from employees
--where salary = (select salary +100
--                from employees);

--부서별 최고 급여를 받는 사람과 같은 급여를 받는 사람의 정보를 출력
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
--in == or   || 비교 구문 중 in(~ , ~ , ~)랑 똑같이 이해
where salary in (select max(salary)
from employees
group by department_id);

--any == or
--60번 부서의 구성원의 급여보다 많은 사람들의 정보 출력
select salary
from employees
where department_id=60;

--any는 부등호[>,<, = ,>=, etc..](뒤) 관계에서 사용한다. 이퀄의 경우에만 in사용

select salary,last_name,job_id
from employees
where salary >any (select salary --4200보다 큰 salary들
    from employees
    where department_id=60);


--all == and; 모든 조건을 충족해야할때 사용|| =을 제외한 부등호들 뒤에 사용
select salary,last_name,job_id
from employees
where salary >all (select salary --9000보다 큰 salary들
    from employees
    where department_id=60);


--다중 열 서브 쿼리 non-pairwise비쌍비교(=독비교) pairwise쌍비교(=짝비교)
select salary, employee_id, last_name
from employees
--두개 이상의 column사용 시 두개 모두 만족하는 경우 조건 만족(=pairwise)
where (salary, employee_id)in(select salary, employee_id
    from employees
    where employee_id>105);
--and employee_id <202;

--non-pairwise || 짝비교의 경우 column 조건이 default로 and 로만 만족;
--독비교의 경우 column 조건을 and or로 지정해줄 수 있다. 그리고 디테일한 차이를 줄 수 있다.
select salary, employee_id, last_name
from employees
where salary in (select salary
    from employees
    where employee_id>105)
and employee_id in (select employee_id
    from employees
    where employee_id>=100);
    
--강사님 ver pairwise
select salary, nvl(commission_pct,-1)
from employees
where department_id=10;

select last_name, salary, commission_pct, department_id
from employees
where (salary, nvl(commission_pct,-1)) in (select salary, nvl(commission_pct,-1)
from employees
where department_id=60)
and department_id<>60;

--비쌍 비교
select last_name, salary, commission_pct, department_id
from employees
where salary in (select salary
    from employees
    where department_id=60)
and nvl(commission_pct,-1)IN(select nvl(commission_pct,-1)
    from employees
    where department_id=60)
and department_id<>60;

--from 절에 서브 쿼리 사용; inline - view

--주의 사항
select last_name, job_id, salary
from employees
where salary>(
--서브쿼리의 값이 none의 경우 출력은 되도 데이터는 x
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
    