<%@ page language="java" contentType="text/html; charset=utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<link href="/includes/all.css" rel="stylesheet" type="text/css"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<script type="text/javascript">
		window.valid_check = function ()
		{
			if (document.r_insert_frm.review_grade.value == "")
			{
				alert("평점을 선택하여 주시기 바랍니다.");
				document.r_insert_frm.review_grade.focus();
				return false;
			}
			document.r_insert_frm.submit();
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
	<TITLE> 리뷰 등록 </TITLE>
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
							<td width="547" height="45" align="left" class="new_tit">리뷰 등록</td>
						</tr>
						<tr>
							<FORM NAME ="r_insert_frm" ACTION = "./review_insert_ok.jsp" METHOD = "post" enctype="multipart/form-data" >
								<td align="center">
									<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">상품번호</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "product_id" VALUE=<%= product_id %> readonly></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">제목</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "review_title"></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">평점</td>
											<td width="76%" align="left" bgcolor="#FFFFFF">
												<SELECT NAME="review_grade">
													<OPTION VALUE="">==평점을 선택하세요==</OPTION>
													<OPTION VALUE="1">★☆☆☆☆</OPTION>
													<OPTION VALUE="2">★★☆☆☆</OPTION>
													<OPTION VALUE="3">★★★☆☆</OPTION>
													<OPTION VALUE="4">★★★★☆</OPTION>
													<OPTION VALUE="5">★★★★★</OPTION>
												</SELECT>
											</td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">첨부사진</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "file" NAME = "review_image" size = 50></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">내용</td>
											<td width="330" align="left" bgcolor="#FFFFFF"> <textarea rows="13" cols="40" NAME = "review_contents"> </textarea> </td>
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