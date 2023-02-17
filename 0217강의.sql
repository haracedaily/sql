--정규화 -> 이상현상 해결하기 위해서 사용하는 기법
--각각 테이블로 나눠서 데이터를 저장.
--3NF 까지 한것

create table rest(
rest_name varchar2(30) not null,
rest_id number(10) primary key,
rest_cate varchar2(18) not null,
rest_salse number(20) not null
);
--sales = 매출
--price = 가격
create table menu(
rest_id number(10) constraint rest_rest_id_fk references rest(rest_id),
menu_id number(10) primary key,
menu_name varchar2(30) not null,
menu_price number(10) check (menu_price>1000)
);

create table ingre(
rest_id number(10) constraint rest_restid_fk references rest(rest_id),
menu_id number(10) constraint menu_menu_id_fk references menu(menu_id),
ingre_name varchar2(27) not null,
ingre_price number(10) not null,
ingre_count number(3)
);
drop table ingre;
create sequence rest_seq
    increment by 1
    start with 10000
    maxvalue 9999999999
    minvalue 1
    nocache
    nocycle;

insert into rest values('또치네 레스토랑', rest_seq.nextval,'레스토랑',15000);
select * from rest;
insert into menu values(10000,0000000000,'등심스테이크',82000);
insert into ingre values(10000,0000000000,'홀스타인등심 500g',13500,1);

insert into rest values('털보네 중식당',rest_seq.nextval,'중식당',3000);
insert into menu values(10001,0000000100,'짜장면',8000);
insert into ingre values(10001,0000000100,'밀가루 300g', 1200,1);
insert into ingre values(10001,0000000100,'춘장 100g', 600,1);

insert into rest values('만재네',rest_seq.nextval,'고기집',10000000);
insert into rest values('제주알곤칼국수',rest_seq.nextval,'국수',5000000);
insert into rest values('마라탕',rest_seq.nextval,'중식',60000000);
insert into rest values('대구만두',rest_seq.nextval,'만두',40000000);
--만재네
insert into menu values(10002,1000,'삼겹살',14000);
insert into menu values(10002,1001,'목살',11000);
insert into menu values(10002,1002,'항정살',15000);

--제주알곤칼국수
insert into menu values(10003,10000,'고기칼국수',9900);

--마라탕
insert into menu values(10004,100000,'마라탕', 12000);
insert into menu values(10004,100001,'마라샹궈', 15000);

--대구만두
insert into menu values(10005,1000000,'만두동',9900);
insert into menu values(10005,1000001,'비빔우동',5000);
insert into menu values(10005,1000002,'탕수만두',6000);
insert into menu values(10005,1000003,'비빔만두',7000);

insert into ingre values(10002,1000,'양파',5000,10);
insert into ingre values(10002,1000,'파',2000,20);
insert into ingre values(10002,1000,'고기',10000,50);
insert into ingre values(10002,1001,'양파',5000,10);
insert into ingre values(10002,1001,'파',2000,20);
insert into ingre values(10002,1001,'고기',8000,50);
insert into ingre values(10002,1002,'양파',5000,10);
insert into ingre values(10002,1002,'파',2000,20);
insert into ingre values(10002,1002,'고기',12000,50);

insert into ingre values(10003,10000,'고기',4000,50);

insert into ingre values(10004,100000,'고기',6000,50);
insert into ingre values(10004,100000,'해산물',3000,15);
insert into ingre values(10004,100000,'당근',1500,12);
insert into ingre values(10004,100000,'두부',500,18);
insert into ingre values(10004,100001,'고기',7000,50);
insert into ingre values(10004,100001,'해산물',3500,15);
insert into ingre values(10004,100001,'두부',500,18);
insert into ingre values(10004,100001,'부추',6000,36);

insert into ingre values(10005,1000000,'고기',7000,50);
insert into ingre values(10005,1000000,'쪽파',1000,25);
insert into ingre values(10005,1000000,'두부',500,18);
insert into ingre values(10005,1000000,'김치',1000,22);
insert into ingre values(10005,1000000,'부추',6000,36);
insert into ingre values(10005,1000000,'마늘',5000,59);
select * from ingre where menu_id=1000003;
delete ingre where menu_id=1000000;
insert into ingre values(10005,1000001,'쪽파',1000,25);
insert into ingre values(10005,1000001,'두부',500,18);
insert into ingre values(10005,1000001,'김치',1000,22);
insert into ingre values(10005,1000001,'부추',6000,36);
insert into ingre values(10005,1000001,'마늘',5000,59);

insert into ingre values(10005,1000002,'고기',6500,40);
insert into ingre values(10005,1000002,'쪽파',1000,25);
insert into ingre values(10005,1000002,'두부',500,18);
insert into ingre values(10005,1000002,'부추',6000,36);
insert into ingre values(10005,1000002,'마늘',5000,59);

insert into ingre values(10005,1000003,'고기',5000,30);
insert into ingre values(10005,1000003,'쪽파',1000,10);
insert into ingre values(10005,1000003,'두부',500,9);
insert into ingre values(10005,1000003,'부추',6000,22);
insert into ingre values(10005,1000003,'마늘',5000,30);
insert into ingre values(10005,1000003,'김치',900,16);
select * from ingre;
update menu
set menu_price = (select (
select* from user_sequences where sequence_name = 'REST_SEQ';
select * from user_constraints where table_name='INGRE';
select * from rest;
select * from menu;
select * from ingre;
select * from ingre where menu_id=100;


commit;

--반정규화 <<-테이블이 너무 많아질 경우 join이 많아져서 퍼포먼스하락 막기 위해 시행
update rest set rest_sales = (select (menu_price*ingre_count)
                                from menu m join ingre i
                                using(menu_id)
                                where i.rest_id=10000)
where rest_id=10000;

select (menu_price*ingre_count)
                                from menu m join ingre i
                                using(menu_id)
                                where i.rest_id=10001;
                                
--문제1                                
select * from rest;

--문제2
select rest_name, rest_cate, ingre_name,ingre_price
from rest join ingre
using(rest_id);

--문제3
select rank() over(order by rest_salse desc) "가게별 매출순위",rest_salse,rest_name
from rest;

--문제4
select rank() over(partition by rest_cate order by rest_salse desc) "카테고리별 매출순위",rest_salse,rest_name
from rest;

--문제5
select rest_name, menu_name, menu_price
from rest join menu
using(rest_id);

--문제6
with menuPan AS(
select menu_price, rest_name,menu_name
from rest s join menu m
using(rest_id)
),
menuPan2 AS(
select rank() over(partition by rest_name order by menu_price desc) rnum, menu_name, rest_name, menu_price
from menuPan
)
select rest_name, max(menu_price), menu_name
from menuPan2
where rnum = 1
group by rest_name, menu_name
order by 2;

select max(menu_price)
from menu
group by rest_id;

select rank() over(partition by rest_id order by menu_price desc) expensive, menu_price, menu_name, rest_name
from menu join rest
using(rest_id)
where menu_price in (select max(menu_price)
from menu
group by rest_id);

--문제 7
select count(*)
from menu
group by rest_id;

select menu_name, menu_price
from menu
group by rest_id
where rest_id=(select rest_id
from menu
where 
);

select menu_name, menu_price
from menu
where rest_id = (select rest_id
                    from ( select count(menu_name) AS menu_count,rest_id
                            from menu
                            groupby rest_id)
                    where menu_count = (
                                        select MAX(count(rest_id))
                                        from menu
                                        group by rest_id)
);