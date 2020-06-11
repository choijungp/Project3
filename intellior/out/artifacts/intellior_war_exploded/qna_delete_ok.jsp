<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<%

PreparedStatement pstmt = null;

try
{
	int num		= Integer.parseInt(request.getParameter("pnum"));

	String strSQL	= "DELETE FROM boardC WHERE num = ?";

	pstmt = con.prepareStatement(strSQL);
	pstmt.setInt(1, num);
	pstmt.executeUpdate();

} //try end
catch(SQLException e1){
	out.println(e1.getMessage());
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (pstmt != null) pstmt.close();
	if (con   != null) con.close();

	response.sendRedirect("boardClist.jsp");

} // finally end
%>