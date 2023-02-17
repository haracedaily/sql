--�������� ����

create sequence dept_deptid_seq
        increment by 10
        start with 200
        maxvalue 9999
        nocache
        nocycle;
        
--���ʿ� �ѹ��϶� currval ��� �����Ͱ� ���� ������ nextval �� �ڿ� ���� ����(=�� ���� start with data)
--nextval���� currval�� ��µȴ�.
insert into departments(department_id, department_name, location_id)
values(dept_deptid_seq.nextval, 'support',2500);

select * from departments;

rollback;

insert into departments(department_id, department_name, location_id)
values(dept_deptid_seq.nextval, 'support',2500);
--sequence�� �ѹ���ѵ� �ʱ�ȭ ���� ����<- 
select * from departments;
commit;

--1> sequence Ȱ���ؼ� �Խ��� �� ��ȣ
--���������� �۹�ȣ �Է� ����<-���������� ���� ��� �ǵ����� ������  ���� �������� ��ȣ�� ������ x [why? ����� �����Ͷ� ������ �������� ��� ������] �� ��� ���� ��ȣ�� ��������
--���� -> ���������� �־ ������ �þ
--2> insert �׷��Լ� Ȱ���ؼ� �Է�
--�׷��Լ��� ����ϰ� �Ǹ� �˾Ƽ� ��ȣ�� ����� �Խ��� ��ȣ ����
--������ -> ���������� ����

--������ ����
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

--���Ǿ�
select * from dept_sum_vu;

create synonym d_sum
for dept_sum_vu;

select * from d_sum;

--���Ǿ� ���� ������ ��ųʸ�(user_~) ����
select * from user_synonyms;
select synonym_name, table_owner, table_name
from user_synonyms;

drop synonym d_sum;

--�ǽ� ����
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
--column�� �����ű涧 ���; �����ű�⸸ �� ����...
select rownum, employee_id, salary, hire_date, department_id
from employees;


--with�� ��inline view�� ���, ������ ���̺� ���鶧 ���
with example as
( select 'with��' as str1
from dual)
select * from example;
--�������� -> inline view�� ���
with example as(
select employee_id, salary, hire_date
from employees)
select * from example;
--with�� ������ sql������ ��Ͽ� �ݺ������� ���ö�
with example as
( select 'with��' as str1
from dual)
select * from example;
--�������� -> inline view�� ���
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


--rank() over() ��ŷ�� �ű��;
--�⺻����
select rank() over(order by salary) AS �޿���, last_name--�������� ����//�ߺ��Ǹ� �ߺ��ȸ�ŭ �����ϰ� ���������� ����
from employees;

select rank() over(order by hire_date) AS �Ի��, last_name
from employees;

--dense_rank() over() �ߺ� ���� ���� //�������� ����//������ �ߺ��Ǿ ���������� ����
select dense_rank() over(order by salary) AS �޿���, last_name, salary
from employees;

--row_number() over() �������� ����//�׳� ���������� ��� ������
select row_number() over(order by salary) as �޿���, last_name, salary
from employees;

--rank over() -> �׷� �Լ� ������ rank over|| partition by(��group by)
select rank() over(partition by department_id order by salary) as �μ����޿���, last_name, salary,department_id
from employees;

select dense_rank() over(partition by department_id order by salary) as �μ����޿���, last_name, salary,department_id
from employees;


--������ ���
--undotbs ->������ ������ �����ϴ� ����
--drop table employees -> �ڵ� Ŀ�� ����,
--���������� �̵�
create table temp(
id number(1));

drop table temp;

select * from user_recyclebin
where original_name='TEMP';

--������ ����
purge recyclebin;

--�����뿡�� �����ϱ�(flashback table "object_name" to before drop;)
flashback table "BIN$BK1bi5J0QHmMnK1etfpz2g==$0" to before drop;

select * from temp;
--��ȸ �ϱ�
--���̺� ��ȸ
select * from tab;
--������ Ȯ��
show recyclebin;
--table ���� ����
drop table temp purge;
select* from temp;
show recyclebin;

