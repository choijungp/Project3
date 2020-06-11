<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<script type="text/javascript">
    function updateChk() {
        document.update_user_info.action = "user_info_update.jsp";
        document.update_user_info.submit();
    }</script>

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
                    <td height="50" align="center" colspan="7" class="new_tit"><a href="#">회원정보확인</a></td>
                </tr>
                <tr>
                    <td height="239" align="center" valign="top">

                        <table width="300" border="0" cellspacing="0" cellpadding="0"><!- table32>

                            <%
                                String user_id			=	(String)session.getAttribute("G_ID");
                                ResultSet rs = null;
                                DecimalFormat df	= new DecimalFormat("###,###,##0");
                                String user_address = null;
                                String user_nm = null;
                                String user_email = null;
                                String user_phone = null;
                                Statement stmt  = con.createStatement();
                                String SQL = "select * from user ";
                                SQL = SQL + " where user_id = '" + user_id + "'    ";
                                rs = stmt.executeQuery(SQL);
                                while(rs.next()){

                                    user_address		= rs.getString("user_address");
                                    user_nm	= rs.getString("user_name");
                                    user_email			= rs.getString("user_email");
                                    user_phone			= rs.getString("user_phone");
                                }
                            %>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">ID </td>
                                <td height="50" align="center" colspan="7" class="new_tit"><%=user_id%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">이름</td>
                                <td height="50" align="center" colspan="7" class="new_tit"><%=user_nm%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">주소</td>
                                <td height="50" align="center" colspan="7" class="new_tit"><%=user_address%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">이메일</td>
                                <td height="50" align="center" colspan="7" class="new_tit"><%=user_email%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">전화번호</td>
                                <td height="50" align="center" colspan="7" class="new_tit"><%=user_phone%></td>
                            </tr>
                        </table>
                    </td>
                <tr>
                    <td height="25" align="center">
                        <input type = "button" id = "button"  value = "정보 변경"  onClick = "updateChk();"/>
                        <input type = "button" id = "button2" value = "회원 탈퇴" />
                    </td>
                </tr>
                </tr>

                <%@ include file="/includes/bottom.jsp" %>
            </table>
        </td>
    </tr>
</table>
</FORM>
</body>
</html>