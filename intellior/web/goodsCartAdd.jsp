<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<%

	String product_id		= request.getParameter("product_id");
	String qty 				= request.getParameter("qty");
	String userid			=	(String)session.getAttribute("G_ID");

	Statement stmt  = con.createStatement();

	try{


		String SQL = "insert into cart (user_id, product_id, p_count,chkYN ) values (";
		SQL = SQL + "'" + userid		+ "', ";
		SQL = SQL  + product_id		+ ", ";
		SQL = SQL +  qty ;
		SQL = SQL + ", 'Y')";
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
		response.sendRedirect("/goodsdetail.jsp?product_id="+product_id);
	}
%>