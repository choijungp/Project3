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

        document.user_update_form.action = "user_info_update_ok.jsp";
        document.user_update_form.submit();
    }

    function KeyNumber()
    {
        var event_key = event.keyCode;

        if((event_key < 48 || event_key > 57) && (event_key != 8 && event_key != 46))
        {
            event.returnValue=false;
        }
    }


</script>

<%

    ResultSet rs = null, rs2 = null, rs3 = null;
    Statement stmt = con.createStatement();

    try
    {

        String user_id			=	(String)session.getAttribute("G_ID");
        String strSQL = "SELECT * FROM user where user_id ='" + user_id + "'";
        rs = stmt.executeQuery(strSQL);

        if (rs.next()){
            String user_nm = rs.getString("user_name");
            String user_address = rs.getString("user_address");
            String user_email = rs.getString("user_email");
            String user_phone = rs.getString("user_phone");


%>
<BODY>
<FORM NAME = "user_update_form" METHOD = "post" enctype = "multipart/form-data">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" valign="top">
                <table width="815" border="0" cellspacing="0" cellpadding="0">
                    <%@ include file="/includes/top.jsp" %>
                    <tr>
                        <td height="80" background="/icons/sub_bg.png">&nbsp;</td>
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
                                            <td width="24%" align="left" bgcolor="#EEEEEE">회원이름</td>
                                            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "20" MAXLENGTH = "20" NAME = "user_nm" VALUE=<%= user_nm %> readonly></td>
                                        </tr>
                                        <tr>
                                            <td width="24%" align="left" bgcolor="#EEEEEE">주소</td>
                                            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "30" MAXLENGTH = "50" NAME = "user_address" VALUE=<%= user_address %>></td>
                                        </tr>
                                        <tr>
                                            <td width="24%" align="left" bgcolor="#EEEEEE">email</td>
                                            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "20" MAXLENGTH = "50" NAME = "user_email"  VALUE=<%= user_email %> ></td>
                                        </tr>
                                        <tr>
                                            <td width="24%" align="left" bgcolor="#EEEEEE">전화번호</td>
                                            <td width="76%" align="left" bgcolor="#FFFFFF"><INPUT TYPE = "text" SIZE = "20" MAXLENGTH = "20" NAME = "user_phone"  VALUE=<%= user_phone %> ></td>
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
        else
        {
            out.print("등록된 상품정보가 없습니다.");
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