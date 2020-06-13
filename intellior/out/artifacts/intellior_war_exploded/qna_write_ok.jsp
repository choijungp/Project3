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

	try{
		String user_id = (String)session.getAttribute("G_ID");

		String product_id			= multi.getParameter("product_id");
		String qna_title			= multi.getParameter("qna_title");
		String lock_yn				= multi.getParameter("lock_yn");
		if (lock_yn == null) lock_yn = "0";
		String qna_contents			= multi.getParameter("qna_contents");

		String strSQL = "select ifnull(max(qna_id), 0) from qna";
		pstmt = con.prepareStatement(strSQL);

		rs = pstmt.executeQuery();
		rs.next();
		int maxnum = rs.getInt(1) + 1;

		String sql ="INSERT INTO qna(qna_id, qna_group, qna_seq, qna_level, product_id, qna_title, qna_contents, lock_yn, writer) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = con.prepareStatement(sql);

		pstmt.setInt(1, maxnum);
		pstmt.setInt(2, maxnum);
		pstmt.setInt(3, 0);
		pstmt.setInt(4, 0);

		pstmt.setString(5, product_id);
		pstmt.setString(6, qna_title);
		pstmt.setString(7, qna_contents);
		pstmt.setString(8, lock_yn);
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

		String product_id			= multi.getParameter("product_id");
		response.sendRedirect("./qna_list.jsp?product_id=" + product_id);
	}
%>