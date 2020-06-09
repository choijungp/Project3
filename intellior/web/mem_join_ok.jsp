<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%@ include file = "/includes/dbinfo.jsp" %>
<%
 Statement stmt=con.createStatement();

 String suos	=request.getParameter("uos");
 String suserid	=request.getParameter("userid");
 String susernm	=request.getParameter("usernm");
 String spasswd	=request.getParameter("passwd");
 String stel=request.getParameter("tel1");
 if(stel.equals("1"))
     stel="010";
 else if(stel.equals("2"))
     stel="011";
 else if(stel.equals("3"))
     stel="016";
 else if(stel.equals("4"))
     stel="017";
 else if(stel.equals("5"))
     stel="018";
 else if(stel.equals("6"))
     stel="019";

 String saddress=request.getParameter("addr1")+" "+request.getParameter("addr2");

 stel=stel+request.getParameter("tel2")+request.getParameter("tel3");
 String semail	=request.getParameter("mail");

    String SQL="insert into "+suos;
    if(suos.equals("user")) SQL=SQL+"(user_id, user_name, user_pw, user_address, user_email,user_phone) values(";
    else SQL=SQL+"(seller_id, seller_name, seller_pw, seller_address, seller_email,seller_phone) values(";
    SQL = SQL + "'" + suserid + "',";
    SQL = SQL + "'" + susernm + "',";
    SQL = SQL + "'" + spasswd + "',";
    SQL = SQL + "'" + saddress  + "',";
    SQL = SQL + "'" + semail  + "',";
    SQL = SQL + "'" + stel  + "')";

    stmt.executeUpdate(SQL);
    stmt.close();
    con.close();

    response.sendRedirect("/index.jsp");
 %>