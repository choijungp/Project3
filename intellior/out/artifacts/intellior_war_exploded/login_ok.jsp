<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<%@ include file = "/includes/dbinfo.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String suserid   = request.getParameter("userid");
	String spasswd   = request.getParameter("passwd");
	String suos   = request.getParameter("uos");

	String SQL;
	if(suos.equals("user")) SQL = "select user_name from user where user_id = ? and user_pw = ?";
	else SQL = "select seller_name from seller where seller_id = ? and seller_pw = ?";
	pstmt = con.prepareStatement(SQL);

	pstmt.setString(1, suserid);
	pstmt.setString(2, spasswd);

	rs = pstmt.executeQuery();

	if (rs.next() == true)
	{
		session.setAttribute("G_ID", suserid);
		session.setAttribute("G_NM", rs.getString(1));
		session.setMaxInactiveInterval(60 * 60);

		if(suos.equals("user")){
			response.sendRedirect("/index.jsp");
		}
		else{
			response.sendRedirect("/seller/seller_index.jsp");
		}

	}
	else
		out.print("로그인을 실패하였습니다.");

	pstmt.close();
	rs.close();
	con.close();
%>