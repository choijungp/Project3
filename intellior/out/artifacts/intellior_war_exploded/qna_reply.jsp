<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<HTML>
<HEAD>
<TITLE>답변형 게시판 답변달기</TITLE>

<script language=javascript>
function valid_check()
{
	if (frm1.writername.value.length < 1) {
		alert("작성자명을 입력하세요.");
		document.frm1.writername.focus(); 
		return false;
	}

	if (frm1.title.value.length < 1) {
		alert("제목을 입력하세요.");
		document.frm1.title.focus(); 
		return false;
	}

	if (frm1.contents.value.length < 1) {
		alert("내용을 입력하세요.");
		document.frm1.contents.focus(); 
		return false;
	}

	document.frm1.submit();
}

function submit_list()
{
	location.href = "boardClist.jsp";
}

</SCRIPT>
</HEAD>

<BODY>
<%@ include file = "/chap10/include/dbinfo.inc" %>

<%
PreparedStatement pstmt = null;
ResultSet rs = null;

try
{
	String num = request.getParameter("pnum"); 

	String strSQL = "SELECT * FROM boardC WHERE num = ?";
	pstmt = con.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(num));

	rs = pstmt.executeQuery();
	rs.next();

	String title	= rs.getString("title");
	String writer	= rs.getString("writer");
	String contents	= rs.getString("contents");

%>
	<h3>답변형 게시판 답변달기</h3>
	<BODY>
	<FORM NAME = "frm1" ACTION = "boardCreply_ok.jsp" METHOD = "POST">
	<INPUT TYPE = "hidden" NAME = "pnum"  VALUE = <%= num %>>
	<TABLE WIDTH = "500" BORDER = "1" CellPadding = "0" CellSpacing = "0">
		<TR>
			<TD WIDTH = "40%" ALIGN = "left">작성자명</TD>
			<TD WIDTH = "60%" ALIGN = "left">
				<INPUT TYPE = "text" SIZE = "15" MAXLENGTH = "10" NAME = "writername" >
			</TD>
		</TR>
		<TR>
			<TD WIDTH = "40%" ALIGN = "left">제목</TD>
			<TD WIDTH = "60%" ALIGN = "left">
				<INPUT TYPE = "text" SIZE = "50" MAXLENGTH = "50" NAME = "title" VALUE="[답변]<%= title %>">
			</TD>
		</TR>
		<TR>
			<TD WIDTH = "40%" ALIGN = "left">내용</TD>
			<TD WIDTH = "60%" ALIGN = "left">
				<TEXTAREA NAME="contents" ROWS=5 COLS=50></TEXTAREA>
			</TD>
		</TR>
		<TR>
			<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2">
			<TABLE>
				<TR>
					<TD WIDTH = "33%" ALIGN = "center">
						<INPUT TYPE = "reset" VALUE = "다시 작성">
					</TD>
					<TD WIDTH = "34%" ALIGN = "center">
						<INPUT TYPE = "button" VALUE = "등록" onClick="valid_check()">
					</TD>
					<TD WIDTH = "33%" ALIGN = "center">
						<INPUT TYPE = "button" VALUE = "목록으로" onClick = "submit_list()">
					</TD>
				</TR>
			</TABLE>
			</TD>
		</TR>
	</TABLE>
	</FORM>   
	</BODY>

<%
} //try end
catch(SQLException e1){
	out.println(e1.getMessage());
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
	if (pstmt != null) pstmt.close();
	if (rs    != null) rs.close();
	if (con   != null) con.close();
} // finally end
%>
</HTML>