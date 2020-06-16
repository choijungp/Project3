<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<TITLE>상품 리뷰 조회</TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>


<script language=javascript>
	function KeyNumber()
	{
		var event_key = event.keyCode;

		if((event_key < 48 || event_key > 57) && (event_key != 8 && event_key != 46))
		{
			event.returnValue=false;
		}
	}

	function goList() {
		document.review_read_form.action = "./review_list.jsp?product_id=" + document.review_read_form.product_id.value;
		document.review_read_form.submit();
	}

	function goModify() {
		document.review_read_form.action = "./review_update.jsp?review_id=" + document.review_read_form.review_id.value;
		document.review_read_form.submit();
	}
</script>

<%

	ResultSet rs = null, rs2 = null, rs3 = null;
	Statement stmt = con.createStatement();

	try
	{
		String review_id = request.getParameter("review_id");
		String s_id2 = (String)session.getAttribute("G_ID");

		String strSQL = "SELECT * FROM review where review_id ='" + review_id + "'";
		rs = stmt.executeQuery(strSQL);

		if (rs.next()){
			String user_id = rs.getString("user_id");
			String product_id = rs.getString("product_id");
			String review_title = rs.getString("review_title");
			String review_image = rs.getString("review_image");
			String review_contents = rs.getString("review_contents");
			String review_grade = rs.getString("review_grade");

%>
<BODY>
<FORM NAME = "review_read_form" METHOD = "post" enctype = "multipart/form-data">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" valign="top">
				<table width="815" border="0" cellspacing="0" cellpadding="0">
					<%
				String id_ch = (String)session.getAttribute("G_ID");
				ResultSet rs_ch = null;
				Statement stmt_ch=con.createStatement();
				String strSQL_ch="SELECT seller_id FROM seller WHERE seller_id='"+ id_ch +"'";
				rs_ch=stmt_ch.executeQuery(strSQL_ch);
				if(rs_ch.next()){
			%>
			<%@ include file="/includes/seller_top.jsp" %>
			<%
			}
			else{
			%>
			<%@ include file="/includes/top.jsp" %>
			<%
				}
			%>
					<tr>
						<td>
							<img src="/icons/sub_bg.png" width="810"/>
						</td>
					</tr>
					<tr>
						<td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="547" height="45" align="left" class="new_tit">상품 리뷰 조회</td>
							</tr>
							<tr>
								<td align="center">
									<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">상품코드</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "product_id" VALUE=<%= product_id %> readonly></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">리뷰 코드</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "review_id" VALUE=<%= review_id %> readonly></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">제목</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><%= review_title %></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">작성자</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><%= user_id %></td>
										</tr>
										<% if(review_image != null)
										{%>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">이미지</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><IMG SRC="/review_images/<%= review_image%>" height=200 width=200></td>
										</tr>
										<%
											}
										%>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">내용</td>
											<td width="330" align="left" bgcolor="#FFFFFF"><%= review_contents %></td>
										</tr>
										<tr>
											<td colspan=2 align=center  bgcolor="#FFFFFF">
												<INPUT TYPE = "button" VALUE = "목록 돌아가기" onclick="goList()">
											<%
												if(s_id2.equals(user_id))
												{
											%>
													<INPUT TYPE = "button" VALUE = "수정" onclick="goModify()">
											<%
												}
											%>
											</td>
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
			out.print("등록된 리뷰가 없습니다.");
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