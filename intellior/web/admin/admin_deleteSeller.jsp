<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<%

    String idx[]		= request.getParameterValues("check_seller_id");

    Statement stmt  = con.createStatement();

    try{

        for (int ii = 0; ii < idx.length; ii ++){
            out.print(idx);
            String SQL = "delete from seller where seller_id = '" + idx[ii]+"'";
            stmt.executeUpdate(SQL);
        }
    } //try end

    catch(SQLException e1){
        e1.printStackTrace();
    } // catch SQLException end

    catch(Exception e2){
        e2.printStackTrace();
    } // catch Exception end

    finally{
        if (stmt  != null) stmt.close();
        if (con   != null) con.close();
        response.sendRedirect("mypage_admin.jsp");
    }
%>