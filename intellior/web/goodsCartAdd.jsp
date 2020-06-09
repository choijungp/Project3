<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

 <%

	String goodscd		= request.getParameter("goodscd");
	String qty 				= request.getParameter("qty");
	String colorcd		= request.getParameter("colorcd");
	String unitprice	= request.getParameter("unitprice");
	String sizecd			= request.getParameter("sizecd");
	String userid			=	(String)session.getAttribute("G_ID");

	Statement stmt  = con.createStatement();

try{

	
	String SQL = "insert into cart (userid, goodscd, color, size, unitprice, qty, chkYN) values (";
	SQL = SQL + "'" + userid		+ "', ";
	SQL = SQL + "'" + goodscd		+ "', ";
	SQL = SQL + "'" + colorcd		+ "', ";
	SQL = SQL + "'" + sizecd		+ "', ";
	SQL = SQL + "'" + unitprice	+ "', ";
	SQL = SQL + "'" + qty				+ "', ";
	SQL = SQL + "'Y')";
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
	response.sendRedirect("goodsCart.jsp");
}
%>