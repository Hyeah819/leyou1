create tablespace itheima
datafile 'c:\itheima.dbf'
size 100m
autoextend on
next 10m;

drop tablespace itheima;

create user itheima
identified by itheima
default tablespace itheima;
--��Ȩ
grant dba to itheima;

create table person(
       pid number(20),
       pname varchar2(10)
);

alter table person add gender number(1)

alter table person modify gender char(1)

alter table person rename column gender to sex

alter table person drop column sex

select * from person

insert into person(pid,pname) values(1,'С��');
commit;

update person set pname='С��' where pid=1;
commit;

alter user scott account unlock;
alter user scott identified by tiger;

delete from person;--ɾ��ȫ����¼
drop table person;
truncate table person;--ɾ�����ٴ��������������ʱ��ʹ��

--���У�Ĭ��1��ʼ�����ε���
create sequence s_person;
select s_person.currval from dual;
select s_person.nextval from dual;

insert into person (pid,pname) values(s_person.nextval,'����');

--����
select upper('yes') from dual;
select lower('yEs') from dual;

select round(26.18,1) from dual;--�������룬����Ĳ���Ϊ������λ��-1��ǰ����
select trunc(56.16,-2) from dual;--ֱ�ӽ�ȡ
select mod(10,3)from dual;

select sysdate-e.hiredate from emp e;--��ְ�����ڼ���
select months_between(sysdate,e.hiredate)from emp e;--���뼸����
select months_between(sysdate,e.hiredate)/12 from emp e;--���뼸����
select round((sysdate-e.hiredate)/7) from emp e;--��ְ�����ڼ�����
--ת��
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;
select to_date('2019-03-26 22:24:34','yyyy-mm-dd hh24:mi:ss') from dual;

select sysdate+1 from dual;

--ͨ�ú���
select sal*12+nvl(e.comm,0) from emp e;

--�������ʽ

select e.ename, 
       case e.ename
         when 'SMITH' then '����'
           else '����'
             end
from emp e;

--��Χ�ж�emp����Ա������ ����3000�����룬����1500С��3000�е����룬����͵�����
select e.sal, 
       case 
         when e.sal>3000 then '������'
           when e.sal>1500 then '������'
           else '������'
             end
from emp e;
--orcalר��
select e.ename, 
       decode( e.ename,
         'SMITH' ,'����',
           '����')������
from emp e;

--���к��� �ۺϺ���
select count(1) from emp;
select sum(sal) from emp;
select max(sal) from emp;
select min(sal) from emp;
select round(avg(sal)) from emp;
--�����ѯ
select e.deptno,avg(e.sal)
from emp e
where e.sal>800
group by e.deptno;

select avg(e.sal)
from emp e
group by e.deptno;


select e.deptno,avg(e.sal)
from emp e
group by e.deptno
having avg(e.sal)>2000;
--where���˷���ǰ�����ݣ�having�ǹ��˷��������ݣ�
--where��group by ֮ǰ��having��֮��
select e.deptno,avg(e.sal)
from emp e
where e.sal>800
group by e.deptno
having avg(e.sal)>2000;
--����ѯ
select * from emp e,dept d;
--������  Ҳ�е�ֵ����
select *from emp e,dept d
where e.deptno=d.deptno;
--������
select *
from emp e right join dept d
on e.deptno=d.deptno;
--orclר��������
--ʡ��
--��Ա���������쵼����   ������,��һ�ű��ɶ��ű�
select e1.ename,e2.ename
from emp e1,emp e2
where e1.mgr=e2.empno;
--��Ա��������Ա�����ţ��쵼���ţ��쵼���� 
select e1.ename,d1.deptno,e2.ename,d2.deptno
from emp e1,emp e2,dept d1,dept d2
where e1.mgr=e2.empno
and e1.deptno=d1.deptno
and e2.deptno=d2.deptno;


--�Ӳ�ѯ������һ��ֵ��һ�����ϣ�һ�ű�
--��ѯ���ʺ�scottһ������Ϣ
select * from emp where sal in (
select sal from emp where ename='SCOTT')

--��ѯ���ʺ�10�Ų�������Ա��һ��
select * from emp where sal in(
select sal from emp where deptno=10)

--��ѯÿ��������͹��ʣ������Ա���������͸�Ա�����ڲ���
select deptno,min(sal)msal
from emp
group by deptno;

select t.deptno,t.msal,e.ename,d.dname
from(select deptno,min(sal)msal
from emp
group by deptno) t,emp e,dept d
where t.deptno=e.deptno
and t.msal=e.sal
and e.deptno=d.deptno

--���к������ۺϺ�����
select count(1)from emp;
select sum(sal)from emp;
select min(sal)from emp;
select max(sal)from emp;
select avg(sal)from emp;
 
--�����ѯ
--��ѯѰÿ�����ŵ�ƽ������
select e.deptno,avg(sal)
from emp e
group by e.deptno
--ƽ�����ʸ�����ǧ�Ĳ�����Ϣ
select e.deptno,avg(sal)
from emp e
group by e.deptno
having avg(sal)>2000

--��ҳ
select * from emp e  order by e.sal desc

select rownum,t.*from(
select rownum,e.* from emp e order by e.sal desc)t
--��Ҫ�������ͱ�
select * from(
select rownum rn,e.* from(
select * from emp order by sal desc
)e where rownum<11
) where rn>5

--��ͼ dbaȨ��
create table emp as select * from scott.emp;
select * from emp;

create view v_emp as select ename,job from emp;

select * from v_emp;
update v_emp set job='CLERK' where ename='ALLEN';
commit;
create view v_emp1 as select ename,job from emp with read only;

--����
create index idx_ename on emp(ename);
select * from emp where ename='SCOTT';

--����
create index idx_enamejob on emp(ename,job);
select * from emp where ename='SCOTT' and job='xx';

--pl/sql�������

declare
 i number(2):=10;
 s varchar2(10):='С��';
 ena emp.ename%type;
 emprow emp%rowtype;
begin
  dbms_output.put_line(i);
  dbms_output.put_line(s);
  select ename into ena from emp where empno=7788;
  dbms_output.put_line(ena);
  select * into emprow from emp where empno=7788;
  dbms_output.put_line(emprow.ename||'�Ĺ���Ϊ'||emprow.job);
 end;
 
 --if�ж�
 declare
 i number(3):=&i;
 
 begin
   if i<18 then
     dbms_output.put_line('δ����');
   elsif  i<40 then
     dbms_output.put_line('����');
     else
       dbms_output.put_line('����');
       end if;
 end;
 --ѭ��
 declare
 i number(2):=1;
 begin
   while i<11 loop
     dbms_output.put_line(i);
     i:=i+1;
     
   end loop;
 end;
 
 declare
 i number(2):=1;
 begin
  loop
    exit when i>10;
    dbms_output.put_line(i);
     i:=i+1;
     end loop;
 end;
 
 declare
  i number(2):=1;
 begin
 for i in 1..10 loop
    dbms_output.put_line(i);
   end loop;  
   end;
 
 --�α꣺��Ŷ�����󣬶��м�¼
 --�������Ա��
 declare
 cursor cl is select * from emp;
 emprow emp%rowtype;
 begin
   open cl;
   loop
     fetch cl into emprow;
     exit when cl%notfound;
     dbms_output.put_line(emprow.ename);
     end loop;
   close cl;
   end;
   
   declare
   cursor c2(eno emp.deptno%type) 
   is select empno from emp where deptno =eno;
   en emp.empno%type;
   begin
     open c2(10);
     loop
       fetch c2 into en;
       exit when c2%notfound;
       update emp set sal=sal+100 where empno=en;
       commit;
       end loop;
     close c2;
   end;
   --10�Ų��żӹ���
   select * from emp where deptno=10;
   
   
 --�洢����
 --���ƶ�Ա����100
 create or replace procedure p1(eno emp.empno%type)
 is
 begin
   update emp set sal=sal+100 where empno=eno;
   commit;
   end;
   --
   select * from emp where empno=7788;
   --
   declare
   
   begin
     p1(7788);
   end;
 
 
--�洢����

--����ָ��Ա������н
create or replace function f_yearsal(eno emp.empno%type)return number
is
s number(10);
begin
   select sal*12+nvl(comm,0) into s from emp where empno=eno;
return s;
end; 
--����,�з���ֵҪ����
declare
s number(10);
begin
  s:=f_yearsal(7788);
dbms_output.put_line(s);
end;

--out����ʹ��
--�洢��������н
create or replace procedure p_yearsal(eno emp.empno%type,yearsal out number)
is 
s number(10);
c emp.comm%type;
begin
  select sal*12,nvl(comm,0)into s,c from emp where empno=eno;
  yearsal:=s+c;
  end;
  --����
  declare
  yearsal number(10);
  begin
    p_yearsal(7788,yearsal);
    dbms_output.put_line(yearsal);
  end;

create table dept as select * from scott.dept;

select e.ename,d.dname
from emp e,dept d
where e.deptno=d.deptno;

--��������
create or replace function fdna(dno dept.deptno%type)return dept.dname%type
is
dna dept.dname%type;
begin
  select dname into dna from dept where deptno=dno;
  return dna;
end;

select
e.ename ,fdna(e.deptno)
from 
emp e;

--������,��ɾ�Ĵ���
--��䴥������
--�м�������for each row,Ϊ��ʹ�ã�old ���ߣ�new

--���룬���һ����Ա����ְ
create or replace trigger t1
after
insert
on person
declare

begin
  dbms_output.put_line('��Ա����ְ');
  end;
  
  insert into person values(2,'����');
  commit;
  
  select * from person;
  
  
  --�м������ܸ�Ա����н
  -- -20001~-20999֮��
  create or replace trigger t2
  before
  update
  on emp
  for each row
    declare
    begin
      if :old.sal>:new.sal then
        raise_application_error(-20001,'���ܸ�Ա����н');
      end if;
    end;
    
    update emp set sal=sal-1 where empno=7788;
    
    --������ʵ����������

--���û��������֮ǰ�õ�������������ݣ��������и�ֵ

create or replace trigger auid
before
insert 
on person
for each row
  declare
  
  begin
    select s_person.nextval into :new.pid from dual;
  end;
  
  select * from person;
  
  insert into person (pname) values('a');
  commit;





