<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

 <%

	String idx[]			= request.getParameterValues("idx");
	String chkName[]	= request.getParameterValues("chkName");
	String qty[] 			= request.getParameterValues("qty");
	String userid			=	(String)session.getAttribute("G_ID");

	Statement stmt  = con.createStatement();
	String	SQL = "";
	boolean fnd = false;

try{
	for (int ii = 0; ii < idx.length; ii ++){
		
		SQL = "update cart set " ;
		SQL = SQL + "  qty = " + qty[ii];

		fnd = false;
		for (int jj = 0; jj < chkName.length; jj ++){
			if (chkName[jj].equals(idx[ii])){
				fnd = true;
				break;
			}
		}
		if (fnd == true)
				SQL = SQL + ", chkYN = 'Y' ";
			else
				SQL = SQL + ", chkYN = 'N' ";

		SQL = SQL + " where idx =" + idx[ii];


		stmt.executeUpdate(SQL);
	}


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
	response.sendRedirect("goodsOrderPageA.jsp");
}
%>