<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>쇼핑몰 모형</title>
    <link href="/includes/all.css" rel="stylesheet" type="text/css" />
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" valign="top">
            <table width="815" border="0" cellspacing="0" cellpadding="0">
                <%@ include file="/includes/top.jsp" %>
                <tr>
                    <td height="284"><img src="/icons/main.jpg" width="815" alt="메인" /></td>
                </tr>
                <%
                    ResultSet rs = null;
                    Statement stmt  = con.createStatement();

                    String SQL = "select * from product";
                    rs = stmt.executeQuery(SQL);
                %>
                <tr>
                    <td height="239" align="center" valign="top">
                        <table width="800" border="0" cellspacing="0" cellpadding="0"><!- table32>
                            <tr>
                                <td height="45" align="center" colspan="5" class="new_tit">- New Product -</td>
                            </tr>
                            <tr>
                                    <%
                  int cnt = 0;
                  while (rs.next()){
                     String goodscd      = rs.getString("product_id");
                     String goodsnm      = rs.getString("product_name");

                     int unitprice         = rs.getInt("product_price");
                     String goodsimg1   = rs.getString("product_thumnail");
               %>
                                <td width="200" align="center" valign="top">
                                    <table width="190" border="0" cellspacing="0" cellpadding="0"><!- table4>
                                        <tr>
                                            <td align="center"><a href="goodsdetail.jsp?pgoodscd=<%= goodscd %>"><img src="/images/<%= goodsimg1 %>" width="170" height="170" border="0" /></a></td>
                                        </tr>
                                        <tr>
                                            <td height="50" align="center"><a href="/goodsdetail.jsp?pgoodscd=<%= goodscd %>"><%= goodsnm %><br />
                                                <%
                                                    DecimalFormat df = new DecimalFormat("###,###,##0");
                                                    out.println(df.format(unitprice));
                                                %>
                                                원</a></td>
                                        </tr>
                                    </table>
                                </td>
                                    <%
                  cnt ++;      //

                  if (cnt == 5)
                     out.print("</TR><TR>");
                  }

                  if (cnt != 5)
                     out.print("</TR>");
                  if (stmt  != null) stmt.close();
                  if (rs    != null) rs.close();
               %>
                        </table>
                    </td>
                </tr>
                <%
                    ResultSet rs2 = null;
                    Statement stmt2  = con.createStatement();

                    String SQL2 = "select * from product order by product_view_count DESC";
                    rs2 = stmt2.executeQuery(SQL2);
                %>
                <tr>
                    <td height="239" align="center" valign="top">
                        <table width="800" border="0" cellspacing="0" cellpadding="0"><!- table32>
                            <tr>
                                <td height="45" align="center" colspan="5" class="new_tit">- Best Product -</td>
                            </tr>
                            <tr>
                                    <%
                  int cnt2 = 0;
                  while (rs2.next()){
                     int goodscd      = rs2.getInt("product_id");
                     String goodsnm      = rs2.getString("product_name");

                     int unitprice         = rs2.getInt("product_price");
                     String goodsimg1   = rs2.getString("product_thumnail");
               %>
                                <td width="200" align="center" valign="top">
                                    <table width="190" border="0" cellspacing="0" cellpadding="0"><!- table4>
                                        <tr>
                                            <td align="center"><a href="goodsdetail.jsp?pgoodscd=<%= goodscd %>"><img src="/images/<%= goodsimg1 %>" width="170" height="170" border="0" /></a></td>
                                        </tr>
                                        <tr>
                                            <td height="50" align="center"><a href="/goodsdetail.jsp?pgoodscd=<%= goodscd %>"><%= goodsnm %><br />
                                                <%
                                                    DecimalFormat df = new DecimalFormat("###,###,##0");
                                                    out.println(df.format(unitprice));
                                                %>
                                                원</a></td>
                                        </tr>
                                    </table>
                                </td>
                                    <%
                  cnt2 ++;      //

                  if (cnt2 == 5)
                     out.print("</TR><TR>");
                  }

                  if (cnt2 != 5)
                     out.print("</TR>");
                  if (stmt2  != null) stmt.close();
                  if (rs2    != null) rs.close();
                  if (con   != null) con.close();
               %>
                        </table>
                    </td>
                </tr>
                <%@ include file="/includes/bottom.jsp" %>
            </table>
        </td>
    </tr>
</table>
</body>
</html>