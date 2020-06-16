<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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
                <%@ include file="/includes/admin_top.jsp" %>
                <tr>
                    <td>
                        <img src="/icons/sub_bg.png" width="810"/>
                    </td>
                </tr>
                <tr>
                    <td height="239" align="center" valign="top">
                        <table width="800" border="0" cellspacing="0" cellpadding="0"><!- table32>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">- 마이페이지 -</td>
                            </tr>
                            <tr>
                                <td width="200" align="center" valign="top">
                                    <table width="190" border="0" cellspacing="0" cellpadding="0"><!- table4>

                                        <tr>
                                            <td height="50" align="center" colspan="7" class="new_tit"><a href="admin_userList.jsp">사용자 조회</a></td>
                                        </tr>
                                        <tr>
                                            <td height="50" align="center" colspan="7" class="new_tit"><a href="admin_sellerList.jsp">판매자 조회</a></td>
                                        </tr>
                                    </table>
                                </td>

                        </table>
                    </td>
                </tr>

            </table>
</table>
</body>
</html>