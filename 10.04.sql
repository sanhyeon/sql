-- 사원명, 급여, 월급(급여/12)를 출력하되 월급은 십단위에서 반올림하여 출력
SELECT  ENAME, SAL, ROUND(SAL/12, -2) AS WOLGUP
FROM EMP;

-- 사원명, 급여, 세금(급여의 3.3%)를 원단위 절삭하고 출력
SELECT  ENAME, SAL, SAL*0.033, TRUNC(SAL * 0.033,-1) AS TAX
FROM EMP;

-- smith의 정보를 사원번호, 성명, 담당업무(소문자) 출력
SELECT EMPNO, ENAME, LOWER(JOB) AS JOB
FROM EMP
WHERE ENAME = 'SMITH';

-- 사원번호, 사원명(첫글자만 대문자), 담당업무(첫글자만 대문자)로 출력
SELECT EMPNO, INITCAP(ENAME)AS ENAME, INITCAP(JOB)AS JOB
FROM EMP;

-- 이름의 첫글자가 ‘K’보다 크고 ‘Y’보다 작은 사원의 정보( 사원번호, 이름, 업무, 급여, 부서번호)를 출력하되 이름순으로 정렬
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE SUBSTR(ENAME,1.1)>K AND SUBSTR(ENAME,1.1)<Y
ORDER BY ENAME;



-- 이름이 5글자 이상인 사원들을 출력
SELECT *
FROM EMP
WHERE LENGTH (ename) >=5;



-- 이름을 15자로 맞추고 글자는 왼쪽에 오른쪽에는 ‘*’로 채운다
SELECT RPAD(ENAME, 15, '*')
FROM EMP;

-- 급여는 10자로 맞추고 숫자는 오른쪽에 왼쪽엔 ‘-‘로 채운다
SELECT LPAD(ENAME, 10, '*')
FROM EMP;

create table info_tab
(
    name varchar(15),
    jumin number(15)
);
drop table info_tab;

INSERT INTO info_tab ( name, jumin ) VALUES( 맹이, '800101-1234567' );
INSERT INTO info_tab ( name, jumin) VALUES( 짱이, '900808-2222222' );
select name, jumin, substr(jumin, 8, 1) gender,
                    substr(jumin, 1, 2) birth_year
from info_tab;

select sysdate
from dual;

-- 급여를 숫자에서 ‘영일이삼사오육칠팔구’ 글자로 대체
select sal, translate(sal, '0123456789', '영일이삼사오육칠팔구') kor_sal
from emp;


-- 급여의 숫자에서 0을 ‘$’로 바꾸어 출력
select sal, replace(sal, 0, '$') char_sal
from emp;

-- *****(모든 공백 제거)
select replace('    이   순   신   ', ' ','') as ename
from dual;

-- 현재까지 근무일 수가 많은 사람 순으로 출력
select ename, hiredate,sysdate-nvl(hiredate,sysdate) ,
                        ceil(sysdate-nvl(hiredate,sysdate))
from emp
order by sysdate-hiredate desc;

select ename,hiredate
from emp
order by sysdate-hiredate desc nulls last;

-- 현재까지 근무일 수가 몇 주 몇 일인가를 출력
select ename, ceil((sysdate-hiredate)/7)as week, 
ceil(sysdate-hiredate) - (ceil((sysdate-hiredate)/7)*7) as day 
from emp;

select ename, sysdate -hiredate,
        trunc((sysdate -hiredate)/7,0) as weeks,
        floor(mod(sysdate -hiredate, 7)) as days
from emp;


-- 10번 부서의 사원의 현재까지의 근무 월수를 계산 
select ename, months_between(sysdate,hiredate), 
                floor(months_between(sysdate,hiredate)) 
from emp
where deptno = '10';



-- 현재 날짜에서 3개월 후의 날짜 구하기

select add_months( sysdate, 3 ) as mydate from dual;


-- 현재 날짜에서 돌아오는 ‘월’요일의 날짜 구하기
select next_day(sysdate,2) as mydate from dual;

-- 현재 날짜에서 해당 월의 마지막 날짜 구하기

select last_day( sysdate ) as last_day from dual;

-- 입사일자에서 입사년도를 출력
select ename, hiredate, to_char(hiredate,'yyyy') as hire_year
from emp;

-- 입사일자를 ‘1999년 1월 1일’ 형식으로 출력
select ename, hiredate, to_char(hiredate,'yyyy"년 "mm"월 "dd"일"') as hire_year
from emp;

-- 1981년도에 입사한 사원 검색
select *
from emp
where to_char(hiredate,'yyyy' )= '1981';

-- 5월에 입사한 사원 검색
select *
from emp
where to_char(hiredate,'mm' )= '05';

-- 급여 앞에 $를 삽입하고 3자리 마다 ,를 출력
select ename, sal, to_char(sal,'$999,999,999,999')as dollor
from emp;

-- 81년 2월에 입사한 사원 검색
select *
from emp
where to_char(hiredate,'yyyymm') = '198102';

-- 81년에 입사하지 않은 사원 검색
select *
from emp
where to_char(hiredate,'yyyy') != '1981';
-- 81년 하반기에 입사한 사원 검색
select *
from emp
 where to_char(hiredate,'yyyymm') >= 198107 and to_char(hiredate,'yyyymm') <= 198112;
 
 select *
from emp
 where to_char(hiredate,'yyyy') = 1981 and to_char(hiredate,'mm') >= 07;

SELECT jumin, decode( substr(jumin, 8, 1), '1', '남자', '3', '남자', '여자') AS gender 
FROM info_tab;

SELECT CASE substr( jumin, 8, 1) 

        WHEN '1' THEN '남자'
        WHEN '3' THEN '남자'
        ELSE '여자'
        END as gender

FROM info_tab;

-- 부서번호가 10이면 영업부, 20이면 관리부, 30이면 IT부 그 외는 기술부로 출력
select deptno,decode(deptno, 10, '영업부', 20, '관리부', 30, 'it부', '기술부') as part
from emp;

select deptno, case deptno

        when 10 then '영업부'
        when 20 then '관리부'
        when 30 then 'it부'
        else '기술부'
        end as part
        
from emp;

-- 업무(job)이 analyst이면 급여 증가가 10%이고 clerk이면 15% , 
-- manager이면 20%인 경우 사원번호, 사원명, 업무, 급여, 증가한 급여를 출력

select empno, ename, job, sal, 
decode(job, 'amalyst', sal*1.1, 'clerk', sal*1.15, 'manager', sal*1.2)as change
from emp;

select empno, ename, job, sal, case job

    when 'analyst' then sal*1.1
    when 'clerk'   then sal*1.15
    when 'manager' then sal*1.2
    else sal
    end as change
from emp;

select all job from emp;

select distinct job from emp;

select empno, ename, job from emp;

desc emp;
select rownum, empno, ename, job from emp;

select rownum, empno, ename, job from emp where rownum<=5;


-- 업무가 ‘SALESMAN’인 사람들의 월급의 평균, 총합, 최소값, 최대값을 구하기
select avg(sal), sum(sal), min(sal) min, max(sal) max
from emp
where job = 'SALESMAN';

insert into emp(empno, ename, job)
values(9001, '홍길국', 'SALESMAN');
-- 커미션(COMM)을 받는 사람들의 수는

SELECT COUNT(COMM) AS "커미션"
FROM  EMP
WHERE COMM >0;

-- 부서별로 인원수, 평균급여, 최저급여, 최고급여, 급여의 합을 구하기

SELECT DEPTNO, COUNT(*), AVG(SAL), MIN(SAL), MAX(SAL), SUM(SAL)
FROM    EMP
--WHERE
GROUP BY DEPTNO;
--HAVING

-- 부서별로 인원수, 평균급여, 최저급여, 최고급여, 급여의 합을 구하기 ( 부서별 급여의 합이 높은 순으로
SELECT DEPTNO, COUNT(*),AVG(SAL) ,MIN(SAL), MAX(SAL), SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY SUM(SAL) DESC;

-- 부서별 업무별 그룹하여 부서번호, 업무, 인원수, 급여의 평균, 급여의 합을 구하기
SELECT DEPTNO,JOB, COUNT(*),AVG(SAL), SUM(SAL)
FROM EMP
GROUP BY DEPTNO,JOB;


-- 최대 급여가 2900 이상인 부서에 대해 부서번호, 평균 급여, 급여의 합을 출력
SELECT DEPTNO,ROUND(AVG(SAL),-2), SUM(SAL)
FROM EMP
HAVING MAX(SAL) >= 2900
GROUP BY DEPTNO;


-- 업무별 급여의 평균이 3000이상인 업무에 대해 업무명, 평균 급여, 급여의 합을 출력
select job, round(avg(sal),-2), sum(sal)
from emp
having avg(sal)>=3000
group by job;
-- 전체 합계 급여가 5000를 초과하는 각 업무에 대해서 업무와 급여 합계를 출력
--단, SALESMAN은 제외하고 급여 합계가 높은 순으로 정렬
SELECT JOB, SUM(SAL)AS SUM
FROM EMP
WHERE JOB != 'SALESMAN'
HAVING SUM(SAL)>5000
GROUP BY JOB
ORDER BY SUM DESC;

-- 업무별 최고 급여와 최소 급여의 차이를 구하라
SELECT JOB, MAX(SAL)-MIN(SAL)AS"차이"
FROM EMP
GROUP BY JOB;

-- 부서 인원이 4명 보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력
SELECT DEPTNO, COUNT(*), SUM(SAL)
FROM EMP
HAVING COUNT(*) >4
GROUP BY DEPTNO;

--1. 2003년에 입사한 사원들의 사번, 이름, 입사일을 출력
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS ENAME,  HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE,'YYYY')=2003;

?

--2. 업무가 FI_ACCOUNT / FI_MGR / SA_MAN / SA_REP 인 사원들의 정보를 출력
select *
FROM EMPLOYEES
where lower(job_id) ='fi_accout' or lower(job_id) = 'fi_mgr' or 
lower(job_id) = 'sa_man' or lower(job_id)= 'sa_rep';
?

?

--3. 커미션을 받는 사원들의 명단을 출력


SELECT *
FROM employees
WHERE commission_pct is not null;
?

--4.업무가 SA_MAN 또는 SA_REP이면 "판매부서"를 그 외는 "그 외 부서"라고 출력
SELECT DECODE(JOB_ID,'SA_MAN', '판매부서', 'SA_REP', '판매부서', '그 외 부서' )AS PART
FROM EMPLOYEES;
?

?

--5. 연도별로 입사자들의 최소급여, 최대 급여, 급여의 총합 그리고 평균 급여를 구하시오
SELECT to_char(hire_date, 'yyyy')year,MIN(SALARY), MAX(SALARY), SUM(SALARY), AVG(SALARY)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE 'YYYY');
?
SELECT to_char(hire_date, 'YYYY') year, min(salary) min, max(salary) max,
sum(salary) sum, avg(salary) avg
FROM employees
GROUP BY to_char(hire_date, 'YYYY');
?

--6. 부서별 평균 급여가 $10,000 이상인 부서만 구하시오. ( 평균급여가 높은 순으로 )
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),0) AS AVG
FROM EMPLOYEES
HAVING AVG(SALARY) >=10000
GROUP BY DEPARTMENT_ID
ORDER BY AVG(SALARY) DESC;
?

?

--7. 부서별 최대 급여를 구하시오
SELECT DEPARTMENT_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 테이블 생성

CREATE TABLE reg_tab( text varchar2(20) );

?

-- 레코드 입력

INSERT INTO reg_tab VALUES('TIGER');

INSERT INTO reg_tab VALUES('TIGGER');

INSERT INTO reg_tab VALUES('elephant');

INSERT INTO reg_tab VALUES('tiger');

INSERT INTO reg_tab VALUES('tiger2');

INSERT INTO reg_tab VALUES('tiger3');

INSERT INTO reg_tab VALUES('doggy');

INSERT INTO reg_tab VALUES('5doggy');

INSERT INTO reg_tab VALUES('DOG');

INSERT INTO reg_tab VALUES('DOG2');

INSERT INTO reg_tab VALUES('개');

INSERT INTO reg_tab VALUES('cat');

INSERT INTO reg_tab VALUES('catty');

INSERT INTO reg_tab VALUES('9catty');

INSERT INTO reg_tab VALUES('catwoman');

INSERT INTO reg_tab VALUES('고양이');

INSERT INTO reg_tab VALUES('BAT');

INSERT INTO reg_tab VALUES('BATMAN');

INSERT INTO reg_tab VALUES('BATGIRL'); 

INSERT INTO reg_tab VALUES('0BATGIRL'); 

INSERT INTO reg_tab VALUES('박쥐');

?

-- 커밋

COMMIT;

desc reg_tab;
select * from reg_tab;
drop table reg_tab;
-- 1.  text 컬럼의 문자열에서 't'로 시작하는 데이터 검색
select text 
from reg_tab
where text like 't%';

?

?

-- 2.  text 컬럼의 문자열에서 't'로 끝나는 데이터 검색
select *
from reg_tab
WHERE TEXT LIKE '%t';

?

-- 3. 첫번째 't'로 시작하여 5번째 'r'이 있는 데이터 검색
select *
from reg_tab
where text like 't%%%%r';
?

-- 4. 숫자로 끝나는 데이터 검색
select *
from reg_tab
where REGEXP_LIKE (text , '[0~9]$');


-- 5. 숫자로 시작하는 데이타 검색
select *
from reg_tab
where REGEXP_LIKE (text , '^[0~9]');
?

-- 6. 숫자가 아닌 문자로 시작하는 데이터 검색
select *
from reg_tab
where not REGEXP_LIKE (text , '^[0~9]');
?

-- 7. 대문자로 시작하는 데이터 검색
select *
from reg_tab
where  regexp_like (text, '^[A-Z]');
?

-- 8. 소문자 외의 문자로 시작하는 데이터 검색
select *
from reg_tab
where not regexp_like (text, '^[a-z]');
?

-- 9. 한글로 시작하는 데이터 검색
select *
from reg_tab
where regexp_like(text,'^[가-힣]');

-- 10. 데이터 중 'gg'나 'GG'가 들어있는 데이터 검색
select *
from reg_tab
where TEXT like '%gg%' or text like '%GG%';

