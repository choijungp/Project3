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
                    <td height="239" align="center" valign="top">
                        <table width="800" border="0" cellspacing="0" cellpadding="0"><!- table32>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit"><a href="#">회원정보확인</a></td>
                            </tr>
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
                                <td height="50" align="center"  class="new_tit"><%=user_nm%> 님의 정보</td>
                            </tr>
                            <tr>

                                <td height="50" align="center" colspan="7" class="new_tit">ID : <%=user_id%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">주소 : <%=user_address%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">이메일 : <%=user_email%></td>
                            </tr>
                            <tr>
                                <td height="50" align="center" colspan="7" class="new_tit">전화번호 : <%=user_phone%></td>
                            </tr>

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