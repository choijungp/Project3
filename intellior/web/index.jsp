<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>인텔리어</title>
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

                    String SQL = "select * from product order by product_id desc";
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
                     int product_id      = rs.getInt("product_id");
                     String product_name      = rs.getString("product_name");

                     int product_price         = rs.getInt("product_price");
                     String product_thumnail   = rs.getString("product_thumnail");
               %>
                                <td width="200" align="center" valign="top">
                                    <table width="190" border="0" cellspacing="0" cellpadding="0"><!- table4>
                                        <tr>
                                            <td align="center"><a href="goodsdetail.jsp?product_id=<%= product_id %>"><img src="/images/<%= product_thumnail %>" width="170" height="170" border="0" /></a></td>
                                        </tr>
                                        <tr>
                                            <td height="50" align="center"><a href="/goodsdetail.jsp?product_id=<%= product_id %>"><%= product_name %><br />
                                                <%
                                                    DecimalFormat df = new DecimalFormat("###,###,##0");
                                                    out.println(df.format(product_price));
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
                     int product_id      = rs2.getInt("product_id");
                     String product_name      = rs2.getString("product_name");

                     int product_price         = rs2.getInt("product_price");
                     String product_thumnail   = rs2.getString("product_thumnail");
               %>
                                <td width="200" align="center" valign="top">
                                    <table width="190" border="0" cellspacing="0" cellpadding="0"><!- table4>
                                        <tr>
                                            <td align="center"><a href="goodsdetail.jsp?product_id=<%= product_id %>"><img src="/images/<%= product_thumnail %>" width="170" height="170" border="0" /></a></td>
                                        </tr>
                                        <tr>
                                            <td height="50" align="center"><a href="/goodsdetail.jsp?product_id=<%= product_id %>"><%= product_name %><br />
                                                <%
                                                    DecimalFormat df = new DecimalFormat("###,###,##0");
                                                    out.println(df.format(product_price));
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