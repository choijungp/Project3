<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<HEAD>
  <TITLE> 상품 상세보기</TITLE>

<link href="/includes/all.css" rel="stylesheet" type="text/css" />

</HEAD>

<script type="text/javascript">

function qtyChanged(){
	var totalAmt		= (document.frm1.unitprice.value) * (document.frm1.qty.value);
	var strTotalAmt	= totalAmt.toString();

	var temp  = "";
	for (idx = strTotalAmt.length - 1; idx >= 0; idx--){
    schar = strTotalAmt.charAt(idx);
    temp	= schar  + temp;
		if(idx % 3 == strTotalAmt.length % 3 && idx != 0){ temp = ',' + temp; }
	}

	document.all.totalAmtView.innerHTML = temp;
}

function cartAdd() {

	if (document.frm1.userid.value == "")
	{
		alert("로그인을 하여 주시기 바랍니다.");
		return false;
	}

	if (document.frm1.colorcd.value == "")
	{
		alert("색상을 선택하여 주시기 바랍니다.");
		document.frm1.colorcd.focus();
		return false;
	}

	if (document.frm1.sizecd.value == "")
	{
		alert("사이즈를 선택하여 주시기 바랍니다.");
		document.frm1.sizecd.focus();
		return false;
	}

	document.frm1.action = "goodsCartAdd.jsp";
	document.frm1.submit();
}

function goMain() {

	document.frm1.action = "index.jsp";
	document.frm1.submit();
}

</script>

<body>

<FORM NAME = frm1 ACTION = "goodsCartAdd.jsp" METHOD = POST>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="/includes/top.jsp" %>
      <tr>
        <td height="80" background="/icons/sub_bg.jpg">&nbsp;</td>
      </tr>


<%
String userid			=	(String)session.getAttribute("G_ID");
if (userid == null) userid = "";

ResultSet rs = null, rs2 = null;
	
Statement stmt  = con.createStatement();

String pgoodscd = request.getParameter("pgoodscd");

String SQL = "select c.cat1nm, b.cat2nm, a.goodscd, goodsnm, unitprice, goodsimg1 from goodsinfo a ";
SQL = SQL + " inner join category2 b on a.cat1cd = b.cat1cd and a.cat2cd = b.cat2cd ";
SQL = SQL + " inner join category1 c on b.cat1cd = c.cat1cd ";
SQL = SQL + " where goodscd = '" + pgoodscd + "'";
rs = stmt.executeQuery(SQL);

if (rs.next() == false){  // 만약 테이블에 아무것도 없다면
%>
			<TR>
				<TD colspan=2><center>등록된 상품이 없습니다</center></TD>      
			</TR>
<% 
}
else
{	

		String cat1nm			= rs.getString("cat1nm");
		String cat2nm			= rs.getString("cat2nm");
		String goodscd		= rs.getString("goodscd");
		String goodsnm		= rs.getString("goodsnm");
		int unitprice			= rs.getInt("unitprice");
		String goodsimg1	= rs.getString("goodsimg1");

	%>

      <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="547" height="45" align="left" class="new_tit"<%= cat1nm %> 상세보기</td>
            <td width="253" align="right">HOME &lt; <%= cat1nm %></td>
          </tr>
					<INPUT type = hidden name = userid value = <%= userid %>>
          <tr>
            <td colspan="2" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="51%" rowspan="2" valign="top"><img src="/images/<%= goodsimg1 %>" width="400" height="400" /></td>
                <td width="49%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="8">
                  <tr>
                    <td width="27%" class="line">대분류</td>
                    <td width="73%" class="line"><%= cat1nm %></td>
                  </tr>
                  <tr>
                    <td class="line">중분류</td>
                    <td class="line"><%= cat2nm %></td>
                  </tr>
                  <tr>
                    <td class="line">상품코드</td>
                    <td class="line"><INPUT type = hidden name = goodscd value = <%= goodscd %>><%= goodscd %></td>
                  </tr>
                  <tr>
                    <td class="line">상품명</td>
                    <td class="line"><%= goodsnm %></td>
                  </tr>
                  <tr>
                    <td class="line">상품가격</td>
                    <td class="line">
											<INPUT type = hidden name = unitprice value = <%= unitprice %>>
											<% 
													DecimalFormat df = new DecimalFormat("###,###,##0"); 
													out.println(df.format(unitprice));
											%>	원</td>
                  </tr>
                  <tr>
                    <td class="line">상품색상</td>
                    <td class="line">
                      <label for="colorcd"></label>
                      <select name="colorcd" id="colorcd">
												<OPTION VALUE="">==색상 선택==</OPTION>
												<%
												String strSQL	= "SELECT colorcd, colornm FROM colorinfo";
												rs2			= stmt.executeQuery(strSQL);

												while (rs2.next()){
													out.print("<OPTION VALUE=\"");
													out.print(rs2.getString("colorcd"));
													out.print("\">");
													out.print(rs2.getString("colornm"));
													out.println("</OPTION>");
												}
												%>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td class="line">상품크기</td>
                    <td class="line">
                      <label for="sizecd"></label>
                      <select name="sizecd" id="sizecd">
											<OPTION VALUE="">==크기 선택==</OPTION>
											<%
											if (rs2    != null) rs2.close();

											strSQL	= "SELECT sizecd, sizenm FROM sizeinfo";
											rs2			= stmt.executeQuery(strSQL);

											while (rs2.next()){
												out.print("<OPTION VALUE=\"");
												out.print(rs2.getString("sizecd"));
												out.print("\">");
												out.print(rs2.getString("sizenm"));
												out.println("</OPTION>");
											}
											%>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td class="line">주문수량</td>
                    <td class="line">
	                  <label for="qty"></label>
										<SELECT name = "qty" size = "1" onChange = "qtyChanged();">
												<OPTION selected>1</OPTION>
												<OPTION>2</OPTION>
												<OPTION>3</OPTION>
												<OPTION>4</OPTION>
												<OPTION>5</OPTION>
												<OPTION>6</OPTION>
												<OPTION>7</OPTION>
												<OPTION>8</OPTION>
												<OPTION>9</OPTION>
												<OPTION>10</OPTION>
											</SELECT>
                   </td>
                  </tr>
                  <tr>
                    <td class="line">총금액</td>
                    <td class="line"><SPAN id = "totalAmtView"><%= df.format(unitprice) %></SPAN>원</td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td align="center">
                  <input type = "button" id = "button"  value = "장바구니 담기" onClick = "cartAdd();"/>
                  <input type = "button" id = "button2" value = "메인으로 가기" onClick = "goMain();"/>
                </td>
              </tr>
            </table></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td align="center" valign="top">&nbsp;</td>
      </tr>
			<%@ include file="/includes/bottom.jsp" %>
    </table></td>
  </tr>
</table>
</form>
<%
}
if (stmt  != null) stmt.close();
if (rs    != null) rs.close();
if (rs2   != null) rs2.close();
if (con   != null) con.close();
%>
</body>
</html>