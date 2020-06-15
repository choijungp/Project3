<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
 <HEAD>
  <TITLE>상품정보조회</TITLE>
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

function delete_check() {
	document.read_form.action = "/admin/goodsinfo_delete.jsp?product_id=" + document.read_form.product_id.value;
	document.read_form.submit();
}
</script>

<%

	ResultSet rs = null, rs2 = null, rs3 = null;
	Statement stmt = con.createStatement();

try
{
	String product_id = request.getParameter("product_id");

	String strSQL = "SELECT * FROM product where product_id ='" + product_id + "'";
	rs = stmt.executeQuery(strSQL);

	if (rs.next()){
		String n_product_name = rs.getString("product_name");
		String product_image = rs.getString("product_image");
		String product_thumnail = rs.getString("product_thumnail");
		String product_contents = rs.getString("product_contents");
		String category = rs.getString("category");
		int	product_price	= rs.getInt("product_price");

%>
<BODY>
<FORM NAME = "read_form" METHOD = "post" enctype = "multipart/form-data">
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
            <td width="547" height="45" align="left" class="new_tit">상품조회</td>
          </tr>
          <tr>
            <td align="center">
							<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">카테고리</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "category" VALUE=<%= category %> readonly></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">상품번호</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "6" NAME = "product_id" VALUE=<%= product_id %> readonly></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">상품명</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "product_name" VALUE=<%= n_product_name %> readonly></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">가격</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "10" MAXLENGTH = "7" NAME = "product_price"  VALUE=<%= product_price %> readonly></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">썸네일</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><IMG SRC="/images/<%= product_thumnail%>" height=200 width=200></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">이미지</td>
									<td width="76%" align="left" bgcolor="#FFFFFF"><IMG SRC="/images/<%= product_image%>" height=200 width=200></td>
								</tr>
								<tr>
									<td width="24%" align="left" bgcolor="#EEEEEE">내용</td>
									<td width="330" align="left" bgcolor="#FFFFFF"> <textarea rows="13" cols="40" readonly="readonly" NAME = "product_contents"><%= product_contents %> </textarea> </td>
								</tr>
								<tr>
									<td colspan=2 align=center  bgcolor="#FFFFFF">
									<INPUT TYPE = "button" VALUE = "삭제" onclick="delete_check()"></td>
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