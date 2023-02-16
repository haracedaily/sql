--대소문자 변환 문자 함수
select upper('oracle database'),
        lower('oracle database'),
        initcap('oracle database')
from dual;
--daul meanings... test data exactly dummy data but use text
select employee_id, last_name, upper(last_name), job_id, initcap(job_id)
from employees;

--비교구문에서 비교군을 바꾸던지 대조군을 바꾸던지해서 조건 맞추기
select employee_id, last_name, job_id
from employees
where last_name = initcap('king');

select concat('hello','world') concat
from dual;

select concat(concat('hello', ' '),'world') concat
from dual;

select employee_id, concat(concat(first_name,' '), last_name) full_name, job_id, email
from employees;

select employee_id, concat(first_name, last_name) full_name, job_id, email
from employees;

--substr

select substr('helloworld',1,5), substr('helloworld',6), substr('helloworld',-5,5)
from dual;
--음수는 역순으로 돌림;

select *
from employees
where substr(last_name, -1,1) = 'n';

select *
from employees
where last_name like '%n';

--length
select length('oracle database'), length('오라클 데이터베이스')
from dual;

select *
from employees
where length(last_name)>6;

--instr (java : indexof와 비슷)
select instr('helloworld','l')
from dual;

select instr(last_name, 'a'), last_name
from employees;

select *
from employees
where instr(last_name,'a')=0;

select *
from employees
where last_name not like '%a%';

--instr('~','~',~,~) '~'대상군 '~'찾을 문자 ~부터 시작해서 ~번째 나온 애의 위치
select instr('helloworld', 'l',1,2), instr('helloworld','l',1,3)
from dual;

--lpad rpad
select employee_id, rpad(last_name, 15, '*') last_name, lpad(salary, 10, '#') salary
from employees;

--replace (바뀌어질~, 바꿀~)

select replace('jack and jue', 'j','bl')
from dual;

--복합문자함수
select employee_id, last_name,
        replace(last_name, substr(last_name,2,length(last_name)),'**') result
        from employees;
        
--trim ->1>양쪽 공백 지우기 2> 양쪽 데이터 지우기

select trim('  helloworld          ')
from dual;

select trim('h'from 'helloworld'), trim ('d'from 'helloworld')
from dual;

select trim('w' from 'window')
from dual;

select trim(0 from 000012345670), trim(leading 0 from 000012345670)
from dual;

select trim('w'from 'windwo'), trim(leading 'w' from 'window'), trim(trailing 'w' from 'window')
from dual;
--안되는trim, 지우고자 하는 문자가 2개 이상이면 안됨
select trim('xy' from 'xyxyxykkkxy')
from dual;

select trim('x' from 'xyxyxykkkxy')
from dual;

--숫자함수
select round(45.923,2), round(45.923), round(45.923,-1)
from dual;

select last_name, salary, mod(salary, 500)
from employees
where job_id='SA_REP';


select floor(45.9999)
from dual;

select floor(45.9999), ceil(45.9999)
from dual;

--날짜함수
select sysdate
from dual;

select sysdate+10
from dual;

select employee_id,last_name,hire_date,sysdate-hire_date "근무일수"
from employees;

select employee_id, last_name, hire_date, trunc(sysdate-hire_date) 근무일수
from employees;

select employee_id,last_name,hire_date,round((sysdate-hire_date)/7) "근무주"
from employees;

select last_name, round((sysdate-hire_date)/7) AS weeks
from employees;

select months_between('22/12/01', '22/01/02')
from dual;

select employee_id, last_name,
trunc (months_between(sysdate,hire_date)) AS "근무기간"
from employees;

--nextday--> 오늘 날짜 기준 다음 '금'요일 언제인지
select add_months(sysdate, 3), last_day(sysdate), next_day(sysdate,'금')
from dual;

select next_day(sysdate, '금'), next_day(sysdate, '금요일'),next_day(sysdate, 6)
from dual;

--rrrr;연도 mm;월 dd;날짜 hh시간24<24시간 표기;24 제외하면 12시간 분기:mi;분 
alter session set
nls_date_format = 'yy/mm/dd';

select next_day(sysdate,'friday')
from dual;
--alter session set; 세션에 설정 변경. nls_date_language; 날짜에 사용되는 언어 교체
alter session set
nls_date_language = 'korean';
--날짜 표기하는 언어 설정
alter session set
nls_date_language = 'american';

--day는 요일, dd는 오늘
--2000~2099  연기준 01/01~12/31  달 기준 03/01~03/31   일 기준 00/01~00/02    요일 기준 일~일 
select round(sysdate,'year'), round(sysdate,'month'), round(sysdate, 'dd'), round(sysdate,'day')
from dual;

--trunc 내림
select trunc(sysdate,'year'), trunc(sysdate,'month'), trunc(sysdate, 'dd'), trunc(sysdate,'day')
from dual;

--변환함수
--날짜->문자로 변환
select employee_id,last_name, hire_date
from employees;

select employee_id, last_name, to_char(hire_date,'yyyy-mm-dd')
from employees;

select employee_id, last_name, to_char(hire_date, 'yyyy"년"-mm"월"--ddth hh24:mi:ss')
from employees;

select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') simple1,
        to_char(sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss')simpl2,
        to_char(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss')simple3
from dual;

select to_char(hire_date, 'yyyy "년" ddspth month hh:mi:ss pm'), hire_date
from employees;

select hire_date
from employees
where hire_date>to_date('99/12/31','rr/mm/dd');

--q(쿼터); 분기, w(주); 해당 월에 몇주차

select employee_id, last_name,
to_char(hire_date, 'yyyy-mm-dd day') AS hire_date,
to_char(hire_date, 'q')||'분기' AS 분기, --1년은 4분기, 12중기+12절기 , 24절기
to_char(hire_date, 'w')||'주차' AS 주수 
from employees;


--숫자를 문자로 변환
select employee_id, last_name, salary, to_char(salary, '$999,999')
from employees;

select employee_id, last_name, salary, to_char(salary, '$999,999'),to_char(salary, '$099,999')
from employees;

select employee_id, last_name, salary, to_char(salary, 'L999,999')||'원',to_char(salary, '099,999')
from employees;

--통화 지역 변경
alter session set
nls_territory = korea;

--지역 원화(=L)
select employee_id, last_name, salary, to_char(salary, 'L999,999')
from employees;


--to_number(char[, 'format_model']) 문자->숫자
select to_number('$3,400','$99,999')
from dual;

select to_number('5000')
from dual;

--to_number 구문(바꾸려는 문자, 만약 이 형태라면~)
select employee_id, last_name, salary, hire_date
from employees
where salary> to_number('$8,000','$9,999');

--문자 -> 날짜 변환
select employee_id, last_name, salary, hire_date
from employees
--암시적 데이터 변환( 문자 -> 날짜 ); 오류는 안 나지만 오라클의 개입으로 좋은 방법은 아님
where hire_date>'1999/12/31';

select employee_id, last_name, salary, hire_date
from employees
where hire_date > to_date('1999/12/31', 'yyyy/mm/dd');

select employee_id, last_name, salary, hire_date
from employees
where hire_date > to_date('1999/12/31', 'yy/mm/dd');

--yy=살고 있는 21세기; 만약 99년도 데이터를 찾는다면 rr=2023<99 -> 1999; yy=2023<99->2099신경x
select employee_id, last_name, salary, hire_date
from employees
where hire_date > to_date('99/12/31', 'rr/mm/dd');


--일반 함수와 중첩 함수(null처리하는 방식, db에서의 if문),nvl함수
--nvl(null이 포함되어잇는지 확인할 데이터, null이라면 대체할 문자)

--'단 nvl에 확인할 데이터가 숫자라면 대체할 문자도 숫자여야한다.'
select employee_id, last_name, salary, NVL(commission_pct,0)
from employees;

select employee_id, last_name, salary, (salary+salary*commission_pct) AS monthly_sal
from employees;

select employee_id, last_name, salary, (salary+salary*NVL(commission_pct,0)) AS monthly_sal
from employees;

--nvl2(~,~,~) (~이 null의 여부,널이 아니면~, 널이 맞으면~)
select employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
    NVL2(commission_pct,'Y','N') AS comm_get
from employees;

select last_name, salary+salary*nvl(commission_pct,0), nvl(commission_pct,0) comm,
nvl2(commission_pct,'sal+comm','sal') income
from employees
where department_id in(50,80);


--nulffif(~,~) ~,~이 서로 같으면 null; ~,~이 서로 다르면 첫번째~를 출력한다. 
select employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
    NVL2(commission_pct,'Y','N') AS comm_get,
    nullif(salary, salary+salary*nvl(commission_pct,0)) AS result
from employees;


select first_name, length(first_name) "expr1",
    last_name, length(last_name) "expr2",
    nullif(length(first_name), length(last_name)) result
    from employees;


--일반함수 coalesce    
--coalesce함수 (expr1,expr2,...,...,...,exprn) null이 아닐때까지 돌다가 마지막 전까지 null이면 마지막 표현식 반환
--구문을 돌던 중 null이 아닌 값을 만나면 그 표현식 반환하고 함수를 빠져나옴
select employee_id, commission_pct, manager_id,
coalesce(commission_pct,manager_id,1234)AS result
from employees;

select last_name, employee_id,
coalesce(to_char(commission_pct), to_char(manager_id),'no commission and no manager') "comm check"
from employees;

--조건표현식 if문 if-then-else논리를 사용 case표현식(ansi sql)|decode함수(오라클구문에만 존재)
--case-when-then표현식 case(조건)when(비교하고자하는 데이터)then(실행문)
select last_name, job_id, salary,
        case job_id when 'IT_PROG' then 1.10*salary
                    when 'ST_CLERK' then 1.15*salary
                    when 'SA_REP'   then 1.20*salary
        else        salary end AS revised_salary
from employees;

select last_name, job_id, salary,
        case  when job_id='IT_PROG' then 1.10*salary
              when job_id='ST_CLERK' then 1.15*salary
              when job_id='SA_REP'   then 1.20*salary
        else salary end AS revised_salary
from employees;

select employee_id, last_name, salary,
        case when salary <5000 then 'L'
            when salary between 5000 and 9000 then 'M'
            else 'H' end AS salary_grade
from employees;

select employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
    NVL2(commission_pct,'Y','N') AS comm_get
from employees;

select employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
        case when commission_pct is not null then 'Y'
        else 'N' end as comm_get
from employees;


--decode 함수(오라클 전용 함수; 오라클에서만 사용 가능)
select employee_id, job_id, salary,
        decode(job_id, 'IT_PROG' , 1.10*salary,
                        'ST_CLERK' , 1.15*salary,
                        'SA_REP' , 1.20*salary,
                        salary)  reveised_salary
from employees;

--java switch문 시험성적->99~90/9, 89~80/8

select last_name, salary,
    decode(trunc(salary/2000,0),
            0,0,
            1,0.09,
            2,0.20,
            3,0.30,
            4,0.40,
            5,0.42,
            6,0.44,
              0.45) Tax_rate
from employees;