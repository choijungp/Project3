<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*, java.util.Calendar" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<HEAD>
  <TITLE> 주문 완료</TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<%

String userid			=	(String)session.getAttribute("G_ID");
String addr				= request.getParameter("addr");
String telno			= request.getParameter("telno");
String usernm2		= request.getParameter("usernm2");
String addr2			= request.getParameter("addr2");
String telno2			= request.getParameter("telno2");
String goodscd		= "";
String goodsnm		= "";
String colornm		= "";
String sizenm			= "";
String colorcd		= "";
String sizecd			= "";
String goodsimg1	= "";
String usernm			= "";

int unitPrice			= 0;
int qty						= 0;
int amt						= 0;
int totAmt				= 0;

DecimalFormat df1	= new DecimalFormat("00"); 
DecimalFormat df2	= new DecimalFormat("###,###,##0"); 

String newOrdNo		= "";

Statement stmt		= con.createStatement();
Statement stmt2		= con.createStatement();
Statement stmt3		= con.createStatement();
ResultSet rs			= null, rs2 = null;

try{		

	String strSQL = "select sum(unitprice * qty) tot from cart ";
	strSQL	= strSQL + " where userid = '" + userid + "' and chkYN = 'Y'";

	rs			= stmt.executeQuery(strSQL);

	while(rs.next()){

		int tot					= rs.getInt("tot");

		Calendar cal		= Calendar.getInstance();

		int year				= cal.get(Calendar.YEAR);
		int mon	    		= cal.get(Calendar.MONTH) + 1;
		int seq	    		= 0;

		String strSeq		= "";
		String newCode  = "";
		String strYear  = Integer.toString(year);
		String strMon		= df1.format(mon);
		
		strSQL = "select max(ordNo) from order_h where left(ordNo, 6) = " + strYear + strMon;
		rs2		= stmt2.executeQuery(strSQL);

		rs2.next() ;
		if (rs2 == null) {
			seq		= 0;
		}else{
			String maxcode	= rs2.getString(1);
			if (maxcode == null)
				seq		= 0;
			else
			{
				strSeq					= maxcode.substring(4);
				seq							= Integer.parseInt(strSeq);
			}
		}

		seq++;
		String newSeq 		= "0000" + Integer.toString(seq);
		int newSeqleng	= newSeq.length();
		newOrdNo	= strYear + strMon + newSeq.substring(newSeqleng - 4, newSeqleng);

		strSQL = "insert into order_H (ordNo, orddtm , userid, ordTamt, addr, telno, deliUserName, deliAddr, deliTelno, cancelYN) values (";
		strSQL = strSQL + "  '"	+ newOrdNo  + "'";
		strSQL = strSQL + ",     getdate() ";
		strSQL = strSQL + ", '" + userid		+ "'";
		strSQL = strSQL + ",  " + tot	;
		strSQL = strSQL + ", '" + addr			+ "'";
		strSQL = strSQL + ", '" + telno			+ "'";
		strSQL = strSQL + ", '" + usernm2		+ "'";
		strSQL = strSQL + ", '" + addr2			+ "'";
		strSQL = strSQL + ", '" + telno2		+ "'";
		strSQL = strSQL + ", 'N')";

		stmt3.execute(strSQL);

	}

	strSQL	= "select * from cart ";
	strSQL	= strSQL + " where userid = '" + userid + "' and chkYN = 'Y'";
	rs2			= stmt.executeQuery(strSQL);

	int i		= 0;
	while(rs2.next()){

		i ++;
		goodscd			= rs2.getString("goodscd");
		colorcd			= rs2.getString("color");
		sizecd			= rs2.getString("size");
		unitPrice		= rs2.getInt("unitprice");
		qty					= rs2.getInt("qty");
		amt					= unitPrice * qty;

		strSQL = "insert into order_D (ordNo, ordSeq , goodscd, color, size, unitprice, ordQty, ordAmt) values (";
		strSQL = strSQL + "  '"	+ newOrdNo  + "'";
		strSQL = strSQL + ",  " + i;
		strSQL = strSQL + ", '" + goodscd		+ "'";
		strSQL = strSQL + ", '" + colorcd		+ "'";
		strSQL = strSQL + ", '" + sizecd		+ "'";
		strSQL = strSQL + ",  " + unitPrice;
		strSQL = strSQL + ",  " + qty;
		strSQL = strSQL + ",  " + amt				+ ")";

		stmt2.execute(strSQL);
	}

	if ( i > 0 )
	{

		strSQL = "delete from cart where userid ='" + userid + "' and chkYN = 'Y'";
//		stmt3.execute(strSQL);

	}
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top">
		< width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="/includes/top.jsp" %>
      <tr>
        <td height="80" background="/icons/sub_bg.jpg">&nbsp;</td>
      </tr>
      <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="547" height="45" align="left" class="new_tit">주문 완료</td>
            <td width="253" align="right">HOME &lt; 주문 완료</td>
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

strSQL = "select a.*, b.*, c.goodsnm, c.goodsimg1, d.colornm, e.sizenm, f.usernm from order_H a ";
strSQL = strSQL + " inner join order_D		b on a.ordNo		= b.ordNo ";
strSQL = strSQL + " inner join goodsinfo	c on b.goodscd	= c.goodscd ";
strSQL = strSQL + " inner join colorinfo	d on b.color		= d.colorcd ";
strSQL = strSQL + " inner join sizeinfo		e on b.size			= e.sizecd ";
strSQL = strSQL + " inner join members		f on a.userid		= f.userid ";
strSQL = strSQL + " where a.userid = '" + userid + "' and a.ordNo = '" + newOrdNo + "'";
strSQL = strSQL + " order by ordSeq";

rs = stmt.executeQuery(strSQL);

while(rs.next()){

	goodscd			= rs.getString("goodscd");
	goodsnm			= rs.getString("goodsnm");
	colornm			= rs.getString("colornm");
	sizenm			= rs.getString("sizenm");
	unitPrice		= rs.getInt("unitprice");
	qty					= rs.getInt("ordQty");
	amt					= rs.getInt("ordAmt");
	goodsimg1		= rs.getString("goodsimg1");
	totAmt			= totAmt + amt;

	usernm			= rs.getString("usernm");
	addr				=	rs.getString("addr");
	telno				= rs.getString("telno");
	usernm2			= rs.getString("deliUserName");
	addr2				=	rs.getString("deliAddr");
	telno2			=	rs.getString("deliTelno");

%>
              <tr>

                <td align="center" bgcolor="#FFFFFF"><img src="/images/<%= goodsimg1 %>" width="40" height="40" /></td>
                <td align="center" bgcolor="#FFFFFF"><%= goodscd					%></td>
                <td align="center" bgcolor="#FFFFFF"><%= goodsnm					%></td>
                <td align="center" bgcolor="#FFFFFF"><%= colornm					%></td>
                <td align="center" bgcolor="#FFFFFF"><%= sizenm						%></td>
                <td align="center" bgcolor="#FFFFFF"><%= df2.format(unitPrice)%></td>
                <td align="center" bgcolor="#FFFFFF"><%= qty							%></td>
                <td align="center" bgcolor="#FFFFFF"><%= df2.format(amt)	%></td>
              </tr>

<%
}
%>
            </table></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="50" align="center">합계 <SPAN id = "totAmtView"><%= df2.format(totAmt) %></SPAN>0원</td>
      </tr>
<%


%>
<FORM NAME = frm1 ACTION = "index.jsp" METHOD = POST>
      <tr>
        <td align="center"><table width="800" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
          <tr>
            <td colspan="2" align="left" bgcolor="#EEEEEE">주문자 정보</td>
            </tr>
          <tr>
            <td width="24%" align="left" bgcolor="#FFFFFF">주문자 성명</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= usernm %></td>
            </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">주문자 주소</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= addr %></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">주문자 전화</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= telno %></td>
          </tr>
          <tr>
            <td colspan="2" align="left" bgcolor="#EEEEEE">받는자 정보</td>
            </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">받는자 성명</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= usernm2 %></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">받는자 주소</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= addr2 %></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#FFFFFF">받는자 전화</td>
            <td width="76%" align="left" bgcolor="#FFFFFF"><%= telno2 %></td>
          </tr>
        </table></td>
      </tr>

      <tr>
        <td height="50" align="center">
          <input type="submit" id="button2" value="메인으로 이동"/>
        </td>
      </tr>

      <tr>
			<%@ include file="/includes/bottom.jsp" %>
      </tr>
</FORM>
</table>
</body>
</html>
<%
} //try end

catch(SQLException e1){
	e1.printStackTrace();
} // catch SQLException end

catch(Exception e2){
	e2.printStackTrace();
} // catch Exception end

finally{
if (stmt  != null) stmt.close();
if (stmt2 != null) stmt2.close();
if (rs    != null) rs.close();
if (rs2   != null) rs2.close();
if (con   != null) con.close();
}
%>