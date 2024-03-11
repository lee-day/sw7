<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 
 <%
 	request.setCharacterEncoding("UTF-8");
 	String id=request.getParameter("id");
 	String pass=request.getParameter("pass");
 	String name=request.getParameter("name");
 	String num=request.getParameter("num");
 	String mode=request.getParameter("mode");
 
 	out.println(id);
 
 	 
 	
 %>
 
 <!-- 
 
 Create table '테이블명'(
 	테이블 조건
 	Primary key('키 필드')
 )
 
  Create table tb_member(
 	id varchar2(20) NOT NULL,
 	pass varchar2(20) NOT NULL,
 	name varchar2(10) NOT NULL,
 	num number(2) NOT NULL,
 	constraint tb_member_pk Primary key(id)
 )
 
 cmd -> sqlplus
 
 id system
 pw 1234
 
 SQL> Create table tb_member(
  2   id varchar2(20) NOT NULL,
  3   pass varchar2(20) NOT NULL,
  4   name varchar2(10) NOT NULL,
  5   num number(2) NOT NULL,
  6   constraint tb_member_pk Primary key(id)
  7   );

테이블이 생성되었습니다.

SQL> desc tb_member;
 이름                                      널?      유형
 ----------------------------------------- -------- ----------------------------
 ID                                        NOT NULL VARCHAR2(20)
 PASS                                      NOT NULL VARCHAR2(20)
 NAME                                      NOT NULL VARCHAR2(10)
 NUM                                       NOT NULL NUMBER(2)

SQL>
  -->
 
 