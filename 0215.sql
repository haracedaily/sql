--게시판 삭제
delete board
where board_no=5;

select *
from board;
--게시판 삭제한 내용을 기준으로 번호 재정렬
update board
set board_no=board_no-1
where board_no>5;

update board
set board_content = (select b.max(board_no) from board b, board a where a.board_no<b.board_no)||'번게시물';
--게시판 생성
select count(*)+1
from board;

insert into board values((select count(*)+1
                        from board),(select count(*)+1
from board)||'번 게시물');

select *
from board
order by 1;

commit;

--insert 문장을 통한 transaction

insert into departments values(70,'Public Relations',100,1700);
select *
from departments;

rollback;

commit;

--다른 테이블로 row 복사
create table sales_reps
AS
select employee_id id, last_name name, salary, commission_pct
from employees;

select *
from sales_reps;

--commit; 하지 않아도 create는 db 명령어라 자동커밋되어짐
--insert 문 => 치환변수 사용
insert into departments (department_id, department_name, location_id)
values(&department_id, '&department_name', &location);
select *
from departments;
--&입력 받음, &&고정값

--update 문장을 활용한 transaction

update employees
set salary = 7000;

select *
from employees;

rollback;

update employees
set salary = 7000
where employee_id=104;

--transaction 종료
rollback;

select *
from employees;

--서브쿼리를 사용한 update
update employees
set job_id = (
                select job_id
                from employees
                where employee_id=205),
    salary = (
                select salary
                from employees
                where employee_id = 205)
where employee_id = 124;

select *
from employees;

update employees
set department_id = (
                        select department_id
                        from departments
                        where department_name like '%Public%')
where employee_id = 206;
select * from employees;

rollback;

--delete
delete from departments
where department_name = 'Finance';

delete from employees
where department_id = 
                    (
                    select department_id
                    from departments
                    where department_name like '%Public%');

rollback;

--table delete & truncate 테이블 데이터 삭제
select *
from sales_reps;
--table에서 delete => 데이터만 삭제
delete from sales_reps;

rollback;
--table에서 truncate => 데이터와 데이터 보관하는 공간까지 삭제
truncate table sales_reps;


insert into sales_reps
select employee_id, last_name, salary, commission_pct
from employees
where job_id like '%REP%';

select * from sales_reps;
commit;

delete from sales_reps
where id= 174;

savepoint sp1;

delete from sales_reps
where id=202;

rollback to sp1;

rollback;

--ddl
select table_name
from user_tables;

select distinct object_type
from user_objects;

select distinct *
from user_objects;

select *
from user_catalog;

create table dept(
    dept_no number(2),
    dname varchar2(14),
    loc varchar2(13),
    create_date DATE DEFAULT sysdate);
drop table dept;    

desc dept;

insert into dept(dept_no,dname,loc) values(1,'또치','예담');

select *
from dept;

create table dept30
AS
--복사할때 표현식은 못 쓰기 때문에 엘리어스로 기본값명을 넣어준다
select employee_id, last_name, salary*12 AS salary, hire_date
from employees
where department_id = 50;

select * from dept30;

desc employees;

desc dept30;

drop table dept;

drop table dept30;

--alter table ~ add[추가]|modify[변경]|drop[버림]|set unused[숨김]

alter table dept30
add (job varchar2(20));

desc dept30;

alter table dept30
modify (job number);

insert into dept30 values(1,'또치',2000,sysdate,123);

select *
from dept30;

alter table dept30
modify (job varchar2(40));

delete from dept30
where job = 123;

alter table dept30
drop column job;

desc dept30;

alter table dept30
set unused (salary);

select *
from dept30;
--drop unused columns 디스크에서도 완전히 해제
alter table dept30
drop unused columns;

--drop table 모든 데이터 및 관련된 인덱스도 모두 삭제
--해당 테이블을 생성한 사용자와 drop any table 권한을 가져야 제거가능

--rename
rename dept30 to dept100;

select *
from dept30;

select *
from dept100;

comment on table dept100
is 'this is dept100';

select *
from user_tab_comments
where table_name='DEPT100';

comment on column dept100.employee_id is 'this is employee_id';

select *
from user_col_comments
where table_name='DEPT100';

select * from dept100;

truncate table dept100;

rollback;

--알쓸잡
--delete 데이터만 지움 truncate 데이터, 메모리도 지움
--UNDO에 데이터 삭제 시 데이터가 존재했던 장소와 데이터를 보관하는 보관함
--rollback하면 REDO에서 해당하는 위치에 데이터를 다시 가져감
--truncate는 위치자체를 없애버리기 때문에 복구 불가

drop table dept100;

insert into departments (department_id, department_name)
values (30,'Purchasing');

insert into departments values(100, 'Finance',NULL,NULL);

select *
from departments;

commit;

select *
from sales_reps;

insert into sales_reps
select employee_id, last_name, salary, commission_pct
from employees
where job_id like '%REP%';

select *
from sales_reps;

commit;

select *
from employees;

update employees
set salary = salary*1.1
where employee_id=104;
--현재 실행문을 사용자가 취소요청함
--대기 걸어두면 기존 트랜잭션 종료 후 알아서 실행 됨
rollback;

select *
from user_constraints;

--기본키(pk) 기본값 열을 포함하는 테이블 생성

drop table board;

create table dept(
deptno number(2) primary key,--기본키
dname varchar2(14),
loc varchar2(13),
create_date DATE default sysdate);--기본값을 가지는 열(즉 column)

desc dept;

insert into dept (deptno, dname)
values(10,'기획부'); --기본 값을 가지는 열에 데이터가 자동 입력

select *
from dept;

insert into dept values(20,'영업부','서울','23/02/15');

delete from dept
where deptno=1;

commit;

select *
from dept;

--여러가지 제약조건을 포함하는 테이블 생성
drop table emp;
--column level constraint
create table emp(
                empno number(6) primary key, --기본키 제약 조건
                ename varchar2(25) not null, --not null 제약 조건
                email varchar2(50) constraint emp_mail_nn not null constraint emp_mail_uk unique, --not null 제약조건 추가 및 이름 부여, unique제약조건 부여 및 제약조건의이름 부여
                phone_no char(11) not null,
                job varchar2(20),
                salary number(8) check(salary>2000), --check 제약조건 2000보다 큰 데이터가 들어와야 입력 가능
                deptno number(4) references dept(deptno)); --foreign key 제약조건, dept테이블에 있는 no만 column 참조해서 데이터 입력.
       --즉 deptno 10과 20만 가능
desc emp;
drop table emp;

--table level constraint
create table emp(
                empno number(6),
                ename varchar2(25)constraint emp_ename_nn not null,
                email varchar2(50)constraint emp_email_non not null,
                phone_no char(11)constraint emp_phone_no_nn not null,
                job varchar2(20),
                salary number(8),
                deptno number(4),
                constraint emp_empno_pk primary key(empno),
                constraint emp_email_un unique(email),
                constraint emp_salary_ck check(salary>2000),
                constraint emp_deptno_fk foreign key(deptno)
                references dept(deptno)
                ); --foreign key 제약조건, dept테이블에 있는 no만 column 참조해서 데이터 입력.
--email unique nn두개가 중복
select constraint_name, constraint_type, search_condition
from user_constraints
where table_name='EMP';

select cc.column_name, c.constraint_name
from user_constraints c join user_cons_columns cc
on (c.constraint_name=cc.constraint_name)
where c.table_name='EMP';

--column level에서 constaints 줄 경우 sys_~~~라는 이름을 default로 줌
select table_name, index_name
from user_indexes
where table_name in('DEPT','EMP');

--dml 수행하며 제약조건 테스트 하기

insert into emp values(null, '또치', 'ddochikim@naver.com','01023456789','회사원',3500,null);

insert into emp values(1234, '또치', 'ddochikim@naver.com','01023456789','회사원',3500,null);

insert into emp values(1233,'희동','heeeedong@naver.com','01054359875',null,1800,20);

insert into emp values(1233,'희동','heeeedong@naver.com','01054359875',null,7800,20);

commit;

select *
from emp;

--update
--외래키 조건 미충족 오류
update emp
set deptno=30
where empno = 1234;

update emp --(업데이트할 테이블 명)
set deptno=10 --줄 데이터(=변경할 데이터)
where empno = 1234; --조건

select *
from emp;

select *
from dept;

--제약 조건 추가 제거 삭제
--alter table ~ add|modify(nn)[nn추가만 가능]||drop[cascade]|disable 제약 조건은 modify가 불가능해서 drop시켜서 없애고 다시 만들어야함
alter table emp
add constraint emp_job_uk unique(job);

insert into emp
values(1200,'길동','gildong@naver.com','01054359875','회사원',5000,20);

alter table emp
modify (salary number not null);

insert into emp
values(1200,'길동','gildong@naver.com','01054359875','회사원',null,20);

alter table emp
drop constraint emp_job_uk;

insert into emp
values(1200,'길동','gildong@naver.com','01054359875','회사원',5400,20);

select *
from emp;