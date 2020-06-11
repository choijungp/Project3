<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>비밀번호 확인</TITLE>
 </HEAD>

<BODY>

<%
String num = request.getParameter("pnum");
%>

<h3>비밀번호 확인</h3>


<FORM NAME = "frm1" ACTION = "boardCview.jsp" METHOD = "post">
<INPUT TYPE = "hidden" NAME = "pnum"  VALUE = <%= num %>>
<TABLE WIDTH = "500" BORDER = "1" CellPadding = "0" CellSpacing = "0">
	<TR>
		<TD WIDTH = "30%" ALIGN = "center">비밀번호</TD>
 		<TD WIDTH = "50%" ALIGN = "left"><INPUT TYPE = "password" NAME = "pwd" SIZE = 10 MAXLENGTH = 10></TD>
		<TD WIDTH = "250%" ALIGN = "center"><INPUT TYPE = "submit"   VALUE = "확인" >
	 	</TD>
    </TR>
</TABLE>
</FORM>                                  
<A HREF = "boardClist.jsp">[목록 보기]</A> 
</BODY>
</HTML>