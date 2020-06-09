<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<TITLE> 상품등록 </TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<script language=javascript>
	function valid_check()
	{

		if (document.frm1.category.value == "")
		{
			alert("카테고리를 선택하여 주시기 바랍니다.");
			document.frm1.category.focus();
			return false;
		}
		document.frm1.submit();
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

<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" valign="top">
			<table width="815" border="0" cellspacing="0" cellpadding="0">
				<%@ include file="/includes/admin_top.jsp" %>
				<tr>
					<td height="80" background="/icons/sub_bg.png">&nbsp;</td>
				</tr>
				<tr>
					<td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="547" height="45" align="left" class="new_tit">상품등록</td>
						</tr>
						<tr>
							<FORM NAME = "frm1" ACTION = "goodsinfo_insert1_ok.jsp" METHOD = "post" enctype="multipart/form-data">
								<td align="center">
									<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">상품명</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "product_name"></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">카테고리</td>
											<td width="76%" align="left" bgcolor="#FFFFFF">
												<SELECT NAME="category">
													<OPTION VALUE="">==카테고리를 선택하세요==</OPTION>
													<OPTION VALUE="가구">가구</OPTION>
													<OPTION VALUE="소품">소품</OPTION>
													<OPTION VALUE="침구">침구</OPTION>
													<OPTION VALUE="반려동물">반려동물</OPTION>
												</SELECT>
											</td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">가격</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "7" NAME = "product_price" onKeyDown = "KeyNumber()"></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">썸네일 이미지</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "file" NAME = "product_thumnail" size = 50></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">이미지</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "file" NAME = "product_image" size = 50></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">내용</td>
											<td width="330" align="left" bgcolor="#FFFFFF"> <textarea rows="13" cols="40" NAME = "prodcut_contents"> </textarea> </td>
										</tr>
										<tr>
											<td colspan=2 align=center  bgcolor="#FFFFFF"><INPUT TYPE = "button" VALUE = "등록" onclick="valid_check()"> </td>
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