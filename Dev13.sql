//scott�� ���� �μ����� �ٹ��ϴ� ����� �̸��� �μ���ȣ
select ename,deptno from emp
where deptno = (select deptno from emp where ename = 'SCOTT');

//scott�� ������ ������ ���� ���
select * from emp
where job =(select job from emp where ename ='SCOTT');

//scott�� �޿��� ���� , ������ �޴� ������ �޿�
select ename,sal from emp
where sal >= (select sal from emp where ename='SCOTT');

//DALLAS���� �ٹ��ϴ� ����� �̸� �μ���ȣ
select ename,deptno from emp
where deptno = (select deptno from dept where LOC='DALLAS');

//SALES �μ����� �ٹ��ϴ� ��� ����� �̸��� �޿�
select ename,sal from emp
where deptno = (select deptno from dept where dname='SALES');

//���ӻ���� KING�� ����� �̸��� �޿�
select ename,sal from emp
where mgr = (select empno from emp where ename='KING');

//������������ �׷��ռ� ���
select ename,sal from emp
where sal > (select avg(sal) from emp);

//������ �������� (in)
select ename,sal,deptno from emp
where deptno in (select deptno from emp 
where sal>=3000);

//�μ����� ���� �޿��� ���� �޴� ���
select empno,ename,sal,deptno from emp
where sal in(select max(sal) from emp group by deptno);

//job�� manager�� ����� ���� �μ��� �μ���ȣ , �μ��� , ����
select deptno,dname,loc from dept
where deptno in (select deptno from emp where job='MANAGER');

//ALL ������
select ename,sal from emp
where sal > all(select sal from emp where deptno=30);

//���� ������� �޿��� ���� �޴� ������� �̸��� �޿��� ����
select ename,sal,job from emp
where sal > all(select sal from emp where job = 'SALESMAN') and job <>'ANALYST';

//ANY ������
select ename,sal from emp
where sal > any (select sal from emp where deptno=30);

//����������� �ּ� �޿����� ���� �޴� ������� �̸�,�޿�,����
select ename,sal,job from emp
where sal > any(select sal from emp where job='SALESMAN') and job <>'SALESMAN';

//1��
select ename,job from emp
where job = (select job from emp where empno='7788');

//2��
select ename,job from emp
where sal > (select sal from emp where empno='7499');

//3��
select job, round(avg(sal),1) from emp
group by job having round(avg(sal),1) = (select min(round(avg,1))
from emp group by job);

//4��
select job,sal from emp
where sal in(select min(sal) from emp group by job);

//5��
select ename,sal,deptno from emp
where sal in ( select min(sal) from emp group by deptno);

//6��
select empno,ename,job from emp
where sal < any(select sal from emp where job = 'ANALYST') and job<>'SALESMAN';

//7��
select ename from emp 
where empno not in(select mgr from emp where mgr is not null);

//8��
select ename from emp
where empno in (select mgr from emp where mgr is not null);

//9��
select ename,hiredate from emp 
where deptno = (select deptno from emp where ename='BLAKE') and ename<>'BLAKE';

//10��
select empno,ename,sal from emp
where sal>(select avg(sal) from emp) order by sal asc;

//11��
select empno,ename,deptno from emp
where deptno in (select deptno
from emp where ename Like '%K%');

//12��
select ename,deptno,job from emp
where deptno = (select deptno from dept where loc='DALLAS');

//13��
select empno,ename,sal from emp
where mgr = (select empno from emp where ename = 'KING');

//14��
select deptno,ename,job from emp
where deptno = (select deptno from dept where dname='RESEARCH');

//15��
select empno,ename,sal from emp
where sal > (select avg(sal) from emp)
and deptno in (select deptno from emp
where ename Like '%M%');

//16��
select job,avg(sal) from emp group by job
having avg(sal) = (select min(avg(sal)) from emp group by job);

//17��
select empno,ename from emp
where empno in(select mgr from emp where mgr is not null)
and job <>'MANAGER';

//ROWID
select rowid,empno,ename from emp;

insert into emp
values(8000,'MICHALE','ARTIST',7839,TO_DATE('90-01-01','yy-mm-dd'),4000,600,40);

select rowid,deptno,dname from dept;

//�÷��� �Ⱓ(4��) ����

drop table sam02;

create table sam02
(year01 interval year(4) to month);

insert into sam02
values(interval '48' month(3));

select * from sam02;

select year01,sysdate,sysdate+year01 from sam02;

//�÷��� �Ⱓ(100��) ����
create table sam03
(day01 interval day(3) to second);

insert into sam03
values(interval '100' day(3));

select * from sam03;

select day01, sysdate, sysdate+day01 from sam03;

//���̺� ����
create table emp01
(empno number(4), ename varchar2(20), sal number(7,2));

drop table dept01;

create table dept01
(deptno number(2) , dname varchar2(14) , loc varchar2(13));

desc dept01;

create table emp02 as select * from emp;
desc dept02;

create table emp03 as select empno,ename from emp;
desc emp03;

create table emp04 as select empno,ename,sal from emp where 1=0;
select * from emp04;
desc emp04;

create table emp05 as select * from emp where deptno = 10;
select * from emp05;

drop table dept20;

CREATE TABLE DEPT20
AS
SELECT EMPNO,ENAME, SAL*12 ANNSAL
FROM EMP
WHERE DEPTNO=20;

select * from dept20;

drop table dept02;

create table dept02
(deptno number(2) , dname varchar2(14) , loc varchar2(13));

desc dept02;

//���̺� ���� ���� alter table
alter table emp01 add(job varchar2(9));
desc emp01;

alter table dept02 add(dngr number(4));

alter table dept02 add(dngr varchar2(15));
desc dept02;
select * from dept02;
insert into dept02 values (10,'RESEARCH','PARIS','KIM');
delete from dept02;


//���� �÷� �Ӽ� �����ϱ�
alter table emp01 modify(job varchar2(30));
desc emp01;
alter table dept02 modify(dngr number(4));
desc dept02;

//���� �÷� ���� (emp01 ���̺� ���� Į�� ����)
alter table emp01 drop column job;
desc emp01;
alter table dept02 drop column dngr;
desc dept02;

//���� �÷� ��� �����ϱ�
select * from emp02;
alter table emp02 set unused(job);
desc emp02;

alter table emp02 drop unused columns;

drop table emp01;

//���̺� ���� ��ü ����
select * from emp02;
truncate table emp02;
desc emp02;

//���̺�� ���� rename
rename emp02 to test;
select * from test;

//user_tables ������ ��ųʸ� ��

desc user_tables;

show user

select table_name from user_tables order by table_name desc;

//all_tables ������ ��ųʸ� ��

desc all_tables;

select owner, table_name from all_tables;

//1��
create table dept00 (dno number(2), dname varchar2(14), loc varchar2(13));
select * from dept00;
desc dept00;

//2��
create table emp00 (eno number(4) , ename varchar2(10) , dno number(2));
select * from emp00;
desc emp00;

//3��
alter table emp00 modify(ename varchar2(25));
desc emp00;

//4��
drop table emp002;
create table emp002 as select empno,ename,sal,job,comm from emp;
alter table emp002 rename column empno to emp_id;
alter table emp002 rename column ename to name;
alter table emp002 rename column job to dept_id;
select * from emp002;

//5��
drop table emp00;

//6��
rename emp002 to emp00;
select * from emp00;

//7��
alter table dept00 drop column dname;
select * from dept00;

//8��
alter table dept00 drop column dno;
select * from dept00;

//9��
alter table emp00 set unused (sal);
select * from emp00;

//10��
alter table emp00 drop unused columns;
select * from emp00;