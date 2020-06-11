<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/chap10/include/dbinfo.inc" %>
<%

PreparedStatement pstmt = null;

try
{
	int num		= Integer.parseInt(request.getParameter("pnum"));
	String title	= request.getParameter("title");
	String contents	= request.getParameter("contents");

	String SQL	= "UPDATE boardC SET ";
	SQL		=  SQL + "  title	= ? ";
	SQL		=  SQL + ", contents	= ? ";
	SQL		=  SQL + ", updatedtm	= ? ";
	SQL		=  SQL + " WHERE num	= ? ";
	pstmt = con.prepareStatement(SQL);

	Calendar dateIn = Calendar.getInstance();
	String indate = Integer.toString(dateIn.get(Calendar.YEAR))		+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1)	+ "-";
	indate = indate + Integer.toString(dateIn.get(Calendar.DATE))		+ " ";
	indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY))	+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE))		+ ":";
	indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

	pstmt.setString(1, title);
	pstmt.setString(2, contents);
	pstmt.setString(3, indate);
	pstmt.setInt(4, num);
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