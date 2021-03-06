﻿<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<TITLE>질문 수정</TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<script language=javascript>
	function valid_check()
	{
		document.q_update_form.action = "./qna_modify_ok.jsp";
		document.q_update_form.submit();
	}

	function KeyNumber()
	{
		var event_key = event.keyCode;

		if((event_key < 48 || event_key > 57) && (event_key != 8 && event_key != 46))
		{
			event.returnValue=false;
		}
	}

	function delete_check() {
		document.q_update_form.action = "./qna_delete_ok.jsp?qna_id=" + document.q_update_form.qna_id.value;
		document.q_update_form.submit();
	}
</script>

<%

	ResultSet rs = null, rs2 = null, rs3 = null;
	Statement stmt = con.createStatement();

	try
	{
		String qna_id = request.getParameter("qna_id");

		String strSQL = "SELECT * FROM qna where qna_id ='" + qna_id + "'";
		rs = stmt.executeQuery(strSQL);

		if (rs.next()){
			String qna_title = rs.getString("qna_title");
			String product_id = rs.getString("product_id");
			String qna_contents = rs.getString("qna_contents");

%>
<BODY>
<FORM NAME = "q_update_form" METHOD = "post" enctype = "multipart/form-data">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" valign="top">
				<table width="815" border="0" cellspacing="0" cellpadding="0">
					<%@ include file="/includes/top.jsp" %>
					<tr>
						<td height="80" background="/icons/sub_bg.png">&nbsp;</td>
					</tr>
					<tr>
						<td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="547" height="45" align="left" class="new_tit">리뷰 수정</td>
							</tr>
							<tr>
								<td align="center">
									<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">상품 코드</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "product_id" VALUE=<%= product_id %> readonly></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">리뷰 코드</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "qna_id" VALUE=<%= qna_id %> readonly></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">제목</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "qna_title" VALUE=<%= qna_title %>></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">내용</td>
											<td width="330" align="left" bgcolor="#FFFFFF"> <textarea rows="13" cols="40" NAME = "qna_contents"><%= qna_contents %> </textarea> </td>
										</tr>
										<tr>
											<td colspan=2 align=center  bgcolor="#FFFFFF">
												<INPUT TYPE = "button" VALUE = "변경" onclick="valid_check()">  <INPUT TYPE = "button" VALUE = "삭제" onclick="delete_check()"></td>
										</tr>
									</table>
								</td>
							</tr>
							</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</FORM>
</BODY>
<%
		}
		else
		{
			out.print("등록된 게시글이 없습니다.");
		}

	} //try end

	catch(SQLException e1){
		out.println(e1.getMessage());
	} // catch SQLException end

	catch(Exception e2){
		e2.printStackTrace();
	} // catch Exception end

	finally{
		if (stmt  != null) stmt.close();
		if (rs    != null) rs.close();
		if (rs2   != null) rs2.close();
		if (rs3   != null) rs3.close();
		if (con   != null) con.close();
	} // finally end
%>
</HTML>