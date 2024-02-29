//�հ� sum
select sum(sal) from emp;

//��� avg
select avg(sal) from emp;

//�ִ밪 max , �ּҰ� min
select max(sal) ,min(sal) from emp;

//������� �ִ� �޿�
select ename,max(sal) from emp;
select ename,sal from emp where sal=(select max(sal) from emp);

//�ֱ� �Ի��� , ������ ����� �Ի���
select max(hiredate)"�ֱ��Ի���",min(hiredate)"�����Ի���" from emp;

// COUNT �Լ� , Ŀ�̼��� ���� ����� ��
select count(comm) from emp;

//��ü ��� �� , Ŀ�̼� ���� ����� ��
select count(*),count(comm) from emp;

//10�� �μ� �Ҽ� �� Ŀ�̼� �޴� ����� ��
select count(comm)"�����" from emp where deptno=10;

//������� ������ ���� ī��Ʈ
select count(job) ������ from emp;

//�ߺ����� ���� ������ ���� ī��Ʈ
select count(distinct job) ������ from emp;

//��� ���̺� - �μ���ȣ�� �׷�
select deptno from emp group by deptno;

//�μ��� ��� �޿�
select deptno,avg(sal) from emp group by deptno;

//�μ��� �ִ�޿� , �ּ� �޿�
select deptno,max(sal),min(sal) from emp group by deptno;

//�μ��� ����� , Ŀ�̼� �޴� �����
select deptno,count(*),count(comm) from emp group by deptno;

//�μ��� �׷� , �μ��� ��� �޿� 2000 �̻�(having) , �μ���ȣ�� �μ��� ��� �޿� ���
select deptno,avg(sal) from emp group by deptno having avg(sal) >= 2000;

//�μ��� �ִ�,�ּ� �޿�  �ִ� �޿� 2900�̻��� �μ��� ���
select deptno,max(sal),min(sal) from emp group by deptno having max(sal)>2900;

//1��
select max(sal)"Maximum",min(sal)"Minimum",sum(sal)"Sum",round(avg(sal))"Average"
from emp;

//2��
select job,max(sal)"Maximum",min(sal)"Minimum",
sum(sal)"Sum",round(avg(sal))"Average"
from emp group by job;

//3��
select job,count(*) from emp group by job;

//4��
select job,count(*) "count(Manager)" from emp group by job having job='MANAGER';

//5��
select max(sal)-min(sal)"DIFFERENCE" from emp;

//6��
select job,min(sal) from emp where mgr is not null group by job
having not min(sal) < 2000 order by min(sal) desc;

//7��
select deptno"DNO" , count(*)"Number of People", Round(avg(sal),2)"Salary"
from emp group by deptno;

//8��
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

//9��
select job,
sum (decode(deptno,10,sal))"�μ� 10",
sum (decode(deptno,20,sal))"�μ� 20",
sum (decode(deptno,30,sal))"�μ� 30",
sum(sal) "�Ѿ�"
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

//������ �̸��� �÷� �� �տ� ���̺� �� �����
select emp.ename,dept.dname,emp.deptno from emp,dept
where emp.deptno = dept.deptno and ename = 'SCOTT';

//1�� ���忡�� �ٹ��ϴ� ��� �̸� , �޿�
select ename,sal
from emp E ,dept D
where E.deptno = D.deptno
and loc='NEW YORK';

//2�� Accounting �μ� �Ҽ� ����� �̸��� �Ի��� ���
select ename,hiredate
from emp E , dept D
where E.deptno = D.deptno
and Dname ='ACCOUNTING';

//3�� ������ MANAGER�� ����� �̸�,�μ���
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

select e1.ename,e2.empno"�����ڻ��",e2.ename"�������̸�"
from emp e1 , emp e2
where e1.mgr =e2.empno(+);

//4�� �Ŵ����� KING�� ������� �̸��� ����
select e1.ename,e2.job
from emp E1, emp E2
where E1.mgr = E2.empno
and E2.ename = 'KING';

//5�� scott�� ������ �ٹ������� �ٹ��ϴ� ����� �̸�
select e1.ename,e2.ename
from emp e1, emp e2
where e1.deptno = e2.deptno
and e1.ename = 'SCOTT';

//Outer join
select e.ename || '�� �Ŵ�����' || m.ename || '�Դϴ�.'
from emp e, emp m
where e.mgr =m.empno(+);

//6�� ���,�μ� ���̺� ���� ����̸�,�μ���ȣ,�μ��� ��� 40�� �μ��� ��µǵ���
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

//1��
drop table dept01;

//2��
Create table dept01(
deptno number(2) , dname varchar2(14));

//3��
insert into dept01 values(10, 'ACCOUNTING');
insert into dept01 values (20, 'RESEARCH');

select * from dept01;

//4��
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

//1��
select ename,empno,dname from emp,dept
where emp.deptno = dept.deptno
and ename = 'SCOTT';

//2��
select ename,dname,loc from emp inner join dept
on emp.deptno = dept.deptno; 

//3��
select deptno,loc from emp ineer join dept
using (deptno);





