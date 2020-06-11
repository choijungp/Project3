<%@ page language="java" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>답변형 게시판 상세보기</TITLE>
 </HEAD>

<script language=javascript>
function submit_modify()
{
	document.frm1.action = "boardCmodify.jsp";
	document.frm1.submit();
}

function submit_reply()
{
	document.frm1.action = "boardCreply.jsp";
	document.frm1.submit();
}

function submit_delete()
{
	document.frm1.action = "boardCdelConfirm.jsp";
	document.frm1.submit();
}

function submit_list()
{
	document.frm1.action = "boardClist.jsp";
	document.frm1.submit();
}
</script>

<%@ include file = "/chap10/include/dbinfo.inc" %>
<%
	int num = Integer.parseInt(request.getParameter("pnum"));

	PreparedStatement pstmt = null;
	ResultSet rs = null;

try
{

	String strSQL = "SELECT num, lock_yn, pwd, title, contents, writer, CONVERT(CHAR(10), updatedtm, 120) writedt, readcnt FROM boardC WHERE num = ?";
	pstmt	= con.prepareStatement(strSQL);
	pstmt.setInt(1, num);
	rs		= pstmt.executeQuery();

	if (rs.next() == false){
		out.print("등록된 게시글이 없습니다.");
	}
	else
	{
		String in_pwd	= request.getParameter("pwd");
		String db_pwd	= rs.getString("pwd");
		String lock_yn	= rs.getString("lock_yn");

		if (lock_yn.equals("Y")) {

			if (in_pwd == null ) 
				response.sendRedirect("boardCpass_input.jsp?pnum=" + num);
			else
				if (in_pwd.equals(db_pwd) == false)
					response.sendRedirect("boardCpass_input.jsp?pnum=" + num);

		} //if (lock_yn.equals("Y")) end

		String writer	= rs.getString("writer");
		String title	= rs.getString("title");
		String contents = rs.getString("contents");
		String writedt  = rs.getString("writedt");
		int readcnt		= rs.getInt("readcnt");

		strSQL = "UPDATE boardC SET readcnt = readcnt + 1 WHERE num = ?"; // 조회수를 증가
		pstmt = con.prepareStatement(strSQL);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();

%>
		<h3>답변형 게시판 상세보기</h3>
		<BODY>
		<TABLE WIDTH = "500" BORDER = "1" CellPadding = "0" CellSpacing = "0">
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">작성자명</TD>
				<TD WIDTH = "60%" ALIGN = "left"><%= writer %></TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">제목</TD>
				<TD WIDTH = "60%" ALIGN = "left"><%= title %></TD>
			</TR>
			<TR>
				<TD WIDTH = "40%" ALIGN = "left">내용</TD>
				<TD WIDTH = "60%" ALIGN = "left">
					<TEXTAREA NAME="contents" ROWS=5 COLS=50 readonly><%= contents %></TEXTAREA>
				</TD>
			</TR>
			<TR>
				<TD WIDTH = "100%" ALIGN = "center" COLSPAN = "2">
				<FORM NAME = "frm1" METHOD = "post">
				<INPUT TYPE = "hidden" NAME = "pnum"  VALUE = <%= num %>>
				<TABLE>
					<TR>
						<TD  ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "수정하기" onclick = "submit_modify()">
						</TD>
						<TD   ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "답변달기" onclick = 'submit_reply();'>
						</TD>
						<TD  ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "삭제하기" onclick = "submit_delete()">
						</TD>
						<TD  ALIGN = "center">
							<INPUT TYPE = "button" VALUE = "목록으로" onclick = "submit_list()">
						</TD>
					</TR>
				</TABLE>
				</FORM>
				</TD>
			</TR>
		</TABLE>
		</BODY>
<%

	} // if (rs.next() == false) else end

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