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

//외래키 제약 조건 FK references
create table emp06(
empno number(4) constraint emp06_empno_pk primary key,
ename varchar2(10) constraint emp06_ename_nn not null,
job varchar2(9),
deptno number(2) constraint emp06_deptno_fk references dept(deptno));

insert into emp06 values (7566,'JONES','MANAGER',50);

//check 제약조건 설정
create table emp07(
empno number(4) constraint emp07_empno_pk primary key,
ename varchar2(10) constraint emp07_ename_nn not null,
sal number(7,2) constraint emp07_sal_ck check(sal between 500 and 5000),
gender varchar2(1) constraint emp07_gender_ck check (gender in('M','F')));

insert into emp07 values(9100,'이순신',5000,'B');

//default 제약조건 설정
create table dept01(
deptno number(2) primary key,
dname varchar2(14),
loc varchar2(13) default 'SEOUL');

insert into dept01(deptno,dname) values(10,'ACCOUNTING');
select * from dept01;

//컬럼 레벨 제약 조건 설정 , 테이블 레벨 제약 조건 설정
drop table emp01;
//컬럼 레벨로 제약 조건 지정
create table emp01 (
empno number(4) primary key,
ename varchar2(10) not null,
job varchar2(9) unique,
deptno number(4) references dept(deptno));

//테이블 레벨 방식
drop table emp02;
create table emp02(
empno number(4),
ename varchar2(10) not null,
job varchar2(9),
deptno number(4),
primary key(empno),
unique(job),
foreign key(deptno) references dept(deptno));

//명시적으로 제약 조건 명을 지정하여 테이블 레벨 방식으로 제약 조건 지정
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

//복합키를 기본 키로 지정
create table member01(
name varchar2(10),
address varchar2(30),
hphone varchar2(16),
constraint member01_combo_pk primary key(name,hphone));

//기존 테이블에 제약 조건 추가 (alter table add)
drop table emp01;
create table emp01(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4));

//emp01 테이블에 empno컬럼에 기본키 설정
alter table emp01
add constraint emp01_empno_pk primary key(empno);
//deptno 컬럼에 외래키 설정
alter table emp01
add constraint emp01_deptno_fk foreign key(deptno) references dept(deptno);

//기존 테이블에 not null 제약조건 추가 modify 사용
alter table emp01
modify ename constraint emp01_ename_nn not null;

//제약 조건 제거 (alter table drop)
alter table emp05 drop constraint emp05_empno_pk;

alter table emp05 drop constraint emp05_ename_nn;

//제약조건으로 인한 컬럼 삭제 불가능 예
drop table dept01;
create table dept01(
deptno number(2) constraint dept01_deptno_pk primary key,
dname varchar2(14),
loc varchar2(13));

//사원 테이블의 부서번호가 부서 테이블의 부서번호를 참조하도록 외래키 설정
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

//사원의 정보를 추가할 때 부서 테이블을 참조하므로 부서 테이블에 존재하는 부서번호 입력
insert into dept01 values(10,'ACCOUNTING','NEW YORK');
insert into dept01 values(20,'RESEARCH','DALLAS');
insert into dept01 values(30,'SALES','CHICAGO');
insert into dept01 values(40,'OPERATIONS','BOSTON');

insert into emp01 values(7499,'ALLEN','SALESMAN',10);
insert into emp01 values(7369,'SMITH','CLERK',20);

delete from dept01 where deptno=10;

//제약 조건 비활성화
alter table emp01
disable constraint emp01_deptno_fk;

select constraint_name,constraint_type,table_name,r_constraint_name,status
from user_constraints where table_name='EMP01';

delete from dept01 where deptno = 10;

select * from dept01;

//제약조건 활성화
alter table emp01
enable constraint emp01_deptno_fk;

insert into dept01 values(10,'ACCOUNTING','NEW YORK');

//cascade 옵션
alter table dept01 disable primary key;
//cascade 옵션으로 제약 조건 연속적으로 비활성화
alter table dept01 disable primary key cascade;

select constraint_name,constraint_type,table_name,r_constraint_name,status
from user_constraints where table_name in('DEPT01','EMP01');

//cascade 옵션을 지정하여 제약 조건 삭제
alter table dept01 drop primary key cascade;

//1번 
desc emp_sample;
create table emp_sample as select * from emp where 1=0; 

alter table emp_sample
add constraint my_emp_pk primary key(empno);

//2번
desc dept01;
alter table dept01
add constraint my_dept_pk primary key(deptno);

//3번 
alter table emp_sample
add constraint my_emp_dept_fk 
foreign key(deptno)
REFERENCES dept01(deptno);

//4번 사원 테이블의 커미션 컬럼에 0보다 큰 값만 입력할 수 있또록 제약 조건 지정
alter table emp_sample
add constraint my_comm_ck
check (comm>0);

//뷰의 기본 테이블 생성 복사본 생성
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
//select문 emp_view20이란 이름의 뷰로 정의
CREATE VIEW EMP_VIEW20
AS
SELECT EMPNO,ENAME,DEPTNO,MGR
FROM EMP_COPY
WHERE DEPTNO=20;

//user_view에서 테이블 이름, 텍스트만 출력
select view_name, text from user_views;

//뷰와 기본 테이블 관계 파악
insert into emp_view30 values(1111,'AAAA',30);
select * from emp_view30;
select * from emp_copy;

//단순 뷰에 대한 데이터 조작 데이터 추가
insert into emp_view30 values(8000,'ANGEL',30);
select * from emp_view30;
select * from emp_copy;

//단순 뷰의 컬럼에 별칭 부여
create or replace view emp_view(사원번호,사원명,급여,부서번호)
as
select empno,ename,sal,deptno from emp_copy;
select * from emp_view;

select * from emp_view where 부서번호=30;

//복합 뷰 만들기
CREATE VIEW EMP_VIEW_DEPT
AS
SELECT E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME, D.LOC 
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO DESC;

select * from emp_view_dept;

//그룹 함수 사용한 단순 뷰
create view view_sal
as
select deptno, sum(sal) as "salsum",
avg(sal) as "salavg"
from emp_copy
group by deptno;
select * from view_sal;

//각 부서별 최대 급여와 최소 급여를 출력하는 뷰를 SAL_VIEW란 이름으로 작성
create or replace view sal_view as 
select D.dname,max(E.sal) max_sal, min(E.sal) min_sal 
from emp E,dept D
where E.DEPTNO = D.DEPTNO 
group by D.dname;

select * from sal_view;

//뷰 삭제하기
drop view view_sal;

//뷰 수정 or replace
CREATE OR REPLACE VIEW EMP_VIEW30
AS 
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO 
FROM EMP_COPY
WHERE DEPTNO=30;

//컬럼 별칭 추가 뷰 변경
CREATE OR REPLACE VIEW emp_view20
AS
SELECT EMPNO AS "EMP_NO", ENAME AS "EMP_NAME", DEPTNO AS "DEPT_NO", MGR AS "MANAGER"
FROM EMP_COPY
WHERE DEPTNO = 20;

select * from emp_view20;


//FORCE 옵션으로 기본 테이블 없이 뷰 생성
create or replace view employees_view
as
select empno,ename,deptno
from employees
where deptno=30;

//force 옵션 적용
create or replace force view notable_view
as
select empno,ename,deptno
from employees
where deptno=30;

select view_name,text
from user_views;

//noforce 옵션
create or replace noforce view existtable_view
as
select empno,ename,deptno
from employees
where deptno=30;

//조건 컬럼값 변경 못하게하는 with check option
update emp_view30 set deptno=20
where sal >= 1200;

//with check option
create or replace view view_chk30
as
select empno,ename,sal,comm,deptno from emp_copy
where deptno=30 with check option;

//급여가 5000이상 사원 20번 부서 이동
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
//입사일 기준 오름차순 정렬 쿼리문에 rownum 컬럼 출력
select rownum,empno,ename,hiredate from emp order by hiredate;

//입사일 기준 오름차순 정렬 쿼리문 새로운 뷰
create or replace view view_hire
as
select empno,ename,hiredate from emp order by hiredate;
select * from view_hire;

select rownum,empno,ename,hiredate from view_hire;

//입사일이 빠른 사람 5명
select rownum,empno,ename,hiredate from view_hire where rownum<=5;

//
select rownum,empno,ename,hiredate
from (select empno,ename,hiredate from emp order by hiredate)
where rownum<=5;

//인라인 뷰 사용 급여 많이 받는 순서대로 3명만 출력
select rownum ranking,empno,ename,sal
from (select empno,ename,sal from emp order by sal desc)
where rownum<=3;


create or replace view sal_top3_view
as
select rownum ranking,empno,ename,sal
from (select empno,ename,sal from emp order by sal desc)
where rownum<=3;

select * from sal_top3_view;

//1번 20번 부서에 소속된 사원의 사원번호,이름,부서번호 출력
create or replace view v_em_dno
as
select deptno,ename,empno
from emp
where deptno=20;

select * from v_em_dno;

//2번
create or replace view v_em_dno
as
select deptno,ename,empno,sal
from emp
where deptno=20;

//3번
drop view v_em_dno;


//시퀀스 관련 데이터 딕셔너리
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

//사원번호 생성하는 시퀀스 객체
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

//부서번호 생성하는 시퀀스 객체
create table dept_example(
deptno number(4) primary key,
dname varchar2(15),
loc varchar2(15));

create sequence dept_seq
start with 10
increment by 10
maxvalue 10000;

insert into dept_example
values (dept_seq.nextval,'인사과','서울');
insert into dept_example
values (dept_seq.nextval,'경리과','서울');
insert into dept_example
values (dept_seq.nextval,'총무과','대전');
insert into dept_example
values (dept_seq.nextval,'기술과','인천');

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