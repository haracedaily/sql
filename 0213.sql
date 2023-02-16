select *
from employees;

select sum(salary), max(salary), min(salary), avg(salary)
from employees;

select sum(salary), max(salary), min(salary), avg(salary)
from employees
where department_id = 60;

--아스키코드 변환 없이 비교 구문 가능 getbytes
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

--null값이 제외된 카운트로 연산됨
select avg(commission_pct)
from employees;

--null인 값을 0으로 줄 경우 총 카운트로 연산되어짐
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

--부서별 직책마다 총 급여와 인원
select department_id, job_id, sum(salary), count(*)
from employees
--부서별 직책마다
group by department_id, job_id

order by 1,2;

--having

select department_id, job_id, sum(salary), count(*)
from employees
group by department_id, job_id
having count(*) <>1
order by 1,2;


--group함수 중첩
select max(sum(salary))
from employees
group by department_id;

--부서별 총합인데, 그 중에 최대값을 추출할 경우 부서아이디가 누락이 생김
--즉, 오류 발생을 없애고 싶으면 조건문으로 부서아이디도 하나로 줄여줘야한다?<<nope
--group중첩 함수와 그룹함수의 상관관계가 있나..?
select max(sum(salary)), avg(department_id)
from employees
group by department_id;


desc employees;
desc departments;

--마찬가지로 카테시아 프로덕트 <<-조건문 없을 경우 모든 경우의 수를 무조건 다 보여줌
select A.*, B.*
from employees A, departments B;

--join
--카테시아 프로덕트
select employee_id, last_name, department_name
from employees, departments;

select count(*)
from employees;

select count(*)
from departments;

select a.employee_id, a.last_name,a.department_id 부서,b.department_name, b.department_id 부서
from employees a, departments b
--부서 아이디 같은 애들끼리 조인하겠다는 조건문(=equi join)
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

select d.department_id 부서, d.department_name, d.location_id 지역,l.location_id 지역,l.city
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

-- 문제1) 사원들의 이름, 부서번호, 부서명을 출력하라
select e.last_name, e.department_id,department_name
from employees e, departments d
where e.department_id=d.department_id;

desc employees;
desc departments

-- 문제2) 사원이름과 부서명과 월급을 출력하는데 월급이 3000 이상인 사원을 출력하라
select last_name, department_name, salary
from employees e, departments d
where e.department_id=d.department_id
and salary>3000;

-- 문제1) 커미션을 받는 사원의 이름, 직업, 부서번호,부서명을 출력하라
select last_name, job_id, d.department_id, department_name
from employees e, departments d
where e.department_id=d.department_id
and commission_pct is not null;


-- 문제2) 지역번호 2500 에서 근무하는 사원의 이름, 직업,부서번호,부서명을 출력하라
select last_name, job_id, d.department_id, department_name
from employees e, departments d
where e.department_id=d.department_id
and location_id=2500;

-- 문제3) 이름에 A가 들어가는 사원들의 이름과 부서이름을 출력하라
select last_name, department_name
from employees e, departments d
where e.department_id=d.department_id
and upper(last_name) like '%A%';


-- 문제4) 사원이름과 부서명과 월급을 출력하는데 월급이 3000 이상인 사원을 출력하라
select last_name, department_name, salary
from employees e, departments d
where e.department_id = d.department_id
and salary>3000;

-- 문제5) 급여가 3000에서 5000사이인 사원의 이름과 소속부서명 출력하라
select last_name, department_name
from employees e, departments d
where e.department_id = d.department_id
and salary between 3000 and 5000;

-- 문제6) ACCOUNTING 부서 소속 사원의 이름과 입사일 출력하라
select last_name, hire_date
from employees e, departments d
where e.department_id=d.department_id
and upper(department_name) = 'ACCOUNTING';


select employee_id, last_name, replace(last_name,substr(last_name,instr(last_name,'a',1,2),1),'*') AS result
from employees;



--replace구문<< replace(해당하는 속성 column명,바꾸고 싶은 문자열 입력, 바꿀 문자) replace(last_name,substr(last_name, instr('b',2),2), '*')
