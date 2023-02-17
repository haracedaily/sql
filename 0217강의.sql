--����ȭ -> �̻����� �ذ��ϱ� ���ؼ� ����ϴ� ���
--���� ���̺�� ������ �����͸� ����.
--3NF ���� �Ѱ�

create table rest(
rest_name varchar2(30) not null,
rest_id number(10) primary key,
rest_cate varchar2(18) not null,
rest_salse number(20) not null
);
--sales = ����
--price = ����
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

insert into rest values('��ġ�� �������', rest_seq.nextval,'�������',15000);
select * from rest;
insert into menu values(10000,0000000000,'��ɽ�����ũ',82000);
insert into ingre values(10000,0000000000,'Ȧ��Ÿ�ε�� 500g',13500,1);

insert into rest values('�к��� �߽Ĵ�',rest_seq.nextval,'�߽Ĵ�',3000);
insert into menu values(10001,0000000100,'¥���',8000);
insert into ingre values(10001,0000000100,'�а��� 300g', 1200,1);
insert into ingre values(10001,0000000100,'���� 100g', 600,1);

insert into rest values('�����',rest_seq.nextval,'�����',10000000);
insert into rest values('���־˰�Į����',rest_seq.nextval,'����',5000000);
insert into rest values('������',rest_seq.nextval,'�߽�',60000000);
insert into rest values('�뱸����',rest_seq.nextval,'����',40000000);
--�����
insert into menu values(10002,1000,'����',14000);
insert into menu values(10002,1001,'���',11000);
insert into menu values(10002,1002,'������',15000);

--���־˰�Į����
insert into menu values(10003,10000,'���Į����',9900);

--������
insert into menu values(10004,100000,'������', 12000);
insert into menu values(10004,100001,'���󼧱�', 15000);

--�뱸����
insert into menu values(10005,1000000,'���ε�',9900);
insert into menu values(10005,1000001,'����쵿',5000);
insert into menu values(10005,1000002,'��������',6000);
insert into menu values(10005,1000003,'�������',7000);

insert into ingre values(10002,1000,'����',5000,10);
insert into ingre values(10002,1000,'��',2000,20);
insert into ingre values(10002,1000,'���',10000,50);
insert into ingre values(10002,1001,'����',5000,10);
insert into ingre values(10002,1001,'��',2000,20);
insert into ingre values(10002,1001,'���',8000,50);
insert into ingre values(10002,1002,'����',5000,10);
insert into ingre values(10002,1002,'��',2000,20);
insert into ingre values(10002,1002,'���',12000,50);

insert into ingre values(10003,10000,'���',4000,50);

insert into ingre values(10004,100000,'���',6000,50);
insert into ingre values(10004,100000,'�ػ깰',3000,15);
insert into ingre values(10004,100000,'���',1500,12);
insert into ingre values(10004,100000,'�κ�',500,18);
insert into ingre values(10004,100001,'���',7000,50);
insert into ingre values(10004,100001,'�ػ깰',3500,15);
insert into ingre values(10004,100001,'�κ�',500,18);
insert into ingre values(10004,100001,'����',6000,36);

insert into ingre values(10005,1000000,'���',7000,50);
insert into ingre values(10005,1000000,'����',1000,25);
insert into ingre values(10005,1000000,'�κ�',500,18);
insert into ingre values(10005,1000000,'��ġ',1000,22);
insert into ingre values(10005,1000000,'����',6000,36);
insert into ingre values(10005,1000000,'����',5000,59);
select * from ingre where menu_id=1000003;
delete ingre where menu_id=1000000;
insert into ingre values(10005,1000001,'����',1000,25);
insert into ingre values(10005,1000001,'�κ�',500,18);
insert into ingre values(10005,1000001,'��ġ',1000,22);
insert into ingre values(10005,1000001,'����',6000,36);
insert into ingre values(10005,1000001,'����',5000,59);

insert into ingre values(10005,1000002,'���',6500,40);
insert into ingre values(10005,1000002,'����',1000,25);
insert into ingre values(10005,1000002,'�κ�',500,18);
insert into ingre values(10005,1000002,'����',6000,36);
insert into ingre values(10005,1000002,'����',5000,59);

insert into ingre values(10005,1000003,'���',5000,30);
insert into ingre values(10005,1000003,'����',1000,10);
insert into ingre values(10005,1000003,'�κ�',500,9);
insert into ingre values(10005,1000003,'����',6000,22);
insert into ingre values(10005,1000003,'����',5000,30);
insert into ingre values(10005,1000003,'��ġ',900,16);
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

--������ȭ <<-���̺��� �ʹ� ������ ��� join�� �������� �����ս��϶� ���� ���� ����
update rest set rest_sales = (select (menu_price*ingre_count)
                                from menu m join ingre i
                                using(menu_id)
                                where i.rest_id=10000)
where rest_id=10000;

select (menu_price*ingre_count)
                                from menu m join ingre i
                                using(menu_id)
                                where i.rest_id=10001;
                                
--����1                                
select * from rest;

--����2
select rest_name, rest_cate, ingre_name,ingre_price
from rest join ingre
using(rest_id);

--����3
select rank() over(order by rest_salse desc) "���Ժ� �������",rest_salse,rest_name
from rest;

--����4
select rank() over(partition by rest_cate order by rest_salse desc) "ī�װ��� �������",rest_salse,rest_name
from rest;

--����5
select rest_name, menu_name, menu_price
from rest join menu
using(rest_id);

--����6
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

--���� 7
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