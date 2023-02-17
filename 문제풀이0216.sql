--����� vers
--�ϳ��� ���Ը� �����Ѵٸ� primary key�� �ʿ� x
--varchar2 -> ����� 1byte, �ѱ��� 3byte

---> ���� ��ȣ, ���� ��, �ּ�, ����ó, ����
--��,
--1-1) ���� ��ȣ�� �ִ� 5��
--1-2) ���� �� �ִ� 10����
--1-3) �ּ� �ִ� 50����
--1-4) ����ó �ִ� 13����
--1-5) ���� 6�ڸ�, 1000�� �̻� �Է�
create table store(
store_id number(5) primary key,
store_name varchar2(30) not null,
store_addr varchar2(150) not null,
store_tel char(13),
store_sales number(6) check (store_sales>=1000)
);


--2) ��ǰ�� ����
---> ��ǰ ��ȣ, ��ǰ ��, ����, �������, ���� ��ȣ
--��, ��ǰ ��ȣ�� �ߺ��� �� �Ǿ����� �Ѵ�.
--2-1) ��ǰ ��ȣ�� 4�ڸ�
--2-2) ��ǰ �� 10����
--2-3) ���� 5�ڸ�, 100�� �̻� �Է�
--2-4) ���� ��� F(�õ�), C(����) �ΰ��� �����͸� �ް�ʹ�
create table prod(
prod_id number(4) primary key,
prod_name varchar2(30),
prod_price number(5) check(prod_price>=100),
--C�� F�ܿ� �Է� �ȵǰ� �޴´�<<-�õ� ���常 ����||
prod_keep char(1) check(prod_keep in('F','C')),
store_id number(5),
constraint store_storeid_fk foreign key (store_id) references store(store_id)
);

--����� vers
--3) ȸ��
---> ȸ�� ID, ȸ�� �̸�, ȸ�� PW, ���� ��ȣ
--3-1) ȸ�� ID 15����
--3-2) ȸ�� �̸� �ѱ� 3����
--3-3) ȸ�� ��й�ȣ 10����

create table member(
member_id varchar2(15) primary key,
member_name varchar2(9) not null,
member_pw varchar2(10) not null,
store_id number(5) references store(store_id)
);

--4) ��ٱ���
---> �ֹ���ȣ, ��ǰ��ȣ, ��ǰ ����, ���� ��ȣ, ȸ�� ��ȣ
---> ��� ����
--1) �ֹ� ��ȣ ���� + ���� �� 10����
--2) ��ǰ ���� �� �ڸ� ��
--3) ��� ���´� �غ�(R), �����(D), �Ϸ�(F)
--��, ��� ������ ��쿡�� �⺻ ���� �غ�(R)�� ������.
create table cart(
cart_id varchar2(10) primary key,
prod_id number(4) references prod(prod_id),
cart_count number(1) not null,
store_id number(5) references store(store_id),
member_id varchar2(15) references member(member_id),
delivery_status char(1) default 'R' check (delivery_status in('R','D','F'))
);
