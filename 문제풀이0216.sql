--강사님 vers
--하나의 가게만 관리한다면 primary key할 필요 x
--varchar2 -> 영어는 1byte, 한글은 3byte

---> 가게 번호, 가게 명, 주소, 연락처, 매출
--단,
--1-1) 가게 번호는 최대 5개
--1-2) 가게 명 최대 10글자
--1-3) 주소 최대 50글자
--1-4) 연락처 최대 13글자
--1-5) 매출 6자리, 1000원 이상 입력
create table store(
store_id number(5) primary key,
store_name varchar2(30) not null,
store_addr varchar2(150) not null,
store_tel char(13),
store_sales number(6) check (store_sales>=1000)
);


--2) 상품의 정보
---> 상품 번호, 상품 명, 가격, 보관방법, 가게 번호
--단, 상품 번호는 중복이 안 되었으면 한다.
--2-1) 상품 번호는 4자리
--2-2) 상품 명 10글자
--2-3) 가격 5자리, 100원 이상 입력
--2-4) 보관 방법 F(냉동), C(냉장) 두개의 데이터만 받고싶다
create table prod(
prod_id number(4) primary key,
prod_name varchar2(30),
prod_price number(5) check(prod_price>=100),
--C랑 F외엔 입력 안되게 받는다<<-냉동 냉장만 구분||
prod_keep char(1) check(prod_keep in('F','C')),
store_id number(5),
constraint store_storeid_fk foreign key (store_id) references store(store_id)
);

--강사님 vers
--3) 회원
---> 회원 ID, 회원 이름, 회원 PW, 가게 번호
--3-1) 회원 ID 15글자
--3-2) 회원 이름 한글 3글자
--3-3) 회원 비밀번호 10글자

create table member(
member_id varchar2(15) primary key,
member_name varchar2(9) not null,
member_pw varchar2(10) not null,
store_id number(5) references store(store_id)
);

--4) 장바구니
---> 주문번호, 상품번호, 물품 갯수, 가게 번호, 회원 번호
---> 배송 상태
--1) 주문 번호 영문 + 숫자 총 10글자
--2) 물품 갯수 한 자리 수
--3) 배송 상태는 준비(R), 배송중(D), 완료(F)
--단, 배송 상태의 경우에는 기본 값을 준비(R)로 가진다.
create table cart(
cart_id varchar2(10) primary key,
prod_id number(4) references prod(prod_id),
cart_count number(1) not null,
store_id number(5) references store(store_id),
member_id varchar2(15) references member(member_id),
delivery_status char(1) default 'R' check (delivery_status in('R','D','F'))
);
