drop table emp05;
//primary key
create table emp05 (
empno number(4) constraint emp05_empno_pk primary key,
ename varchar2(10) constraint emp05_ename_nn not null,
job varchar2(9),
deptno number(2));

insert into emp05 values (7499,'ALLEN','SALESMAN',30);
//insert into emp05 values (7499,'JONES','MANAGER',20);
//insert into emp05 values (null,'JONES','MANAGER',20);

insert into emp values (8100,'SUJAN','CLERK',7839,'92/03/03',3000,500,50);

SELECT TABLE_NAME, CONSTRAINT_TYPE, 
CONSTRAINT_NAME, R_CONSTRAINT_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('DEPT', 'EMP');

//�ܷ�Ű ���� ���� FK references
create table emp06(
empno number(4) constraint emp06_empno_pk primary key,
ename varchar2(10) constraint emp06_ename_nn not null,
job varchar2(9),
deptno number(2) constraint emp06_deptno_fk references dept(deptno));

insert into emp06 values (7566,'JONES','MANAGER',50);

//check �������� ����
create table emp07(
empno number(4) constraint emp07_empno_pk primary key,
ename varchar2(10) constraint emp07_ename_nn not null,
sal number(7,2) constraint emp07_sal_ck check(sal between 500 and 5000),
gender varchar2(1) constraint emp07_gender_ck check (gender in('M','F')));

insert into emp07 values(9100,'�̼���',5000,'B');

//default �������� ����
create table dept01(
deptno number(2) primary key,
dname varchar2(14),
loc varchar2(13) default 'SEOUL');

insert into dept01(deptno,dname) values(10,'ACCOUNTING');
select * from dept01;

//�÷� ���� ���� ���� ���� , ���̺� ���� ���� ���� ����
drop table emp01;
//�÷� ������ ���� ���� ����
create table emp01 (
empno number(4) primary key,
ename varchar2(10) not null,
job varchar2(9) unique,
deptno number(4) references dept(deptno));

//���̺� ���� ���
drop table emp02;
create table emp02(
empno number(4),
ename varchar2(10) not null,
job varchar2(9),
deptno number(4),
primary key(empno),
unique(job),
foreign key(deptno) references dept(deptno));

//��������� ���� ���� ���� �����Ͽ� ���̺� ���� ������� ���� ���� ����
drop table emp03;
create table emp03(
empno number(4) constraint emp03_ename_nn not null,
ename varchar2(10),
job varchar2(9),
deptno number(4),
constraint emp03_empno_pk primary key(empno),
constraint emp03_job_uk unique(job),
constraint emp03_deptno_fk foreign key(deptno)
references dept(deptno));

//����Ű�� �⺻ Ű�� ����
create table member01(
name varchar2(10),
address varchar2(30),
hphone varchar2(16),
constraint member01_combo_pk primary key(name,hphone));

//���� ���̺� ���� ���� �߰� (alter table add)
drop table emp01;
create table emp01(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4));

//emp01 ���̺� empno�÷��� �⺻Ű ����
alter table emp01
add constraint emp01_empno_pk primary key(empno);
//deptno �÷��� �ܷ�Ű ����
alter table emp01
add constraint emp01_deptno_fk foreign key(deptno) references dept(deptno);

//���� ���̺� not null �������� �߰� modify ���
alter table emp01
modify ename constraint emp01_ename_nn not null;

//���� ���� ���� (alter table drop)
alter table emp05 drop constraint emp05_empno_pk;

alter table emp05 drop constraint emp05_ename_nn;

//������������ ���� �÷� ���� �Ұ��� ��
drop table dept01;
create table dept01(
deptno number(2) constraint dept01_deptno_pk primary key,
dname varchar2(14),
loc varchar2(13));

//��� ���̺��� �μ���ȣ�� �μ� ���̺��� �μ���ȣ�� �����ϵ��� �ܷ�Ű ����
drop table emp01;
create table emp01(
EMPNO NUMBER(4) 
CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY ,
ENAME VARCHAR2(10) 
CONSTRAINT EMP01_ENAME_NN NOT NULL, 
JOB VARCHAR2(9), 
DEPTNO NUMBER(4) 
CONSTRAINT EMP01_DEPTNO_FK REFERENCES DEPT01(DEPTNO)
);

//����� ������ �߰��� �� �μ� ���̺��� �����ϹǷ� �μ� ���̺� �����ϴ� �μ���ȣ �Է�
insert into dept01 values(10,'ACCOUNTING','NEW YORK');
insert into dept01 values(20,'RESEARCH','DALLAS');
insert into dept01 values(30,'SALES','CHICAGO');
insert into dept01 values(40,'OPERATIONS','BOSTON');

insert into emp01 values(7499,'ALLEN','SALESMAN',10);
insert into emp01 values(7369,'SMITH','CLERK',20);

delete from dept01 where deptno=10;

//���� ���� ��Ȱ��ȭ
alter table emp01
disable constraint emp01_deptno_fk;

select constraint_name,constraint_type,table_name,r_constraint_name,status
from user_constraints where table_name='EMP01';

delete from dept01 where deptno = 10;

select * from dept01;

//�������� Ȱ��ȭ
alter table emp01
enable constraint emp01_deptno_fk;

insert into dept01 values(10,'ACCOUNTING','NEW YORK');

//cascade �ɼ�
alter table dept01 disable primary key;
//cascade �ɼ����� ���� ���� ���������� ��Ȱ��ȭ
alter table dept01 disable primary key cascade;

select constraint_name,constraint_type,table_name,r_constraint_name,status
from user_constraints where table_name in('DEPT01','EMP01');

//cascade �ɼ��� �����Ͽ� ���� ���� ����
alter table dept01 drop primary key cascade;

//1�� 
desc emp_sample;
create table emp_sample as select * from emp where 1=0; 

alter table emp_sample
add constraint my_emp_pk primary key(empno);

//2��
desc dept01;
alter table dept01
add constraint my_dept_pk primary key(deptno);

//3�� 
alter table emp_sample
add constraint my_emp_dept_fk 
foreign key(deptno)
REFERENCES dept01(deptno);

//4�� ��� ���̺��� Ŀ�̼� �÷��� 0���� ū ���� �Է��� �� �ֶǷ� ���� ���� ����
alter table emp_sample
add constraint my_comm_ck
check (comm>0);

//���� �⺻ ���̺� ���� ���纻 ����
drop table dept_copy;
create table dept_copy as select * from dept;

drop table emp_copy;
create table emp_copy as select * from emp;

CREATE VIEW EMP_VIEW30
AS 
SELECT EMPNO, ENAME, DEPTNO
FROM EMP_COPY
WHERE DEPTNO=30;

select * from emp_view30;
desc emp_view30;
//select�� emp_view20�̶� �̸��� ��� ����
CREATE VIEW EMP_VIEW20
AS
SELECT EMPNO,ENAME,DEPTNO,MGR
FROM EMP_COPY
WHERE DEPTNO=20;

//user_view���� ���̺� �̸�, �ؽ�Ʈ�� ���
select view_name, text from user_views;

//��� �⺻ ���̺� ���� �ľ�
insert into emp_view30 values(1111,'AAAA',30);
select * from emp_view30;
select * from emp_copy;

//�ܼ� �信 ���� ������ ���� ������ �߰�
insert into emp_view30 values(8000,'ANGEL',30);
select * from emp_view30;
select * from emp_copy;

//�ܼ� ���� �÷��� ��Ī �ο�
create or replace view emp_view(�����ȣ,�����,�޿�,�μ���ȣ)
as
select empno,ename,sal,deptno from emp_copy;
select * from emp_view;

select * from emp_view where �μ���ȣ=30;

//���� �� �����
CREATE VIEW EMP_VIEW_DEPT
AS
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO DESC;

select * from emp_view_dept;

//�׷� �Լ� ����� �ܼ� ��
create view view_sal
as
select deptno, sum(sal) as "salsum",
avg(sal) as "salavg"
from emp_copy
group by deptno;
select * from view_sal;

//�� �μ��� �ִ� �޿��� �ּ� �޿��� ����ϴ� �並 SAL_VIEW�� �̸����� �ۼ�
create or replace view sal_view as 
select D.dname,max(E.sal) max_sal, min(E.sal) min_sal 
from emp E,dept D
where E.DEPTNO = D.DEPTNO 
group by D.dname;

select * from sal_view;

//�� �����ϱ�
drop view view_sal;

//�� ���� or replace
CREATE OR REPLACE VIEW EMP_VIEW30
AS 
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO 
FROM EMP_COPY
WHERE DEPTNO=30;

//�÷� ��Ī �߰� �� ����
CREATE OR REPLACE VIEW emp_view20
AS
SELECT EMPNO AS "EMP_NO", ENAME AS "EMP_NAME", DEPTNO AS "DEPT_NO", MGR AS "MANAGER"
FROM EMP_COPY
WHERE DEPTNO = 20;

select * from emp_view20;


//FORCE �ɼ����� �⺻ ���̺� ���� �� ����
create or replace view employees_view
as
select empno,ename,deptno
from employees
where deptno=30;

//force �ɼ� ����
create or replace force view notable_view
as
select empno,ename,deptno
from employees
where deptno=30;

select view_name,text
from user_views;

//noforce �ɼ�
create or replace noforce view existtable_view
as
select empno,ename,deptno
from employees
where deptno=30;

//���� �÷��� ���� ���ϰ��ϴ� with check option
update emp_view30 set deptno=20
where sal >= 1200;

//with check option
create or replace view view_chk30
as
select empno,ename,sal,comm,deptno from emp_copy
where deptno=30 with check option;

//�޿��� 5000�̻� ��� 20�� �μ� �̵�
update view_chk30 set deptno=20
where sal >= 1200;

//with check option , with read only
update view_chk30 set comm=1000;

create or replace view view_read30
as
select empno,ename,sal,comm,deptno
from emp_copy
where dept=30 with read only;

update view_read30 set comm=2000;

//ROWNUM
select rownum,empno,ename,hiredate from emp;

select empno,ename,hiredate from emp order by hiredate;
//�Ի��� ���� �������� ���� �������� rownum �÷� ���
select rownum,empno,ename,hiredate from emp order by hiredate;

//�Ի��� ���� �������� ���� ������ ���ο� ��
create or replace view view_hire
as
select empno,ename,hiredate from emp order by hiredate;
select * from view_hire;

select rownum,empno,ename,hiredate from view_hire;

//�Ի����� ���� ��� 5��
select rownum,empno,ename,hiredate from view_hire where rownum<=5;

//
select rownum,empno,ename,hiredate
from (select empno,ename,hiredate from emp order by hiredate)
where rownum<=5;

//�ζ��� �� ��� �޿� ���� �޴� ������� 3�� ���
select rownum ranking,empno,ename,sal
from (select empno,ename,sal from emp order by sal desc)
where rownum<=3;


create or replace view sal_top3_view
as
select rownum ranking,empno,ename,sal
from (select empno,ename,sal from emp order by sal desc)
where rownum<=3;

select * from sal_top3_view;

//1�� 20�� �μ��� �Ҽӵ� ����� �����ȣ,�̸�,�μ���ȣ ���
create or replace view v_em_dno
as
select deptno,ename,empno
from emp
where deptno=20;

select * from v_em_dno;

//2��
create or replace view v_em_dno
as
select deptno,ename,empno,sal
from emp
where deptno=20;

//3��
drop view v_em_dno;


//������ ���� ������ ��ųʸ�
select sequence_name, min_value, max_value,
increment_by,cycle_flag
from user_sequences;

create sequence dept_deptno_seq
increment by 10
start with 10;

//nextval
select dept_deptno_seq.nextval from dual;

//currval
select dept_deptno_seq.currval from dual;

//�����ȣ �����ϴ� ������ ��ü
create sequence emp_seq
start with 1
increment by 1
maxvalue 100000;

//2.
drop table emp01;
create table emp01(
empno number(4) primary key,
ename varchar(10),
hiredate date);

//3.
insert into emp01
values (emp_seq.nextval,'JULIA', sysdate);

select * from emp01;

//�μ���ȣ �����ϴ� ������ ��ü
create table dept_example(
deptno number(4) primary key,
dname varchar2(15),
loc varchar2(15));

create sequence dept_seq
start with 10
increment by 10
maxvalue 10000;

insert into dept_example
values (dept_seq.nextval,'�λ��','����');
insert into dept_example
values (dept_seq.nextval,'�渮��','����');
insert into dept_example
values (dept_seq.nextval,'�ѹ���','����');
insert into dept_example
values (dept_seq.nextval,'�����','��õ');

select * from dept_example;

DROP SEQUENCE dept_seq;

//

create table MEMBER_TBL (

id varchar2(14) primary key,

name varchar2(20) not null,

password varchar2(20) not null,

phone varchar2(13),

email varchar2(30),

grade char(1));

desc member_tbl;

//
alter table member_tbl add(point number(10));



alter table member_tbl modify(grade char(10));



alter table member_tbl drop column email;

//

create table BOARD_TBL(

bno number(4) primary key,

title varchar2(50),

content varchar2(1000),

id varchar2(14) constraint board_tbl_member_tbl_fk references member_tbl(id));

//regdate date);


//
select * from user_constraints;