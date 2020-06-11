<%@ page language="java" import="java.util.*,java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<%
	String realFolder = "";
	String saveFolder = "/chap11/images/";
	String encType = "utf-8";

	int sizeLimit = 10 * 1024 * 1024;
	realFolder = application.getRealPath(saveFolder);
	MultipartRequest multi	= new MultipartRequest(request,realFolder,sizeLimit,encType);

	ResultSet  rs = null;
	Statement stmt = con.createStatement();

	String goodscd		= multi.getParameter("goodscd");

try{

	String strSQL = "SELECT * FROM goodsinfo where goodscd ='" + goodscd + "'";
	rs = stmt.executeQuery(strSQL);

	if (rs.next()){
		String goodsimg1	= rs.getString("goodsimg1");
		String filePath		= getServletContext().getRealPath(saveFolder) + File.separator + goodsimg1; 
		out.print(filePath);
		File f1 = new File(filePath);

		if (f1.exists()) new File(filePath).delete();
	}

	strSQL		= "delete from goodsinfo where goodscd	= '" + goodscd	+ "'";

	stmt.executeUpdate(strSQL);

} //try end

catch(SQLException e1){
	e1.printStackTrace();
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (stmt  != null) stmt.close();
	if (rs    != null) rs.close();
	if (con   != null) con.close();
	response.sendRedirect("goodslist.jsp");
}
%>