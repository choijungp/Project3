<%@ page language="java" import="java.util.*,java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<%
    String realFolder = "";
    String saveFolder = "/images/";
    String encType = "utf-8";

    int sizeLimit = 10 * 1024 * 1024;
    realFolder = application.getRealPath(saveFolder);
    MultipartRequest multi	= new MultipartRequest(request,realFolder,sizeLimit,encType);

    Statement stmt = con.createStatement();

    String user_nm			= multi.getParameter("user_nm");
    String user_email			= multi.getParameter("user_email");
    String user_address		= multi.getParameter("user_address");
    String user_phone	= multi.getParameter("user_phone");
    String user_id			=	(String)session.getAttribute("G_ID");

    try{
        String SQL		= "UPDATE user set ";
        SQL = SQL + "  user_name		= '" + user_nm		+ "' ";
        SQL = SQL + ",  user_email		= '" + user_email		+ "' ";
        SQL = SQL + ", user_address	= '" + user_address	+ "' ";
        SQL = SQL + ", user_phone	= '" + user_phone	+ "' ";
        SQL = SQL + "  WHERE user_id	= '" + user_id		+ "'";

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
        response.sendRedirect("user_info_update.jsp");
    }
%>