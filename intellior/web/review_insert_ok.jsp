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

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Statement stmt = con.createStatement();

	String n_user_id = (String)session.getAttribute("G_ID");

	String product_id			= multi.getParameter("product_id");
	String review_title			= multi.getParameter("review_title");
	String review_grade				= multi.getParameter("review_grade");
	String review_image			= multi.getFilesystemName("review_image");
	String review_contents				= multi.getParameter("review_contents");

	try{
		String SQL = "INSERT INTO review(product_id, review_title, review_grade, review_image, review_contents, user_id) VALUES (?, ?, ?, ?, ?, ?)";

		pstmt = con.prepareStatement(SQL);

		pstmt.setString(1, product_id);
		pstmt.setString(2, review_title);
		pstmt.setString(3, review_grade);
		pstmt.setString(4, review_image);
		pstmt.setString(5, review_contents);
		pstmt.setString(6, n_user_id);


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

		int p_id = Integer.parseInt(product_id);
		response.sendRedirect("./review_list.jsp?product_id=" + product_id);
	}



%>