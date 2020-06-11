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

	String user_id = (String)session.getAttribute("G_ID");

	String product_id			= multi.getParameter("product_id");
	String qna_title			= multi.getParameter("review_title");
	String lock_yn				= multi.getParameter("lock_yn");
	if (lock_yn == null) lock_yn = "0";
	String pwd					= multi.getParameter("pwd");
	String qna_contents			= multi.getParameter("review_contents");

	try{
		String strSQL = "select isnull(max(qna_id), 0) from qna";
		pstmt = con.prepareStatement(strSQL);

		rs = pstmt.executeQuery();
		rs.next();
		int maxnum = rs.getInt(1) + 1;

		//String SQL = "INSERT INTO qna(product_id, qna_title, qna_contents, user_id) VALUES (?, ?, ?, ?)";
		String SQL ="INSERT INTO qna(qna_id, qna_group, qna_seq, qna_level, qna_title, qna_contents, lock_yn, pwd, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = con.prepareStatement(SQL);

		pstmt.setInt(1, maxnum);
		pstmt.setInt(2, maxnum);
		pstmt.setInt(3, 0);
		pstmt.setInt(4, 0);

		pstmt.setString(5, qna_title);
		pstmt.setString(6, qna_contents);
		pstmt.setString(7, lock_yn);
		pstmt.setString(8, pwd);
		pstmt.setString(9, user_id);

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
		response.sendRedirect("./qna_list.jsp?product_id=" + product_id);
	}



%>