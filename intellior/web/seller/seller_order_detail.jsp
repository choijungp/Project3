<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<script type="text/javascript">
    function updateChk() {
        document.update_seller_order.action = "seller_order_detail_ok.jsp";
        document.update_seller_order.submit();
    }
</script>
<HTML>
<HEAD>
    <TITLE> 주문 상세보기</TITLE>
    <link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>


<%
    String sellerid         =   (String)session.getAttribute("G_ID");
    DecimalFormat df1   = new DecimalFormat("00");
    DecimalFormat df2   = new DecimalFormat("###,###,##0");
    String order_code = request.getParameter("order_code");

    int amt                  = 0;
    int totAmt            = 0;
    Statement stmt      = con.createStatement();
    ResultSet rs         = null;
%>
<BODY>
<FORM NAME="update_seller_order" ACTION="seller_order_detail_ok.jsp" METHOD="post">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
                <%@ include file="/includes/seller_top.jsp" %>
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
                        <td width="9%" align="center" bgcolor="#EEEEEE" class="list2_tit">상품이미지</td>
                        <td width="12%" align="center" bgcolor="#EEEEEE" class="list2_tit">상품명</td>
                        <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">단가</td>
                        <td width="7%" align="center" bgcolor="#EEEEEE" class="list2_tit">수량</td>
                        <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">금액</td>
                        <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">주문자 이름</td>
                        <td width="14%" align="center" bgcolor="#EEEEEE" class="list2_tit">주문자 주소</td>
                        <td width="14%" align="center" bgcolor="#EEEEEE" class="list2_tit">주문자 번호</td>
                        <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">주문상태</td>
                        <td width="10%" align="center" bgcolor="#EEEEEE" class="list2_tit">배송</td>
                    </tr>


                    <%
                        String strSQL = "select a.*, b.*, c.*   from intelior.order a ";
                        strSQL = strSQL + " inner join product   b on a.product_id   = b.product_id ";
                        strSQL = strSQL + " inner join intelior.user c on a.user_id   = c.user_id ";
                        strSQL = strSQL + " where a.seller_id = '" + sellerid + "' and a.order_code = " + order_code ;


                        rs = stmt.executeQuery(strSQL);
                        int i =0;


                        while(rs.next()){
                            i++;
                            String product_thumnail = rs.getString("product_thumnail");
                            String product_name = rs.getString("product_name");
                            String user_nm = rs.getString("user_name");
                            String user_address = rs.getString("user_address");
                            String user_phone = rs.getString("user_phone");
                            int product_price = rs.getInt("product_price");
                            int order_id = rs.getInt("order_id");
                            int order_count = rs.getInt("order_count");
                            int order_state = rs.getInt("order_state");
                            int result_price = product_price*order_count;
                            totAmt         = totAmt + result_price;

                    %>
                    <tr>
                        <INPUT type = hidden name = "order_id" value = "<%= order_id %>">
                        <INPUT type = hidden name = "order_code" value = "<%= order_code %>">
                        <INPUT type = hidden name = "order_state" value = "<%= order_state %>">
                        <td align="center" bgcolor="#FFFFFF"><img src="/images/<%= product_thumnail %>" width="40" height="40" /></td>
                        <td align="center" bgcolor="#FFFFFF"><%= product_name               %></td>
                        <td align="center" bgcolor="#FFFFFF"><%= df2.format(product_price)%></td>
                        <td align="center" bgcolor="#FFFFFF"><%= order_count         %></td>
                        <td align="center" bgcolor="#FFFFFF"><%= df2.format(result_price)   %></td>
                        <td align="center" bgcolor="#FFFFFF"><%= user_nm               %></td>
                        <td align="center" bgcolor="#FFFFFF"><%= user_address         %></td>
                        <td align="center" bgcolor="#FFFFFF"><%= user_phone      %></td>
                        <td height="45" align=center>
                            <% if(order_state>0){
                            %>
                            배송완료
                            <% }
                            else{
                            %>
                            배송대기
                            <% }
                            %>
                        </td>
                        <TD><INPUT type = checkbox name = "chkName" value = "<%= order_id %>" id = "chkId<%= i %>"></TD>
                    </tr>

                    <%
                        }
                    %>



                </table></td>
                </tr>
                <tr>
                    <td height="50" align="center">합계 <SPAN id = "totAmtView"><%= df2.format(totAmt) %></SPAN>원</td>
                </tr>
                <tr>
                    <td height="25" align="right">
                        <input type = "button" id = "button"  value = "배송/취소"  onClick = "updateChk();"/>
                    </td>
                </tr>

                </tr>
                <tr>

                </tr>

                </tr>
                <%@ include file="/includes/bottom.jsp" %>
            </table></td>
        </tr>
    </table>
</FORM>
</body>
</html>
<%
    if (stmt  != null) stmt.close();
    if (rs    != null) rs.close();
    if (con   != null) con.close();
%>
</BODY>