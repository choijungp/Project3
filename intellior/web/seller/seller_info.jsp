<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>쇼핑몰 관리자 페이지</title>

    <link href="/includes/all.css" rel="stylesheet" type="text/css" />

</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" valign="top">
            <table width="815" border="0" cellspacing="0" cellpadding="0">
                <%@ include file="/includes/seller_top.jsp" %>
                <tr>
                    <td height="80" background="/icons/sub_bg.png">&nbsp;</td>
                </tr>
                <tr>
                    <td height="239" align="center" valign="top">
                        <table width="800" border="0" cellspacing="0" cellpadding="0"><!- table32>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit"><a href="#">판매자정보확인</a></td>
                            </tr>
                            <%
                                String sellerid	=	(String)session.getAttribute("G_ID");
                                ResultSet rs = null;
                                DecimalFormat df	= new DecimalFormat("###,###,##0");
                                String seller_address = null;
                                String seller_name = null;
                                String seller_email = null;
                                String seller_phone = null;
                                Statement stmt  = con.createStatement();
                                String SQL = "select * from seller ";
                                SQL = SQL + " where seller_id = '" + sellerid + "'    ";
                                rs = stmt.executeQuery(SQL);
                                while(rs.next()){

                                    seller_address		= rs.getString("seller_address");
                                    seller_name	= rs.getString("seller_name");
                                    seller_email			= rs.getString("seller_email");
                                    seller_phone			= rs.getString("seller_phone");
                                }
                            %>
                            <tr>
                                <td height="50" align="center"  class="new_tit"><%=seller_name%> 님의 정보</td>
                            </tr>
                            <tr>

                                <td height="50" align="center" colspan="7" class="new_tit">ID : <%=sellerid%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">주소 : <%=seller_address%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">이메일 : <%=seller_email%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">전화번호 : <%=seller_phone%></td>
                            </tr>

                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>