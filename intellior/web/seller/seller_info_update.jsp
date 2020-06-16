<%@ page language="java" import="java.util.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
    <TITLE>상품정보변경</TITLE>
    <link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<script language=javascript>
    function valid_check()
    {

        document.seller_update_form.action = "seller_info_update_ok.jsp";
        document.seller_update_form.submit();
    }


</script>

<%

    ResultSet rs = null, rs2 = null, rs3 = null;
    Statement stmt = con.createStatement();

    try
    {

        String seller_id			=	(String)session.getAttribute("G_ID");
        String strSQL = "SELECT * FROM seller where seller_id ='" + seller_id + "'";
        rs = stmt.executeQuery(strSQL);

        if (rs.next()){
            String seller_nm = rs.getString("seller_name");
            String seller_address = rs.getString("seller_address");
            String seller_email = rs.getString("seller_email");
            String seller_phone = rs.getString("seller_phone");


%>
<BODY>
<FORM NAME = "seller_update_form" METHOD = "post" >
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" valign="top">
                <table width="815" border="0" cellspacing="0" cellpadding="0">
                    <%@ include file="/includes/seller_top.jsp" %>
                    <tr>
                        <td>
                            <img src="/icons/sub_bg.png" width="810"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="547" height="45" align="left" class="new_tit">회원정보변경</td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
                                        <tr>
                                            <td width="24%" align="left" bgcolor="#EEEEEE">판매자이름</td>
                                            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "20" MAXLENGTH = "20" NAME = "seller_nm" VALUE=<%= seller_nm %>></td>
                                        </tr>
                                        <tr>
                                            <td width="24%" align="left" bgcolor="#EEEEEE">주소</td>
                                            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "seller_address" VALUE=<%= seller_address %>></td>
                                        </tr>
                                        <tr>
                                            <td width="24%" align="left" bgcolor="#EEEEEE">email</td>
                                            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "seller_email"  VALUE=<%= seller_email %> ></td>
                                        </tr>
                                        <tr>
                                            <td width="24%" align="left" bgcolor="#EEEEEE">전화번호</td>
                                            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "seller_phone"  VALUE=<%= seller_phone %> ></td>
                                        </tr>

                                        <tr>
                                            <td colspan=2 align=center  bgcolor="#FFFFFF">
                                                <INPUT TYPE = "button" VALUE = "변경" onclick="valid_check()"> </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</FORM>
</BODY>
<%
        }

    } //try end

    catch(SQLException e1){
        out.println(e1.getMessage());
    } // catch SQLException end

    catch(Exception e2){
        e2.printStackTrace();
    } // catch Exception end

    finally{
        if (stmt  != null) stmt.close();
        if (rs    != null) rs.close();
        if (rs2   != null) rs2.close();
        if (rs3   != null) rs3.close();
        if (con   != null) con.close();
    } // finally end
%>
</HTML>