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
        <td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
            <%@ include file="/includes/admin_top.jsp" %>
            <tr>
                <td height="80" background="/icons/sub_bg.png">&nbsp;</td>
            </tr>
            <tr>
                <td width="547" height="45" align="left" class="new_tit">사용자 조회, 삭제</td>
            </tr>
            <tr>
                <FORM NAME = deleteform ACTION = "admin_deleteUser.jsp" METHOD = POST>
                    <td colspan="1" align="left" valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">

                        <tr>
                            <td width="20%" align="center" bgcolor="#EEEEEE">고객 id</td>
                            <td width="10%" align="center" bgcolor="#EEEEEE">고객 이름</td>
                            <td width="20%" align="center" bgcolor="#EEEEEE">고객 email</td></td>
                            <td width="20%" align="center" bgcolor="#EEEEEE">고객 전화번호</td>
                            <td width="10%" align="center" bgcolor="#EEEEEE">선택</td>

                        </tr>

                        <%
                            ResultSet rs   = null;
                            Statement stmt      = con.createStatement();

                            String strSQL = "select * from intelior.user";
                            String user_id = "";
                            String user_nm = "";
                            int product_price = 0;
                            String user_email ="";
                            String user_phone = "";

                            rs = stmt.executeQuery(strSQL);

                            while(rs.next()) {
                                user_id = rs.getString("user_id");
                                user_nm = rs.getString("user_name");
                                user_email = rs.getString("user_email");
                                user_phone = rs.getString("user_phone");

                        %>

                            <TR>
                                <TD align="center" bgcolor="#FFFFFF">
                                    <%= user_id   %>
                                </TD>
                                <TD align="center" bgcolor="#FFFFFF">
                                    <%= user_nm   %>
                                </TD>
                                <TD align="center" bgcolor="#FFFFFF">
                                    <%= user_email   %>
                                </TD>
                                <TD align="center" bgcolor="#FFFFFF">
                                    <%= user_phone   %>
                                </TD>
                                <TD align="center" bgcolor="#FFFFFF">
                                    <input type ="checkbox" name="check_id" value="<%= user_id   %>">
                                </TD>
                            </TR>

                        <% }
                        %>
                    </table></td>

            <tr>
                <td height="50" align="center">
                    <input type="submit" id="button2" value="회원삭제" onclick="return confirm('정말 선택한 회원을 삭제하시겠습니까?')"/>
                </td>
            </tr>
            <tr>
                <%@ include file="/includes/bottom.jsp" %>
            </tr>
            </FORM>
        </table></td>
    </tr>
</table>
</body>
</HTML>