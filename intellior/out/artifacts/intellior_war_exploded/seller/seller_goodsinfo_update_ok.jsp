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

	String product_name			= multi.getParameter("product_name");
	String category			= multi.getParameter("category");
	String product_price		= multi.getParameter("product_price");
	String product_thumnail	= multi.getFilesystemName("product_thumnail");
	String product_image		= multi.getFilesystemName("product_image");
	String content			= multi.getParameter("product_contents");
	String product_id			= multi.getParameter("product_id");

try{
	String SQL		= "UPDATE product set ";
	SQL = SQL + "  product_name		= '" + product_name		+ "' ";
	SQL = SQL + ",  category		= '" + category		+ "' ";
	SQL = SQL + ", product_price	= '" + product_price	+ "' ";
	if (product_thumnail != null)
		SQL = SQL + ", product_thumnail		= '" + product_thumnail		+ "' ";
	if (product_image != null)
		SQL = SQL + ", product_image		= '" + product_image		+ "' ";
	SQL = SQL + ", product_contents	= '" + content	+ "' ";
	SQL = SQL + "  WHERE product_id	= '" + product_id		+ "'";

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
	response.sendRedirect("seller_goodslist.jsp");
}
%>