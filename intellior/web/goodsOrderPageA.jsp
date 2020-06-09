<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<HEAD>
  <TITLE> 주문서 작성</TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>


<script type="text/javascript">


function chkProsess(){

	if(document.frm1.chk.checked == true)
	{
			document.frm1.usernm2.value		= document.frm1.usernm.value;
			document.frm1.addr2.value			= document.frm1.addr.value;
			document.frm1.telno2.value		= document.frm1.telno.value;
	}
	else
	{
			document.frm1.usernm2.value		= "";
			document.frm1.addr2.value			= "";
			document.frm1.telno2.value		= "";
	}
}


function sendComplete() {
	document.frm1.action = "goodsOrderPageB.jsp";
	document.frm1.submit();
}

function sendMain() {
	document.frm1.action = "/index.jsp";
	document.frm1.submit();
}

</script>

<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		<table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="/includes/top.jsp" %>
      <tr>
        <td height="80" background="/icons/sub_bg.jpg">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="547" height="45" align="left" class="new_tit">주문서 작성</td>
            <td width="253" align="right">HOME &lt; 주문서 작성</td>
            </tr>
          <tr>
            <td colspan="2" align="left" valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
              <tr>
                <td width="10%" align="center" bgcolor="#EEEEEE">상품이미지</td>
                <td width="20%" align="center" bgcolor="#EEEEEE">상품코드</td>
                <td width="20%" align="center" bgcolor="#EEEEEE">상품명</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">상품색상</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">상품크기</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">단가</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">수량</td>
                <td width="10%" align="center" bgcolor="#EEEEEE">금액</td>
              </tr>
							
<%

String userid			=	(String)session.getAttribute("G_ID");

ResultSet rs			= null;
DecimalFormat df	= new DecimalFormat("###,###,##0"); 
int amt						= 0;
int totAmt				= 0;
	
Statement stmt  = con.createStatement();

String SQL = "select a.*, b.goodsnm, b.goodsimg1, c.colornm, d.sizenm from cart a ";
SQL = SQL + " inner join goodsinfo b on a.goodscd = b.goodscd ";
SQL = SQL + " inner join colorinfo c on a.color		= c.colorcd ";
SQL = SQL + " inner join sizeinfo  d on a.size		= d.sizecd ";
SQL = SQL + " where userid = '" + userid + "' and chkYN = 'Y'";
rs = stmt.executeQuery(SQL);

int cnt = 0;
int i		= 0;
while(rs.next()){

	i ++;
	String goodscd		= rs.getString("goodscd");
	String goodsnm		= rs.getString("goodsnm");
	String colornm		= rs.getString("colornm");
	String sizenm			= rs.getString("sizenm");
	int unitPrice			= rs.getInt("unitprice");
	int qty						= rs.getInt("qty");
	int idx						= rs.getInt("idx");
	String goodsimg1	= rs.getString("goodsimg1");
	amt								= unitPrice * qty;
	totAmt						= totAmt + amt;

%>
              <tr>
									<INPUT type = hidden name = "idx" value = "<%= idx %>">

                <td align="center" bgcolor="#FFFFFF"><img src="/images/<%= goodsimg1 %>" width="40" height="40" /></td>
                <td align="center" bgcolor="#FFFFFF"><%= goodscd					%></td>
                <td align="center" bgcolor="#FFFFFF"><%= goodsnm					%></td>
                <td align="center" bgcolor="#FFFFFF"><%= colornm					%></td>
                <td align="center" bgcolor="#FFFFFF"><%= sizenm						%></td>
                <td align="center" bgcolor="#FFFFFF"><%= df.format(unitPrice)%></td>
                <td align="center" bgcolor="#FFFFFF"><%= qty							%></td>
                <td align="center" bgcolor="#FFFFFF"><%= df.format(amt)		%></td>
              </tr>

<%
}
%>
            </table></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="50" align="center">합계 <SPAN id = "totAmtView"><%= df.format(totAmt) %></SPAN>0원</td>
      </tr>
<%

if (rs    != null) rs.close();
SQL = "select usernm, addr1 + ' ' + addr2 addr, telno from members where userid = '" + userid + "'";
rs = stmt.executeQuery(SQL);

if (rs.next()){

	String usernm = rs.getString("usernm");
	String addr		= rs.getString("addr");
	String telno	= rs.getString("telno");

%>
<FORM NAME = frm1 ACTION = "goodsOrderPageB.jsp" METHOD = POST>
      <tr>
        <td align="center"><table width="800" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
          <tr>
            <td colspan="2" align="left" bgcolor="#EEEEEE">주문자 정보</td>
            </tr>
          <tr>
            <td width="24%" align="left" bgcolor="#FFFFFF">주문자 성명</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= usernm %></TD><INPUT type = hidden name = usernm value = "<%= usernm %>"></td>
            </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">주문자 주소</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT type = text name = addr value = "<%= addr %>" size = 50 maxlength = 50></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">주문자 전화</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT type = text name = telno value = "<%= telno %>"></td>
          </tr>
          <tr>
            <td colspan="2" align="left" bgcolor="#EEEEEE">받는자 정보</td>
            </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">주문자 정보와 동일</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT type = checkbox name = chk onClick = "chkProsess();"></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">받는자 성명</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT type = text name = usernm2 maxlength = 10></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">받는자 주소</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT type = text name = addr2 size = 50 maxlength = 50></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">받는자 전화</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT type = text name = telno2 maxlength = 20></td>
          </tr>
        </table></td>
      </tr>

<%
}

%>
      <tr>
        <td height="50" align="center">
          <input type="button" id="button"  value="주문하기" onClick = "sendComplete();"/>
          <input type="button" id="button2" value="메인으로 이동" onClick = "sendMain();"/>
        </td>
      </tr>

      <tr>
			<%@ include file="/includes/bottom.jsp" %>
      </tr>
    </table></td>
  </tr>
</table>
</BODY>
</html>
<%
if (stmt  != null) stmt.close();
if (rs    != null) rs.close();
if (con   != null) con.close();
%>