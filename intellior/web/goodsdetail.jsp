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
        var totalAmt      = (document.detail_form.product_price.value) * (document.detail_form.qty.value);
        var strTotalAmt   = totalAmt.toString();

        var temp  = "";
        for (idx = strTotalAmt.length - 1; idx >= 0; idx--){
            schar = strTotalAmt.charAt(idx);
            temp   = schar  + temp;
            if(idx % 3 == strTotalAmt.length % 3 && idx != 0){ temp = ',' + temp; }
        }

        document.all.totalAmtView.innerHTML = temp;
    }

    function cartAdd() {

        if (document.detail_form.userid.value == "")
        {
            alert("로그인을 하여 주시기 바랍니다.");
            return false;
        }

        document.detail_form.action = "goodsCartAdd.jsp";
        document.detail_form.submit();
    }

    function goView() {
        document.detail_form.action = "./review_list.jsp?product_id="+document.detail_form.product_id.value;
        document.detail_form.submit();
    }

    function goQnA() {
        document.detail_form.action = "./qna_list.jsp?product_id="+document.detail_form.product_id.value;
        document.detail_form.submit();
    }

</script>

<body>

<FORM NAME = "detail_form" ACTION = "goodsCartAdd.jsp" METHOD = POST>
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


                    <%
                        String sbar=request.getParameter("bar");
                        if(sbar==null)
                            sbar="1";

                        String userid         =   (String)session.getAttribute("G_ID");
                        String product_id = request.getParameter("product_id");

                        if (userid == null) userid = "";

                        ResultSet rs = null, rs2 = null;

                        Statement stmt  = con.createStatement();

                        String SQL = "select category, product_name, product_view_count, product_price, product_thumnail, product_image, seller_id, product_contents from product ";
                        SQL = SQL + " where product_id = '" + product_id + "'";
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

                        String category         = rs.getString("category");
                        String product_name         = rs.getString("product_name");
                        int product_price         = rs.getInt("product_price");
                        int product_view_count         = rs.getInt("product_view_count");
                        String product_thumnail   = rs.getString("product_thumnail");
                        String product_image   = rs.getString("product_image");
                        String seller_id   = rs.getString("seller_id");
                        String product_contents   = rs.getString("product_contents");
                        product_view_count++;

                        String sql2 = "UPDATE product SET product_view_count = '" + product_view_count + "'";
                        sql2 = sql2 + "WHERE product_id = '" + product_id + "'";

                        stmt.executeUpdate(sql2);

                    %>

                    <tr>
                        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="547" height="45" align="left" class="new_tit"<%= category %> 상세보기</td>
                                <td width="253" align="right">HOME &lt; <%= category %></td>
                            </tr>
                            <INPUT type = hidden name = userid value = <%= userid %>>
                            <tr>
                                <td colspan="2" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="51%" rowspan="2" valign="top"><img src="/images/<%= product_thumnail %>" width="300" height="300" /></td>
                                        <td width="49%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="8">
                                            <tr>
                                                <td width="27%" class="line">카테고리</td>
                                                <td width="73%" class="line"><%= category %></td>
                                            </tr>
                                            <tr>
                                                <td class="line">상품코드</td>
                                                <td class="line"><INPUT type = hidden name = product_id value = <%= product_id %>><%= product_id %></td>
                                            </tr>
                                            <tr>
                                                <td class="line">조회수</td>
                                                <td class="line"><INPUT type = hidden name = product_view_count value = <%= product_view_count %>><%= product_view_count %></td>
                                            </tr>
                                            <tr>
                                                <td class="line">판매자</td>
                                                <td class="line"><INPUT type = hidden name = seller_id value = <%= seller_id %>><%= seller_id %></td>
                                            </tr>
                                            <tr>
                                                <td class="line">상품명</td>
                                                <td class="line"><%= product_name %></td>
                                            </tr>
                                            <tr>
                                                <td class="line">상품가격</td>
                                                <td class="line">
                                                    <INPUT type = hidden name = product_price value = <%= product_price %>>
                                                    <%
                                                        DecimalFormat df = new DecimalFormat("###,###,##0");
                                                        out.println(df.format(product_price));
                                                    %>   원</td>
                                            </tr>
                                            <tr>
                                                <td class="line">설명</td>
                                                <td class="line"><%= product_contents %></td>
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
                                                <td class="line"><SPAN id = "totalAmtView"><%= df.format(product_price) %></SPAN>원</td>
                                            </tr>
                                        </table></td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <input type = "button" id = "button2"  value = "장바구니 담기" onClick = "cartAdd();" onmouseover="this.style.cursor='hand';" class="submit_button"/>
                                        </td>
                                    </tr>
                                </table>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="8">
                                        <br><br>
                                        <tr>
                                            <td align="center" width="233" <%if(sbar.equals("1")){ out.print("class=\"detail_bar_slt\"");} else out.print("class=\"detail_bar_nslt\"");%>>
                                                <a href="/goodsdetail.jsp?product_id=<%=product_id%>&bar=1">상세보기</a></td>
                                            <td align="center" width="233" <%if(sbar.equals("2")){ out.print("class=\"detail_bar_slt\"");} else out.print("class=\"detail_bar_nslt\"");%>>
                                                <a href="/review_list.jsp?product_id=<%=product_id%>">리뷰</a></td>
                                            <td align="center" width="233" <%if(sbar.equals("3")){ out.print("class=\"detail_bar_slt\"");} else out.print("class=\"detail_bar_nslt\"");%>>
                                                <a href="/qna_list.jsp?product_id=<%=product_id%>">Q&A</a></td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" align="center" class="detail_drq"><img src="/images/<%= product_image %>" width="80%" height="100%" /></td>
                                        </tr>
                                </table></td>
                            </tr>
                        </table></td>
                    </tr>

                    <tr>
                        <td align="center" valign="top">
                            <%@ include file="/includes/bottom.jsp" %>&nbsp;
                        </td>
                    </tr>

                </table>
            </td>
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