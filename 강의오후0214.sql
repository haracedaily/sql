Create Table emp(
emp_id number,
emp_name varchar2(10),
mgr number,
sal number,
dept_id number,
hire_date Date
);

Drop table emp;
--1) insert 문 2가지 형태
--insert column 쓰지 않을 경우; 모든 데이터 한번에 다 넣어줘야함
insert into emp values (1,'김또치',100,24000,10);
select *
from emp;


--insert column 쓴 경우
--데이터 지정해서 넣을 수 있음, 안 넣은 속성(column)엔 (null)이 대입됨.
insert into emp(emp_id, emp_name, sal)
values (2,'고희동',3000);

select *
from emp;

--insert 할때 Null값 기입 하는 방법
desc emp;
insert into emp values (1,'김또치',100,24000,10,null);
insert into emp values (2,'고희동',100,24000,10,sysdate);

select to_char(hire_date, 'yyyy/mm/dd hh24:mi:ss day')
from emp;

--delete where절 사용할 경우 해당하는 조건문들 삭제
delete from emp
where emp_id=2;
--where절 없이 delete시 해당 table 모든 데이터 삭제
delete from emp;

--delete from emp
--where emp_id=(select emp_id
--                from emp
--                where   );

--update delete와 insert 반반
select *
from emp;
--update문에서 where 사용하였을 경우
update emp
set emp_name = '도우너'
where emp_id=1;
--update문에서 where 사용 안 했을때
update emp
set emp_id = 1000;

--update문 깜짝 퀴즈
--emp 테이블에서 dept_id 모두 11로 바꾸는데
--dept_id=11말고 다른 방법으로 update 해보세요
update emp
set dept_id=11;

update emp
set dept_id=(dept_id+1);
select *
from emp;

--게시판 번호 설정
create table board(
board_no number,
board_content varchar2(200));

insert into board values(1,'1번게시물');
insert into board values(2,'2번게시물');
insert into board values(3,'3번게시물');
insert into board values(4,'4번게시물');
insert into board values(5,'5번게시물');
insert into board values(6,'6번게시물');
insert into board values(7,'7번게시물');
insert into board values(8,'8번게시물');

drop table board;

select *
from board;
--게시판 삭제
delete from board
where board_no=4;
--게시판 삭제한 내용을 기준으로 번호 재정령
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
--게시판 데이터 입력할 때 값을 부여하는게 아니라 번호를 생성해서 입력
insert into board values(board_no+1,board_no+1||'번 게시물');
----pl/sql pl sql에서 반복문
--declare
--begin
--loop
--insert into ~ values(~~~~)
--end
--end/