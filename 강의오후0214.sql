Create Table emp(
emp_id number,
emp_name varchar2(10),
mgr number,
sal number,
dept_id number,
hire_date Date
);

Drop table emp;
--1) insert �� 2���� ����
--insert column ���� ���� ���; ��� ������ �ѹ��� �� �־������
insert into emp values (1,'���ġ',100,24000,10);
select *
from emp;


--insert column �� ���
--������ �����ؼ� ���� �� ����, �� ���� �Ӽ�(column)�� (null)�� ���Ե�.
insert into emp(emp_id, emp_name, sal)
values (2,'����',3000);

select *
from emp;

--insert �Ҷ� Null�� ���� �ϴ� ���
desc emp;
insert into emp values (1,'���ġ',100,24000,10,null);
insert into emp values (2,'����',100,24000,10,sysdate);

select to_char(hire_date, 'yyyy/mm/dd hh24:mi:ss day')
from emp;

--delete where�� ����� ��� �ش��ϴ� ���ǹ��� ����
delete from emp
where emp_id=2;
--where�� ���� delete�� �ش� table ��� ������ ����
delete from emp;

--delete from emp
--where emp_id=(select emp_id
--                from emp
--                where   );

--update delete�� insert �ݹ�
select *
from emp;
--update������ where ����Ͽ��� ���
update emp
set emp_name = '�����'
where emp_id=1;
--update������ where ��� �� ������
update emp
set emp_id = 1000;

--update�� ��¦ ����
--emp ���̺��� dept_id ��� 11�� �ٲٴµ�
--dept_id=11���� �ٸ� ������� update �غ�����
update emp
set dept_id=11;

update emp
set dept_id=(dept_id+1);
select *
from emp;

--�Խ��� ��ȣ ����
create table board(
board_no number,
board_content varchar2(200));

insert into board values(1,'1���Խù�');
insert into board values(2,'2���Խù�');
insert into board values(3,'3���Խù�');
insert into board values(4,'4���Խù�');
insert into board values(5,'5���Խù�');
insert into board values(6,'6���Խù�');
insert into board values(7,'7���Խù�');
insert into board values(8,'8���Խù�');

drop table board;

select *
from board;
--�Խ��� ����
delete from board
where board_no=4;
--�Խ��� ������ ������ �������� ��ȣ ������
select board_no
from board_no
where board_no=(select board_no+1
                from board
                where board_no=board_no-1);

update board
set board_no = (select board_no+1
                from board
                where board_no=board_no-1)
where board_no=4;
rollback;
--�Խ��� ������ �Է��� �� ���� �ο��ϴ°� �ƴ϶� ��ȣ�� �����ؼ� �Է�
insert into board values(board_no+1,board_no+1||'�� �Խù�');
----pl/sql pl sql���� �ݺ���
--declare
--begin
--loop
--insert into ~ values(~~~~)
--end
--end/