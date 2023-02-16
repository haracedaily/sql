--��ҹ��� ��ȯ ���� �Լ�
select upper('oracle database'),
        lower('oracle database'),
        initcap('oracle database')
from dual;
--daul meanings... test data exactly dummy data but use text
select employee_id, last_name, upper(last_name), job_id, initcap(job_id)
from employees;

--�񱳱������� �񱳱��� �ٲٴ��� �������� �ٲٴ����ؼ� ���� ���߱�
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
--������ �������� ����;

select *
from employees
where substr(last_name, -1,1) = 'n';

select *
from employees
where last_name like '%n';

--length
select length('oracle database'), length('����Ŭ �����ͺ��̽�')
from dual;

select *
from employees
where length(last_name)>6;

--instr (java : indexof�� ���)
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

--instr('~','~',~,~) '~'��� '~'ã�� ���� ~���� �����ؼ� ~��° ���� ���� ��ġ
select instr('helloworld', 'l',1,2), instr('helloworld','l',1,3)
from dual;

--lpad rpad
select employee_id, rpad(last_name, 15, '*') last_name, lpad(salary, 10, '#') salary
from employees;

--replace (�ٲ����~, �ٲ�~)

select replace('jack and jue', 'j','bl')
from dual;

--���չ����Լ�
select employee_id, last_name,
        replace(last_name, substr(last_name,2,length(last_name)),'**') result
        from employees;
        
--trim ->1>���� ���� ����� 2> ���� ������ �����

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
--�ȵǴ�trim, ������� �ϴ� ���ڰ� 2�� �̻��̸� �ȵ�
select trim('xy' from 'xyxyxykkkxy')
from dual;

select trim('x' from 'xyxyxykkkxy')
from dual;

--�����Լ�
select round(45.923,2), round(45.923), round(45.923,-1)
from dual;

select last_name, salary, mod(salary, 500)
from employees
where job_id='SA_REP';


select floor(45.9999)
from dual;

select floor(45.9999), ceil(45.9999)
from dual;

--��¥�Լ�
select sysdate
from dual;

select sysdate+10
from dual;

select employee_id,last_name,hire_date,sysdate-hire_date "�ٹ��ϼ�"
from employees;

select employee_id, last_name, hire_date, trunc(sysdate-hire_date) �ٹ��ϼ�
from employees;

select employee_id,last_name,hire_date,round((sysdate-hire_date)/7) "�ٹ���"
from employees;

select last_name, round((sysdate-hire_date)/7) AS weeks
from employees;

select months_between('22/12/01', '22/01/02')
from dual;

select employee_id, last_name,
trunc (months_between(sysdate,hire_date)) AS "�ٹ��Ⱓ"
from employees;

--nextday--> ���� ��¥ ���� ���� '��'���� ��������
select add_months(sysdate, 3), last_day(sysdate), next_day(sysdate,'��')
from dual;

select next_day(sysdate, '��'), next_day(sysdate, '�ݿ���'),next_day(sysdate, 6)
from dual;

--rrrr;���� mm;�� dd;��¥ hh�ð�24<24�ð� ǥ��;24 �����ϸ� 12�ð� �б�:mi;�� 
alter session set
nls_date_format = 'yy/mm/dd';

select next_day(sysdate,'friday')
from dual;
--alter session set; ���ǿ� ���� ����. nls_date_language; ��¥�� ���Ǵ� ��� ��ü
alter session set
nls_date_language = 'korean';
--��¥ ǥ���ϴ� ��� ����
alter session set
nls_date_language = 'american';

--day�� ����, dd�� ����
--2000~2099  ������ 01/01~12/31  �� ���� 03/01~03/31   �� ���� 00/01~00/02    ���� ���� ��~�� 
select round(sysdate,'year'), round(sysdate,'month'), round(sysdate, 'dd'), round(sysdate,'day')
from dual;

--trunc ����
select trunc(sysdate,'year'), trunc(sysdate,'month'), trunc(sysdate, 'dd'), trunc(sysdate,'day')
from dual;

--��ȯ�Լ�
--��¥->���ڷ� ��ȯ
select employee_id,last_name, hire_date
from employees;

select employee_id, last_name, to_char(hire_date,'yyyy-mm-dd')
from employees;

select employee_id, last_name, to_char(hire_date, 'yyyy"��"-mm"��"--ddth hh24:mi:ss')
from employees;

select to_char(sysdate,'yyyy/mm/dd hh24:mi:ss') simple1,
        to_char(sysdate+3/24, 'yyyy/mm/dd hh24:mi:ss')simpl2,
        to_char(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss')simple3
from dual;

select to_char(hire_date, 'yyyy "��" ddspth month hh:mi:ss pm'), hire_date
from employees;

select hire_date
from employees
where hire_date>to_date('99/12/31','rr/mm/dd');

--q(����); �б�, w(��); �ش� ���� ������

select employee_id, last_name,
to_char(hire_date, 'yyyy-mm-dd day') AS hire_date,
to_char(hire_date, 'q')||'�б�' AS �б�, --1���� 4�б�, 12�߱�+12���� , 24����
to_char(hire_date, 'w')||'����' AS �ּ� 
from employees;


--���ڸ� ���ڷ� ��ȯ
select employee_id, last_name, salary, to_char(salary, '$999,999')
from employees;

select employee_id, last_name, salary, to_char(salary, '$999,999'),to_char(salary, '$099,999')
from employees;

select employee_id, last_name, salary, to_char(salary, 'L999,999')||'��',to_char(salary, '099,999')
from employees;

--��ȭ ���� ����
alter session set
nls_territory = korea;

--���� ��ȭ(=L)
select employee_id, last_name, salary, to_char(salary, 'L999,999')
from employees;


--to_number(char[, 'format_model']) ����->����
select to_number('$3,400','$99,999')
from dual;

select to_number('5000')
from dual;

--to_number ����(�ٲٷ��� ����, ���� �� ���¶��~)
select employee_id, last_name, salary, hire_date
from employees
where salary> to_number('$8,000','$9,999');

--���� -> ��¥ ��ȯ
select employee_id, last_name, salary, hire_date
from employees
--�Ͻ��� ������ ��ȯ( ���� -> ��¥ ); ������ �� ������ ����Ŭ�� �������� ���� ����� �ƴ�
where hire_date>'1999/12/31';

select employee_id, last_name, salary, hire_date
from employees
where hire_date > to_date('1999/12/31', 'yyyy/mm/dd');

select employee_id, last_name, salary, hire_date
from employees
where hire_date > to_date('1999/12/31', 'yy/mm/dd');

--yy=��� �ִ� 21����; ���� 99�⵵ �����͸� ã�´ٸ� rr=2023<99 -> 1999; yy=2023<99->2099�Ű�x
select employee_id, last_name, salary, hire_date
from employees
where hire_date > to_date('99/12/31', 'rr/mm/dd');


--�Ϲ� �Լ��� ��ø �Լ�(nulló���ϴ� ���, db������ if��),nvl�Լ�
--nvl(null�� ���ԵǾ��մ��� Ȯ���� ������, null�̶�� ��ü�� ����)

--'�� nvl�� Ȯ���� �����Ͱ� ���ڶ�� ��ü�� ���ڵ� ���ڿ����Ѵ�.'
select employee_id, last_name, salary, NVL(commission_pct,0)
from employees;

select employee_id, last_name, salary, (salary+salary*commission_pct) AS monthly_sal
from employees;

select employee_id, last_name, salary, (salary+salary*NVL(commission_pct,0)) AS monthly_sal
from employees;

--nvl2(~,~,~) (~�� null�� ����,���� �ƴϸ�~, ���� ������~)
select employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
    NVL2(commission_pct,'Y','N') AS comm_get
from employees;

select last_name, salary+salary*nvl(commission_pct,0), nvl(commission_pct,0) comm,
nvl2(commission_pct,'sal+comm','sal') income
from employees
where department_id in(50,80);


--nulffif(~,~) ~,~�� ���� ������ null; ~,~�� ���� �ٸ��� ù��°~�� ����Ѵ�. 
select employee_id, last_name, salary+salary*NVL(commission_pct,0) AS monthly_sal,
    NVL2(commission_pct,'Y','N') AS comm_get,
    nullif(salary, salary+salary*nvl(commission_pct,0)) AS result
from employees;


select first_name, length(first_name) "expr1",
    last_name, length(last_name) "expr2",
    nullif(length(first_name), length(last_name)) result
    from employees;


--�Ϲ��Լ� coalesce    
--coalesce�Լ� (expr1,expr2,...,...,...,exprn) null�� �ƴҶ����� ���ٰ� ������ ������ null�̸� ������ ǥ���� ��ȯ
--������ ���� �� null�� �ƴ� ���� ������ �� ǥ���� ��ȯ�ϰ� �Լ��� ��������
select employee_id, commission_pct, manager_id,
coalesce(commission_pct,manager_id,1234)AS result
from employees;

select last_name, employee_id,
coalesce(to_char(commission_pct), to_char(manager_id),'no commission and no manager') "comm check"
from employees;

--����ǥ���� if�� if-then-else���� ��� caseǥ����(ansi sql)|decode�Լ�(����Ŭ�������� ����)
--case-when-thenǥ���� case(����)when(���ϰ����ϴ� ������)then(���๮)
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


--decode �Լ�(����Ŭ ���� �Լ�; ����Ŭ������ ��� ����)
select employee_id, job_id, salary,
        decode(job_id, 'IT_PROG' , 1.10*salary,
                        'ST_CLERK' , 1.15*salary,
                        'SA_REP' , 1.20*salary,
                        salary)  reveised_salary
from employees;

--java switch�� ���輺��->99~90/9, 89~80/8

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