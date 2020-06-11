<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<html>
<%
    String current_id = (String)session.getAttribute("G_ID");
    if ( current_id == null)
    {
        out.print("<script type=text/javascript>");
        out.print("alert('로그인 후 이용할 수 있습니다.');");
        out.print("location.href = 'index.jsp';");
        out.print("</script>");
    }
%>
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
                    <td height="239" align="center" valign="top">
                        <table width="800" border="0" cellspacing="0" cellpadding="0"><!- table32>
                            <tr>
                                <td height="120" background="${pageContext.request.contextPath}/icons/sub_bg.png">&nbsp;</td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">- 마이페이지 -</td>
                            </tr>
                            <tr>
                                <td width="200" align="center" valign="top">
                                    <table width="190" border="0" cellspacing="0" cellpadding="0"><!- table4>

                                        <tr>
                                            <td height="50" align="center" colspan="7" class="new_tit"><a href="user_Info.jsp">회원정보확인</a></td>
                                        </tr>

                                        <tr>
                                            <td height="50" align="center" colspan="7" class="new_tit"><a href="goodsCart.jsp">장바구니 확인</a></td>
                                        </tr>
                                        <tr>
                                            <td height="50" align="center" colspan="7" class="new_tit"><a href="user_orderList.jsp ">전체주문내역</a></td>
                                        </tr>
                                    </table>
                                </td>

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