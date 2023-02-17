--시퀀스의 생성

create sequence dept_deptid_seq
        increment by 10
        start with 200
        maxvalue 9999
        nocache
        nocycle;
        
--최초에 한번일때 currval 경우 데이터가 없고 무조건 nextval 한 뒤에 값이 존재(=이 값은 start with data)
--nextval에서 currval이 출력된다.
insert into departments(department_id, department_name, location_id)
values(dept_deptid_seq.nextval, 'support',2500);

select * from departments;

rollback;

insert into departments(department_id, department_name, location_id)
values(dept_deptid_seq.nextval, 'support',2500);
--sequence는 롤백시켜도 초기화 되지 않음<- 
select * from departments;
commit;

--1> sequence 활용해서 게시판 글 번호
--순차적으로 글번호 입력 가능<-삭제데이터 있을 경우 되돌릴순 있으나  이후 정상적인 번호로 넣을수 x [why? 사라진 데이터랑 별개로 시퀀스는 계속 유지됨] 즉 계속 이전 번호로 내려야함
--편함 -> 유지보수에 있어서 할일이 늘어남
--2> insert 그룹함수 활용해서 입력
--그룹함수를 사용하게 되면 알아서 번호를 만들어 게시판 번호 생성
--귀찮음 -> 유지보수에 편함

--시퀀스 수정
alter sequence dept_deptid_seq
        increment by 20
        maxvalue 999999
        nocycle
        nocache;

insert into departments(department_id, department_name, location_id)
values(dept_deptid_seq.nextval, 'support',2500);

select * from departments;

select dept_deptid_seq.currval
from dual;

rollback;

select sequence_name, min_value, max_value, increment_by, last_number
from user_sequences;

drop sequence dept_deptid_seq;

--동의어
select * from dept_sum_vu;

create synonym d_sum
for dept_sum_vu;

select * from d_sum;

--동의어 관련 데이터 딕셔너리(user_~) 보기
select * from user_synonyms;
select synonym_name, table_owner, table_name
from user_synonyms;

drop synonym d_sum;

--실습 정리
drop table emp;
drop table cart;
drop table store;
drop table prod;
drop table member;
drop table product;
drop table market;
drop table m_user;
drop table morder;

desc prod;
desc store;
alter table prod drop constraint sys_c007198 cascade;
alter table store drop constraint sys_c007195 cascade;

select * from user_constraints where table_name='STORE';


--rownum
--column에 순서매길때 사용; 순서매기기만 함 흐응...
select rownum, employee_id, salary, hire_date, department_id
from employees;


--with절 ≒inline view와 비슷, 가상의 테이블 만들때 사용
with example as
( select 'with절' as str1
from dual)
select * from example;
--서브쿼리 -> inline view랑 비슷
with example as(
select employee_id, salary, hire_date
from employees)
select * from example;
--with절 복잘한 sql동일한 블록에 반복적으로 나올때
with example as
( select 'with절' as str1
from dual)
select * from example;
--서브쿼리 -> inline view랑 비슷
with example as(
select 'example' from dual
union all
select 'example3' from dual
),
example2 AS(
select 'example2' from dual
union all
select * from example
)
select * from example2;


--rank() over() 랭킹을 매긴다;
--기본형태
select rank() over(order by salary) AS 급여순, last_name--공동순위 존재//중복되면 중복된만큼 제외하고 순차적으로 진행
from employees;

select rank() over(order by hire_date) AS 입사순, last_name
from employees;

--dense_rank() over() 중복 순위 제외 //공동순위 존재//하지만 중복되어도 순차적으로 진행
select dense_rank() over(order by salary) AS 급여순, last_name, salary
from employees;

--row_number() over() 공동순위 제외//그냥 순차적으로 등수 내려감
select row_number() over(order by salary) as 급여순, last_name, salary
from employees;

--rank over() -> 그룹 함수 내에서 rank over|| partition by(≒group by)
select rank() over(partition by department_id order by salary) as 부서별급여순, last_name, salary,department_id
from employees;

select dense_rank() over(partition by department_id order by salary) as 부서별급여순, last_name, salary,department_id
from employees;


--휴지통 기능
--undotbs ->데이터 삭제시 보관하는 공간
--drop table employees -> 자동 커밋 삭제,
--휴지통으로 이동
create table temp(
id number(1));

drop table temp;

select * from user_recyclebin
where original_name='TEMP';

--휴지통 비우기
purge recyclebin;

--휴지통에서 복구하기(flashback table "object_name" to before drop;)
flashback table "BIN$BK1bi5J0QHmMnK1etfpz2g==$0" to before drop;

select * from temp;
--조회 하기
--테이블 조회
select * from tab;
--휴지통 확인
show recyclebin;
--table 영구 삭제
drop table temp purge;
select* from temp;
show recyclebin;

