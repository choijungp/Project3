<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<TITLE>리뷰 수정</TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<script language=javascript>
	function valid_check()
	{
		var grad = 0;
		if (document.review_update_form.review_grade.value == "1") {
			grad = 1;
		}
		else if (document.review_update_form.review_grade.value == "2") {
			grad = 1;
		}
		else if (document.review_update_form.review_grade.value == "3") {
			grad = 1;
		}
		else if (document.review_update_form.review_grade.value == "4") {
			grad = 1;
		}
		else if (document.review_update_form.review_grade.value == "5") {
			grad = 1;
		}
		else if (document.review_update_form.review_grade.value == "6") {
			grad = 1;
		}
		else if (document.review_update_form.review_grade.value == "7") {
			grad = 1;
		}
		else if (document.review_update_form.review_grade.value == "8") {
			grad = 1;
		}
		else if (document.review_update_form.review_grade.value == "9") {
			grad = 1;
		}
		else if (document.review_update_form.review_grade.value == "10") {
			grad = 1;
		}

		else if (grad != 1)
		{
			alert("평점은 1 ~ 10의 수로 입력해주시기 바랍니다.");
			document.review_update_form.review_grade.focus();
			return false;
		}

		document.review_update_form.action = "./review_update_ok.jsp";
		document.review_update_form.submit();
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
		document.review_update_form.action = "./review_delete.jsp?review_id=" + document.review_update_form.review_id.value;
		document.review_update_form.submit();
	}
</script>

<%

	ResultSet rs = null, rs2 = null, rs3 = null;
	Statement stmt = con.createStatement();

	try
	{
		String review_id = request.getParameter("review_id");

		String strSQL = "SELECT * FROM review where review_id ='" + review_id + "'";
		rs = stmt.executeQuery(strSQL);

		if (rs.next()){
			String review_title = rs.getString("review_title");
			String product_id = rs.getString("product_id");
			String review_grade = rs.getString("review_grade");
			String review_image = rs.getString("review_image");
			String review_contents = rs.getString("review_contents");

%>
<BODY>
<FORM NAME = "review_update_form" METHOD = "post" enctype = "multipart/form-data">
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
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "review_id" VALUE=<%= review_id %> readonly></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">제목</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "review_title" VALUE=<%= review_title %>></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">평점</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "review_grade"></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">변경전 이미지</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><IMG SRC="/review_images/<%= review_image%>" height=200 width=200></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">변경후 이미지</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "file" NAME = "review_image" size = 50></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">내용</td>
											<td width="330" align="left" bgcolor="#FFFFFF"> <textarea rows="13" cols="40" NAME = "review_contents"><%= review_contents %> </textarea> </td>
										</tr>
										<tr>
											<td colspan=2 align=center  bgcolor="#FFFFFF">
												<INPUT TYPE = "button" VALUE = "변경" onclick="valid_check()"><INPUT TYPE = "button" VALUE = "삭제" onclick="delete_check()"></td>
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
			out.print("등록된 상품정보가 없습니다.");
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