<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<%


    Statement stmt = con.createStatement();

    String seller_nm			= request.getParameter("seller_nm");
    String seller_email			= request.getParameter("seller_email");
    String seller_address		= request.getParameter("seller_address");
    String seller_phone	= request.getParameter("seller_phone");
    String seller_id			=	(String)session.getAttribute("G_ID");


    try{

        String SQL		= "UPDATE seller set ";
        SQL = SQL + "  seller_name		= '" + seller_nm		+ "' ";
        SQL = SQL + ",  seller_email		= '" + seller_email		+ "' ";
        SQL = SQL + ", seller_address	= '" + seller_address	+ "' ";
        SQL = SQL + ", seller_phone	= '" + seller_phone	+ "' ";
        SQL = SQL + "  WHERE seller_id	= '" + seller_id		+ "'";

        stmt.executeUpdate(SQL);
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
        response.sendRedirect("seller_index.jsp");
    }
%>


