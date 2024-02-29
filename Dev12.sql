//합계 sum
select sum(sal) from emp;

//평균 avg
select avg(sal) from emp;

//최대값 max , 최소값 min
select max(sal) ,min(sal) from emp;

//사원들의 최대 급여
select ename,max(sal) from emp;
select ename,sal from emp where sal=(select max(sal) from emp);

//최근 입사일 , 오래된 사원의 입사일
select max(hiredate)"최근입사일",min(hiredate)"최초입사일" from emp;

// COUNT 함수 , 커미션을 받은 사원의 수
select count(comm) from emp;

//전체 사원 수 , 커미션 받은 사원의 수
select count(*),count(comm) from emp;

//10번 부서 소속 중 커미션 받는 사원의 수
select count(comm)"사원수" from emp where deptno=10;

//사원들의 직업의 개수 카운트
select count(job) 업무수 from emp;

//중복되지 않은 직업의 개수 카운트
select count(distinct job) 업무수 from emp;

//사원 테이블 - 부서번호로 그룹
select deptno from emp group by deptno;

//부서별 평균 급여
select deptno,avg(sal) from emp group by deptno;

//부서별 최대급여 , 최소 급여
select deptno,max(sal),min(sal) from emp group by deptno;

//부서별 사원수 , 커미션 받는 사원수
select deptno,count(*),count(comm) from emp group by deptno;

//부서별 그룹 , 부서별 평균 급여 2000 이상(having) , 부서번호와 부서별 평균 급여 출력
select deptno,avg(sal) from emp group by deptno having avg(sal) >= 2000;

//부서별 최대,최소 급여  최대 급여 2900이상인 부서만 출력
select deptno,max(sal),min(sal) from emp group by deptno having max(sal)>2900;

//1번
select max(sal)"Maximum",min(sal)"Minimum",sum(sal)"Sum",round(avg(sal))"Average"
from emp;

//2번
select job,max(sal)"Maximum",min(sal)"Minimum",
sum(sal)"Sum",round(avg(sal))"Average"
from emp group by job;

//3번
select job,count(*) from emp group by job;

//4번
select job,count(*) "count(Manager)" from emp group by job having job='MANAGER';

//5번
select max(sal)-min(sal)"DIFFERENCE" from emp;

//6번
select job,min(sal) from emp where mgr is not null group by job
having not min(sal) < 2000 order by min(sal) desc;

//7번
select deptno"DNO" , count(*)"Number of People", Round(avg(sal),2)"Salary"
from emp group by deptno;

//8번
select 
Decode(deptno,10, 'ACCOUNTING',
20,'RESEARCH',
30,'SALES',
40,'OPERATIONS')as "dname",

Decode(deptno,10,'NEW YORK',
20,'DALLAS',
30,'CHICAGO',
40,'BOSTON')as "Location",
count(*)as "Number of People" , Round(avg(sal))as"Salary" 
from emp
group by deptno;

//9번
select job,
sum (decode(deptno,10,sal))"부서 10",
sum (decode(deptno,20,sal))"부서 20",
sum (decode(deptno,30,sal))"부서 30",
sum(sal) "총액"
from emp
group by job;

//join
select deptno from emp where ename='SCOTT';
select * from dept where deptno=20; 

//Cross Join
select * from emp,dept;

//Equi Join
select * from emp,dept where EMP.DEPTNO = DEPT.DEPTNO;

//equi join and
select ename,dname from emp,dept where emp.deptno=dept.deptno
and ename='SCOTT';

//동일한 이름의 컬럼 명 앞에 테이블 명 명시적
select emp.ename,dept.dname,emp.deptno from emp,dept
where emp.deptno = dept.deptno and ename = 'SCOTT';

//1번 뉴욕에서 근무하는 사원 이름 , 급여
select ename,sal
from emp E ,dept D
where E.deptno = D.deptno
and loc='NEW YORK';

//2번 Accounting 부서 소속 사원의 이름과 입사일 출력
select ename,hiredate
from emp E , dept D
where E.deptno = D.deptno
and Dname ='ACCOUNTING';

//3번 직급이 MANAGER인 사원의 이름,부서명
select ename,dname
from emp e , dept d
where E.deptno = D.deptno
and job='MANAGER';

//non-equi join
select ename,sal,grade from emp,salgrade
where sal between losal and hisal;

//seif join
select ename,mgr from emp
where ename ='SMITH';

select e1.ename,e2.empno"관리자사번",e2.ename"관리자이름"
from emp e1 , emp e2
where e1.mgr =e2.empno(+);

//4번 매니저가 KING인 사원들의 이름과 직급
select e1.ename,e2.job
from emp E1, emp E2
where E1.mgr = E2.empno
and E2.ename = 'KING';

//5번 scott과 동일한 근무지에서 근무하는 사원의 이름
select e1.ename,e2.ename
from emp e1, emp e2
where e1.deptno = e2.deptno
and e1.ename = 'SCOTT';

//Outer join
select e.ename || '의 매니저는' || m.ename || '입니다.'
from emp e, emp m
where e.mgr =m.empno(+);

//6번 사원,부서 테이블 조인 사원이름,부서번호,부서명 출력 40번 부서도 출력되도록
select * from emp;
select * from dept;
select e.ename,d.deptno,d.dname
from emp e, dept d
where e.deptno(+) = d.deptno

//ANSI Join
select * from emp cross join dept;

//ANSI Inner Join
select ename,dname from emp inner join dept
on emp.deptno = dept.deptno where ename = 'SCOTT';

//ANSI Inner join (using)
select ename,dname from emp inner join dept
using (deptno); 

//ANSI NATURAL JOIN
select emp.ename,dept.dname
from emp natural join dept;

//1번
drop table dept01;

//2번
Create table dept01(
deptno number(2) , dname varchar2(14));

//3번
insert into dept01 values(10, 'ACCOUNTING');
insert into dept01 values (20, 'RESEARCH');

select * from dept01;

//4번
DROP TABLE DEPT02;

CREATE TABLE DEPT02( 
DEPTNO NUMBER(2), 
DNAME VARCHAR2(14)); 

INSERT INTO DEPT02 VALUES(10, 'ACCOUNTING');
INSERT INTO DEPT02 VALUES (30, 'SALES'); 

SELECT * FROM DEPT02;

//LEFT OUTER JOIN
select * from dept01 left outer join dept02
using (deptno);

//Right outer join
select * from dept01 right outer join dept02
using (deptno);

//Full outer join
select * from dept01 full outer join dept02
using (deptno);

//
select * from emp;
select * from dept;

//1번
select ename,empno,dname from emp,dept
where emp.deptno = dept.deptno
and ename = 'SCOTT';

//2번
select ename,dname,loc from emp inner join dept
on emp.deptno = dept.deptno; 

//3번
select deptno,loc from emp ineer join dept
using (deptno);





