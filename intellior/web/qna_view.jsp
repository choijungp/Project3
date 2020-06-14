<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<TITLE>상품 리뷰 조회</TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<%
	String now_id = (String)session.getAttribute("G_ID");
	String qna_id = request.getParameter("qna_id");

	ResultSet rs = null, rs2 = null, rs3 = null;
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();

	String check_sql = "SELECT * FROM qna q LEFT JOIN product p ON (q.product_id = p.product_id) where qna_id ='" + qna_id + "'";
	rs = stmt.executeQuery(check_sql);
	rs.next();

	String qna_group = rs.getString("qna_group");
	String seller_id = rs.getString("seller_id");
	String lock_yn = rs.getString("lock_yn");

	String check = "SELECT * FROM qna q where qna_group ='" + qna_group + "'";
	rs3 = stmt3.executeQuery(check);
	rs3.next();
	String writer = rs3.getString("writer");


	String writer_check = "SELECT * FROM qna q where qna_group ='" + qna_group + "' and qna_id='" + qna_id + "'";
	rs2 = stmt2.executeQuery(writer_check);
	rs2.next();
	String writer1 = rs2.getString("writer");

	if(lock_yn.equals("1")){
		if(now_id == null)
		{
			out.print("<script type=text/javascript>");
			out.print("alert('비밀글입니다.');");
			out.print("location.href = '/index.jsp';");
			out.print("</script>");
		}
		else if(!now_id.equals(writer) && !now_id.equals(seller_id)){
			out.print("<script type=text/javascript>");
			out.print("alert('비밀글입니다.');");
			out.print("location.href = '/index.jsp';");
			out.print("</script>");
		}
	}
%>

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
		document.qna_read_form.action = "./qna_list.jsp?product_id=" + document.qna_read_form.product_id.value;
		document.qna_read_form.submit();
	}

	function goModify() {
		document.qna_read_form.action = "./qna_modify.jsp?qna_id=" + document.qna_read_form.qna_id.value;
		document.qna_read_form.submit();
	}

	function goReply() {
		document.qna_read_form.action = "./qna_reply.jsp?qna_id=" + document.qna_read_form.qna_id.value;
		document.qna_read_form.submit();
	}
</script>

<%

	try
	{
		String strSQL = "SELECT * FROM qna where qna_id ='" + qna_id + "'";
		rs = stmt.executeQuery(strSQL);

		if (rs.next()){
			String product_id = rs.getString("product_id");
			String qna_title = rs.getString("qna_title");
			int qna_seq = rs.getInt("qna_seq");
			String qna_contents = rs.getString("qna_contents");

%>
<BODY>
<FORM NAME = "qna_read_form" METHOD = "post" enctype = "multipart/form-data">
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
								<td width="547" height="45" align="left" class="new_tit">Q&A 조회</td>
							</tr>
							<tr>
								<td align="center">
									<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">상품코드</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "product_id" VALUE=<%= product_id %> readonly></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">Q&A 코드</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "qna_id" VALUE=<%= qna_id %> readonly></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">작성자</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><%= writer %></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">제목</td>
											<td width="76%" align="left" bgcolor="#FFFFFF"><%= qna_title %></td>
										</tr>
										<tr>
											<td width="24%" align="left" bgcolor="#EEEEEE">내용</td>
											<td width="330" align="left" bgcolor="#FFFFFF"><%= qna_contents %></td>
										</tr>
										<tr>
											<td colspan=2 align=center  bgcolor="#FFFFFF">
												<%
													if(now_id.equals(writer1))
													{
												%>
												<INPUT TYPE = "button" VALUE = "수정" onclick="goModify()">
												<%
													}
												%>
												<%
													if(now_id.equals(seller_id) && qna_seq == 0)
													{
												%>
												<INPUT TYPE = "button" VALUE = "답글달기" onclick="goReply()">
												<%
													}
												%>
												<INPUT TYPE = "button" VALUE = "목록 돌아가기" onclick="goList()"></td>
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
		if (stmt2  != null) stmt2.close();
		if (stmt3  != null) stmt3.close();
		if (rs    != null) rs.close();
		if (rs2   != null) rs2.close();
		if (rs3   != null) rs3.close();
		if (con   != null) con.close();
	} // finally end
%>
</HTML>