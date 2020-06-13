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
      document.orderform.usernm2.value		= document.orderform.usernm.value;
      document.orderform.addr2.value			= document.orderform.addr.value;
      document.orderform.telno2.value		= document.orderform.telno.value;
    }
    else
    {
      document.orderform.usernm2.value		= "";
      document.orderform.addr2.value			= "";
      document.orderform.telno2.value		= "";
    }
  }


  function sendComplete() {
    document.orderform.action = "goodsOrderPageB.jsp";
    document.orderform.submit();
  }

  function sendMain() {
    document.orderform.action = "/index.jsp";
    document.orderform.submit();
  }

</script>

<BODY>
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
              <td width="547" height="45" align="left" class="new_tit">주문서 작성</td>
              <td width="253" align="right">HOME &lt; 주문서 작성</td>
            </tr>
            <tr>
              <td colspan="2" align="left" valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
                <tr>
                  <td width="9%" align="center" bgcolor="#EEEEEE">상품이미지</td>
                  <td width="12%" align="center" bgcolor="#EEEEEE">상품코드</td>
                  <td width="20%" align="center" bgcolor="#EEEEEE">상품명</td>
                  <td width="10%" align="center" bgcolor="#EEEEEE">상품가격</td>
                  <td width="14%" align="center" bgcolor="#EEEEEE">수량</td>
                  <td width="10%" align="center" bgcolor="#EEEEEE">금액</td>
                </tr>

                <%

                  String userid			=	(String)session.getAttribute("G_ID");

                  ResultSet rs			= null;
                  DecimalFormat df	= new DecimalFormat("###,###,##0");
                  int amt						= 0;
                  int totAmt				= 0;
                  String user_rank ="";
                  Statement stmt  = con.createStatement();

                  String SQL = "select a.*, b.*, user_rank from cart a ";
                  SQL = SQL + " inner join product b on a.product_id = b.product_id inner join intelior.user u on a.user_id = u.user_id ";
                  SQL = SQL + " where a.user_id = '" + userid + "' and chkYN = 'Y'";
                  rs = stmt.executeQuery(SQL);

                  int cnt = 0;
                  int i		= 0;
                  while(rs.next()){
                    i ++;
                    user_rank =rs.getString("user_rank");
                    String product_id		= rs.getString("product_id");
                    String product_name		= rs.getString("product_name");

                    int product_price			= rs.getInt("product_price");
                    int qty						= rs.getInt("p_count");

                    String product_thumnail	= rs.getString("product_thumnail");
                    String chkYN			= rs.getString("chkYN");
                    amt								= product_price * qty;
                    totAmt						= totAmt + amt;

                %>
                <tr>
                  <INPUT type = hidden name = "idx" value = "<%= product_id %>">

                  <td align="center" bgcolor="#FFFFFF"><img src="/images/<%= product_thumnail %>" width="40" height="40" /></td>
                  <td align="center" bgcolor="#FFFFFF"><%= product_id					%></td>
                  <td align="center" bgcolor="#FFFFFF"><%= product_name					%></td>
                  <td align="center" bgcolor="#FFFFFF"><%= df.format(product_price)%></td>
                  <td align="center" bgcolor="#FFFFFF"><%= qty							%></td>
                  <td align="center" bgcolor="#FFFFFF"><%= df.format(amt)		%></td>
                </tr>

                <%
                  }

//고객 등급 따라서 결제금액 재설정
                  double discounted_price = 0.0;
                  if(user_rank.equals("silver")){
                    discounted_price = totAmt * 0.97; // 3% 할인
                  }
                  else if(user_rank.equals("gold")){
                    discounted_price = totAmt * 0.95;
                  }
                  else if(user_rank.equals("basic")){
                    discounted_price = totAmt;
                  }
                  int discounted_price_int = (int)discounted_price;

                %>
              </table></td>
            </tr>
          </table></td>
        </tr>
        <% if(user_rank.equals("basic")){
        %>
        <tr>
          <td height="50" align="center">합계 <%= df.format(totAmt) %>원</td>
        </tr>
        <tr>
          <td height="50" align="center">회원 등급: <%= user_rank %>  <br> 최종금액 <%= df.format(discounted_price_int) %>원</td>
        </tr>
        <% }
        else if(user_rank.equals("silver")){
        %>
        <tr>
          <td height="50" align="center">합계 <%= df.format(totAmt) %>원</td>
        </tr>
        <tr>
          <td height="50" align="center">회원 등급: <%= user_rank %> 3% 할인 <br> 최종금액 <%= df.format(discounted_price_int) %>원</td>
        </tr>
        <% }
        else if(user_rank.equals("gold")){
        %>
        <tr>
          <td height="50" align="center">합계<%= df.format(totAmt) %>원</td>
        </tr>
        <tr>
          <td height="50" align="center">회원 등급: <%= user_rank %>,  5% 할인 <br> 최종금액 <%= df.format(discounted_price_int) %>원</td>
        </tr>
        <% }
        %>

        <%





          if (rs    != null) rs.close();
          SQL = "select user_name, user_address ,user_phone, user_email from user where user_id = '" + userid + "'";
          rs = stmt.executeQuery(SQL);

          if (rs.next()){

            String user_nm = rs.getString("user_name");
            String user_address		= rs.getString("user_address");
            String user_phone	= rs.getString("user_phone");
            String user_email	= rs.getString("user_email");

        %>
        <FORM NAME = orderform ACTION = "goodsOrderPageB.jsp" METHOD = POST>
          <tr>
            <td align="center"><table width="800" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
              <tr>
                <td colspan="2" align="left" bgcolor="#EEEEEE">주문자 정보</td>
              </tr>
              <tr>
                <td width="24%" align="left" bgcolor="#FFFFFF">주문자 성명</td>
                <td width="76%" align="left" bgcolor="#FFFFFF"><%= user_nm %></TD><INPUT type = hidden name = usernm value = "<%= user_nm %>"></td>
              </tr>
              <tr>
                <td align="left" bgcolor="#FFFFFF">주문자 주소</td>
                <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT type = text name = addr value = "<%= user_address %>" size = 50 maxlength = 50></td>
              </tr>
              <tr>
                <td align="left" bgcolor="#FFFFFF">주문자 전화</td>
                <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT type = text name = telno value = "<%= user_phone %>"></td>
              </tr>
              <tr>
                <td align="left" bgcolor="#FFFFFF">주문자 email</td>
                <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT type = text name = eamil value = "<%= user_email %>"></td>
              </tr>
            </table></td>
          </tr>
          <%
            }
          %>
          <tr>
            <td height="50" align="center">
              <input type="button" id="button" value="주문하기" onClick = "sendComplete();"/>
              <input type="button" id="button2" value="메인으로 이동" onClick = "sendMain();"/>
            </td>
          </tr>

          <tr>
            <%@ include file="/includes/bottom.jsp" %>
          </tr></FORM>
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