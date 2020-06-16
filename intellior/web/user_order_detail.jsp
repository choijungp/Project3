<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<HEAD>
    <TITLE> 주문 상세보기</TITLE>
    <link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<%
    String userid			=	(String)session.getAttribute("G_ID");
    DecimalFormat df1	= new DecimalFormat("00");
    DecimalFormat df2	= new DecimalFormat("###,###,##0");
    String order_code = request.getParameter("order_code");

    int amt						= 0;
    int totAmt				= 0;
    int order_payment =0;
    Statement stmt		= con.createStatement();
    ResultSet rs			= null;
%>
<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
            <%@ include file="/includes/top.jsp" %>
            </tr>
            <tr>
                <td>
                    <img src="/icons/sub_bg.png" width="810"/>
                </td>
            </tr>
            <tr>
                <td width="547" height="45" align="left" class="new_tit">주문 상세보기</td>
            </tr>

            <td align="center" valign="top"><table width="800" border="0" cellspacing="5" cellpadding="0">


                <tr>
                    <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">상품이미지</td>
                    <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">상품코드</td>
                    <td width="15%" align="center" bgcolor="#EEEEEE" class="list2_tit">상품명</td>
                    <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">판매자</td>
                    <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">단가</td>
                    <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">수량</td>
                    <td width="15%" align="center" bgcolor="#EEEEEE" class="list2_tit">금액</td>
                    <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">주문상태</td>
                </tr>


                <%
                    String strSQL = "select a.*, b.*, c.* , seller_name from intelior.order a ";
                    strSQL = strSQL + " inner join product	b on a.product_id	= b.product_id ";
                    strSQL = strSQL + " inner join intelior.user c on a.user_id	= c.user_id ";
                    strSQL = strSQL + " inner join intelior.seller d on a.seller_id	= d.seller_id ";
                    strSQL = strSQL + " where a.user_id = '" + userid + "' and a.order_code = " + order_code ;


                    rs = stmt.executeQuery(strSQL);


                    while(rs.next()){

                        String product_thumnail = rs.getString("product_thumnail");
                        int product_id = rs.getInt("product_id");
                        String product_name = rs.getString("product_name");
                        String seller_name = rs.getString("seller_name");
                        int product_price = rs.getInt("product_price");
                        int order_count = rs.getInt("order_count");
                        int order_state = rs.getInt("order_state");
                        order_payment = rs.getInt("order_payment");
                        int result_price = product_price*order_count;
                        totAmt			= totAmt + result_price;

                %>
                <tr>

                    <td align="center" bgcolor="#FFFFFF"><img src="/images/<%= product_thumnail %>" width="40" height="40" /></td>
                    <td align="center" bgcolor="#FFFFFF"><%= product_id					%></td>
                    <td align="center" bgcolor="#FFFFFF"><%= product_name					%></td>
                    <td align="center" bgcolor="#FFFFFF"><%= seller_name					%></td>
                    <td align="center" bgcolor="#FFFFFF"><%= df2.format(product_price)%></td>
                    <td align="center" bgcolor="#FFFFFF"><%= order_count			%></td>
                    <td align="center" bgcolor="#FFFFFF"><%= df2.format(result_price)	%></td>
                    <td height="45" align=center>
                        <% if(order_state>0){
                        %>
                        배송완료<br><a href="review_insert.jsp?product_id=<%= product_id %>">[리뷰작성]
                            <% }
                        else{
                        %>
                        배송대기
                            <% }
                        %>

                    </td>
                </tr>

                <%
                    }
                %>



            </table></td>
            </tr>

            <tr>
                <td height="50" align="right">결제금액 <SPAN id = "totAmtView"><%= df2.format(order_payment) %></SPAN>원</td>
            </tr>
            </tr>
            <tr>

            </tr>

            </tr>
            <%@ include file="/includes/bottom.jsp" %>
        </table></td>
    </tr>
</table>
</body>
</html>
<%
    if (stmt  != null) stmt.close();
    if (rs    != null) rs.close();
    if (con   != null) con.close();
%>
</BODY>