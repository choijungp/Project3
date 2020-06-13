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
		String now_id = (String)session.getAttribute("G_ID");

		String qna_id			= multi.getParameter("qna_id");
		String product_id			= multi.getParameter("product_id");
		String qna_title			= multi.getParameter("qna_title");
		String qna_contents			= multi.getParameter("qna_contents");

		String strSQL = "SELECT * FROM qna WHERE qna_id='" + qna_id + "'";
		pstmt = con.prepareStatement(strSQL);

		rs = pstmt.executeQuery();
		rs.next();

		int qna_group		= rs.getInt("qna_group");
		int qna_seq		= rs.getInt("qna_seq");
		int qna_level		= rs.getInt("qna_level");
		int lock_yn		= rs.getInt("lock_yn");

		int new_mseq		= qna_seq + 1;  // 답변글의 정렬 순번
		int new_mlvl		= qna_level + 1;  // 답변글의 레벨

		strSQL = "UPDATE qna SET qna_seq = qna_seq + 1 WHERE qna_group = " + qna_group + " and qna_seq > " + qna_seq;
		pstmt = con.prepareStatement(strSQL);
		pstmt.executeUpdate();

		if (rs != null) rs.close();
		rs = null;

		strSQL = "select ifnull(max(qna_id), 0) from qna";
		pstmt = con.prepareStatement(strSQL);

		rs = pstmt.executeQuery();
		rs.next();
		int maxnum = rs.getInt(1) + 1;  // 게시판 글번호 구하기

		String SQL ="INSERT INTO qna(qna_id, qna_group, qna_seq, qna_level, product_id, qna_title, lock_yn, qna_contents, writer) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
		pstmt = con.prepareStatement(SQL);

		pstmt.setInt   (1, maxnum);
		pstmt.setInt   (2, qna_group);
		pstmt.setInt   (3, new_mseq);
		pstmt.setInt   (4, new_mlvl);

		pstmt.setString(5, product_id);
		pstmt.setString(6, qna_title);
		pstmt.setInt(7, lock_yn);
		pstmt.setString(8, qna_contents);
		pstmt.setString(9, now_id);

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