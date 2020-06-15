<%@ page language="java" import="java.util.*,java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<%
	String realFolder = "";
	String saveFolder = "./images/";
	String encType = "utf-8";

	int sizeLimit = 10 * 1024 * 1024;
	realFolder = application.getRealPath(saveFolder);
	MultipartRequest multi	= new MultipartRequest(request,realFolder,sizeLimit,encType);

	ResultSet  rs = null;
	Statement stmt = con.createStatement();

	String product_id		= multi.getParameter("product_id");

	try{

		String strSQL = "SELECT * FROM product where product_id ='" + product_id + "'";
		rs = stmt.executeQuery(strSQL);

		if (rs.next()){
			String product_thumnail	= rs.getString("product_thumnail");
			String product_image	= rs.getString("product_image");

			String filePath1		= getServletContext().getRealPath(saveFolder) + File.separator + product_thumnail;
			String filePath2		= getServletContext().getRealPath(saveFolder) + File.separator + product_image;

			out.print(filePath1);
			File f1 = new File(filePath1);

			out.print(filePath2);
			File f2 = new File(filePath2);

			if (f1.exists()) new File(filePath1).delete();
			if (f2.exists()) new File(filePath2).delete();
		}

		strSQL = "DELETE FROM product where product_id ='" + product_id + "'";
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
		response.sendRedirect("./goodslist.jsp");
	}
%>