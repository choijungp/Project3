<%@ page language="java" contentType="text/html; charset=utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<link href="/includes/all.css" rel="stylesheet" type="text/css"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<script type="text/javascript">
		window.valid_check = function ()
		{
			document.q_insert_frm.submit();
		}

		function KeyNumber()
		{
			var event_key = event.keyCode;

			if((event_key < 48 || event_key > 57) && (event_key != 8 && event_key != 46))
			{
				event.returnValue=false;
			}
		}

	</script>
	<TITLE> 질문 등록 </TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<%
	String u_id = (String)session.getAttribute("G_ID");
	if (u_id == null)
	{
		out.print("<script type=text/javascript>");
		out.print("alert('로그인을 하시기 바랍니다.!!!');");
		out.print("location.href = '/seller/seller_index.jsp';");
		out.print("</script>");
	}
%>
<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" valign="top">
			<table width="815" border="0" cellspacing="0" cellpadding="0">
				<%@ include file="/includes/top.jsp" %>
				<tr>
					<td>
						<img src="/icons/sub_bg.png" width="810"/>
					</td>
				</tr>

				<%
					String product_id = request.getParameter("product_id");
				%>
				<tr>
					<td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="547" height="45" align="left" class="new_tit">질문 등록</td>
						</tr>
						<tr>
							<FORM NAME ="q_insert_frm" ACTION = "./qna_write_ok.jsp" METHOD = "post" enctype="multipart/form-data" >
								<td align="center">
									<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">상품번호</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "product_id" VALUE=<%= product_id %> readonly></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">제목</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "qna_title"></td>
										</tr>
										<TR>
											<TD WIDTH = "40%" ALIGN = "left" bgcolor="#EEEEEE">비밀글</TD>
											<TD WIDTH = "60%" ALIGN = "left" bgcolor="#FFFFFF">
												비밀글 여부<INPUT TYPE ="checkbox" NAME="lock_yn" VALUE = "1"><BR><BR>
												비밀번호 <INPUT TYPE ="text" NAME="pwd" SIZE = "10" MAXLENGTH = "10">
											</TD>
										</TR>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">내용</td>
											<td width="330" align="left" bgcolor="#FFFFFF"> <textarea rows="13" cols="40" NAME = "qna_contents"> </textarea> </td>
										</tr>
										<tr>
											<td colspan=2 align=center  bgcolor="#FFFFFF"><INPUT TYPE = "button" VALUE = "등록" onclick="valid_check()" onmouseover="this.style.cursor='hand';"> </td>
										</tr>
									</table>
								</td>
							</FORM >
						</tr>
					</table></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</BODY>
</HTML>