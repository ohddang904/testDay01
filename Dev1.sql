SELECT ENAME, SAL, COMM, SAL*12+COMM, 
NVL(COMM, 0), SAL*12+NVL(COMM, 0)
FROM EMP
ORDER BY JOB;

select * from emp;
select empno,ename, nvl(to_char(mgr,'9999'),'CEO') "MANAGER"
from emp
where mgr is null;

select empno,ename,sal,comm,
nvl2(comm,sal*12+comm,sal*12) annsal
from emp;

select * from emp;

select ename,deptno,
decode(deptno, 10,'ACCOUNTING',
20,'RESEARCH',
30,'SALES',
40,'OPERATIONS') as dname
from emp;

select empno,ename,job,sal,
decode(job, 'ANALYST', sal*1.05,
'SALESMAN', sal*1,1,
'MANAGER', sal*1.15,
'CLERK' , sal*1.2) as upsal
from emp;

select ename,deptno,
case when deptno=10 then 'ACCOUNTING'
when deptno=20 then 'RESEARCH'
when deptNO=30 then 'SALES'
when DEPTNO=40 then 'OPERATIONS'
end as dname
from emp;
//1번
select substr(HIREDATE, 1,2) 년도, substr(HIREDATE, 4,2) 달
from emp;
//2번
select * from emp
where substr(HIREDATE, 4,2)='04';
//3번
select * from emp
where mod(empno,2)=0;
//4번
select hiredate, to_char(hiredate, 'yy/mon/dy')
from emp;
//5번
select trunc(sysdate-to_date('2024/01/01', 'YYYY/MM/DD'))
from dual;
//6번
select empno,ename,
nvl(mgr,0) as MANAGER
from emp;
//7번
select empno,ename,job,sal,
decode(job, 'ANALYST' , sal+200,
'SALESMAN', sal+180,
'MANAGER' , sal+150,
'CLERK' , sal+100)
from emp;


