DROP table boards;

create table boards (
    bno             number          primary key,
    btitle          varchar2(100)   not null,
    bcontent        clob            not null,
    bwriter         varchar2(50)    not null,
    bdate           date            default sysdate,
    bfilename       varchar2(50)    null,
    bfiledata		blob			null
);
CREATE SEQUENCE SEQ_BNO NOCACHE;

Insert INTO Boards values
(SEQ_BNO.NEXTVAL,'눈오는 날','함박눈이 내려요','winter',sysdate,'snow.jpg','');

create table users (
	userid          varchar2(50)	primary key, 
	username		varchar2(50)	not null,
	userpassword	varchar2(50)	not null,
	userage			number(3)	    not null,
	useremail		varchar2(50)	not null
);