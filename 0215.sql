--�Խ��� ����
delete board
where board_no=5;

select *
from board;
--�Խ��� ������ ������ �������� ��ȣ ������
update board
set board_no=board_no-1
where board_no>5;

update board
set board_content = (select b.max(board_no) from board b, board a where a.board_no<b.board_no)||'���Խù�';
--�Խ��� ����
select count(*)+1
from board;

insert into board values((select count(*)+1
                        from board),(select count(*)+1
from board)||'�� �Խù�');

select *
from board
order by 1;

commit;

--insert ������ ���� transaction

insert into departments values(70,'Public Relations',100,1700);
select *
from departments;

rollback;

commit;

--�ٸ� ���̺�� row ����
create table sales_reps
AS
select employee_id id, last_name name, salary, commission_pct
from employees;

select *
from sales_reps;

--commit; ���� �ʾƵ� create�� db ��ɾ�� �ڵ�Ŀ�ԵǾ���
--insert �� => ġȯ���� ���
insert into departments (department_id, department_name, location_id)
values(&department_id, '&department_name', &location);
select *
from departments;
--&�Է� ����, &&������

--update ������ Ȱ���� transaction

update employees
set salary = 7000;

select *
from employees;

rollback;

update employees
set salary = 7000
where employee_id=104;

--transaction ����
rollback;

select *
from employees;

--���������� ����� update
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

--table delete & truncate ���̺� ������ ����
select *
from sales_reps;
--table���� delete => �����͸� ����
delete from sales_reps;

rollback;
--table���� truncate => �����Ϳ� ������ �����ϴ� �������� ����
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

insert into dept(dept_no,dname,loc) values(1,'��ġ','����');

select *
from dept;

create table dept30
AS
--�����Ҷ� ǥ������ �� ���� ������ ������� �⺻������ �־��ش�
select employee_id, last_name, salary*12 AS salary, hire_date
from employees
where department_id = 50;

select * from dept30;

desc employees;

desc dept30;

drop table dept;

drop table dept30;

--alter table ~ add[�߰�]|modify[����]|drop[����]|set unused[����]

alter table dept30
add (job varchar2(20));

desc dept30;

alter table dept30
modify (job number);

insert into dept30 values(1,'��ġ',2000,sysdate,123);

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
--drop unused columns ��ũ������ ������ ����
alter table dept30
drop unused columns;

--drop table ��� ������ �� ���õ� �ε����� ��� ����
--�ش� ���̺��� ������ ����ڿ� drop any table ������ ������ ���Ű���

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

--�˾���
--delete �����͸� ���� truncate ������, �޸𸮵� ����
--UNDO�� ������ ���� �� �����Ͱ� �����ߴ� ��ҿ� �����͸� �����ϴ� ������
--rollback�ϸ� REDO���� �ش��ϴ� ��ġ�� �����͸� �ٽ� ������
--truncate�� ��ġ��ü�� ���ֹ����� ������ ���� �Ұ�

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
--���� ���๮�� ����ڰ� ��ҿ�û��
--��� �ɾ�θ� ���� Ʈ����� ���� �� �˾Ƽ� ���� ��
rollback;

select *
from user_constraints;

--�⺻Ű(pk) �⺻�� ���� �����ϴ� ���̺� ����

drop table board;

create table dept(
deptno number(2) primary key,--�⺻Ű
dname varchar2(14),
loc varchar2(13),
create_date DATE default sysdate);--�⺻���� ������ ��(�� column)

desc dept;

insert into dept (deptno, dname)
values(10,'��ȹ��'); --�⺻ ���� ������ ���� �����Ͱ� �ڵ� �Է�

select *
from dept;

insert into dept values(20,'������','����','23/02/15');

delete from dept
where deptno=1;

commit;

select *
from dept;

--�������� ���������� �����ϴ� ���̺� ����
drop table emp;
--column level constraint
create table emp(
                empno number(6) primary key, --�⺻Ű ���� ����
                ename varchar2(25) not null, --not null ���� ����
                email varchar2(50) constraint emp_mail_nn not null constraint emp_mail_uk unique, --not null �������� �߰� �� �̸� �ο�, unique�������� �ο� �� �����������̸� �ο�
                phone_no char(11) not null,
                job varchar2(20),
                salary number(8) check(salary>2000), --check �������� 2000���� ū �����Ͱ� ���;� �Է� ����
                deptno number(4) references dept(deptno)); --foreign key ��������, dept���̺� �ִ� no�� column �����ؼ� ������ �Է�.
       --�� deptno 10�� 20�� ����
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
                ); --foreign key ��������, dept���̺� �ִ� no�� column �����ؼ� ������ �Է�.
--email unique nn�ΰ��� �ߺ�
select constraint_name, constraint_type, search_condition
from user_constraints
where table_name='EMP';

select cc.column_name, c.constraint_name
from user_constraints c join user_cons_columns cc
on (c.constraint_name=cc.constraint_name)
where c.table_name='EMP';

--column level���� constaints �� ��� sys_~~~��� �̸��� default�� ��
select table_name, index_name
from user_indexes
where table_name in('DEPT','EMP');

--dml �����ϸ� �������� �׽�Ʈ �ϱ�

insert into emp values(null, '��ġ', 'ddochikim@naver.com','01023456789','ȸ���',3500,null);

insert into emp values(1234, '��ġ', 'ddochikim@naver.com','01023456789','ȸ���',3500,null);

insert into emp values(1233,'��','heeeedong@naver.com','01054359875',null,1800,20);

insert into emp values(1233,'��','heeeedong@naver.com','01054359875',null,7800,20);

commit;

select *
from emp;

--update
--�ܷ�Ű ���� ������ ����
update emp
set deptno=30
where empno = 1234;

update emp --(������Ʈ�� ���̺� ��)
set deptno=10 --�� ������(=������ ������)
where empno = 1234; --����

select *
from emp;

select *
from dept;

--���� ���� �߰� ���� ����
--alter table ~ add|modify(nn)[nn�߰��� ����]||drop[cascade]|disable ���� ������ modify�� �Ұ����ؼ� drop���Ѽ� ���ְ� �ٽ� ��������
alter table emp
add constraint emp_job_uk unique(job);

insert into emp
values(1200,'�浿','gildong@naver.com','01054359875','ȸ���',5000,20);

alter table emp
modify (salary number not null);

insert into emp
values(1200,'�浿','gildong@naver.com','01054359875','ȸ���',null,20);

alter table emp
drop constraint emp_job_uk;

insert into emp
values(1200,'�浿','gildong@naver.com','01054359875','ȸ���',5400,20);

select *
from emp;