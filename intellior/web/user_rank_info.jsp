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
<FORM NAME="update_user_info" ACTION="user_info_update.jsp" METHOD="post">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" valign="top">
                <table width="815" border="0" cellspacing="0" cellpadding="0">
                    <%@ include file="/includes/top.jsp" %>
                    <tr>
                        <td>
                            <img src="/icons/sub_bg.png" width="810"/>
                        </td>
                    </tr>
                    <tr>
                        <td height="50" align="center" colspan="7" class="new_tit">회원 등급 안내</td>
                    </tr>
                    <tr>
                        <td>
                            <img src="/icons/user_rank_info.PNG" />
                        </td>
                    </tr>

                    <%@ include file="/includes/bottom.jsp" %>
                </table>
            </td>
        </tr>
    </table>
</FORM>
</body>
</html>