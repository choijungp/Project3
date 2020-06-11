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
                <%@ include file="/includes/admin_top.jsp" %>
                <tr>
                    <td height="120" background="/icons/sub_bg.png">&nbsp;</td>
                </tr>
            </table>
    <tr>
        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="547" height="45" align="left" class="new_tit">판매자 조회, 삭제</td>
                <td width="253" align="right">ADMIN < 판매자 조회, 삭제</td>
            </tr>
            <tr>
                <td colspan="1" align="center" valign="top"><table width="100%" align="center" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
                    <FORM NAME = deleteform2 ACTION = "admin_deleteSeller.jsp" METHOD = POST>
                    <tr>
                        <td width="20%" align="center" bgcolor="#EEEEEE">판매자 id</td>
                        <td width="10%" align="center" bgcolor="#EEEEEE">판매자 이름</td>
                        <td width="20%" align="center" bgcolor="#EEEEEE">판매자 email</td></td>
                        <td width="20%" align="center" bgcolor="#EEEEEE">판매자 전화번호</td>
                        <td width="20%" align="center" bgcolor="#EEEEEE">선택</td>

                    </tr>

                    <%
                        ResultSet rs			= null;
                        Statement stmt		= con.createStatement();

                        String strSQL = "select * from seller  r";

                        String seller_id = "";
                        String seller_nm = "";
                        String seller_email ="";
                        String seller_phone = "";

                        rs = stmt.executeQuery(strSQL);

                        while(rs.next()) {

                            seller_id = rs.getString("seller_id");
                            seller_nm = rs.getString("seller_address"); //수정필요
                            seller_email = rs.getString("seller_email");
                            seller_phone = rs.getString("seller_phone");

                    %>

                    <TR>
                        <TD align="center" bgcolor="#FFFFFF">
                            <%= seller_id	%>
                        </TD>
                        <TD align="center" bgcolor="#FFFFFF">
                            <%= seller_nm	%>
                        </TD>
                        <TD align="center" bgcolor="#FFFFFF">
                            <%= seller_email	%>
                        </TD>
                        <TD align="center" bgcolor="#FFFFFF">
                            <%= seller_phone	%>
                        </TD>
                        <TD align="center" bgcolor="#FFFFFF">
                            <input type ="checkbox" name="check_seller_id" value="<%= seller_id%>">
                        </TD>
                    </TR>
                    <% }
                    %>
                </table></td>
            <tr>
                <td height="50" align="center">
                    <input type="submit" id="button" value="판매자삭제" onclick="return confirm('정말 선택한 판매자를 삭제하시겠습니까?')"/>
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