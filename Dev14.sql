//insert���� ���� ���̺� ����
drop table dept01;
create table dept01 as select * from dept where 1=0;
insert into dept01 (deptno,dname,loc) values(10,'ACCOUNTING','NEW YORK');
insert into dept01 values(20,'RESEARCH','DALLAS');

//
create table sam01 as select empno,ename,job,sal from emp where 1=0;
insert into sam01 values (1000,'APPLE','POLICE',10000);
insert into sam01 values (1010,'BANANA','NURSE',15000);
insert into sam01 values (1020,'ORANGE','DOCTOR',25000);
select * from sam01;

//�Ͻ��� null�� ����
insert into dept01 (deptno,dname) values (30,'SALES');
select * from dept01;
insert into dept01 values (40,'SALES',NULL);
insert into dept01 values (50,'','CHICAGO');
insert into dept01 values (60,' ','PARIS');

//
insert into sam01 values (1030,'VERY',NULL,25000);
insert into sam01 values (1040,'CAT','',2000);
select * from sam01;

//���� ������ ������ ����
drop table dept02;
create table dept02 as select * from dept where 1=0;

insert into dept02 select * from dept;

select * from dept;

//sam01 ���̺� ���������� ��� emp�� ����� ��� �� 10�� �μ� �Ҽ�
insert into sam01 select empno,ename,job,sal from emp where deptno=10;
select * from sam01;

//insert all ��ɹ� , ���̺� ���� �� �Է�
create table emp_hir as select empno,ename,hiredate from emp where 1=0;
create table emp_mgr as select empno,ename,mgr from emp where 1=0;

insert all 
into emp_hir values (empno,ename,hiredate)
into emp_mgr values (empno,ename,mgr)
select empno,ename,hiredate,mgr from emp where deptno=20;

select * from emp_hir;
select * from emp_mgr;

create table emp_hir02 as select empno,ename,hiredate from emp where 1=0;
create table emp_sal as select empno,ename,sal from emp where 1=0;

insert all 
when hiredate > '1982/01/01' then into emp_hir02 values(empno,ename,hiredate)
when sal > 2000 then into emp_sal values(empno,ename,sal)
select empno,ename,hiredate,sal from emp;

select * from emp_hir02;
select * from emp_sal;

//pivoting insert�� �ǽ�
//sales ����
create table sales(
sales_id number(4),
week_id number(4),
mon_sales number(8,2),
tue_sales number(8,2),
wed_sales number(8,2),
thu_sales number(8,2),
fri_sales number(8,2));
select* from sales;

//sales_date ����
create table sales_data(
sales_id number(4),
week_id number(4),
daily_id number(4),
sales number(8,2));
select * from sales_data;

//sales ���̺� �ǸŽ��� �߰�
insert into sales values(1001,1,200,100,300,400,500);
insert into sales values(1002,2,100,300,200,500,350);
select * from sales;

//������ ������ �� �ִ� �÷��� �߰� , ���ϸ��� �ǸŽ����� ���
INSERT ALL
INTO SALES_DATA VALUES(SALES_ID, WEEK_ID, 1, MON_SALES)
INTO SALES_DATA VALUES(SALES_ID, WEEK_ID, 2, TUE_SALES)
INTO SALES_DATA VALUES(SALES_ID, WEEK_ID, 3, WED_SALES)
INTO SALES_DATA VALUES(SALES_ID, WEEK_ID, 4, THU_SALES)
INTO SALES_DATA VALUES(SALES_ID, WEEK_ID, 5, FRI_SALES)
SELECT SALES_ID, WEEK_ID, MON_SALES, TUE_SALES, WED_SALES,
THU_SALES, FRI_SALES 
FROM SALES;

select * from sales_data;

//update set
create table emp01 as select * from emp;

//�μ���ȣ 30������ ����
update emp01 set deptno = 30;
select * from emp01;

//��� ����� �޿� 10%�λ�
update emp01 set sal = sal * 1.1;

//��� ����� �Ի��� ����
update emp01 set hiredate = sysdate;

//10���� ����� �μ���ȣ 30������ ����

update emp01 set deptno=30 where deptno= 10;

//�޿��� 3000�̻��� ����� �޿��� 10% �λ�
update emp01 set sal = sal *1.1 where sal >= 3000;

//1987�⿡ �Ի��� ����� �Ի����� ���÷� ����
update emp01 set hiredate=sysdate where substr(hiredate,1,2)='87';

//sam01���̺� ����� ����� �޿��� 10000�̻���  ������� �޿��� 5000 �谨
update sam01 set sal= sal-5000 where sal >=10000;

//���̺��� 2�� �̻��� �÷� �� ����
update emp01 set deptno=20, job='manager' where ename = 'scott';

//scott ����� �Ի����ڴ� ���÷�, �޿� 50,Ŀ�̼� 4000���� ����
UPDATE EMP01
SET HIREDATE = SYSDATE, SAL=50, COMM=4000
WHERE ENAME='SCOTT'; 

//10�� �μ��� �������� 40�� �μ��� ���������� ����
UPDATE DEPT01
SET LOC=(SELECT LOC 
         FROM DEPT01 
         WHERE DEPTNO=10)
         WHERE DEPTNO=40;
       
//emp ���̺��� ����� �������� Ư�� �÷������� ������ sam02 ���̺� ����
drop table sam02;
create table sam02 as select ename,sal,hiredate,deptno from emp;

//dallas�� ��ġ�� �μ� �Ҽ� ������� �޿��� 1000�λ�
update sam02 set sal = sal+1000 where deptno in(select deptno from dept
where loc='DALLAS');

//�Ѳ����� �ΰ��� �÷� �� ����
update dept01 set (dname,loc) = (select dname,loc from dept where deptno=40)
where deptno=20;

select * from dept01;
//sam02 ���̺��� ��� ����� �޿��� �Ի����� �̸��� king�� ����� �޿��� �Ի��Ϸ� ����
update sam02 set (sal,hiredate)
=(select sal,hiredate from sam02 where ename='KING');

//delete��
delete from dept01;

create table dept01 as select*from dept;

//Ư�� �ุ ����
delete from dept01 where deptno=30;

delete from sam01 where JOB is null;

//���������� �̿��� ������ ����
delete from emp01 where deptno = (select DEPTNO from dept where DNAME='SALES');

delete from sam02 where deptno = (select deptno from dept where dname = 'RESEARCH');

select * from sam02;

//merge �պ�
drop table emp01;

create table emp01 as select * from emp;

create table emp02 as select * from emp where job='MANAGER';

update emp02 set job = 'TEST';

insert into emp02 values(8000,'SYJ','TOP',7566,'2009/01/12',1200,10,20);
select * from emp01;
select * from emp02;

//���̺� �պ�
merge into emp01 using emp02 on(emp01.empno = emp02.empno)
when MATCHED THEN update set
emp01.ename = emp02.ename,
emp01.job = emp02.job,
emp01.mgr = emp02.mgr,
emp01.hiredate = emp02.hiredate,
emp01.sal = emp02.sal,
emp01.comm = emp02.comm,
emp01.deptno = emp02.deptno
when not matched then
insert values(emp02.empno, emp02.ename, emp02.job, emp02.mgr, emp02.hiredate,
emp02.sal, emp02.comm, emp02.deptno);

select * from emp01;

//1��
create table emp_insert as select*from emp where 1=0;

select * from emp_insert;

//2��
insert into emp_insert values(1234,'��','����',1234,sysdate,null,null,null);

//3��
insert into emp_insert values(1235,'��','����',1235,sysdate-1,null,null,null);

//4��
create table emp_copy as select * from emp;

select * from emp_copy;
drop table emp_copy;

//5��
update emp_copy set empno=7788 where deptno=10;

select * from emp_copy;

//6��
update emp_copy set (job,sal) = (select job,sal from emp_copy where empno=7499);

//7��
update emp_copy
set(deptno)=(
select job,deptno
from emp_copy where empno=7369)
where job = (select job from emp_copy where empno=7369);

//8��
create table dept_copy as select*from dept;
select * from dept_copy;
//9��
delete from dept_copy where dname='RESEARCH';

//10��
delete from dept_copy where deptno=10 or deptno=40;

//11��
create table hw_emp as select * from emp;
create table hw_dept as select * from dept;
create table hw_salgrade as select * from salgrade;
select * from hw_dept;

insert into hw_dept values ( 50,'ORACLE','BUSAN');
insert into hw_dept values ( 60,'SQL','ILSAN');
insert into hw_dept values ( 70,'SELECT','INCHEON');
insert into hw_dept values ( 80,'DML','BUNDANG');

//12��
select * from hw_emp;

insert into hw_emp values (7934,'MILLER','CLERK',7782,'82/01/23',1300,null,10);
insert into hw_emp values (7201,'TEST_USER1','MANAGER',7788,'16/01/02',4500,null,50);
insert into hw_emp values (7202,'TEST_USER2','CLERK',7201,'16/02/21',1800,null,50);
insert into hw_emp values (7203,'TEST_USER3','ANALYST',7201,'16/04/11',3400,null,60);
insert into hw_emp values (7204,'TEST_USER4','SALESMAN',7201,'16/05/31',2700,300,60);
insert into hw_emp values (7205,'TEST_USER5','CLERK',7201,'16/07/20',2600,null,70);
insert into hw_emp values (7206,'TEST_USER6','CLERK',7201,'16/09/08',2600,null,70);
insert into hw_emp values (7207,'TEST_USER7','LECTURER',7201,'16/10/28',2300,null,80);
insert into hw_emp values (7208,'TEST_USER8','STUDENT',7201,'18/03/09',1200,null,80);

//13��
update hw_emp set deptno=70 
where sal>(select avg(sal) from hw_emp where deptno=50);

//14��
update hw_emp set deptno =80
where hiredate>(select min(hiredate) from hw_emp where deptno=60);

 
//15��
select e.empno
from hw_emp e, salgrade s
where e.sal between s.losal and s.hisal
and s.grade = 5;

//�ѹ�
select * from dept01;
delete from dept01;
rollback;

//20�� �μ� ����
delete from dept01 where deptno=20;
commit;

//40�� �μ� ����
select  * from dept02;
delete from dept02 where deptno=40;

create table dept03 as select * from dept;
select * from dept03;
rollback;
delete from dept03 where deptno=20;

select * from dept01;

delete from dept01 where deptno=40;
commit;

delete from dept01 where deptno=30;

savepoint c1;
delete from dept01 where deptno=20;

savepoint c2;
delete from dept01 where deptno=10;

rollback to c2;
rollback to c1;
rollback;

//�������� Ȯ��
desc user_constraints;

select constraint_name,constraint_type,table_name from user_constraints;

select * from user_cons_columns;

select * from emp01;

insert into emp01 values(NULL,NULL,'SALESMAN',8000,'1999/01/01',1000,NULL,30);

//not null �������� ���� ���̺� ����
drop table emp02;
select * from emp02;

create table emp02(
empno number(4) not null,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2));

//insert into emp02 values(null,null,'SALESMAN',10);
desc emp02;

//unique �������� ���� ���̺� ����
create table emp03(
empno number(4) unique,
ename varchar2(10) not null,
job varchar2(9),
deptno number(2));

INSERT INTO EMP03
VALUES(7499, 'ALLEN', 'SALESMAN', 30);

//insert into emp03
//values(7499,'JONES','MANAGER',20);

insert into emp03
values(null, 'JONES', 'MANAGER',20);

insert into emp03
values(null, 'JONES', 'SALESMAN',10);

select * from emp03;

desc emp03;

//���� ���Ǹ� ����ϱ�
drop table emp04;
create table emp04(
empno number(4) constraint emp04_empno_uk unique,
ename varchar2(10) constraint emp04_ename_nn not null,
job varchar2(9),
deptno number(2));

select * from emp;
insert into emp values (8000,'MICHAEL','ARTIST',7839,'88/01/01',5000,null,10);

update emp
set sal = sal*1.2 , comm = 300
where empno=8000;