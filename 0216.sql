create table market(
marketNO number(5) primary key,
market_name varchar2(10),
address varchar2(50),
phone char(13),
sales number(6) check(sales>1000));

desc market;

create table product(
productNo number(4),
product_name varchar2(10),
product_sale number(5) check(product_sale>100),
keep_tem varchar2(4) check(keep_tem>'0' and keep_tem like '%C'or keep_tem like '%F' and keep_tem<'0'),
marketNO number(5) references market(marketNO));

--create table product(
--productNo number(4),
--product_name varchar2(10),
--product_sale number(5) check(product_sale>100),
--keep_tem varchar2(4) check((case when keep_tem>'0' then keep_tem||'C' when keep_tem<'0' then keep_tem||'F' end)),
--marketNO number(5) references market(marketNO));

drop table product;
insert into market values(10,'집','대구','0531234567',5000);
insert into product values(12,'까까',1200,'25C',10);
insert into product values(12,'까까',1200,'-25F',10);

select *
from market;

select *
from product;


drop table store;

alter table store add constraints sotre_id primary key;

insert into store values(12345,'털보네 슈퍼','대구시 중구 중앙대로 403','053-1234-1234',1000);

insert into store values(54321,'tulbo＇s market','대구시 중구 중앙대로 403','053-1234-1234',0);

select *
from store;



insert into prod values(1000,'귤',2000,'C',12345);
insert into prod values(1001,'사과',3000,'C',12345);
insert into prod values(1002,'고등어',4000,'C',12345);
insert into prod values(1003,'만두',10000,'F',12345);
insert into prod values(1004,'얼음',500,'F',12345);

select *
from prod
order by 1;

insert into prod values(1005,'꼬깔콘',2000,'C',55555);

select *
from user_constraints
where table_name = 'PROD';

select *
from user_constraints
where table_name = 'PRODUCT';

select cc.column_name, c.constraint_name, c.search_condition
from user_constraints c join user_cons_columns cc
on(c.constraint_name = cc.constraint_name)
where c.table_name = 'PROD';

select *
from user;
--회원 테이블
create table m_user(
muser_id varchar2(15) primary key,
muser_name varchar2(9) not null,
muser_pw varchar2(10)not null,
store_id number(5),
constraints sotre_sotre_id_fk foreign key (store_id) references store(store_id)
);
drop table m_user;
--장바구니 테이블
create table morder(
morder_no varchar2(10) primary key,
prod_id number(4) constraint prod_prod_id_fk references prod(prod_id),
prod_ea number(1),
store_id number(5) constraint store_store_id_fk references store(store_id),
muser_id varchar2(15) constraint m_user_muser_id_fk references m_user(muser_id),
morder_develop char(1) default 'R' check(morder_develop in ('R','D','F'))
);
drop table morder;
insert into m_user values('123','김또치','12345',12345);

--빈칸으로 입력해도 default값은 들어가지지 않음
insert into morder values('a123',1000,3,12345,'123','');

--이렇게 설정해서 넣는 방식 외엔 안되나..?
insert into morder(morder_no,prod_id,prod_ea,store_id,muser_id)
values('a123',1000,2,12345,'123');

delete from morder
where morder_no='a123';

select * from store;
select * from prod;
select * from morder;
select * from m_user;

select *
from user_constraints
where table_name = 'M_USER';

select *
from user_constraints
where table_name = 'MORDER';


select * from user_cons_columns where table_name = 'MORDER';

select cc.constraint_name, c.column_name, cc.search_condition
from user_constraints cc join user_cons_columns c
on c.constraint_name=cc.constraint_name
where cc.table_name = 'MORDER';

insert into member values('yedam001','또치','yedam001',12345);

insert into member values('yedam002','희동','yedam002',12345);

insert into member values('yedam003','길동','yedam003',12345);

select * from member;

insert into cart values('cart0001',1000,9,12345,'yedam001','R');
insert into cart values('cart0002',1001,5,12345,'yedam002','D');
insert into cart values('cart0003',1002,3,12345,'yedam003','F');
insert into cart values('cart0004',1003,2,12345,'yedam001','R');
insert into cart values('cart0005',1004,6,12345,'yedam002','D');
insert into cart values('cart0006',1004,3,12345,'yedam003','F');
insert into cart values('cart0007',1000,4,12345,'yedam001','R');
insert into cart values('cart0008',1001,3,12345,'yedam002','F');
insert into cart values('cart0009',1002,6,12345,'yedam003','F');
insert into cart values('cart0010',1003,5,12345,'yedam001','R');
insert into cart values('cart0011',1000,9,12345,'yedam001','R');
insert into cart values('cart0012',1001,5,12345,'yedam002','D');
insert into cart values('cart0013',1002,3,12345,'yedam003','F');
insert into cart values('cart0014',1003,2,12345,'yedam001','R');
insert into cart values('cart0015',1004,6,12345,'yedam002','D');
insert into cart values('cart0016',1004,3,12345,'yedam003','F');
insert into cart values('cart0017',1000,4,12345,'yedam001','R');
insert into cart values('cart0018',1001,3,12345,'yedam002','F');
insert into cart values('cart0019',1002,6,12345,'yedam003','F');
insert into cart values('cart0020',1003,5,12345,'yedam001','R');
delete from cart;
select *
from cart;
--문제1
select * from store where store_id = 12345;

--풀이
select * from store where store_id = 12345;

--문제2
select store_name, store_sales,prod_name
from store s join prod p
on s.store_id=p.store_id
where s.store_id=12345;

--풀이
select store_name, store_sales, prod_name from store e join prod p on e.store_id=p.store_id) where e.store_id=12345;

--문제3
select cart_id, cart_count, prod_name, (cart_count*prod_price), delivery_status
from cart c left outer join prod p
on c.prod_id=p.prod_id
where c.store_id=12345
order by 1;

--풀이
select cart_id, cart_count, prod_name, (cart_count*prod_price), 
case when delivery_status='R' then '배송 전' when delivery_status='D' then '배송 중' when delivery_status='F' then '배송 완료' end "배송상태" from cart c join prod p on c.prod_id=p.prod_id where c.store_id=(select store_id from store where store_name='털보네 슈퍼');
--문제4
select cart_id, cart_count, prod_name, (cart_count*prod_price), delivery_status
from cart c left outer join prod p
on c.prod_id=p.prod_id
where c.member_id='yedam001';

--풀이
select cart_id, cart_count, prod_name, (cart_count*prod_price), case when delivery_status='R' then '배송 전' when delivery_status='D' then '배송 중' when delivery_status='F' then '배송 완료' end "배송상태" from cart c join prod p on c.prod_id=p.prod_id where c.member_id=(select member_id from member where member_name='또치');
--문제5+풀이
select NVL(sum(cart_count),0) 귤개수
from cart
where prod_id=(select prod_id
from prod
where prod_name='귤');

delete from prod
where prod_id=100;

select sum(cart_count), p.prod_name
from cart c join prod p
on c.prod_id=p.prod_id
where prod_name='귤'
group by p.prod_name;

--and c.delivery_status <> 'F';

--장바구니 누르면 insert기능이 켜지게끔 구현해야함;어떤 방법? ajar로 통신해서<< 이건 결제나 타 프로그램 가져올때 씀[강의 들어볼때까지 keep]

--view(보여주고 싶은 데이터);접근성 차이
--데이터 접근을 접속하는 사람에 따라서 차이를 둘 수 있다.
--복잡한 쿼리를 쉽게 쓴다.
--AS는 복사하는 거
create view empvu80
AS
    select employee_id, last_name, salary
    from employees
    where department_id = 80;

select * from empvu80;

create view salvu80
AS
    select employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY
    from employees
    where department_id = 50;
    
select * from salvu80;

desc empvu80;
desc salvu80;

--뷰와 복사된 테이블 비교
select * from employees;
update employees
set salary=salary*1.1;

--employees의 데이터를 조회해서 실행시켜 준다-> 데이터가 변경됨
select* from empvu80;
select * from salvu80;

rollback;

--뷰 관련 데이터 딕셔너리 정보 확인
select view_name, text
from user_views;

--뷰 수정하기
create or replace view salvu50
AS
    select employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY, hire_date
    from employees
    where department_id=50;
    --rollback 안먹히기 때문에 사용할때 항상 고민해보고 사용할 것<-기존 데이터 날아감
select * from salvu50;

--simple view [단순 뷰-하나의 테이블로 만듬] || complex view [복합 뷰-하나 이상의 테이블로 만듬]
create or replace view dept_sum_vu (name, minsal, maxsal, avgsal)
as 
    select d.department_name, min(e.salary),max(e.salary),trunc(avg(e.salary))
    from employees e join departments d
    on e.department_id = d.department_id
    group by d.department_name;

select * from dept_sum_vu;

--with check option의 차이

--with check option 미사용
create or replace view empvu80
AS 
    select employee_id, last_name, salary, department_id
    from employees
    where department_id=80;
select * from empvu80;

update empvu80 set salary =9800 where employee_id=176;
select * from empvu80;
select employee_id,salary from employees where employee_id=176;
rollback;

--with check option 사용
create or replace view empvu80
AS 
    select employee_id, last_name, salary, department_id
    from employees
    where department_id=80
    with check option;

--범위 안의 데이터를 범위 밖으로 보내는 쿼리문 => 안됨
update empvu80 set department_id=50 where employee_id=176;

select * from empvu80;
--범위 안의 데이터를 범위 안에 속하는 한도 내에서의 업데이트
update empvu80 set salary=9800 where employee_id=176;
select employee_id, salary from employees where employee_id=176;
rollback;

--with read only옵션
create or replace view empvu80
AS 
    select employee_id, last_name, salary, department_id
    from employees
    where department_id=80
    with read only;
--read only를 넣어둔 뷰는 dml 실행이 불가능
update empvu80 set salary = 9800 where employee_id = 176;

--뷰 삭제

select view_name, text from user_views;

drop view empvu80;

--drop view salvu80;
--drop view salvu50;
--drop view dept_sum_vu;

select * from empvu80;

--자동 INDEX
drop table emp;

create table emp(
empno number(6) primary key,
ename varchar2(25) not null,
email varchar2(50) not null unique,
phone_no char(11) not null,
job varchar2(20),
salary number(8),
deptno number(4));

select constraint_name, constraint_type, search_condition
from user_constraints
where table_name = 'EMP';

select table_name, index_name
from user_indexes
where table_name = 'EMP';

select cc.column_name, c.constraint_name
from user_constraints c join user_cons_columns cc
on c.constraint_name= cc.constraint_name
where c.table_name= 'EMP';

--수동 index 생성
create index emp_ename_idx on emp(ename);

select table_name, index_name
from user_indexes
where table_name = 'EMP';

--인덱스 삭제

--자동 인덱스 삭제
drop index SYS_C007254;--안됨; 인덱스를 삭제하는 대신 제약조건을 삭제하라는 구문이 나옴

--수동 인덱스 삭제
drop index emp_ename_idx; --됨