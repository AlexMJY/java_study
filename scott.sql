-- 테이블의 내용 조회 
-- SELECT [ALL|DISTINCT] 조회할 컬럼명 | * 
-- FROM  테이블 이름
-- [WHERE 검색조건
-- GROUP BY 그룹화할 컬럼명
-- HAVING 검색조건
-- ORDER BY 정렬기준 ASC|DESC ]

-- 모든 컬럼 조회
SELECT * FROM emp;

-- 단일 컬럼 조회
SELECT ename FROM emp;

-- 복수 컬럼 조회
SELECT ename , job, sal FROM emp;

SELECT deptno FROM emp;

SELECT ALL deptno FROM emp;
SELECT DISTINCT deptno FROM emp;  -- 중복 제거

SELECT  deptno, job FROM emp;
SELECT DISTINCT deptno, job FROM emp;

SELECT ename, job, sal * 12 FROM emp;

-- 컬럼명 별칭
SELECT ename, job,  sal 월급,  sal * 12 AS "연 봉"  FROM emp;

-- 컬럼 결합
SELECT ename, job, 
            ename || job, 
            ename || ' : ' || job  AS "이름:직업"
FROM emp;

SELECT ename, sal, ename || sal FROM emp;


-- 테이블 구조 확인
DESC emp;

-- 테이블 조회
SELECT * FROM tab;


SELECT DISTINCT deptno, job FROM emp ORDER BY deptno ASC; -- 오름차순
SELECT DISTINCT deptno, job FROM emp ORDER BY deptno DESC; -- 내림차순

SELECT DISTINCT deptno, job FROM emp ORDER BY deptno, job ASC;  -- 조건 두 개(depno가 우선시)
SELECT deptno, job FROM emp ORDER BY deptno, job ASC;

SELECT deptno, job, ename, sal FROM emp ORDER BY job, sal ASC;
SELECT deptno, job, ename, sal FROM emp ORDER BY 2;

-- 검색 조건 지정
-- 문자와 날짜의 경우 반드시 '  ' 사용
-- 컬럼의 값은 대소문자 구별

-- deptno가 10인 레코드 조회
SELECT * FROM emp WHERE deptno = 10;
SELECT * FROM emp WHERE job = 'MANAGER';
SELECT * FROM emp WHERE job = 'manager';  -- 오류, 데이터값은 대소문자 구별

-- 81년도 이전 입사자 레코드만 조회
SELECT * FROM emp WHERE hiredate < '81/01/01';
SELECT * FROM emp WHERE hiredate < '81-01-01';
SELECT * FROM emp WHERE hiredate < '1981/01/01';
SELECT * FROM emp WHERE hiredate < '810101';
SELECT * FROM emp WHERE hiredate < '19810101';


SELECT * FROM emp WHERE job = 'MANAGER' AND deptno = 10;
SELECT * FROM emp WHERE job = 'MANAGER' OR deptno = 10;

-- 80년도 또는 82년도에 입사한 사람들의 레코드를
-- 먼저 입사한 사람들 순서로 조회
SELECT * FROM emp 
               WHERE (hiredate >= '80/01/01' AND hiredate <= '80/12/31')
               OR (hiredate >= '82/01/01' AND hiredate <= '82/12/31')
               ORDER BY hiredate;
               
-- 연봉이 30000대인 레코드의 ename, job, 연봉, hiredate를 가장 큰 연봉 순서대로 조회
SELECT ename, job, sal * 12 AS 연봉, hiredate 
FROM emp 
WHERE 40000 > (sal * 12) 
AND (sal * 12) >= 30000 
ORDER BY sal DESC;


-- job이 ANALYST, PRESIDENT, SALESMAN인 레코드를 알파벳순으로 조회
SELECT * FROM emp 
WHERE job = 'ANALYST' OR job = 'PRESIDENT' OR job = 'SALESMAN'
ORDER BY job ASC;


-- deptno가 20인 레코드 조회
SELECT * FROM emp WHERE deptno = 20;
-- deptno가 20이 아닌 레코드 조회
SELECT * FROM emp WHERE deptno != 20;
SELECT * FROM emp WHERE deptno <> 20;
SELECT * FROM emp WHERE deptno ^= 20;
SELECT * FROM emp WHERE NOT deptno = 20;

SELECT * FROM emp WHERE sal < 2000 ORDER BY sal ASC;

SELECT ename, job, sal, 
            +sal, -sal,  -- 음수 양수 부호 표시
            sal+1, sal-1  -- 덧셈, 뺄셈, 산술 연산자
FROM emp WHERE sal < 2000 ORDER BY 3;

-- ename이 A, B, C로 시작하는 레코드 조회
SELECT * FROM emp WHERE ename < 'D';


-- 컬럼명 BETWEEN 작은값 AND 큰값
-- 이상/이하 사용가능, 미만/초과는 사용하지 않음
SELECT * FROM emp 
WHERE  hiredate BETWEEN '80/01/01' AND '80/12/31'
OR hiredate BETWEEN '82/01/01' AND '82/12/31'
ORDER BY hiredate ASC;  

SELECT * FROM emp 
WHERE sal * 12 BETWEEN 30000 AND 39999
ORDER BY 3;  

SELECT * FROM emp 
WHERE sal * 12 NOT BETWEEN 30000 AND 39999
ORDER BY 3;  


-- IN (비교값 목록 - 숫자, 날짜, 문자 모두 가능)
-- job이 ANALYST, PRESIDENT, SALESMAN인 레코드를 알파벳순으로 조회
SELECT * FROM emp
WHERE job 
        IN ('ANALYST', 'PRESIDENT', 'SALESMAN')
ORDER BY job;

--job이 SAMESMAN이 아닌 레코드 조회
SELECT * FROM emp
WHERE job 
        NOT IN ('SALESMAN')
ORDER BY job;


-- 컬럼명 LIKE %  : 0개 이상의 문자열과 일치
--                 _   : 특정 위치의 한 개의 문자와 일치하는지 여부 확인

-- 81년도 이전 입사자 레코드 조회 use LIKE
SELECT * FROM emp WHERE hiredate LIKE '81%';

SELECT * FROM emp WHERE ename LIKE '_O%';

-- ename이 M으로 시작하고 R로 끝나는 레코드 조회
SELECT * FROM emp WHERE ename LIKE 'M%' AND ename LIKE '%R';

-- ename이 4자인 레코드 중에 두 번째에 A가 있는 
SELECT * FROM emp WHERE ename LIKE '_A__';

-- ename이 4자인 레코드 중에 두 번째에 A가 없는
SELECT * FROM emp WHERE ename NOT LIKE '_A__' AND ename LIKE '____';


-- job에 R_R이 들어가는 레코드 조회
SELECT * FROM emp WHERE job LIKE '%R\_R%' ESCAPE '\';

SELECT * FROM emp WHERE (job LIKE '%MAN%' or job LIKE '%ID%') AND sal > 2000 ;


-- IS NULL, IS NOT NULL
-- comm이 없는 레코드 조회
SELECT * FROM emp WHERE comm = NULL;  -- 작동 안함
SELECT * FROM emp WHERE comm IS NULL;  -- 작동
-- comm이 null이 아닌 사람들의 sal에 10%를 보너스로 조회
SELECT ename, job, sal, sal * 0.1 as bonus, comm FROM emp WHERE comm IS NOT NULL;


---------------------------------------------------------------------------------------------------------
-- 집합 연산자 UNION, UNION ALL, MINUS, INTERSECT
SELECT deptno, job, ename FROM emp WHERE job = 'CLERK' AND deptno = 10;
SELECT deptno, job, ename FROM emp WHERE job = 'CLERK' AND deptno = 20;
-- 결과 모아서 출력
SELECT deptno, job, ename FROM emp WHERE job = 'CLERK' AND deptno = 10
UNION
SELECT deptno, job, ename FROM emp WHERE job = 'CLERK' AND deptno = 20;

SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 10
UNION
SELECT deptno, job FROM emp WHERE job = 'CLERK' AND deptno = 20;

SELECT deptno FROM emp WHERE job = 'CLERK' AND deptno = 10
UNION
SELECT deptno FROM emp WHERE job = 'CLERK' AND deptno = 20;


-- deptno가 10, 30인 deptno, dname, ename을 중복 제거 및
-- deptno로 정렬하여 조회
SELECT deptno, '' DNAME, ename FROM emp WHERE deptno IN(10, 30)
UNION
SELECT deptno, dname, '' FROM dept WHERE deptno IN(10, 30)
ORDER BY 1;


-- 비공통 데이터 찾기 MINUS
-- 사원이 소속되어 있지 않은 deptno 조회
SELECT deptno FROM dept 
MINUS
SELECT deptno FROM emp;

-- 공통 데이터 찾기 MINUS
-- 사원이 소속되어 있는 deptno 조회
SELECT deptno FROM dept 
INTERSECT
SELECT deptno FROM emp;


----------------------------------------------------------------------------------------------
-- DML ; Data Manipulation Language 데이터 조작어
-- INSERT, DELETE, UPDATE
-- COMMIT, ROLLBACK 대상

-- CTAS ; Create Table As Select
-- 기존 테이블의 데이터를 이용하여 테이블 생성
-- 단, 제약조건은 복사되지 않는다

-- 1. 기존 테이블의 데이터와 구조를 모두 복사
CREATE TABLE emp2 AS SELECT * FROM emp;

-- 2. 기존 테이블의 구조만 복사
CREATE TABLE emp3 AS SELECT * FROM emp WHERE 1=2;

-- 3. 기존 테이블의 특정 컬럼들만 복사
CREATE TABLE t_emp AS SELECT empno, ename, deptno, sal, hiredate FROM emp WHERE 1=2;


-- 테이블에 레코드 추가하기
-- INSERT INTO 테이블이름 [(컬럼명1, 컬럼명2, ...)]
-- VALUES (컬럼1의 값, 컬럼2의 값, ...);

-- t_emp 테이블의 모든 컬럼에 데이터 입력 1
INSERT INTO t_emp (empno, ename, deptno, sal, hiredate)
VALUES (1111, 'KIM', 40, 1000, '2024/03/07'); 

-- t_emp 테이블의 모든 컬럼에 데이터 입력 2
INSERT INTO t_emp 
VALUES (2222, 'Lee', NULL, 2000, SYSDATE); 

-- t_emp 테이블의 모든 컬럼에 데이터 입력 3
INSERT INTO t_emp(empno, ename, hiredate) 
VALUES (3333, 'Han', ''); 

INSERT INTO t_emp(empno, ename, hiredate)
VALUES (4444, 'SAN', '2024-03-10');

INSERT INTO t_emp(empno, ename, hiredate)
VALUES (5555, 'Ohh', '28-02-2024');  -- X

INSERT INTO t_emp(empno, ename, hiredate)
VALUES (5555, 'Ohh', TO_DATE('28-02-2024', 'DD-MM-YYYY'));




-- 숫자 데이터 입력
INSERT INTO t_emp(empno, sal)
VALUES (6666, 123456789);  -- larger then specified precision allowed for this column

INSERT INTO t_emp(empno, sal)
VALUES (6666, 1234567);  -- O

INSERT INTO t_emp(empno, sal)
VALUES (6666, 12345);  -- O

INSERT INTO t_emp(empno, sal)
VALUES (6666, 0.12345); -- 둘째 자리에서 끊김 (0.12)

INSERT INTO t_emp(empno, sal)
VALUES (6666, 0.12543); -- 둘째 자리에서 끊기고 반올림까지 (0.13)

COMMIT;  -- 변경 사항 반영하기 (이후 롤백 불가능)

-- 테이블에 데이터 변경하기 -------------------------------------
-- UPDATE 테이블이름
-- SET 컬럼명1 = 변경할 값1, 컬럼명 2 = 변경할 값2, ...
-- WHERE 변경조건

-- deptno를 모두 99번으로변경
UPDATE t_emp SET deptno = 99;

-- deptno가 null인 데이터를 모두 99번으로 변경
UPDATE t_emp SET deptno = 99 WHERE deptno IS NULL;

-- deptno가 99번이고, sal이 없는 데이터의 sal을 100으로
UPDATE t_emp SET sal = 100, deptno = 10 WHERE deptno = 99 AND sal IS NULL;



-- 테이블 데이터 삭제하기
-- DELETE FROM 테이블이름
-- WHERE 삭제조건

-- t_emp 테이블의 모든 데이터 삭제하기
DELETE FROM t_emp;
ROLLBACK;

-- sal이 1 미만인 레코드 삭제하기
DELETE FROM t_emp WHERE sal < 1;



SELECT * FROM t_emp;


---------------------------------------------------------


SELECT * FROM t_survey WHERE endDate > SYSDATE;

SELECT * FROM t_survey WHERE endDate > SYSDATE AND startDate <= SYSDATE;

-----------------------------------------------------------------
-- 단일행 함수
-- 문자


SELECT * FROM emp;

SELECT ename, INITCAP(ename), LOWER(ename), UPPER('abc') FROM emp;

-- ename의 값 중 대소문자 구분없이  smith인 레코드를 검색
SELECT * FROM emp WHERE LOWER(ename) = 'smith';

SELECT * FROM t_emp;
SELECT * FROM t_emp WHERE LOWER(ename) = 'goo' OR UPPER(ename) = 'GOO';
SELECT * FROM t_emp WHERE LOWER(ename) = LOWER('GOO');

SELECT 3 * 4, 'dual table', SYSDATE, SYSTIMESTAMP FROM dual;

SELECT LENGTH('eng'), LENGTH('lionel messi'),LENGTH(12345), LENGTH('축구장') FROM dual;
-- BYTE로 보면 한글은 더 용량이 크다
SELECT LENGTHB('eng'), LENGTHB('lionel messi'),LENGTHB(12345), LENGTHB('축구장') FROM dual;

SELECT * FROM emp WHERE LENGTH(ename) <= 4;


-- 컬럼 결합
SELECT  ename, job, 
                ename || job,
                CONCAT(ename, job),
                ename || ' : ' || job AS "이름 : 직업",
                CONCAT(ename, CONCAT(' : ', job)) AS "이름 : 직업"
FROM emp;


SELECT DISTINCT job, 
SUBSTR(job, 1, 5), SUBSTR(job, 6), SUBSTR(job, -3, 3), SUBSTR(job, -6)
FROM emp  WHERE job = 'SALESMAN';

SELECT '19' || SUBSTR(hiredate, 1, 2) FROM emp WHERE hiredate IS NOT NULL;

SELECT 'HELLO WORLD > L' ,
INSTR('HELLO WORLD', 'L')  "1",
INSTR('HELLO WORLD', 'L', 1) "2",
INSTR('HELLO WORLD', 'L', 1, 1) "3",
INSTR('HELLO WORLD', 'L', 1, 2) "4",
INSTR('HELLO WORLD', 'L', 2, 3) "5",
INSTR('HELLO WORLD', 'L', 3, 3) "6"
FROM dual;

SELECT 'HELLO WORLD > L' ,
INSTR('HELLO WORLD', 'L')  "1",
INSTR('HELLO WORLD', 'L', -1) "2",
INSTR('HELLO WORLD', 'L', -1, 1) "3",
INSTR('HELLO WORLD', 'L', -1, 2) "4",
INSTR('HELLO WORLD', 'L', -2, 3) "5",
INSTR('HELLO WORLD', 'L', -3, 3) "6"
FROM dual;

SELECT * FROM emp WHERE SUBSTR(hiredate, 5, 1) = 4;
SELECT * FROM emp WHERE SUBSTR(hiredate, 5, 1) = 3;

-- 4월에 입사한 사람들의 레코드 조회
SELECT ename, hiredate
FROM emp
WHERE SUBSTR(hiredate, INSTR(hiredate, '/') + 2, 1) = '4';

-- 이번 달에 입사한 사람들의 레코드 조회
SELECT ename, hiredate
FROM emp
WHERE SUBSTR(hiredate, 4, 2) = SUBSTR(SYSDATE, 4, 2);


SELECT * FROM t_survey;

-- https://www.homepage.com/user/info.html
-- http://127.0.0.1:8090/index.jsp
-- 도메인 정보 추출
SELECT SUBSTR(title,INSTR(title, '/', 1, 2) + 1, (INSTR(title, '/', 1, 3) - INSTR(title, '/', 1, 2)) - 1)  
FROM t_survey WHERE sno > 6;



SELECT ename, job, REPLACE(job,'PRESIDENT','CEO') "RP"
FROM emp  WHERE job = 'PRESIDENT';


SELECT ename, REPLACE(ename, SUBSTR(ename, 2, 3), 
FROM emp;


SELECT ename, REPLACE(ename, SUBSTR(ename, -3, LENGTH(ename)-2), 
FROM emp;

SELECT ename, REPLACE(ename, SUBSTR(ename, -3), 
FROM emp;

SELECT ename, SUBSTR(ename, 1, LENGTH(ename) - 3) || 
FROM emp;


-- 공백 없애기
SELECT 
LENGTH('    ABC   '),
LENGTH(TRIM('    ABC   ')),
LENGTH(LTRIM('    ABC   ')),
LENGTH(RTRIM('    ABC   '))
FROM dual;

SELECT 
hiredate,
TRIM(LEADING 8 FROM hiredate),
TRIM(TRAILING 8 FROM hiredate),
TRIM(BOTH '8' FROM hiredate)
FROM emp;

-- 공백 만들기
SELECT 
empno,
LPAD(empno, 7, '*')
FROM emp;

SELECT 
empno,
RPAD(empno, 10, '-')
FROM emp;


-- 숫자
SELECT 
sal, sal * 0.33333,
ROUND(sal * 0.33333) "NONE",
ROUND(sal * 0.33333, 0) "0",
ROUND(sal * 0.33333, 1) "1",
ROUND(sal * 0.33333, 2) "2",
ROUND(sal * 0.33333, -1) "-1",
ROUND(sal * 0.33333, -2) "-2"
FROM emp;


-- sal의 0.3333을 보너스로 계산하여
-- 소수점 둘째 자리까지 반올림하여 출력, 단 보너스가 1000에서 10000미만의 값을 대상으로 하고
-- 부족한 자리는 0으로 표시
SELECT 
RPAD(ROUND(sal * 0.3333, 2), 7, '0') BONUS
FROM emp
WHERE ROUND((sal * 0.3333), 2) BETWEEN 1000 AND 9999.99;


SELECT 
sal, sal * 0.33333,
TRUNC(sal * 0.33333) "NONE",
TRUNC(sal * 0.33333, 0) "0",
TRUNC(sal * 0.33333, 1) "1",
TRUNC(sal * 0.33333, 2) "2",
TRUNC(sal * 0.33333, -1) "-1",
TRUNC(sal * 0.33333, -2) "-2"
FROM emp;

SELECT 
sal / 30,
CEIL(sal / 30),
FLOOR(sal / 30),
MOD(sal, 30),
MOD(10, 2)
FROM emp;

-- empno가 홀수로 끝나면 TEAM_RED, 짝수로 끝나면 TEAM_BLUE로 지정하여
-- TEAM, EMPNO, ENAME을 조회. 
--  TEAM을 기준으로 오름차순 정렬, 같은 TEAM내에서는 이름을 기준으로 오름차순 정렬
SELECT ename "TEAM",  empno, ename FROM emp WHERE MOD(empno, 2) = 0
ORDER BY ASC;

SELECT 
    CASE 
        WHEN MOD(empno, 2) = 0 THEN 'TEAM_BLUE'  ELSE 'TEAM_RED' 
    END AS TEAM, 
    empno, ename 
FROM 
    emp 
ORDER BY 1 ASC, 3 ASC;



SELECT 'TEAM_RED' AS TEAM, empno, ename
FROM emp 
WHERE MOD(empno, 2) != 0

UNION ALL

SELECT 'TEAM_BLUE' AS TEAM, empno, ename
FROM emp
WHERE MOD(empno, 2) = 0

ORDER BY 1 ASC, 3 ASC;

SELECT ROWNUM, ename, 'TEAM'
FROM emp;

-- 사원들을 3명씩 한 팀으로 구성하여 TEAM`1 ~ TEAM5까지 표시
SELECT ROWNUM, ename, CONCAT('TEAM',CEIL(ROWNUM / 3))
FROM emp;



------
-- 날짜


SELECT
hiredate,
hiredate + 100 입사100일차,
SYSDATE - hiredate 근속일수,
SYSDATE - 1 어제,
SYSDATE 오늘,
SYSDATE + 1 내일
FROM emp;

-- 모든 사원의 ename, hiredate, 근속년수 조회
-- 근속년수가 오래된 순서로 정렬
SELECT
ename, hiredate, FLOOR((SYSDATE - hiredate) / 365) || '년' AS 근속년수
FROM emp ORDER BY 2;

SELECT
ename, hiredate, FLOOR((SYSDATE - hiredate) / 365 * 12) || '개월' AS 근속월수,
TRUNC( MONTHS_BETWEEN(sysdate, hiredate), 2)
FROM emp ORDER BY 2;

SELECT ename, hiredate, ADD_MONTHS(hiredate, 6)
FROM emp;

SELECT 
NEXT_DAY(SYSDATE, '금요일'),
LAST_DAY(SYSDATE)
FROM dual;

SELECT SYSTIMESTAMP,
ROUND(SYSTIMESTAMP),
TRUNC(SYSTIMESTAMP)
FROM dual;




-----------------------------
-- 단일행 함수
-- 형변환
-- NUMBER   TO_CHAR   ->   CHAR   TO_DATE   ->   DATE
--               <-   TO_NUMBER            <- TO_CHAR

SELECT 
1 + '1',  -- 묵시적 형변환
1 + TO_NUMBER('1')  -- 명시적 형변환
FROM dual;


-- 숫자를 문자로
SELECT 
ename, sal * 123.45,
TO_CHAR(sal * 123.45, '999,999.99') "1",
TO_CHAR(sal * 123.45, 'L999,999.99') "2",
TO_CHAR(sal * 123.45, '$999,999.99') "3",
TO_CHAR(sal * 123.45, '$000,000.00') "4"
FROM emp;


-- 문자를 날짜로
SELECT 
TO_DATE ('24-03-01', 'YY-MM-DD'),
TO_DATE ('2024-03-01', 'YYYY-MM-DD')
FROM dual;


-- 날짜를 문자로
SELECT 
SYSDATE, 
TO_CHAR(SYSDATE, 'YY.MM.DD'),
TO_CHAR(SYSDATE, 'YY"년" MM"월" DD"일"')
FROM dual;



----------------------
-- 단일행 함수
-- NULL 값 비교 - NVL, NVL2, NULLIF
SELECT 
ename, comm,
NVL(comm, 100), -- comm이 null이면 100으로 지정
NVL2(comm, 200, 100) -- comm이 null이면 100으로, null이 아니면 200으로 지정
FROM emp;


SELECT 
NULLIF(10, 10),  -- 둘이 같으면 null 값 출력
NULLIF(10, 20),  -- 둘이 다르면 첫번째 값 출력
NULLIF(40, 20)
FROM dual;


---------------------
-- 조건 비교
-- DECODE - equal 비교 : 정확히 일치하는지 여부 비교
-- CASE - range 비교 : 범위값을 비교

-- deptno가 10이면 Team1, 20이면 Team2, 30이면 Team3, 나머지는 Free로 지정
SELECT 
deptno, ename, 
DECODE(deptno, '10', 'Team1',
                             '20', 'Team2',
                             '30', 'Team3',
                                     'Free') AS TEAM
FROM emp
ORDER BY 1;


SELECT 
deptno, ename, 
CASE deptno WHEN 10 THEN 'Team10'
                       WHEN 20 THEN 'Team20'
                       WHEN 30 THEN 'Team30'
                                        ELSE 'Freee'
                     END AS TEAM
FROM emp
ORDER BY 1;

-- hiredate가
-- 80 ~ 81년도 사이는 Senior,
-- 82 ~ 84년도 사이는 Junior,
-- 85 ~ 89년도 사이는 Newbie,
-- 그외는 Free
SELECT 
deptno, ename, hiredate,
    CASE 
        WHEN hiredate BETWEEN '80/01/01' AND '81/12/31' THEN 'Senior'  
        WHEN hiredate BETWEEN '82/01/01' AND '84/12/31' THEN 'Junior'  
        WHEN hiredate BETWEEN '85/01/01' AND '89/12/31' THEN 'Newbie'  
        ELSE 'Free' 
    END AS TEAM
FROM  emp 
ORDER BY 3;



SELECT 
ename, comm, '수당내역'
FROM emp
ORDER BY 2;
-- comm이 0이면 수당 없음, 1이상이면 수당지급, null이면 해당사항 없음

SELECT
ename, comm,
    CASE  
        WHEN comm = 0 THEN '수당없음'
        WHEN comm IS NULL THEN '해당사항없음'
        WHEN comm > 0 THEN '수당지급'
    END AS 수당내역
FROM emp
ORDER BY 2;


--------------------------

-- 복수행Group 함수


-- 합계와 개수
SELECT  SUM(sal), SUM(ALL sal), SUM(DISTINCT sal) FROM emp
UNION ALL
SELECT  COUNT(sal), COUNT(ALL sal), COUNT(DISTINCT sal) FROM emp;

SELECT  COUNT(comm), COUNT(ALL comm), COUNT(DISTINCT comm),
COUNT(*)
FROM emp;

-- t_member의 id컬럼의 값이 'aaaa'인 행의 개수 조회
SELECT COUNT(*) FROM t_member WHERE id = 'aaaa';

SELECT 
COUNT(id),
CASE  
        WHEN COUNT(id) > 0 THEN '아이디가 존재합니다.'
        WHEN COUNT(id) < 0 THEN  '아이디가 존재하지 않습니다.'
END AS ID조회
FROM t_member 
WHERE id = 'aaaa';


-- emp테이블에서 MAN이 포함된 개수
SELECT COUNT(job) FROM emp WHERE job LIKE '%MAN%';
-- comm이 없는 사람들의 수 조회
SELECT COUNT(*) FROM emp WHERE comm IS NULL or comm = 0;


--  평균
SELECT 
AVG(comm) -- null값은 제외
FROM EMP;

-- 전체 인원 평균
SELECT
ROUND(SUM(comm) / COUNT(*), 2) AS 전체인원평균1,
ROUND(AVG(NVL(comm, 0)), 2) AS 전체인원평균2
FROM emp;


-- 최대값, 최소값, 표준편차, 분산
SELECT 
MAX(sal), MIN(sal), -- MAX, MIN 둘 다 내부정렬을 해서 성능저하
MAX(hiredate), MIN(hiredate),
MAX(ename), MIN(ename),
STDDEV(sal) AS 표준편차,
VARIANCE(sal) AS 분산

FROM emp;

-- sal을 가장 많이 받는 사람의 ename, sal 조회
SELECT MAX(sal) FROM emp;
SELECT
ename, sal
FROM emp
-- WHERE sal = MAX(sal); -- ERROR ; group function is not allowed here 
WHERE sal = 5000;

-- 부서별 sal 평균
SELECT deptno, AVG(sal) -- 그룹 함수를 사용했을 경우 (ex) AVG)
FROM emp                         -- 그룹 함수가 아닌 컬럼은 
GROUP BY deptno             -- 반드시 GROUP BY 절에 명시
ORDER BY 1;                    -- SELECT에 사용되지 않은 컬럼도 명시 가능

-- 각 부서별 job의 개수 및 평균 sal
SELECT deptno, job, COUNT(*) AS job_count, AVG(sal) AS avg_salary
FROM emp
GROUP BY deptno, job
ORDER BY 1;

-- 각 부서별 sal의 평균이 2000 이상인 레코드의 
-- deptno, 부서의 인원수 및 평균 sal 조회

SELECT deptno, COUNT(*), AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000  -- 그룹화 했을 경우 검색조건을 WHERE이 아닌 HAVING을 사용
ORDER BY 1;

SELECT deptno, job,  COUNT(*)
FROM emp
GROUP BY deptno, job
HAVING COUNT(*) >= 3;

SELECT deptno, AVG(sal)
FROM emp
WHERE job = 'MANAGER'
GROUP BY deptno
ORDER BY 1;


-----------------------------
-- 분석함수
-- ROLLUP - 주어진 데이터들의 소계 계산

-- deptno, job, sal의 합계, job의 개수
-- deptno의 오름차순으로 조회
SELECT 
deptno, job, SUM(sal), COUNT(*)
FROM emp
GROUP BY deptno, job
ORDER BY 1;


SELECT 
deptno, job, SUM(sal), COUNT(*)
FROM emp
GROUP BY ROLLUP(deptno, job)
ORDER BY 1;

SELECT 
deptno, job, SUM(sal), COUNT(*)
FROM emp
GROUP BY deptno, ROLLUP(job)
ORDER BY 1;

SELECT 
deptno, job, SUM(sal), COUNT(*)
FROM emp
GROUP BY job, ROLLUP(deptno)
ORDER BY 1;

-- CUBE - 소계와 전체의 총계 계산
SELECT 
deptno, job, SUM(sal), COUNT(*)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY 1;

SELECT 
deptno, job, SUM(sal), COUNT(*)
FROM emp
GROUP BY deptno, CUBE(job)
ORDER BY 1;

SELECT 
deptno, job, SUM(sal), COUNT(*)
FROM emp
GROUP BY job, CUBE(deptno)
ORDER BY 1;


-- 각 부서의 매니저 별로 관리하는 인원 수를 조회하여
-- deptno, mgr, mgr의 관리 인원 수를 표시
-- 단, 매니저가 없는 경우는 제외
SELECT deptno, mgr, COUNT(mgr)
FROM emp
WHERE mgr IS NOT NULL
GROUP BY mgr, deptno
ORDER BY 1;


SELECT deptno, mgr, COUNT(mgr)
FROM emp
WHERE mgr IS NOT NULL
GROUP BY GROUPING SETS(mgr, deptno)
ORDER BY 1;


SELECT deptno, LISTAGG(ename, ' | ')
WITHIN GROUP (ORDER BY sal DESC)
FROM emp
GROUP BY deptno;

SELECT deptno, 
    COUNT(DECODE(job, 'CLERK', 1)) AS CLARK,
    COUNT(DECODE(job, 'SALESMAN', 1)) AS SALESMAN,
    COUNT(DECODE(job, 'PRESIDENT', 1)) AS PRESIDENT,
    COUNT(DECODE(job, 'MANAGER', 1)) AS MANAGER,
    COUNT(DECODE(job, 'ANALYST', 1)) AS ANALYST
FROM emp
GROUP BY deptno
ORDER BY 1;


-- 부서별, JOB의 개수 1
SELECT 
DEPTNO,
COUNT(DECODE(JOB, 'CLERK', 100)) AS CLARK,
COUNT(DECODE(JOB, 'SALESMAN', 100)) AS SALESMAN,
COUNT(DECODE(JOB, 'PRESIDENT', 100)) AS PRESIDENT,
COUNT(DECODE(JOB, 'MANAGER', 100)) AS MANAGER,
COUNT(DECODE(JOB, 'ANALYST', 100)) AS ANALYST
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;

-- 부서별, JOB의 개수 2
CREATE TABLE T_PIVOT
AS
SELECT *
FROM (SELECT DEPTNO, JOB FROM EMP)
PIVOT (COUNT(JOB)
        FOR  JOB  IN('CLERK' AS CLEARK, 
                                'SALESMAN' AS SALESMAN,
                                'PRESIDENT' AS PRESIDENT, 
                                'MANAGER' AS MANAGER, 
                                'ANALYST' AS ANALYST))
ORDER BY 1;
                                

-- 생성된 피벗 테이블을 원래 형태로 조회
SELECT *
FROM T_PIVOT
UNPIVOT (JOB_COUNT
                    FOR JOB IN(CLEARK, SALESMAN, PRESIDENT, MANAGER, ANALYST));
                    


-- LAG : 이전 행 값 가져오기
-- LEAD : 이후 값 가져오기
SELECT 
ENAME, 
LAG(SAL, 1, 0) OVER(ORDER BY SAL) LAG,
SAL,
LEAD(SAL, 1, 0) OVER(ORDER BY SAL) LEAD
FROM EMP
ORDER BY 2;

-- 전일 판매량, 당일 판매량, 전일과 당일 비교 조회
SELECT 
HIREDATE "매출일", 
LAG(SAL, 1, 0) OVER(ORDER BY HIREDATE) "전일 판매량",
SAL "당일 판매량",
SAL - (LAG(SAL, 1, 0) OVER(ORDER BY HIREDATE)) AS "전일 대비" 
FROM EMP;


-- 순위 출력
-- RANK, RANK OVER, DENSE_RANK, ROW_NUMBER

-- 전체 ENAME 중에서 JAMES의 순위 조회
SELECT RANK('JAMES') WITHIN GROUP (ORDER BY ENAME) "RANK"
FROM EMP;


-- JOB이 CLEARK인 레코드 중에서 JAMES의 순위 조회
SELECT 
RANK('JAMES') WITHIN GROUP (ORDER BY ENAME) "RANK"
FROM EMP
WHERE JOB = 'CLERK';

-- 전체 사원들의 ENAME, SAL 순위 조회
SELECT ENAME, SAL, 
RANK() OVER (ORDER BY SAL) "순위",
RANK() OVER (ORDER BY SAL ASC) "ASC",
RANK() OVER (ORDER BY SAL DESC) "DESC",
DENSE_RANK() OVER (ORDER BY SAL DESC) "DENSE", -- 동일 순위 인정 처리
ROW_NUMBER() OVER (ORDER BY SAL DESC) "순위 중복 제거"
FROM EMP;

-- DEPTNO가 30인 부서의 SAL 순위를 조회하여
-- DEPTNO, ENAME, JOB, SAL 순위를 표시
-- 동일 순위 인정하여 처리
SELECT DEPTNO, ENAME, JOB, SAL,
DENSE_RANK() OVER(ORDER BY SAL DESC) "SAL RANK"
FROM EMP
WHERE DEPTNO = 30;


-- 누적 합계 구하기
-- SUM
SELECT 
DEPTNO, HIREDATE "매출일",
SAL "당일 판매량",
SUM(SAL) OVER(PARTITION BY DEPTNO 
                             ORDER BY HIREDATE, SAL) "누적 판매량"
FROM EMP
ORDER BY 1;

-------------------------------------------------
-- JOIN
-- 여러 테이블에 흩어져 있는 데이터들을 조합해서 가져옴
-- 집합 연산자 : 세로 연결
-- 조인            : 가로 연결


-- 오라클 조인
-- SELECT  테이블이름.컬럼명 
-- FROM     테이블1이름, 테이블2이름 
-- WHERE   테이블1이름.컬럼명 = 테이블2이름.컬럼명  -- << 조인조건
-- AND        -- << 검색 조건


-- ANSI 조인
-- SELECT  테이블이름.컬럼명 
-- FROM     테이블1이름 [INDER | OUTER] JOIN  테이블2이름 
-- ON          테이블1이름.컬럼명 = 테이블2이름.컬럼명  -- << 조인조건
-- WHERE   -- << 검색 조건


-- INNER JOIN -  Cartesian Product / CROSS JOIN / 카티션 곱
-- - 조인 조건을 누락했을 경우
-- - 해당 조인에 참여하는 모든 대상 행을 출력
-- - 조인 결과 : 컬럼의 수 = 테이블1 + 테이블2
--                      행의 수 = 테이블 * 테이블2

SELECT * FROM EMP, DEPT;  -- ORACLE JOIN
SELECT * FROM EMP CROSS JOIN DEPT; -- ANSI JOIN

--  ERROR column ambiguously defined
-- DEPTNO가 중복돼서 에러
SELECT DEPTNO, DNAME FROM EMP, DEPT;  -- ORACLE JOIN
SELECT * FROM EMP CROSS JOIN DEPT; -- ANSI JOIN

SELECT EMP.DEPTNO, DNAME FROM EMP, DEPT;
SELECT E.DEPTNO, DNAME FROM EMP E CROSS JOIN DEPT D;

-- INNER JOIN - EQUI JOIN 동등 조인
-- 선행 테이블에서 데이터를 가져온 후
-- 조인 조건을 검사하여
-- 같은 값을 가진 데이터를 후행 테이블에서 꺼내 옴

-- deptno, dname, ename을 조회
SELECT dept.deptno, dname, ename
FROM emp, dept
WHERE dept.deptno = emp.deptno
AND dept.deptno = 10;

SELECT d.deptno, dname, ename
FROM emp e JOIN dept d
ON e.deptno = d.deptno
WHERE e.deptno = 10;

SELECT * FROM EMP;



----------------------------------------------------------------------
----------HR----------------------------------------------------------

-- 사원의 부서이름, 사원이름, 직함  (hr)
SELECT d.department_id,   -- Oracle  
       department_name,
       first_name,
       job_title
FROM departments d, employees e, jobs j
WHERE d.department_id = e.department_id 
AND e.job_id = j.job_id;


SELECT d.department_id,  -- ANSI
       department_name,
       first_name,
       job_title
FROM departments d JOIN employees e
ON d.department_id = e.department_id 
JOIN jobs j
ON j.job_id = e.job_id;



-- INNDER JOIN - NON EQUIT JOIN 비동등 조인 (scott)
-- - '='이 아닌 조건을 사용
-- - 정확히 일치하지 않는 값으로 조인

-- 모든 sal의 grade를 조회
SELECT ename, sal, grade, losal, hisal -- ORACLE
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal;
-- 위와 아래는 같다 (겹치는 게 없으니 굳이 별칭을 쓰지 않아도 된다.)
SELECT e.ename, e.sal, s.grade, s.losal, s.hisal
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

SELECT ename, sal, grade, losal, hisal -- ANSI
FROM emp JOIN salgrade
ON sal BETWEEN losal AND hisal;

-- 각 grade의 사원 수를 조회하여 grade, 소계로 표시
SELECT grade || '호봉' AS 호봉, LPAD(COUNT(grade), 2, 0) AS 소계
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal
GROUP BY grade
ORDER BY 1;

SELECT grade || '호봉' , LPAD(COUNT(grade), 2, 0)
FROM emp JOIN salgrade
ON sal BETWEEN losal AND hisal
GROUP BY grade
ORDER BY 1;

-- 각 grade의 사원 수를 조회하여 grade, 소계로 표시
-- 단, 소계가 3명 이상인 데이터만 대상으로 하여 처리
SELECT grade || '호봉' AS 호봉, LPAD(COUNT(grade), 2, 0) AS 소계
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal
HAVING COUNT(grade) >= 3  -- GROUP함수로 정한 변수는 WHERE 대신 HAVING 사용
GROUP BY grade
ORDER BY 1;


-- INNSER JOIN - SELF JOIN
--  원하는 데이터가 한 테이블에 모두 들어있는 경우
--  같은 테이블을 마치 두 개의 테이블인 것처럼 사용하여 조인


-- 모든 사원의 ename, ename, mgr, 매니저의 이름을 조회하여 표시
SELECT e.empno, e.ename, e.mgr, m.ename AS 매니저이름
FROM emp e, emp m
WHERE e.mgr = m.empno
ORDER BY 2;



-- OUTER JOIN
-- - INNER JOIN 조건을 만족하지 않는 경우에도 모든 행을 출력
-- - 한 쪽 테이블에는 데이터가 있고 다른 테이블에는 없는 경우
--   데이터가 있는 쪽의 내용을 우선하여 출력
-- - OUTER 키워드 생략 시 INNER 조인 수행
--   LEFT [OUTER] JOIN  왼쪽 기준으로 출력
--   RIGHT [OUTER] JOIN 오른쪽 기준으로 출력
-- - 오라클의 경우 자료가 부족한 쪽에 (+) 표시
--   FULL [OUTER] JOIN 양쪽 모두 (ANSI가 지원)
--   ORACLE은 지원하지 않음, 대신 UNION 사용
--   풀스캔으로 성능에 악영향



SELECT e.empno, e.ename, e.mgr, m.ename AS 매니저이름 -- ANSI
FROM emp e JOIN emp m
ON e.mgr = m.empno
ORDER BY 2;

SELECT e.empno, e.ename, e.mgr, m.ename AS 매니저이름 -- ANSI
FROM emp e LEFT OUTER JOIN emp m
ON e.mgr = m.empno
ORDER BY 2;

SELECT e.empno, e.ename, e.mgr, m.ename AS 매니저이름 -- ORACLE
FROM emp e, emp m
WHERE e.mgr = m.empno (+)  -- 부족한 쪽에 (+)
ORDER BY 2;


-- 모든 사원의 deptno, dname, ename을 조회
-- 단, 사원이 없는 부서도 포함
SELECT d.deptno, d.dname, e.ename
FROM dept d, emp e
WHERE d.deptno = e.deptno (+)
ORDER BY 1;

SELECT d.deptno, d.dname, e.ename
FROM emp e RIGHT OUTER JOIN dept d
ON d.deptno = e.deptno
ORDER BY 1;

-- 모든 사원의 deptno, dname, empno, ename 조회
-- 단, 관리자 없는 사원 및 사원이 없는 부서도 포함
SELECT d.deptno, d.dname, empno, ename
FROM emp e FULL OUTER JOIN dept d
ON d.deptno = e.deptno
ORDER BY 1;

-- 각 부서별로 sal 합을 계산하여 내림차순 정렬
-- deptno, dname, 급여합계(세 자리마다 , 표시)
SELECT  -- LPAD(NVL(e.deptno, 0), 2, 0) DEPTNO, 
        TO_CHAR(NVL(e.deptno, 0), '00') DEPTNO, 
        NVL(d.dname, 'NONE') DNAME, 
        NVL(TO_CHAR(SUM(e.sal), '999,999'), 0) 급여합계
FROM emp e, dept d
WHERE e.deptno = d.deptno (+)
GROUP BY e.deptno, d.dname
ORDER BY 1 DESC;

SELECT LPAD(NVL(e.deptno, 0), 2, 0) DEPTNO, d.dname, NVL(TO_CHAR(SUM(e.sal), '999,999'), 0) 급여합계
FROM emp e LEFT OUTER JOIN dept d
ON e.deptno = d.deptno (+)
GROUP BY e.deptno, d.dname
ORDER BY 1 DESC;


-------------------------------------------------------------
--  DDL ; Data Definition Language
-- - CREATE, ALTER, TRUNCATE, DROP
-- - 실행 시 자동 COMMIT 되어 ROLLBACK 불가능
-- 명명 규칙
-- - 테이블과 컬럼명은 반드시 문자로 시작
-- - 영문자, 숫자, _, &, # 만 가능
-- - 최대 30BYTE까지 허용
-- - 오라클 예약어는 사용 불가

-- 테이블 생성
-- CREATE TABLE [스키마.]테이블명 (
--      컬럼명1 데이터타입 [DEFAULT 형식] [컬럼 레벨 제약 조건],
--      ...
--  [테이블 레벨 제약 조건]
-- );

-- 게시판 테이블
-- 기본 값을 지정하여 테이블 생성
CREATE TABLE t_board (
    no  NUMBER(10) DEFAULT 0,
    title VARCHAR2(100),
    content VARCHAR2(4000),
    writer VARCHAR2(50) DEFAULT 'guest',
    regdate DATE    DEFAULT SYSDATE
);


-- t_board 테이블에 title은 test, content는 test content로 레코드 추가
INSERT INTO t_board(title, content) VALUES ('test', 'test_content');

SELECT * FROM t_board;


-- ALTER
-- - 기존 객체 변경
-- - 테이블의 구조 변경
--      컬럼 추가, 삭제
--      컬럼명, 데이터 타입, 길이 변경

-- 컬럼 추가
ALTER TABLE t_emp
ADD work VARCHAR2(20);

-- 컬럼명 변경
ALTER TABLE t_emp
RENAME COLUMN work TO job;

-- 테이블 이름 변경
RENAME t_board TO board;

-- 컬럼 길이 변경
ALTER TABLE t_emp
MODIFY job VARCHAR2(10);

-- 컬럼 타입 변경
ALTER TABLE t_emp
MODIFY job NUMBER;

-- 컬럼 삭제
ALTER TABLE t_emp
DROP COLUMN job;

DESC t_emp;

-- 테이블 삭제
DROP TABLE board;  -- 휴지통으로 보내기 (복원 가능)

DROP TABLE board PURGE;  -- 휴지통으로 안보내고 완전 삭제 (복원 불가)

-- 삭제된 테이블 복원
FLASHBACK TABLE board TO BEFORE DROP;


-- emp 테이블을 복사하여 t_temp 테이블 생성
-- (데이터와 구조 모두)
CREATE TABLE t_temp AS SELECT * FROM emp;

DELETE FROM t_temp;

ROLLBACK;       -- 되돌리기 x -> 백업 파일로 복구

TRUNCATE TABLE t_temp; -- 데이터, 인덱스 삭제

SELECT * FROM t_temp;


RENAME t_temp TO t_readonly;

-- 읽기 전용 테이블로 변경
ALTER TABLE t_readonly READ ONLY;

-- 읽기, 쓰기 가능 테이블로 변경
ALTER TABLE t_readonly READ WRITE;

INSERT INTO t_readonly (empno, ename, sal) VALUES(1, 'Lee', 100);



-- 가상 컬럼 테이블
CREATE TABLE t_virtual (
    item1 NUMBER,
    item2 NUMBER,
    total NUMBER GENERATED ALWAYS AS (item1 + item2)
);

INSERT INTO t_virtual (item1, item2) VALUES(100, 200);
SELECT * FROM t_virtual;

UPDATE t_virtual SET item2 = 2;



-- DATA DICTIONARY
SELECT * FROM DICTIONARY;
SELECT * FROM DICT;

SELECT * FROM ALL_TABLES;

DESC USER_TABLES;
SELECT * FROM USER_TABLES;
SELECT * TABLE_NAME FROM USER_TABLES;

SELECT * FROM USER_OBJECTS;

----------------------SYS--------------------------------
DESC DBA_TABLES;
SELECT * FROM DBA_TABLES;
SELECT OWNER, TABLE_NAME FROM DBA_TABLES;
SELECT OWNER, TABLE_NAME, PCT_FREE, CLUSTER_NAME FROM DBA_TABLES;

SELECT * FROM DBA_USERS
WHERE USERNAME = 'SCOTT';

SELECT * FROM V$VERSION;
---------------------------------------------------------
-------------SCOTT---------------------------------------

SELECT * FROM t_emp;
SELECT * FROM emp;

-- 서브쿼리를 이용하여 여러 행 입력
INSERT INTO t_emp
    SELECT  empno, ename, deptno, sal, hiredate 
    FROM    emp
    WHERE   deptno = 10;

INSERT ALL
    INTO t_emp(deptno) VALUES(50)
    INTO t_pivot(deptno) VALUES(50)
    SELECT * FROM dual;
    
-- emp 테이블의 데이터 중에서
-- comm이 null이 아닌 데이터의 ename, job, sal, comm은 bonus테이블로
-- comm이 null인 데이터의 ename, deptno, sal은 t_emp테이블에 입력
INSERT ALL
    WHEN comm IS NOT NULL THEN
        INTO bonus VALUES(ename, job, sal, comm)
    WHEN comm IS NULL AND deptno = 20 THEN
        INTO t_emp (ename, deptno, sal) 
        VALUES (ename, deptno, sal)
    SELECT  ename, deptno, job, sal, comm
    FROM    emp;


-- 서브 쿼리를 이용하여 여러 컬럼을 한 번에 수정
UPDATE t_emp
SET     empno = 1112,
        (deptno, sal) = (SELECT deptno, sal FROM t_emp WHERE ename='Kim')
WHERE ename = 'FORD';

UPDATE t_emp
SET sal = sal * 1.1
WHERE deptno = (SELECT deptno FROM t_emp WHERE ename = 'Lee');

-- 부서의 위치가 DALLAS인 사원의 급여를 두 배 인상 업데이트
-- sal이 없는 경우 1000으로 지정하여 처리
UPDATE t_emp
SET sal = NVL(sal, 1000) * 2
WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');

-- dept = 20
-- sal = between 3
-- ename을 꺼내서 레코드 지우기
DELETE t_emp 
WHERE ename IN (SELECT ename 
                FROM t_emp, salgrade 
                WHERE sal BETWEEN losal AND hisal 
                AND grade = 3 
                AND deptno = 20);



---------------------------------------------------
-- MERGE
-- 테이블 병합

-- salgrade 테이블의 구조를 복사하여 t_merge 테이블 생성
CREATE TABLE t_merge AS SELECT * FROM salgrade WHERE 1=2;

-- salgrade 테이블의 grade가 3이하인 데이터들만 복사하여 salgrade2 테이블 생성
CREATE TABLE salgrade2 AS SELECT * FROM salgrade WHERE grade <= 3;

MERGE INTO t_merge tm 
      USING  salgrade sg
ON (tm.grade = sg.grade)
WHEN MATCHED THEN
    UPDATE SET  tm.losal = sg.losal,
                tm.hisal = sg.hisal
WHEN NOT MATCHED THEN
    INSERT VALUES(sg.grade, sg.losal, sg.hisal);
    
    
MERGE INTO t_merge tm 
      USING  salgrade2 sg
ON (tm.grade = sg.grade)
WHEN MATCHED THEN
    UPDATE SET  tm.losal = sg.losal,
                tm.hisal = sg.hisal
WHEN NOT MATCHED THEN
    INSERT VALUES(sg.grade, sg.losal, sg.hisal);
    
SELECT * FROM t_merge;
SELECT * FROM emp;
SELECT * FROM t_emp;
SELECT * FROM t_pivot;
SELECT * FROM bonus;

----------------------------------------------------------
-- CONSTRAINTS 제약 조건
-- PRIMARY KEY : Null x, 중복 값 x >> NOT NULL + QUNIQUE
-- FOREIGN KEY : 다른 테이블의 PRIMARY KEY 또는 UNIQUE로 설정된 칼럼을 참조
--               PARENT TABLE - 정보 제공 테이블 / CHILD TABLE - 정보를 제공받는 테이블
-- UNIQUE : 중복 값 X
-- CHECK : 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정된 값만 허용
-- NOT NULL : NULL 입력 X. 컬럼 레벨로만 정의 가능




SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_CONS_COLUMNS;


-- 테이블 생성 시 제약 조건 지정 - 제약 조건 이름 생략
CREATE TABLE member (
    userid      VARCHAR2(20)    PRIMARY KEY, 
    empno       NUMBER          REFERENCES emp(empno),
    usernm      VARCHAR2(20)    NOT NULL,
    userpw      VARCHAR2(20)    NOT NULL,
    email       VARCHAR2(50)    UNIQUE,
    gender      CHAR(1),        CHECK(gender IN ('M', 'F')),
    regdate     DATE            DEFAULT SYSDATE
);
    
-- 부모 테이블에 테스트 데이터 추가
INSERT INTO emp(empno, ename) VALUES (1000, 'Woo');
INSERT INTO emp(empno, ename) VALUES (2000, 'Goo');
INSERT INTO emp(empno, ename) VALUES (3000, 'Hoo');

-- member 테이블에 userid가 abc인 레코드 추가
INSERT INTO member(userid) VALUES ('abc');  -- X (NOT NULL 인 로우값 안넣어줌)
INSERT INTO member(userid, usernm, userpw) VALUES ('abc', 'Woo', '1111'); -- O
INSERT INTO member(userid, usernm, userpw) VALUES ('abc', 'Woo', '1111'); -- O (UNIQUE 제약조건 위배)
INSERT INTO member(userid, usernm, userpw, empno) VALUES ('aaa', 'Goo', '1111', 2222); -- X (emp에 2222가 없음)
INSERT INTO member(userid, usernm, userpw, empno) VALUES ('aaa', 'Goo', '1111', 2000); -- O

DELETE FROM emp WHERE empno = 2000; -- X (CHILDE 레코드가 있어서 삭제 불가능)
DELETE FROM member WHERE userid = 'aaa';
DELETE FROM emp WHERE empno = 2000; -- O

INSERT INTO member(userid, usernm, userpw, gender) VALUES('aaa', 'Goo', '1111', 'Male'); -- X
INSERT INTO member(userid, usernm, userpw, gender) VALUES('aaa', 'Goo', '1111', 'X'); -- X
INSERT INTO member(userid, usernm, userpw, gender) VALUES('aaa', 'Goo', '1111', 'F'); -- O

INSERT INTO member(userid, usernm, userpw, email) VALUES('bbb', 'Goo', '1111', 'g@g.com'); -- O
INSERT INTO member(userid, usernm, userpw, email) VALUES('ccc', 'Goo', '1111', 'g@g.com'); -- O

DROP TABLE member;


-- 테이블 생성 시 제약 조건 지정 - 제약 조건 이름 명시
CREATE TABLE member (
    userid      VARCHAR2(20)    CONSTRAINT member_pk  PRIMARY KEY, 
    empno       NUMBER          CONSTRAINT member_fk  REFERENCES emp(empno)   ON DELETE CASCADE, -- 부모 레코드와 함께 삭제
    usernm      VARCHAR2(20)    ,
    userpw      VARCHAR2(20)    CONSTRAINT member_pw_chk    CHECK(LENGTH(userpw) >= 4), -- 길이 4자 이상 제한
    email       VARCHAR2(50)    CONSTRAINT  member_em_nn NOT NULL 
                                CONSTRAINT  member_em_uq UNIQUE,
    gender      CHAR(1),        CHECK(gender IN ('M', 'F')),
    regdate     DATE            DEFAULT SYSDATE
);

INSERT INTO member(userid, email, empno) VALUES('aaa', 'aaa@aaa.com', 3000);
INSERT INTO member(userid, email, empno) VALUES('bbb', 'aaa@aaa.com', '123');
INSERT INTO member(userid, email, userpw) VALUES('bbb', 'bbb@bbb.com', '1234');

DELETE FROM emp WHERE empno = 3000; -- O (ON DELETE CASCADE를 했기 때문)


-- 테이블 생성 시 제약 조건 지정
CREATE TABLE member (
    userid      VARCHAR2(20), 
    empno       NUMBER,
    usernm      VARCHAR2(20) NOT NULL,
    userpw      VARCHAR2(20),
    email       VARCHAR2(50),
    gender      CHAR(1),
    regdate     DATE    DEFAULT SYSDATE,
    
    CONSTRAINT member_pk PRIMARY KEY(userid),
    CONSTRAINT member_fk FOREIGN KEY(empno) REFERENCES emp(empno) ON DELETE SET NULL, -- 부모 레코드 삭세 시 NULL로 설정
    CONSTRAINT member_chk CHECK(LENGTH(userpw) >= 4), 
    UNIQUE(email)
);

INSERT INTO member(userid, usernm, empno) VALUES('aaa', 'userA', 1000);
DELETE FROM emp WHERE empno = 1000;

DROP TABLE member;
SELECT * FROM emp;
SELECT * FROM member;


CREATE TABLE t_qna (
    qno         NUMBER,
    question    VARCHAR2(1000),
    qid         VARCHAR2(20),
    answer      VARCHAR2(1000),
    qdate       DATE,
    adate       DATE,
    mdate       DATE,
    hitno       NUMBER
);

INSERT INTO t_qna(qno, question, qid, qdate, hitno) VALUES(1, 'question?', 'abc', SYSDATE, 0);
INSERT INTO t_qna(qno, question, qid, qdate, hitno) VALUES(1, 'question???', 'bbb', SYSDATE, 0);

-- 기존 테이블에 제약 조건 추가 - PK
ALTER TABLE t_qna ADD CONSTRAINT t_qna_pk PRIMARY KEY(qno);  -- X (중복 데이터 있음)
UPDATE t_qna SET qno = 2 WHERE qid = 'bbb'; -- 중복 제거

ALTER TABLE t_qna ADD CONSTRAINT t_qna_pk PRIMARY KEY(qno);  -- O 

ALTER TABLE t_qna MODIFY qno CONSTRAINT t_qna_pk PRIMARY KEY;

-- 기존 테이블에 제약 조건 추가 - FK
ALTER TABLE t_qna
ADD CONSTRAINT t_qna_fk FOREIGN KEY(qid) REFERENCES t_member(id);  -- X (parent keys not found, member의 id랑 안맞음)

-- t_qna테이블의 qid를 모두 aaa로 변경
UPDATE t_qna SET qid = 'aaaa';

ALTER TABLE t_qna ADD CONSTRAINT t_qna_fk FOREIGN KEY(qid) REFERENCES t_member(id);

ALTER TABLE t_qna MODIFY qid CONSTRAINT t_qna_fk REFERENCES t_member(id) ON DELETE SET NULL;

-- question 컬럼에 NULL을 허용하지 않도록 제약 조건 추가
ALTER TABLE t_qna
ADD CONSTRAINT t_qna_nn NOT NULL(question); -- X (NOT NULL은 추가가 아니라 수정하는 것)

ALTER TABLE t_qna MODIFY(question CONSTRAINT t_qna_nn NOT NULL); -- O


-- question 컬럼에 중복을 허용하지 않도록 제약 조건 추가
ALTER TABLE t_qna ADD UNIQUE(question);

ALTER TABLE t_qna MODIFY question UNIQUE;

ALTER TABLE t_qna MODIFY qdate Date DEFAULT SYSDATE;

ALTER TABLE t_qna MODIFY (hitno NUMBER DEFAULT 0);


-- 제약 조건 삭제
ALTER TABLE t_qna DROP CONSTRAINT t_qna_pk;
ALTER TABLE t_qna DROP CONSTRAINT t_qna_fk;
ALTER TABLE t_qna DROP CONSTRAINT t_qna_nn;
ALTER TABLE t_qna DROP CONSTRAINT t_qna_un;


-- 제약 조건 이름 변경
ALTER TABLE t_qna RENAME CONSTRAINT SYS_C007046 TO t_qna_uq;
    

--------------t_member------------------------------------------------

  CREATE TABLE "SCOTT"."T_MEMBER" 
   (	"ID" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"PW" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"NAME" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"PHOTO" VARCHAR2(100 BYTE), 
	"GENDER" VARCHAR2(5 BYTE), 
	"JOINDATE" DATE, 
	 CONSTRAINT "T_MEMBER_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
---------------------------------------------------------------
DROP TABLE t_member;  -- X (자식 테이블에서 참조 중)
ALTER TABLE t_qna DROP CONSTRAINT T_QNA_FK;

-- t_qna 테이블에 qno를 t_member 테이블의 id를 참조하도록 
-- 외래키 t_qna_fk 추가
ALTER TABLE t_qna ADD CONSTRAINT t_qna_fk FOREIGN KEY(qid) REFERENCES t_member(id);

DROP TABLE t_member;

DROP TABLE t_member CASCADE CONSTRAINTS; -- 부모 테이블 삭제 시, 자식 테이블의 FK 제거

-- t_member 테이블의 구조와 데이터를 복사하여 t_member2 테이블로 생성
CREATE TABLE t_member2 AS SELECT * FROM t_member;


-- t_member2 테이블의 이름을 t_member로 변경
-- t_member2 테이블의 id 컬럼을 기본키로 지정
-- t_qna 테이블의 qno 컬럼을 t_member 테이블의 id를 참조하도록 설정
-- t_qna 테이블에서 참조하고 있는 id 값으로 t_member 레이블에 레코드 하나 추가
-- t_member 테이블의 구조와 데이터를 복사하여 t_member3 테이블로 생성
ALTER TABLE t_member2 RENAME TO t_member;
ALTER TABLE t_member MODIFY(id PRIMARY KEY);
ALTER TABLE t_qna ADD CONSTRAINT t_qna_fk FOREIGN KEY(qid) REFERENCES t_member(id);
INSERT INTO t_member(id, pw, name, email) VALUES ('aaaa', '1111', 'userA', 'a@a.com');
CREATE TABLE t_member3 AS SELECT * FROM t_member;
SELECT * FROM t_member;

-- FK로 참조되는 컬럼 삭제
ALTER TABLE t_member DROP COLUMN id;  -- X (종속)
ALTER TABLE t_member DROP COLUMN id CASCADE CONSTRAINTS; -- O

-- t_member 테이블에 id 컬럼 추가 및 pk 지정
-- t_qna 테이블의 qid 컬럼을 t_member 테이블의 id를 참조하도록 설정
ALTER TABLE t_member ADD id VARCHAR2(20);ww
ALTER TABLE t_member ADD PRIMARY KEY(id);
ALTER TABLE t_qna ADD CONSTRAINT t_qna_fk FOREIGN KEY(qid) REFERENCES t_member(id);


------------------------------------------------------------------------
-- 제약 조건 활성화 및 비활성화
INSERT INTO t_qna(qno, question, qid, qdate, hitno)
VALUES (3, 'question????????', 'bbb', SYSDATE, 0); -- X (종속으로 연결되어 있는 t_member 부모 테이블에 없는 아이디라서)

ALTER TABLE t_qna DISABLE NOVALIDATE CONSTRAINT T_QNA_FK;  -- FK 비활성화

ALTER TABLE t_qna ENABLE NOVALIDATE CONSTRAINT T_QNA_FK;  -- FK 활성화
    -- 새로 추가되는 데이터들부터 제약 조건 검사
    
INSERT INTO t_qna(qno, question, qid, qdate, hitno)
VALUES (4, 'question????????', 'bbb', SYSDATE, 0); -- X

UPDATE t_qna SET qid = 'aaaa' WHERE qno = 3;

ALTER TABLE t_qna ENABLE VALIDATE CONSTRAINT T_QNA_FK;
    -- 모든 데이터 제약 조건 검사


ALTER TABLE t_qna DISABLE VALIDATE CONSTRAINT T_QNA_FK;  -- read only / DML 불가능

INSERT INTO t_qna(qno, question, qid, qdate, hitno) VALUES (3, 'question????????', 'bbb', SYSDATE, 0); -- X


SELECT * FROM USER_CONS_COLUMNS WHERE table_name = 'T_QNA';
SELECT * FROM t_qna;
SELECT * FROM t_member;

-------------------------------------------------------------
ALTER TABLE t_survey_attend ADD FOREIGN KEY(id) REFERENCES t_member(id);
-------------------------------------------------------------






--------------------------------------------------------------
-- 인덱스
--  - 어떤 데이터가 어디에 있는지 알려주기 위해 컬럼에 대해 생성하는 오라클 객체
--  - 원하는 데이터를 빨리 찾기 위해 사용
--  - 기본 키나 유일 키는 데이터 무결성 확인 및 빠른 조회를 목적으로 오라클 내부에서 자동으로 인덱스 생성
--  - 오라클 인덱스는 내부적으로 B* 트리 형식으로 구성
--  - 기본적으로 들어오는 순서대로 기록


-- 인덱스 생성 과정
--  - 전체 테이블 스캔 -> 정렬 -> Block 기록


-- 인덱스 장점
--  - 인덱스를 위한 추가적인 공간 필요
--  - 인덱스 생성에 시간 소요
--  - 데이터의 변경(DML)이 자주 일어나는 경우에는 오히려 성능 저하


-- 인덱스 사용 O
--  - 테이블에 행의 수가 많을 때
--  - WHERE 절에 해당 컬럼이 많이 사용될 때
--  - 검색 결과가 전체 데이터의 2% ~ 4% 정도일 때
--  - JOIN에 자주 사용되는 컬럼이나 NULL 포함 컬럼이 많을 때


-- 인덱스 사용 X
--  - 테이블의 행의 수가 적을 때
--  - WHERE 절에 해당 컬럼이 자주 사용되지 않을 때
--  - 검색 결과가 전체 데이터의 10% ~ 15% 정도일 때
--  - DML이 많이 사용될 때


-- ROWID
--  - 오라클의 모든 데이터가 갖는 고유의 주소
--  - 데이터를 찾아갈 때 필요
--  - ROWID정보를 모아서 갖고 있는 것인 인덱스
SELECT ROWID, ROWNUM, ename FROM t_emp;



SELECT * FROM USER_INDEXES;     --사용자의 모든 인덱스 조회
SELECT * FROM USER_IND_COLUMNS; --인덱스가 지정된 컬럼 조회


-- UNIQUE INDEX
--  - 기본 키나 유일 키처럼 유일한 값을 갖는 컬럼에 대해서 생성
--  - 인덱스 내의 키 값에 중복 데이터 X
--  - 속도가 빠름
CREATE UNIQUE INDEX t_emp_idx
ON                  t_emp(empno);

DROP INDEX t_emp_idx;



-- NON UNIQUE INDEX
--  - 중복 데이터를 갖는 컬럼에 생성
CREATE INDEX t_emp_idx
ON           t_emp(empno);  -- 기본은 오름차순

DROP INDEX t_emp_idx_asc;
SELECT * FROM t_emp;

CREATE INDEX t_emp_idx_desc
ON           t_emp(empno DESC);  -- 내림차순 인덱스

CREATE UNIQUE INDEX t_emp_idx_asc
ON           t_emp(ename);  

SELECT * FROM t_emp WHERE sal >= 2000;
SELECT * FROM t_emp WHERE ename = 'Lee';
SELECT * FROM t_emp WHERE empno <= 5000;

SELECT * FROM t_survey;

CREATE UNIQUE INDEX t_survey_pk_desc
ON           t_survey(sno DESC); 

SELECT * FROM t_survey ORDER BY sno DESC;






