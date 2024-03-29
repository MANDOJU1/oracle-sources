-- scott

-- SELECT(데이터 조회)
--e : 별칭(임의 지정 가능) / 없어도 됨
--* : 전체 필드(컬럼)를 의미함
SELECT * FROM  EMP e;

--특정 컬럼에 해당하는 내용 보기
SELECT
	EMPNO,
	ENAME,
	JOB
FROM
	emp;

-- emp 테이블
-- empno(사원번호), ename(사원명), job(직책), mgr(매니저번호), hiredatr(고용일), sal(급여),comm(보너스)
-- deptno(부서번호)


-- emp 테이블에서 사원번호, 매니저번호, 부서번호만 조회
SELECT EMPNO, MGR, DEPTNO FROM emp;


-- emp 테이블에서 부서번호만 조회(중복 데이터제거) 조회
SELECT DISTINCT deptno
FROM EMP e;


-- 데이터 출력 시 필드명 별칭 부여
--쌍따옴표는 별칭에 공백이 있는 경우 무조건 사용
--AS 생략 가능
SELECT
	EMPNO AS 사원번호,
	MGR 매니저번호,
	DEPTNO "부서 번호"
FROM
	emp;
	

-- 연봉 계산
-- 월급 * 12 + 수당
-- sal * 12 + comm
SELECT empno, sal, sal * 12 + comm AS "연봉"
FROM emp e;


-- 정렬 조회
--order by 정렬기준컬럼명 + DESC or ASC
--DESC(내림차순), ASC(오름차순-default)
SELECT
	*
FROM
	emp
ORDER BY SAL DESC;


-- emp 테이블에서 empno, ename, sal 조회 (단, empno 내림차순)
SELECT
	empno, ename, sal
FROM
    EMP 
ORDER BY EMPNO desc;


-- 전체조회, 부서번호 오름차순, sal 내림차순
SELECT
	*
FROM
	emp e
ORDER BY DEPTNO, SAL DESC;


-- 조건 
-- 부서번호가 30번인 사원 조회
-- sal > 1000이상인 사원 조회
SELECT * FROM emp e
WHERE DEPTNO =30;

SELECT
	*
FROM emp e
WHERE sal >= 1000;


SELECT *
FROM emp e
WHERE sal >= 1000
ORDER BY sal DESC;

--empno가 7782 인 사원 조회
-- = (같다), 산술연산자 (>, <, >=, <=)
SELECT *
FROM emp e
WHERE EMPNO = 7782;

-- deptno 30이고, job 이 salesman
-- 데이터는 대소문자 구별 함
SELECT *
FROM emp e
WHERE deptno = 30 AND job = 'SALESMAN';

-- 사원번호가 7499 이고 부서번호가 30인 사원 조회
SELECT *
FROM EMP E
WHERE EMPNO =7499 AND DEPTNO =30;


-- 이거나(혹은) : OR
-- 부서번호가 30 이거나 job SALESMAN 사원 조회
SELECT *
FROM EMP e 
WHERE DEPTNO = 30 OR job = 'SALESMAN';


-- 연봉이 36000 인 사원 조회
-- 연봉 SAL * 12 + COMM
SELECT *
FROM EMP e 
WHERE SAL * 12 + COMM = 36000; 

-- 문자 비교도 가능 - 산술연산 기호 가능
-- 알파벳 순서로 F 다음에 있는 
SELECT *
FROM EMP e 
WHERE ENAME >= 'F';


-- sal 이 3000이 아닌 사원 조회
-- ~ 이 아닌 : !=, <>, ^=
SELECT *
FROM EMP e 
WHERE SAL != 3000;

SELECT *
FROM EMP e 
WHERE SAL <> 3000;

SELECT *
FROM EMP e 
WHERE SAL ^= 3000;

-- job 이 MANAGER OR SALESMAN OR CLERK
SELECT *
FROM EMP e 
WHERE JOB = 'MANAGER' OR  JOB = 'SALESMAN' OR  JOB = 'CLERK';


-- IN 
SELECT *
FROM EMP e 
WHERE JOB IN('MANAGER','SALESMAN','CLERK' );

SELECT *
FROM EMP e 
WHERE JOB NOT IN('MANAGER','SALESMAN','CLERK' );

--HIREDATE 가 1981 10 31 이후에 고용된 사원 조회
--날짜 데이터 산술 연산 가능, 날짜 데이터 '' 로 처리
SELECT *
FROM EMP e 
WHERE HIREDATE > '1981-10-31';

-- BETWEEN A AND B
-- SAL 2000이상 3000이하 인 사원을 조회
SELECT *
FROM EMP e 
WHERE SAL BETWEEN 2000 AND 3000;

-- NOT BETWEEN A AND B
-- SAL 2000 이상 3000이하가 아닌 사원 조회
SELECT *
FROM EMP e 
WHERE SAL NOT BETWEEN 2000 AND 3000;



-- 2일차
-- LIKE 연산자와 와일드 카드 (_, %)
-- _ : 문자 하나
-- % : 문자 개수는 무한대

-- 사원 이름이 S로 시작하는 사원 조회
SELECT * 
FROM EMP e 
WHERE ENAME LIKE 'S%';

-- 사원 이름의 두번째 글자가 L인 사원
SELECT *
FROM EMP e 
WHERE ENAME LIKE '_L%';

-- 사원 이름에 AM 문자가 포함된 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME LIKE '%AM%';

-- 사원 이름에 AM 문자가 포함되지 않은 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME NOT LIKE '%AM%';

--
SELECT *FROM EMP e;

-- NULL : 값이 없는 상태
-- '' : 빈 값
-- ' ' : 스페이스 바도 문자임

-- comm 이 null 인 사원 조회
-- null 비교 : IS
SELECT * FROM EMP e WHERE comm = NULL; --(x)
SELECT * FROM EMP e WHERE comm is NULL;

-- MGR 이 NULL 인 사원 조회
SELECT *FROM EMP e WHERE MGR IS NULL;

-- MGR 이 NULL 이 아닌 사원 조회
SELECT  * FROM EMP e WHERE MGR IS NOT NULL;


-- 집합연산자 
-- 합집합(UNION, NUNION ALL), 교집합(INTERSECT), 차집합(MINUS)

-- 부서번호 10 혹은 20 사원 조회
-- OR 사용해서 추출
-- 합집합

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
WHERE DEPTNO = 10
UNION 
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP e 
WHERE DEPTNO = 20;

-- 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.(오류)
-- 집합 연산자 UNION 을 사용할 때 출력 열 개수, 타입 동일
--SELECT EMPNO, ENAME, SAL, DEPTNO
--FROM EMP e 
--WHERE DEPTNO = 10
--UNION 
--SELECT EMPNO, ENAME, SAL 
--FROM EMP e 
--WHERE DEPTNO = 20;


-- 타입 동일 (실행가능)
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
WHERE DEPTNO = 10
UNION 
SELECT SAL, JOB, DEPTNO, SAL 
FROM EMP e 
WHERE DEPTNO = 20;


-- 결과 값의 중복 제거
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
WHERE DEPTNO = 10;


-- UNION ALL : 중복된 결과 값 제거 안함
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
WHERE DEPTNO = 10;


-- MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
WHERE DEPTNO = 10;

-- INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e 
WHERE DEPTNO = 10;



-- 오라클 함수(내장 함수)
-- 함수는 사용하는 DBMS 에 따라 다르게 제공
-- 1. 문자 함수
-- 1 )대소문자 변경

SELECT ENAME 
FROM EMP e 
WHERE ENAME = upper('clark');

SELECT ENAME 
FROM EMP e 
WHERE lower(ENAME) = 'clark';

-- upper(문자열) : 괄호 안 문자를 모두 대문자로 변환하여 반환
-- lower(문자열) : 괄호 안 문자를 모두 소문자로 변환하여 반환
-- initcap(문자열) : 괄호 안 문자 데이터 중 첫번째 글자만 대문자로 
--                    나머지는 소문자로 변환하여 반환
SELECT ENAME , UPPER(ENAME), lower(ENAME), INITCAP(ENAME) 
FROM EMP e;

-- 2) 문자열 길이 : LENGTH, LENGTHB
-- LENGTHB : 문자열에 사용된 바이트 수 반환 
SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME) 
FROM EMP e;

-- 함수 결과를 보고 싶은데 테이블이 없는 경우 임시 테이블로 DUAL 사용
-- 한글은 문자 하나당 3byte 할당, 영어 1byte
SELECT  LENGTH('한글'), LENGTHB('한글') FROM DUAL;

-- 직책 이름이 6글자 이상인 사원 조회
SELECT *
FROM EMP e 
WHERE LENGTH(job) >= 6;

-- 3) 문자열 일부 추출 : substr(문자열데이터, 시작위치, 추출길이)
--                       substr(문자열데이터, 시작위치) : 시작위치 ~ 마지막까지
                         시작 위치가 음수라면 오른쪽 끝부터 시작
SELECT job, SUBSTR(job,1,2), substr(job,3,2), substr(job,5) 
FROM EMP e;

SELECT job, SUBSTR(job,-1,2), substr(job,-3,2), substr(job,-5) 
FROM EMP e;

-- 4) INSTR(문자열데이터, 위치를 찾으려는 문자, 시작위치, 시작위치에서 몇번째 위치)
--    문자열 데이터 안에서 특정 문자 위치 찾기

SELECT INSTR('HELLO, ORACLE!','L') AS INSTR_1,
       INSTR('HELLO, ORACLE!','L',5) AS INSTR_2,
       INSTR('HELLO, ORACLE!','L',2,2) AS INSTR_3
	FROM DUAL;

-- 사원 이름에 S 가 들어있는 사원 조회
-- LIKE 

SELECT *
FROM EMP e 
WHERE INSTR(ENAME,'S') > 0;

-- 5) REPLACE : 특정 문자를 다른 문자로 변경
--              REPLACE(문자열데이터, 찾는문자, 변경할문자)

SELECT '010-1234-5678' AS REPLACE_BEFORE,
	    REPLACE('010-1234-5678','-','') AS REPLACE_1,
	    REPLACE('010-1234-5678','-') AS REPLACE_2,
	    REPLACE('010-1234-5678','-',' ') AS REPLACE_3
FROM DUAL;

-- 6) CONCAT : 두 문자열 데이터 합하는 함수
--              CONCAT(문자열데이터1, 문자열데이터2)
--SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,ENAME,JOB) --> 3개 써서 오류
--FROM EMP e
--WHERE ENAME = 'SCOTT';

-- 7369 : SMITH
SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO, CONCAT(' : ',ENAME)) 
FROM EMP e
WHERE ENAME = 'SMITH';


SELECT EMPNO ||' : '|| ENAME 
FROM EMP e
WHERE ENAME = 'SMITH'

-- 7) TRIM : 공백 제거(기본)
--    TRIM(삭제옵션(선택), 삭제 할 문장) FROM 원본문자열
-- 'SMITH' = 'SMITH ' ' SMITH' ' SMITH '(다 다른 문자 / 공백도 문자이기때문)


SELECT '[' || (' __Oracle__ ') || ']' AS trim_before,
	   '[' || TRIM(' __Oracle__ ') || ']' AS trim,
	   '[' || LTRIM(' __Oracle__ ') || ']' AS Ltrim,
	   '[' || RTRIM(' __Oracle__ ') || ']' AS Rtrim
FROM DUAL;

-- LEADING : 앞에만 삭제
-- TRALING : 뒤에만 삭제
-- BOTH : 둘 다 삭제
SELECT '[' || (' __Oracle__ ') || ']' AS trim_before,
	   '[' || TRIM(LEADING '_' FROM'__Oracle__') || ']' AS TRIM_READING,
	   '[' || TRIM(TRAILING '_' FROM'__Oracle__') || ']' AS TRIM_TRAILING,
	   '[' || TRIM(BOTH '_' FROM'__Oracle__') || ']' AS TRIM_BOTH
FROM DUAL;


-- 2. 숫자함수 : 숫자 데이터에 적용
--	  반올림, 올림, 버림, 나머지값
--	  ROUND,/ CEIL,FLOOR / TRUNC,/ MOD

-- ROUND(숫자, 반올림위치)
SELECT ROUND(1234.5678) AS ROUND,
	   ROUND(1234.5678,0) AS ROUND1, 
	   ROUND(1234.5678,1) AS ROUND2,
	   ROUND(1234.5678,2) AS ROUND3,
	   ROUND(1234.5678,-1) AS ROUND_MINUS1,
	   ROUND(1234.5678,-2) AS ROUND_MINUS2
FROM DUAL;

-- TRUNC(숫자, 버릴위치) : 버림
SELECT TRUNC(1234.5678) AS TRUNC,
	   TRUNC(1234.5678, 0) AS TRUNC0,
	   TRUNC(1234.5678, 1) AS TRUNC1,
	   TRUNC(1234.5678, 2) AS TRUNC2,
	   TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
	   TRUNC(1234.5678, -2) AS TRUNC_MINSU2
FROM DUAL;

-- CEIL, FLOOR : 지정한 숫자와 가까운 정수를 찾기
-- CETL : 지정한 숫자보다 큰 정수 중 가장 작은 정수
-- FLOOR : 지정한 숫자보다 작은 정수 중 가장 큰 정수 반환
SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)  
FROM DUAL;


-- MOD : 나머지
SELECT 11/5, MOD(11,5)
FROM DUAL;


-- 3. 날짜 함수
-- 2023-01-24 OR 2023/01/24

-- 오늘날짜
SELECT SYSDATE, CURRENT_DATE, CURRENT_TIMESTAMP 
FROM DUAL;


-- 날짜데이터 + 숫자 : 날짜 데이터보다 숫자만큼 이후의 날짜
SELECT SYSDATE, (SYSDATE + 1), (SYSDATE - 1)
FROM DUAL;

-- ADD_MONTH() : 몇 개월 이후의 날짜 구하기
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3) 
FROM DUAL;

-- 입사 30주년 되는 날짜 구하기
SELECT EMPNO ,ENAME , HIREDATE, ADD_MONTHS(HIREDATE,360) 
FROM EMP e;

-- MONTH_BETWEEN(날짜1, 날짜2) : 두 개의 날짜 데이터를 입력하고 두 날짜간의 개월 수 차이 구하기
-- 고용일과 오늘날짜 차이
SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3
FROM
	EMP e;

-- NEXT_DAY, LAST_DAY
-- NEXT_DAY(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
-- LAST_DAY(날짜) : 특정 날짜가 속한 달의 마지막 날짜
SELECT SYSDATE, NEXT_DAY(SYSDATE,'월요일'), LAST_DAY(SYSDATE)  
FROM DUAL;


-- 데이터 타입
-- NUMBER(숫자), VARCHAR2(문자), DATE(날짜/시간)
-- 자료형 변환(날짜 -> 문자, 문자 -> 숫자)


--NUMBER + 문자 : 자동 형 변환으로 계산 처리
SELECT EMPNO, EMPNO + '500'
FROM EMP e
WHERE ENAME = 'FORD';

--수치가 부적합합니다
--SELECT EMPNO, EMPNO + 'ABCD'
--FROM EMP e
--WHERE ENAME = 'FORD';

-- 명시적 형변환
-- TO_CHAR(날짜(숫자)데이터, '출력되기를 원하는 문자 형태') : 숫자, 날짜 데이터를 출력할 문자형태를 지정 (주로 날자 데이터에 사용)
--TO_NUMBER() : 문자 데이터를 숫자로 변환 / 문자열 데이터를 지정한 형태의 숫자로 인식하여 숫자 데이터로 변환
--TO_DATE() : 문자 데이터를 날짜로 변환

-- Y : 연도, M : 월, D : 일, HH : 시간, MI : 분, SS : 초 HH24 : 시를 24시간으로 표현, AM(PM) : 오전,오후 표현
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD'), SYSDATE, TO_CHAR(SYSDATE, 'YY/MM/DD HH:MI:SS AM')  
FROM DUAL;

SELECT 1300 - '1500', '1300' + 1500
FROM DUAL;

SELECT '1300' + '1500'
FROM DUAL;

--수치가 부적합합니다 (콤마(,) 를 쓰면 안됨)
--SELECT '1,300' + '1,500'
--FROM DUAL;

-- 9 : 숫자의 한 자리를 의미함(빈자리를 채우지 않음)
-- 0 : 빈 자리를 0으로 채움
SELECT TO_NUMBER('1,300','999,999') + TO_NUMBER('1,500','999,999')
FROM DUAL;

SELECT TO_CHAR(SAL, '999,999.00') AS SAL1,
	   TO_CHAR(SAL, '000,999,999.00') AS SAL2
FROM EMP e;


-- TO_DATE(문자, '인식될 날짜 형태') : 문자 데이터를 날짜 데이터로 변환
SELECT
	TO_DATE('2024-01-24') AS TODATE1,
	TO_DATE('20240124') AS TODATE2,
FROM DUAL;

--수치가 부적합합니다.
--SELECT '2024-01-24' - '2023-12-31'
--FROM DUAL;

SELECT TO_DATE('2024-01-24') - TO_DATE('2023-12-31')
FROM DUAL;

-- NULL 처리 함수
-- NULL * 숫자 -> NULL, NULL + 숫자 -> NULL
-- NULL 을 다른 값으로 변경

SELECT EMPNO, ENAME, SAL, COMM, SAL + COMM
FROM EMP e;

--NVL(NULL인지 검사할 열이름(OR 데이터), 대체할 데이터) 
SELECT EMPNO, ENAME, SAL, COMM, SAL + NVL(COMM,0)
FROM EMP e;

--NVL2(NULL인지 검사할 열이름(OR 데이터),NULL 이 아닌경우 반환 데이터(계산식), NULL인 경우 반환 데이터(계산식)
SELECT EMPNO, ENAME, SAL, COMM, NVL2(COMM, '0', 'X')
FROM EMP e;

--NVL2
--COMM 이 NULL 이면 연봉 = SAL *12, NULL이 아니면 연봉 = SAL * 12 + COMM
SELECT EMPNO, ENAME, SAL, COMM, NVL2(COMM, SAL * 12 + COMM, SAL * 12) AS 연봉
FROM EMP e;


--JOB 이 MANAGER 라면 SAL * 1.1  (조건1)
--JOB 이 SALESMAN 라면 SAL * 1.05 (조건2)
--JOB 이 ANALYST 라면 SAL (조건3)
--       나머지 직무 SAL * 1.03 (조건 1,2,3 일치하지 않고 반환할 결과)

--DECODE 함수 CASE 문
--DECODE(검사대상, 조건1, 조건1이 참일 때 반환할 결과, 조건2, 조건2가 참일 때 반환할 결과, ..., 조건1 ~ 조건n 일치하지 않는 경우 반환할 결과 )
SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	DECODE(JOB, 'NANARER', SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ANALYST', SAL, SAL * 1.03) AS UPSAL
FROM
	EMP e;



-- CASE
SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	CASE
		job 
		WHEN 'NANARER' THEN SAL * 1.1
		WHEN 'SALESMAN' THEN SAL * 1.05
		WHEN 'ANALYST' THEN SAL
		ELSE SAL * 1.03
	END AS UPSAL2, 
	DECODE(JOB, 'NANARER', SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ANALYST', SAL, SAL * 1.03) AS UPSAL
FROM
	EMP e;


-- COMM 이 NULL 일때 해당 사항 없음 
-- 	 	   0 일때    수당없음
--         > 0       수당 : COMM

SELECT
	EMPNO,
	ENAME,
	COMM,
	CASE
		WHEN COMM IS NULL THEN '해당 사항 없음'
		WHEN COMM = 0 THEN '수당 없음'
		WHEN COMM > 0 THEN '수당 : ' || COMM
	END AS COMM_TEXT
FROM
	EMP e;

-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일 이다. 하루 근무시간을 8시간으로 보았을 때 사원들의 하루 급여(DAY_PAY)와
--시급(TIME_PAY)를 계산하여 결과를 출력한다. 단 하루 급여는 소수점 셋째 자리에서 버리고, 시급은 두 번째 소수점에서 반올림한다.

SELECT EMPNO, ENAME, SAL,
ROUND(SAL/21.5/8,1) AS TIME_PAY,
TRUNC(SAL/21.5,2) AS DAY_PAY
FROM EMP e;

--EMP 테이블에서 사원들은 입사일(HIREDATE)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 
--사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 아래와 같이 출력한다.
--단, 추가수당(COMM)이 없는 사원의 추가 수당은 N/A로 출력한다

-- 칼럼은 숫자형태의 데이터로 형성되어있어서 문자열N/A와 같이 수행될 수 없음. 
-- COMM 을 TO_CHAR로 감싸야 같은 문자열이 되어 수행될 수 있음


SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	NEXT_DAY(ADD_MONTHS (HIREDATE,3), '월요일') AS R_JOB,
	NVL(TO_CHAR(COMM), 'N/A') AS COMM 
FROM
	EMP e;

SELECT
	EMPNO,
	ENAME,
	TO_CHAR(HIREDATE, 'YY/MM/DD') AS hiredate,
	TO_CHAR(ADD_MONTHS(NEXT_DAY(HIREDATE, '월요일'), 3), 'YY/MM/DD') AS R_JOB,
--	NEXT_DAY(ADD_MONTH(HIREDATE,3), '월요일') AS R_JOB,
	NVL(TO_CHAR(COMM), 'N/A') AS COMM 
FROM
	EMP e;

--EMP 테이블의 모든 사원들 대상으로 직속 상관의 사원 번호(MGR)를 다음과 같은 조건을 기준으로 변환해서
--CHG_MGR 열에 출력한다.
--직속상관의 사원 번호가 존재하지 않을 경우 : 0000
--직속상관의 사원 번호 앞 두자리가 75일 경우 :5555
--직속상관의 사원 번호 앞 두자리가 76일 경우 : 6666
--직속상관의 사원 번호 앞 두자리가 77일 경우 : 7777
--직속상관의 사원 번호 앞 두자리가 78일 경우 : 8888
--그 외 직속상관의 사원 번호의 경우 : 본래 직속 상관의 사원번호 그대로 출력 


--SUBSTR(TO_CHAR(mgr),1,2)
SELECT
	EMPNO,
	ENAME,
	MGR, 
	DECODE (SUBSTR(TO_CHAR(mgr), 1, 2), NULL, '0000', '75', 5555, '76', '7777', '78', '8888', SUBSTR(TO_CHAR(mgr), 1))AS CHG_MGR
FROM
	EMP e;



SELECT
	EMPNO,
	ENAME,
	MGR, 
	   CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = 75 THEN '5555'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = 76 THEN '6666'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = 77 THEN '7777'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = 78 THEN '8888'
		ELSE TO_CHAR(mgr)
	END AS CHG_MGR
FROM
	EMP e;


-- 여쭤보기 !!!!!!!!!!!!!!!!!!
SELECT
	EMPNO,
	ENAME,
	MGR, 
	   CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
		WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
		ELSE TO_CHAR(mgr)
	END AS CHG_MGR
FROM
	EMP e;


SELECT
	EMPNO,
	ENAME,
	MGR, 
	   CASE SUBSTR(TO_CHAR(NVL(MGR,0)), 1, 2)
		WHEN '0'  THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE TO_CHAR(mgr)
	END AS CHG_MGR
FROM
	EMP e;



-- 다중 행 함수
-- sum(), avg(), count(), max(), min() 

--단일 그룹의 그룹 함수가 아닙니다(여러 행이 나올 수 있는 컬럼을 추가한 경우)
SELECT sum(sal), avg(SAL), COUNT(SAL), max(SAL), min(sal), ENAME 
FROM EMP e;

-- 동일한 급여를 하나만 선택해서 합계
SELECT sum(DISTINCT sal)
FROM EMP e;

SELECT COUNT(*)
FROM EMP e;

-- 부서번호가 30인 사원 수 출력
SELECT COUNT(*)
FROM EMP e 
WHERE DEPTNO =30;

-- 부서번호가 30인 사원 중에서 급여의 최대값
SELECT MAX(SAL)
FROM EMP e 
WHERE DEPTNO =30;

--부서번호가 20인 사원의 입사일 중에서 제일 최근 입사일 조회
SELECT MAX(hiredate)
FROM EMP e 
WHERE deptno = 20;


--부서번호가 20인 사원의 입사일 중에서 제일 오래된 입사일 조회
SELECT min(hiredate)
FROM EMP e 
WHERE deptno = 20;

-- 부서번호가 30인 사원 중에서 sal 중복값 제거한 후 평균구하기
SELECT avg(DISTINCT sal)
FROM EMP e 
WHERE DEPTNO =30;


--부서별 급여 합계 구하기

SELECT '10' AS deptno, sum(sal)
FROM EMP e
WHERE deptno = 10
UNION
SELECT '20' AS deptno, sum(sal)
FROM EMP e
WHERE deptno = 20
UNION
SELECT '30' AS deptno, sum(sal)
FROM EMP e
WHERE deptno = 30;

--결과 값을 원하는 열로 묶는방법 : GROUP BY
--SELECT 보고싶은 컬럼(열이름) 나열....             	  ①
--FROM 테이블 명									 	  ②
--WHERE 조건들 나열										  ③
--GROUP BY 그룹화할 열 이름 나열 .....(HAVING - option)	  ④
--ORDER BY 정렬조건 									  ⑤

--실행 순서
-- ② -> ③ -> GROUP BY -> HAVING -> ① -> ⑤


--GROUP BY 표현식이 아닙니다.
--GROUP BY 옆에 오는 컬럼만 SELECT 절에 사용 가능

SELECT deptno, sum(sal)
FROM EMP e 
GROUP BY deptno;

-- 부서별 급여 평균
SELECT deptno, AVG(sal)
FROM EMP e 
GROUP BY DEPTNO;

-- 부서번호, 직무별 급여 평균 
SELECT deptno,job, AVG(sal)
FROM EMP e 
GROUP BY DEPTNO, job
ORDER BY deptno;

--HAVING : GROUP BY 절에 조건을 사용할 때
-- 부서별 직책의 평균 급여가 500이상인 사원들의 부서번호, 직책, 부서별 직책평균급여 
SELECT DEPTNO, JOB, avg(sal)
FROM EMP e 
GROUP BY DEPTNO, JOB HAVING avg(sal) >=500
ORDER BY DEPTNO, JOB;


SELECT DEPTNO, JOB, avg(sal)
FROM EMP e 
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB HAVING avg(sal) >= 2000
ORDER BY DEPTNO, JOB;

-- 같은 직무에 종사하는 사원이 3명 이상인 직무와 인원수 조회
SELECT JOB, COUNT(JOB)
FROM EMP e 
GROUP BY JOB HAVING COUNT(JOB) >= 3
ORDER BY JOB;

-- 사원들의 입사연도를 기준으로 부서별 몇 명이 입사했는지 조회
SELECT  DEPTNO, TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR, COUNT(*) AS 인원수
FROM EMP e 
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY DEPTNO;


-- JOIN : 여러 테이블을 하나의 테이블처럼 사용
-- 1) 내부조인 (일치하는 값이 있을 경우)
-- EMP 와 DEPT 조인
SELECT *
FROM EMP e, DEPT d 
WHERE E.DEPTNO = D.DEPTNO;


--열의 정의가 애매합니다 (조인 할 경우 테이블에 동일한 컬럼명이 존재하는 경우)
SELECT e.ename, e.sal, d.loc, d.DEPTNO 
FROM EMP e, DEPT d 
WHERE E.DEPTNO = D.DEPTNO;


-- 조인 조건 없을 때 나올 수 있는 모든 조합이 결과로 출력 / WHERE 절 없는 조인은 없음
SELECT e.ename, e.sal, d.loc, d.DEPTNO 
FROM EMP e, DEPT d;


SELECT e.ename, e.sal, d.loc, d.DEPTNO 
FROM EMP e, DEPT d 
WHERE E.DEPTNO = D.DEPTNO AND e.sal >= 3000;


-- SQL-99 표준구문(JOIN ~ ON)
SELECT e.ename, e.sal, d.loc, d.DEPTNO 
FROM EMP e INNER JOIN DEPT d ON E.DEPTNO = D.DEPTNO 
WHERE e.sal >= 3000;


-- EMP 와 SALGRADE 조인
SELECT *
FROM emp e, SALGRADE s 
WHERE e.sal BETWEEN s.losal AND s.hisal;



-- EMP 와 EMP 조인(SELF JOIN)
SELECT e.empno, e.ename, e.mgr, e2.ENAME AS mgr_name
FROM EMP e , EMP e2 
WHERE E.MGR = E2.EMPNO;


-- 2) 외부조인
-- (1) 왼쪽 외부조인 : LEFT OUTER JOIN
-- (2) 오른쪽 외부조인 : RIGHT OUTER JOIN

SELECT e.empno, e.ename, e.mgr, e2.ENAME AS mgr_name
FROM EMP e LEFT OUTER JOIN EMP e2 ON E.MGR = E2.EMPNO;


SELECT e.empno, e.ename, e.mgr, e2.ENAME AS mgr_name
FROM EMP e RIGHT OUTER JOIN EMP e2 ON E.MGR = E2.EMPNO;

-- 각 부서별 평균급여, 최대급여, 최소급여, 사원수
-- 부서번호, 부서명, 평균급여, 최대급여, 최소급여, 사원수 

SELECT e.DEPTNO,d.DNAME, MIN(SAL), MAX(SAL), MIN(SAL), COUNT(*)
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
GROUP BY e.DEPTNO, d.DNAME; 


-- 세 개의 테이블 조인하기
SELECT
	*
FROM
	emp e1
JOIN emp e2 ON
	e1.empno = e2.EMPNO
JOIN EMP e3 ON
	e2.EMPNO = e3.EMPNO;

-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원이름 순으로 정렬하여 출력
-- 부서번호, 부서명, 사원번호, 사원명, 직무, 급여
--dept 테이블 기준으로 출력
SELECT d.DEPTNO, d.DNAME, e.EMPNO, e.ENAME, e.JOB, e.SAL 
FROM DEPT d LEFT OUTER JOIN EMP e ON d.DEPTNO = e.DEPTNO 
ORDER by d.DEPTNO, e.ENAME;


SELECT d.DEPTNO, d.DNAME, e.EMPNO, e.ENAME, e.JOB, e.SAL 
FROM EMP e  RIGHT OUTER JOIN DEPT d ON d.DEPTNO = e.DEPTNO 
ORDER by d.DEPTNO, e.ENAME;

-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원이름 순으로 정렬하여 출력
-- 부서번호, 부서명, 사원번호, 사원명, 직무, 급여, LOSAL, HISAL, GRADE
--dept 테이블 기준으로 출력

SELECT
	d.DEPTNO,
	d.DNAME,
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	s.LOSAL, 
	s.HISAL, 
	s.GRADE
FROM
	DEPT d
LEFT OUTER JOIN EMP e ON
	d.DEPTNO = e.DEPTNO
LEFT OUTER JOIN SALGRADE s ON
	e.sal BETWEEN s.LOSAL AND s.HISAL
ORDER BY
	d.DEPTNO,
	e.ENAME;



-- 4일차
-- 서브쿼리
-- SQL 문 안에 내부에서 SELECT 문을 사용
-- 괄호로 묶어서 사용 
-- 메인쿼리에 비교대상과 같은 자료형과 같은 개수로 서브쿼리에 지정해야 한다.

-- JONES 사원의 급여보다 높은 급여를 받는 사원 조회
-- JONES 급여 알아내기 => 비교

SELECT SAL
FROM EMP e 
WHERE e.ENAME = 'JONES';

SELECT *
FROM EMP e
WHERE SAL > 2975;

SELECT
	*
FROM
	EMP e
WHERE
	SAL > (
	SELECT
		SAL
	FROM
		EMP e
	WHERE
		e.ENAME = 'JONES');
	
--ALLEN 이 받는 COMM 보다 많은 추가수당을 받는 사원 조회
SELECT *
FROM EMP e 
WHERE COMM > (SELECT COMM FROM EMP e WHERE E.ENAME = 'ALLEN');


-- WARD 사원의 입사일보다 빠른 입사자 조회 (어제보다 오늘이 더 큰 숫자)
SELECT * 
FROM EMP e 
WHERE HIREDATE < (SELECT HIREDATE FROM EMP e WHERE E.ENAME = 'WARD');


-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 조회
-- 사원번호, 사원명, 직무, 부서번호, 부서명, 지역

SELECT e.EMPNO, e.ENAME, e.JOB, e.sal, d.DEPTNO
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE e.DEPTNO = 20 AND e.sal > (SELECT AVG(sal) FROM EMP); 


-- 단일행 서브쿼리 : 서브쿼리 실행 결과가 단 하나의 행으로 나오는 서브쿼리
-- 	사용 가능한 연산자 : >, <, >=, <=, <>, ^=, !=

-- 다중행 서브쿼리 : 서브쿼리 실행 결과가 여러개의 행으로 나오는 서브쿼리
-- 	사용 가능한 연산자 : IN, ANY(SOME), ALL, EXISTS
--						 IN,ANY(SOME) : 메인 쿼리의 조건식을 만족하는 서브쿼리가 하나이상
--                       ALL : 메인쿼리의 조건식을 서브 쿼리의 결과 모두가 만족
--                       EXISTS : 서브 쿼리의 결과가 존재하면 


-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
-- 서브쿼리가 여러 개의 결과값을 리턴하는데 단일행 서브쿼리에 사용하는 연산자가 사용된 경우
SELECT * FROM EMP e WHERE sal >= (SELECT max(sal) FROM emp GROUP BY DEPTNO);


SELECT * FROM EMP e WHERE sal IN (SELECT max(sal) FROM emp GROUP BY DEPTNO);

-- IN 사용과 동일한 결과
SELECT * FROM EMP e WHERE sal = ANY (SELECT max(sal) FROM emp GROUP BY DEPTNO);


-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	sal < ANY (
	SELECT
		sal
	FROM
		emp
	WHERE
		DEPTNO = 30);


SELECT
	*
FROM
	EMP e
WHERE
	sal < ALL (
	SELECT
		sal
	FROM
		emp
	WHERE
		DEPTNO = 30);


SELECT
	*
FROM
	EMP 
WHERE
	EXISTS (
	SELECT
		DNAME
	FROM
		DEPT
	WHERE
		DEPTNO = 20);
	
	
-- [실습 1] 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원정보, 부서 정보를 다음과 같이 출력하는 SQL문을 작성하기
	SELECT e.JOB, e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME 
	FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
	WHERE e.JOB IN (SELECT job FROM EMP e WHERE e.ENAME = 'ALLEN');
	
	


-- [실습 2] 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보, 급여 등급 정보를 출력하는 SQL문 작성 
--	(단, 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 사원번호를 기준으로 오름차순으로 정렬)
SELECT e.empno, e.ename, e.hiredate, e.sal, d.dname, d.loc, s.GRADE 
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE e.sal < (SELECT AVG(e.SAL) FROM EMP e)
ORDER BY e.sal DESC, e.EMPNO ASC;


	
-- 다중 열 서브쿼리		
-- 부서 별 급여 최대 값
SELECT *
FROM EMP e 
WHERE (DEPTNO, SAL) IN 
(SELECT DEPTNO, max(SAL)
FROM EMP e 
GROUP BY DEPTNO);

--FROM 절에 사용하는 서브쿼리 (인라인 뷰)
	
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO=10) E10,
	 (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;


-- SELECT 절에 사용하는 서브쿼리 (스칼라 서브쿼리)

SELECT EMPNO, ENAME, JOB, SAL, (SELECT GRADE FROM SALGRADE s WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL) AS SALGRADE
FROM EMP e;	
	
	
	
-- DML(Data Manipulation Languge - 데이터 조작 언어)
-- SELECT(조회), INSERT(삽입), UPDATE(수정), DELETE(삭제)

-- 기존 테이블 복제해서 새로운 테이블 생성
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

-- 새로운 부서 추가
-- INSERT INTO 테이블명(열이름1, 열이름2...)
-- VALUES(데이터, 데이터....)

 INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
 VALUES(60, 'DATABASE', 'BUSAN');
	

 INSERT INTO DEPT_TEMP
 VALUES(70, 'DATABASE', 'BUSAN');	

-- 값의 수가 충분하지 않습니다
INSERT INTO DEPT_TEMP
 VALUES(80, 'DATABASE');		
	
INSERT INTO DEPT_TEMP(DEPTNO,DNAME)
 VALUES(80, 'DATABASE');

-- 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다. 
INSERT INTO DEPT_TEMP(DEPTNO,DNAME)
 VALUES(800, 'DATABASE');

-- 
INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
 VALUES(90, 'DATABASE', NULL);

CREATE TABLE EMP_TEMP AS SELECT * FROM EMP;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (8000, 'HONG', 'MANAGER', 7902, '2015-03-15', 1000, NULL, 50);

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9000, 'SUNG', 'MANAGER', 7782, SYSDATE, 1200, 800, 50);

-- 테이블의 구조만 복사 (데이터를 복사하지 않을 때)
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP WHERE 1<>1;

-- 수정
-- UPDATE 테이블명 SET 수정할 내용, ... , ... ;
-- UPDATE 테이블명 SET 수정할 내용, ... , ... WHERE 조건;

UPDATE DEPT_TEMP 
SET LOC = 'BUSAN';

UPDATE DEPT_TEMP 
SET LOC = 'SEOUL'
WHERE DEPTNO = 50;

UPDATE DEPT_TEMP 
SET LOC = 'SEOUL', DNAME = 'NETWORK'
WHERE DEPTNO = 40;



-- 삭제 : DELECT (행단위)
-- DELECT 테이블명 WHERE 조건 
-- DELECT FROM 테이블명 WHERE 조건 

DELETE DEPT_TEMP 
WHERE DEPTNO = 20;

DELETE FROM DEPT_TEMP 
WHERE DEPTNO = 30;

-- 서브쿼리 + DELETE
-- 급여등급이 3등급이고 30번 부서의 사원 삭제

DELETE FROM EMP_TEMP
WHERE EMPNO IN (SELECT EMPNO FROM EMP_TEMP et JOIN SALGRADE s ON et.sal BETWEEN s.losal AND s.hisal AND s.grade =3 AND et.deptno=30)

-- 서브쿼리 + UPDATE
UPDATE DEPT_TEMP 
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT WHERE DEPTNO = 40)
WHERE DEPTNO =40;

-- 서브 쿼리 + INSERT 

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT e1.EMPNO, E1.JOB, E1.HIREDATE, E1.MGR, E1.SAL, E1.COMM, E1.DEPTNO 
FROM EMP E1 JOIN SALGRADE s ON e1.SAL BETWEEN s.LOSAL AND s.HISAL AND s.GRADE = 1;


-- [실습 1] 
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;


INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES 


CREATE TABLE EXAM_EMP1 AS SELECT * FROM EMP WHERE 1<>1;


UPDATE EXAM_EMP
SET ENAME = 'TEXT_USER1' WHERE DEPTNO =20;


UPDATE EXAM_EMP
SET ENAME = 'TEXT_USER2' WHERE EMPNO =7499;

UPDATE EXAM_EMP
SET ENAME = 'TEXT_USER3' WHERE COMM =500;

COMMIT;

UPDATE EXAM_EMP
SET ENAME = 'TEXT_USER4' WHERE MGR =7839;
COMMIT;

UPDATE EXAM_EMP
SET ENAME = 'TEXT_USER5' WHERE SAL =1250;
COMMIT;

UPDATE EXAM_EMP
SET ENAME = 'TEXT_USER6' WHERE SAL =2850;
COMMIT;

UPDATE EXAM_EMP
SET ENAME = 'TEXT_USER7' WHERE SAL =2450;
COMMIT;

UPDATE EXAM_EMP
SET ENAME = 'TEXT_USER8' WHERE SAL =5000;
COMMIT;


UPDATE EXAM_EMP
SET EMPNO = 7202 WHERE ENAME = 'TEXT_USER2'; 
COMMIT;

UPDATE EXAM_EMP
SET EMPNO = 7203 WHERE ENAME = 'TEXT_USER3'; 
COMMIT;

UPDATE EXAM_EMP
SET EMPNO = 7204 WHERE ENAME = 'TEXT_USER4'; 
COMMIT;

UPDATE EXAM_EMP
SET EMPNO = 7205 WHERE ENAME = 'TEXT_USER5'; 
COMMIT;

UPDATE EXAM_EMP
SET EMPNO = 7206 WHERE ENAME = 'TEXT_USER6'; 
COMMIT;

UPDATE EXAM_EMP
SET EMPNO = 7207 WHERE ENAME = 'TEXT_USER7'; 
COMMIT;

UPDATE EXAM_EMP
SET EMPNO = 7208 WHERE ENAME = 'TEXT_USER8'; 
COMMIT;

UPDATE EXAM_EMP
SET JOB = 'MANAGER' WHERE ENAME = 'TEXT_USER1'; 
COMMIT;

UPDATE EXAM_EMP
SET JOB = 'CLERK' WHERE ENAME = 'TEXT_USER2'; 
COMMIT;





INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7201, 'TEXT_USER1', 'MANAGER', 7788, '2016-01-02', 4500, NULL, 50);

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7202, 'TEXT_USER2', 'CLERK', 7201, '2016-02-21', 1800, NULL, 50);

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7203, 'TEXT_USER3', 'ANALYST', 7201, '2016-04-11', 3400, NULL, 50);

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7204, 'TEXT_USER4', 'SALEMAN', 7201, '2016-05-31', 2700, 300, 50);

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7206, 'TEXT_USER5', 'CLERK', 7201, '2016-07-20', 2600, NULL, 50);

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7207, 'TEXT_USER6', 'CELRK', 7201, '2016-09-08', 2600, NULL, 50);

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7208, 'TEXT_USER7', 'LECTURER', 7201, '2016-10-28', 2300, NULL, 50);

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7208, 'TEXT_USER8', 'STUDENT', 7201, '2016-03-09', 1200, NULL, 50);

COMMIT;

UPDATE EXAM_EMP 
SET DEPTNO  = 60 WHERE EMPNO = 7203;
COMMIT;

UPDATE EXAM_EMP 
SET DEPTNO  = 80 WHERE EMPNO = 7208;
COMMIT;


-- EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을 
-- 70번 부서로 옮기는 SQL문 작성하기
UPDATE EXAM_EMP  

SET DEPTNO  = 70 
WHERE SAL > (SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO  = 50);

-- EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 
-- 급여 10% 인상하고 80번 부서로 옮기는 SQL문 작성
UPDATE EXAM_EMP SET SAL=SAL*1.1, DEPTNO=80
WHERE HIREDATE >(SELECT MIN(HIREDATE) FROM EXAM_EMP WHERE DEPTNO=60);

-- EXAM_EMP에 속한 사원 중 , 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
DELETE FROM EXAM_EMP 
WHERE EMPNO IN (SELECT EMPNO FROM EXAM_EMP, SALGRADE s WHERE SAL BETWEEN LOSAL AND HISAL AND GRADE=5);

DELETE FROM 
WHERE GRADE IN (SELECT GRADE FROM EXAM_EMP ee JOIN SALGRADE s ON ee.sal BETWEEN s.losal AND s.hisal WHERE s.grade =5);

COMMIT;

-- TRANSACTION
-- 하나의 작업 또는 밀접하게 연관되어 있는 작업 수행을 위해 나눌 수 없는 최소 작업 단위
-- 최종반영(commit) / 모두 취소(rollback)

-- dbeaver 설정에서 커밋 모드 변경 가능
-- 기본 : auto commit 상태


INSERT INTO DEPT_TEMP VALUES(55, 'NETWORK', 'SEOUL');
UPDATE DEPT_TEMP SET LOC ='BUSAN' WHERE DEPTNO = 55;


COMMIT;
ROLLBACK; -- COMMIT 하기 전에 해야함 

SELECT * FROM DEPT_TEMP dt;

DELETE FROM DEPT_TEMP dt WHERE deptno=55;
UPDATE DEPT_TEMP SET DNAME = 'WEB' WHERE DEPTNO =10;

COMMIT;


--LOCK => 한 세션에서 트랜잭션이 작업이 완료되지 않으면
--	다른 세션에서 작업을 처리할 수 없는 상태
--	(DML -insert, update, delete)



-- SQL - 1. DDL 2. DML -select, insert, update, delete 3. DCL (권한부여)

-- 데이터 정의어 (DDL)
-- 테이블 정의, 사용자 정의, 권한 부여(취소)
-- CREATE 


-- 1. 테이블 생성
-- CREATE TABLE 테이블명(
-- 필드명 필드타입(크기) 제약조건, 
-- )

-- 열 이름 규칙
--문자로 시작/ 30byte 이하로 작성 / 한 테이블 안 열 이름 중복 불가
-- 열 이름은 문자, 0-9, 특수문자 ($, #, _) 사용 가능
--SQL 키워드는 열 이름으로 사용 불가 (ORDER, GROUP, SELECT...)

-- 문자 
-- 1) CHAR 2) VARCHAR2 3) NCHAR 4) NVARCHAR2 5) CLOB 6) NCLOB 7) LONG
-- CHAR ORE VACHAR : 열의 너비가 고정값인지 가변인지
-- CHAR(10) : 'HONG' -> 무조건 10자리 다 사용
-- VARCHAR2(10) : 'HONG' -> 입력된 글자에 따라 가변

-- VARCHAR2, CHAR 가 한글, 영문 입력 시 사용하는 바이트 수가 다름
-- NCHAR, NVARCHAR 는 사용하는 바이트 수를 통일해서 사용
-- NCHAR(10) : 'HONG' -> 유니코드 문자열 타입, 10자리 고정 
-- NVARCHAR2(10) : 'HONG' -> 유니코드 문자열 타입, 글자에 따라 가변

-- CLOB : 문자열 데이터를 외부 파일로 저장
--		  엄청 많은 텍스트 데이터 입력 시 사용

-- LONG : 2기가 저장

-- 숫자
-- NUMBER (전체자릿수, 소수점자릿수) 
-- BINARY_FLOAT, BLNARY_DOUBLE

-- 날짜
-- DATE, TIMESTAMP


CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER (2)
);


SELECT * FROM EMP_DDL;


-- 기본 테이블 열 구조와 데이터 복사해서 새 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;

-- 기본 테이블 열 구조만 작성 (데이터 복사 X)
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP WHERE 1<>1;



-- DDL : CREATE, ALTER 
-- 2. 테이블 변경
-- 1) 열 추가(ADD)
--    ALTER  TABLE 테이블명 ADD 추가할열이름 데이터타입(10)
-- EMP_DDL 새로운 컬럼 추가 HP(010-1234-5678)
ALTER TABLE EMP_DDL ADD HP VARCHAR2(15);

SELECT  * FROM EMP_DDL;

-- 2) 열 이름 변경(RENAME)
--    ALTER TABLE 테이블명 RENAME COLUMN 기존이름 TO 변경이름
-- HP -> MOBILE
ALTER TABLE EMP_DDL RENAME COLUMN HP TO MOBILE;

-- 3) 열 자료형 변경(MODIFY)
--	  ALTER TABLE 테이블명 MODIFY 열이름 데이터타입(20)
--	  EMPNO NUMBER(5)
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);


-- 4) 열 제거 
-- 	  ALTER TABLE 테이블명 DROP COLUMN 열이름;
ALTER TABLE EMP_DDL DROP COLUMN MOBILE;


-- 테이블 이름 변경
-- RENAME 변경전테이블명 TO 변경할테이블명
-- EMP_DDL => EMP_ALTER
RENAME EMP_DDL TO EMP_ALTER;

SELECT  * FROM EMP_ALTER;

-- CREATE, ALTER, DROP
-- 5) 삭제 : DROP
-- DROP TABLE 테이블명;
DROP TABLE EMP_ALTER;


-- VIEW : 가상테이블 
-- CREATE VIEW 뷰 이름 AS (SELECT * FROM 원본테이블명)
-- VIEW 를 통해 원본 수정이 가능
-- 편리성, 보안성


-- 권한이 불충분합니다
-- VIEW 는 권한을 가진 사용자만 생성할 수 있음
CREATE VIEW VM_EMP20 AS (SELECT * FROM EMP WHERE DEPTNO=20);


SELECT * FROM VM_EMP20;


-- 뷰를 통해 데이터 삽입 시 원본에도 영향을 미침
INSERT INTO VM_EMP20 
VALUES (8888, 'HONG', 'ANASLYST', 7902, SYSDATE,2500,NULL,20);

SELECT  * FROM EMP e;


SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME ='VM_EMP20';


-- CREATE VIEW 뷰이름 AS (SELECT * FROM 원본 테이블명) WITH READ ONLY
-- VIEW 를 통해 읽기만 가능 
CREATE VIEW VM_EMP30 AS (SELECT * FROM EMP WHERE DEPTNO=30) WITH READ ONLY;

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME ='VM_EMP30';


-- VIEW 삭제
DROP VIEW VM_EMP20;


-- INDEX 생성, 삭제
-- INDEX (색인, 목차)
-- 인덱스 : 기본키, 고유키 일 때 자동으로 생성됨

--CREATE INDEX 인덱스명 ON 테이블명(인덱스로 사용할 필드명)

CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

SELECT * FROM USER_IND_COLUMNS;


DROP INDEX IDX_EMP_SAL;



-- 시퀀스 생성/삭제 
-- 오라클 객체, 하나씩 증가하는 값이 필요 할 때 주로 사용
-- 다른 DB의 auto_increment 과 동일한 역할
--CREATE SEQUENCE 시퀀스명 INCREMENT BY 증감값 START WITH 시작값 MAXVALUE 최대값 MINVALUE 최소값
--NOCYCLE(CYCLE) CASHE 숫자;


-- 1 에서 시작 ~ 9999999999999999999999999999
-- 1씩 증가하면서 숫자 생성
CREATE SEQUENCE dept_seq;
DROP SEQUENCE dept_seq;

SELECT * FROM USER_sequences;

CREATE TABLE dept_sequence AS SELECT * FROM dept WHERE 1<>1;
CREATE SEQUENCE dept_seq
INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0
NOCYCLE CACHE 2;

INSERT INTO DEPT_SEQUENCE (DEPTNO, DNAME, LOC)
VALUES(DEPT_SEQ.NEXTVAL, 'DATABASE', 'SEOUL');

SELECT * FROM DEPT_SEQUENCE;

ALTER SEQUENCE DEPT_SEQ INCREMENT BY 3 MAXVALUE 99 CYCLE;

-- 마지막으로 생성된 시퀀스 확인
SELECT DEPT_SEQ.CURRVAL FROM DUAL;




-- 제약조건
-- 테이블의 특정 열에 지정
-- 1) NOT NULL : 열에 NULL을 허용하지 않음
-- 2) UNIQE : 지정한 열이 유일한 값을 가져야 함(NULL은 중복 시 따지지 않음)
-- 3) PRIMARY KEY : 지정한 열이 유일한 값이면서 NULL을 허용하지 않음(테이블당 하나만 지정)
-- 4) FOREIGN KEY : 다른 테이블의 열을 참조하여 존재하는 값만 입력 
-- 5) CHECK : 설정한 조건식을 만족하는 데이터만 입력

-- 열이름(컬럼명) : USERNAME => USER_NAME (snakecase)
CREATE TABLE TBL_NOTNULL(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

-- NULL을 ("SCOTT"."TBL_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
INSERT INTO TBL_NOTNULL VALUES ('TESTID1', NULL, '010-1234-5678');

INSERT INTO TBL_NOTNULL VALUES ('TESTID1', 'TESTID1', 'NULL');

SELECT * FROM TBL_NOTNULL;


-- 계약조건 확인
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS;


CREATE TABLE TBL_NOTNULL2(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN2_LOGIN_NN NOT NULL, 
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN2_LOGPWD_NN NOT NULL,
	TEL VARCHAR2(20)
);


-- 생성한 테이블에 제약 조건 추가
ALTER TABLE TBL_NOTNULL MODIFY(TEL NOT NULL);

-- 생성한 테이블에 제약 조건 추가
ALTER TABLE TBL_NOTNULL2 MODIFY(TEL CONSTRAINT TBLNN2_TEL_NN NOT NULL);

UPDATE TBL_NOTNULL2 
SET TEL = '010-1234-5678'
WHERE LOGIN_ID = 'TESTID1';


-- 생성한 제약 조건 이름 변경
ALTER TABLE TBL_NOTNULL2 RENAME CONSTRAINT TBLNN2_TEL_NN TO TBLNN2_TEL;


-- 제약 조건 삭제
ALTER TABLE TBL_NOTNULL2 DROP CONSTRAINT TBLNN2_TEL;


-- UNIQUE : 중복되지 않은 값
CREATE TABLE TBL_UNIQUE(
	LOGIN_ID VARCHAR2(20) UNIQUE,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);


-- 데이터 무결성 : 데이터 정확성, 일관성을 보장해야 함

-- 무결성 제약 조건 (SCOTT.SYS.C008361)에 위배
INSERT INTO TBL_UNIQUE VALUES ('TESTID1', 'TESTID1', '010-1234-5678')


CREATE TABLE TBL_UNIQUE2(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBL_UNQ2_LOGIN_ID UNIQUE,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBL_UNQ2_LOGPWD_NN_ID NOT NULL,
	TEL VARCHAR2(20));

-- 계약조건 확인
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS;

ALTER TABLE TBL_UNIQUE2 MODIFY (TEL UNIQUE);
ALTER TABLE TBL_UNIQUE MODIFY (TEL CONSTRAINT TBL_UNQ_TEL_UNQ UNIQUE);
ALTER TABLE TBL_UNIQUE DROP CONSTRAINT TBL_UNQ_TEL_UNQ;


-- 3) PRIMAY KEY (PK) : 기본키
-- 	  인덱스 설정 자동으로  만들어짐
--	  NOT NULL + UNIQUE => 회원 아이디, 이메일, 상품코드, 게시판글번호...

CREATE TABLE TBL_PRIMARY(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20));

INSERT INTO TBL_PRIMARY(LOGIN_ID, LOGIN_PWD, TEL)
VALUES ('TESTID1', 'TESTPWD1', '010-1234-5678');


-- 4) FOREIGN KEY(외래키) : 특정 테이블의 기본키로 지정한 열을 다른 테이블의 특정 열에서 참조 
-- 부모키 / 자식키


CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
	DENAME VARCHAR2(20),
	LOC VARCHAR2(20)
);


CREATE TABLE EMP_FK(
	EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER (2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO));

DROP TABLE EMP_FK;

-- 부모(참조 대상 테이블) / 자식(참조하는 테이블)
-- 부모 키가 없습니다
INSERT INTO EMP_FK VALUES(1000, 'HONG', 'CLERK', 7788, SYSDATE, 1200, NULL, 50);


INSERT INTO DEPT_FK VALUES(50, 'DATABASE', 'SEOUL');


-- 자식 레코드가 발견되었습니다(참조하는 테이블의 자식 DELETE)
DELETE FROM DEPT_FK WHERE DEPTNO =50;


-- FOREIGN KEY
-- 1) ON DELETE CASCADE : 부모가 삭제되면 자식도 같이 삭제
-- 2) ON DELETE SET NULL : 부모가 삭제되면 자식이 참조하는 부모의 값을 NULL 변경

CREATE TABLE EMP_FK2(
	EMPNO NUMBER(4) CONSTRAINT EMPFK2_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER (2) CONSTRAINT EMPFK2_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE
);

DROP TABLE EMP_FK2;

INSERT INTO EMP_FK2 VALUES (1000, 'HONG', 'CLERK', 7788, SYSDATE, 1200, NULL, 50);

-- 부모가 제거되면서 자식도 제거
DELETE FROM DEPT_FK WHERE DEPTNO =50;


CREATE TABLE EMP_FK3(
	EMPNO NUMBER(4) CONSTRAINT EMPFK3_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER (2) CONSTRAINT EMPFK3_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL
);

DROP TABLE EMP_FK3;

INSERT INTO DEPT_FK VALUES (50, 'DATABASE', 'SEOUL');
INSERT INTO EMP_FK3 VALUES (1000, 'HONG', 'CLERK', 7788, SYSDATE, 1200, NULL, 50);

DELETE FROM DEPT_FK WHERE DEPTNO=50;
SELECT * FROM EMP_FK3;

-- 5) CHECK : 열에 저장할 수 있는 값의 범위 혹은 패턴 정의

CREATE TABLE TBL_CHECK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLACK_PWD_CK CHECK (LENGTH(LOGIN_PWD) > 3),
	TEL VARCHAR2(20)
);

-- 체크 제약조건(SCOTT.TBLACK_PWD_CK)이 위배되었습니다 (PWD가 3보다 크지 않음)
INSERT INTO TBL_CHECK VALUES('TESTID1', '123', NULL);



CREATE TABLE TBL_CHECK2(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLACK2_PWD_CK CHECK (LENGTH(LOGIN_PWD) > 3),
	GRADE VARCHAR2(10)  CONSTRAINT TBLACK2_GRADE_CK CHECK (GRADE IN ('SILVER', 'GOLD', 'VIP')),
	TEL VARCHAR2(20)
);

-- 체크 제약조건(SCOTT.TBLACK2_GRADE_CK)이 위배되었습니다
INSERT INTO TBL_CHECK2 VALUES('TESTID1', '1234', 'DIAMOND', NULL);


-- DEFAULT : 특정 열에 값이 지정되지 않았을 때 기본 값 주기

CREATE TABLE TBL_DEFAULT(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
	TEL VARCHAR2(20)
);

INSERT INTO TBL_DEFAULT VALUES('TESTID1', '4687', NULL);
INSERT INTO TBL_DEFAULT (LOGIN_ID,TEL) VALUES('TESTID2', '010-1234-5678');
SELECT * FROM TBL_DEFAULT;




-- 제조업체
CREATE TABLE HAN_COMPANY (
	COM_CODE NUMBER(20) CONSTRAINT COM_CODE_PK PRIMARY KEY,
	COM_NAME VARCHAR2(20) CONSTRAINT COM_NAME_MN NOT NULL,
	COM_LOC VARCHAR2(20) CONSTRAINT COM_LOC_MN NOT NULL,
	COM_WORKER VARCHAR2(20) CONSTRAINT COM_WOKER_MN NOT NULL,
	COM_TEL VARCHAR2(20) CONSTRAINT COM_TEL_MN NOT NULL
);

INSERT INTO HAN_COMPANY
VALUES (123456, '한빛업체', 'SEOUL', 'minju', '010-1234-5678');

SELECT * FROM HAN_COMPANY;


-- 상품
-- 상품번호는 숫자(DRODUCT_SEQ 시퀸스 값 대입) 
CREATE TABLE HAN_PRODUCT_COM (
	PRODUCT NUMBER(20) PRIMARY KEY,
	PNAME VARCHAR2(20) NOT NULL,
	AMOUNT NUMBER(20) NOT NULL,
	PRICE NUMBER(20) NOT NULL,
	SUPPLY_DATE DATE NOT NULL,
	SUPPLY_AMOUNT NUMBER NOT NULL,
	PRO_CODE NUMBER(20) CONSTRAINT HAN_CODE_FK REFERENCES HAN_COMPANY(COM_CODE)
);



CREATE SEQUENCE PRODUCT_SEQ;

INSERT INTO HAN_PRODUCT_COM (PRODUCT, PNAME, AMOUNT, PRICE, SUPPLY_DATE, SUPPLY_AMOUNT)
VALUES (PRODUCT_SEQ.NEXTVAL, '초코파이', 100, 3500, '2024-01-02', 5500);

SELECT * FROM HAN_PRODUCT_COM;

-- 회원
CREATE TABLE HAN_MEMBER (
	USERID VARCHAR2(20) PRIMARY KEY,
	PASSWORD VARCHAR2(30) NOT NULL,
	NAME VARCHAR2(20) NOT NULL,
	AGE NUMBER(3) CHECK(AGE > 0),
	JOB VARCHAR2(15),
	GRADE VARCHAR2(10) DEFAULT 'SILVER' CHECK (GRADE IN ('SILVER', 'GOLD', 'VIP')),
	POINT NUMBER(8) DEFAULT 0
);

SELECT *FROM HAN_MEMBER;

INSERT INTO HAN_MEMBER(USERID, PASSWORD, NAME)
VALUES ('KIM123', 'KIM123', '김지호');

INSERT INTO HAN_MEMBER(USERID, PASSWORD, NAME, AGE)
VALUES ('KIM123', 'KIM123', '김지호', 15);

INSERT INTO HAN_MEMBER(USERID, PASSWORD, NAME, AGE, JOB)
VALUES ('KIM123', 'KIM123', '김지호', 15, '학생');



-- 주문 
CREATE TABLE HAN_ORDER(
	ORDER_CODE NUMBER(20) PRIMARY KEY,
	ORDER_ID VARCHAR2(30) CONSTRAINT ORDER_ID_FK REFERENCES HAN_MEMBER(USERID),
	ORDER_NUMBER NUMBER CONSTRAINT ORDER_NUMBER_FK REFERENCES HAN_PRODUCT_COM(PRODUCT),
	ORDER_ODDR VARCHAR2(50) NOT NULL,
	ORDER_AMOUNT NUMBER NOT NULL,
	ORDER_DATE DATE DEFAULT SYSDATE
);
	

SELECT *FROM HAN_ORDER;

CREATE SEQUENCE HAN_ORDER_SEQ;

INSERT INTO HAN_ORDER (ORDER_CODE, ORDER_ID, ORDER_NUMBER, ORDER_ODDR, ORDER_AMOUNT)
VALUES(HAN_ORDER_SEQ.NEXTVAL, 'KIM123', 4, '서울시 종로구', 10);


-- 게시글
CREATE TABLE HAN_WRITE (
	WRITE_NUM NUMBER PRIMARY KEY,
	WRITE_ID VARCHAR2(20) CONSTRAINT WRITE_ID_FK REFERENCES HAN_MEMBER(USERID),
	WRITE_TITLE VARCHAR2(20) NOT NULL,
	WRITE_CONT VARCHAR2(2000) NOT NULL,
	WRITE_DATE DATE NOT NULL
);


	
CREATE SEQUENCE HAN_WRITE_SEQ;

INSERT INTO HAN_WRITE (WRITE_NUM, WRITE_ID, WRITE_TITLE, WRITE_CONT, WRITE_DATE)
VALUES ( HAN_WRITE_SEQ.NEXTVAL, 'KIM123', 'INSERT', 'INSERT', '2024-01-01')


SELECT * FROM HAN_WRITE;



-- 제약조건
CREATE TABLE EMP_FK2 (
	EMPNO NUMBER(4) CONSTRAINT EMPFK4_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER (2),
	CONSTRAINT EMPFK4_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT_FK(DEPTNO)	
);



























