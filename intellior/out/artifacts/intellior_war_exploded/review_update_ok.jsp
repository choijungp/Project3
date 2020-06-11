<%@ page language="java" import="java.util.*,java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<%
	String realFolder = "";
	String saveFolder = "/review_images/";
	String encType = "utf-8";

	int sizeLimit = 10 * 1024 * 1024;
	realFolder = application.getRealPath(saveFolder);
	MultipartRequest multi	= new MultipartRequest(request,realFolder,sizeLimit,encType);

	Statement stmt = con.createStatement();

	String review_id			= multi.getParameter("review_id");
	String product_id			= multi.getParameter("product_id");
	String review_title			= multi.getParameter("review_title");
	String review_grade		= multi.getParameter("review_grade");
	String review_contents			= multi.getParameter("review_contents");
	String review_image		= multi.getFilesystemName("review_image");

	try{
		String SQL		= "UPDATE review set ";
		SQL = SQL + "  review_title		= '" + review_title		+ "' ";
		SQL = SQL + ",  review_grade		= '" + review_grade		+ "' ";
		SQL = SQL + ", review_contents	= '" + review_contents	+ "' ";
		if (review_image != null)
			SQL = SQL + ", review_image		= '" + review_image		+ "' ";
		SQL = SQL + "  WHERE review_id	= '" + review_id		+ "'";

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
		response.sendRedirect("./review_list.jsp?product_id=" + product_id);
	}
%>