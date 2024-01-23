-- scott

-- SELECT(데이터 조회)
--e : 별칭(임의 지정 가능) / 없어도 됨
--* : 전체 필드(컬럼)를 의미함
SELECT * FROM  EMP e;

--특정 컬럼에 해당하는 내용 보기
SELECT  EMPNO, ENAME, JOB FROM emp;

-- emp 테이블
-- empno(사원번호), ename(사원명), job(직책), mgr(매니저번호), hiredatr(고용일), sal(급여),comm(보너스)
-- deptno(부서번호)
