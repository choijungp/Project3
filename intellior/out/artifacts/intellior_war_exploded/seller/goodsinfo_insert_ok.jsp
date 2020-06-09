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

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Statement stmt = con.createStatement();

	String n_seller_id = (String)session.getAttribute("G_ID");

	String n_product_name			= multi.getParameter("product_name");
	String n_category				= multi.getParameter("category");
	String n_product_price			= multi.getParameter("product_price");
	String n_product_thumnail		= multi.getFilesystemName("product_thumnail");
	String n_product_image			= multi.getFilesystemName("product_image");
	String n_content				= multi.getParameter("product_contents");

	try{
		String SQL = "INSERT INTO product(product_name, category, product_price, product_thumnail, product_image, product_contents, seller_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

		pstmt = con.prepareStatement(SQL);

		pstmt.setString(1, n_product_name);
		pstmt.setString(2, n_category);
		pstmt.setInt   (3, Integer.parseInt(n_product_price));
		pstmt.setString(4, n_product_thumnail);
		pstmt.setString(5, n_product_image);
		pstmt.setString(6, n_content);
		pstmt.setString(7, n_seller_id);

		pstmt.executeUpdate();
	}//try end

	catch(SQLException e1){
		e1.printStackTrace();
	} // catch SQLException end

	catch(Exception e2){
		e2.printStackTrace();
	} // catch Exception end

	finally{
		if (pstmt != null) pstmt.close();
		if (stmt  != null) stmt.close();
		if (rs    != null) rs.close();
		if (con   != null) con.close();
		response.sendRedirect("seller_goodslist.jsp");
	}



%>