<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>


<%
	String suserid	= request.getParameter("userid");
	String spasswd	= request.getParameter("passwd");

	if (suserid.equals("admin") && spasswd.equals("intelior"))
	{
		session.setAttribute("G_ADMIN_ID", suserid);
		session.setAttribute("G_ADMIN_NM", "관리자");
		session.setMaxInactiveInterval(60 * 60);

		response.sendRedirect("/admin/admin_index.jsp");
	}
	else
		out.print("로그인을 실패하였습니다.");
%>