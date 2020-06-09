<%@ page language="java" contentType="text/html; charset=utf-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<link href="/includes/all.css" rel="stylesheet" type="text/css"/>
<HTML>
<HEAD>
    <script language=javascript>
        window.valid_check = function () {
            if (document.frm1.userid.value == "") {
                alert("아이디를 입력하여 주시기 바랍니다.");
                document.frm1.userid.focus();
                return false;
            }

            if (document.frm1.userid.value.length <= 3) {
                alert("아이디는 4자 이상입니다.");
                document.frm1.userid.focus();
                return false;
            }

            if (document.frm1.usernm.value == "") {
                alert("이름을 입력하여 주시기 바랍니다.");
                document.frm1.usernm.focus();
                return false;
            }

            if (document.frm1.passwd.value == "") {
                alert("비밀번호를 입력하여 주시기 바랍니다.");
                document.frm1.passwd.focus();
                return false;
            }

            if (document.frm1.passwd.value != document.frm1.passwd2.value) {
                alert("비밀번호를 확인하여 주시기 바랍니다.");
                document.frm1.passwd.focus();
                return false;
            }
            document.frm1.submit();
        }

        function KeyNumber() {
            var event_key = event.keyCode;
            if ((event_key < 48 || event_key > 57) && (event_key != 8 && event_key != 46)) {
                event.returnValue = false;
            }
        }

        function cursor_move(a) {
            if (a == 1) {
                var str = document.frm1.jumin1.value.length;
                if (str == 6)
                    document.frm1.jumin2.focus();
            } else if (a == 2) {
                var str = document.frm1.tel2.value.length;
                if (str == 4)
                    document.frm1.tel3.focus();
            }
        }

        function check_id() {
            var JSPName = "id_check.jsp";
            var browsing_window = window.open(JSPName, "_idcheck", "height=150, width=520, " +
                "menubar=no, diretories=no, resizable=no, status=yes, scrollbars=no, toolbar=no");
            browsing_window.focus();
        }
    </script>

    <TITLE>회원 가입</TITLE>
</HEAD>
<BODY>
<FORM NAME="frm1" ACTION="mem_join_ok.jsp" METHOD="post">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" valign="top">
                <table width="815" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <img src="/icons/sub_bg.png" width="810"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="top">
                            <table width="800" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="547" height="45" align="center" class="new_tit">회원 가입</td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <table width="50%" border="0" cellspacing="0" cellpadding="7" bgcolor="#D7D7D7">
                                            <TR>
                                                <TD ALIGN="center" bgcolor="#FFFFFF" colspan="2">
                                                    구매자 <INPUT TYPE="radio" NAME="uos" VALUE="user">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;판매자
                                                    <INPUT TYPE="radio" NAME="uos" VALUE="seller">
                                                </TD>
                                            </TR>
                                            <TR>
                                                <TD WIDTH="24%" ALIGN="left" bgcolor="#FFFFFF">이름</TD>
                                                <TD WIDTH="76%" ALIGN="left" bgcolor="#FFFFFF">
                                                    <INPUT TYPE="text" SIZE="15" MAXLENGTH="10" NAME="usernm"
                                                           class="info_text">
                                                </TD>
                                            </TR>
                                            <tr>
                                                <td width="24%" align="left" bgcolor="#FFFFFF">아이디</td>
                                                <td width="76%" align="left" bgcolor="#FFFFFF">
                                                    <INPUT TYPE="text" SIZE="15" MAXLENGTH="10" NAME="userid" readonly
                                                           class="info_text">
                                                    <INPUT TYPE="button" VALUE="중복확인" onclick="check_id()"
                                                           onmouseover="this.style.cursor='hand';" class="id_button">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="24%" align="left" bgcolor="#FFFFFF">비밀번호</td>
                                                <td width="76%" align="left" bgcolor="#FFFFFF">
                                                    <INPUT TYPE="password" SIZE="15" MAXLENGTH="10" NAME="passwd"
                                                           class="info_text">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="24%" align="left" bgcolor="#FFFFFF">비밀번호</td>
                                                <td width="76%" align="left" bgcolor="#FFFFFF">
                                                    <INPUT TYPE="password" SIZE="15" MAXLENGTH="10" NAME="passwd2"
                                                           class="info_text">
                                                </td>
                                            </tr>
                                            <TR>
                                                <TD WIDTH="24%" ALIGN="left" bgcolor="#FFFFFF">번호</TD>
                                                <TD WIDTH="76%" ALIGN="left" bgcolor="#FFFFFF">
                                                    <SELECT NAME="tel1" class="box_select">
                                                        <OPTION VALUE="1">010</OPTION>
                                                        <OPTION VALUE="2">011</OPTION>
                                                        <OPTION VALUE="3">016</OPTION>
                                                        <OPTION VALUE="4">017</OPTION>
                                                        <OPTION VALUE="5">018</OPTION>
                                                        <OPTION VALUE="6">019</OPTION>
                                                    </SELECT>
                                                    -
                                                    <INPUT TYPE="text" SIZE="4" MAXLENGTH="4" NAME="tel2"
                                                           onKeyDown="KeyNumber()" onKeyup="cursor_move(2)"
                                                           class="info_text"> -
                                                    <INPUT TYPE="text" SIZE="4" MAXLENGTH="4" NAME="tel3"
                                                           onKeyDown="KeyNumber()" class="info_text">
                                                </TD>
                                            </TR>
                                            <TR>
                                                <TD WIDTH="24%" ALIGN="left" bgcolor="#FFFFFF">e-mail</TD>
                                                <TD WIDTH="76%" ALIGN="left" bgcolor="#FFFFFF">
                                                    <INPUT TYPE="text" SIZE="30" MAXLENGTH="30" NAME="mail"
                                                           class="info_text">
                                                </TD>
                                            </TR>
                                            <TR>
                                                <TD WIDTH="24%" ALIGN="left" bgcolor="#FFFFFF">주소</TD>
                                                <TD WIDTH="76%" ALIGN="left" bgcolor="#FFFFFF">
                                                    <INPUT TYPE="text" SIZE="30" MAXLENGTH="30" NAME="addr1"
                                                           class="info_text">
                                                    <INPUT TYPE="text" SIZE="30" MAXLENGTH="30" NAME="addr2"
                                                           class="info_text">
                                                </TD>
                                            </TR>
                                            <tr>
                                                <td bgcolor="#FFFFFF"><br></td>
                                                <td bgcolor="#FFFFFF"><br></td>
                                            </tr>
                                            <tr>
                                                <td colspan=2 align=center bgcolor="#FFFFFF">
                                                    <INPUT TYPE="button" VALUE="가입" onclick="valid_check()"
                                                           class="submit_button"
                                                           onmouseover="this.style.cursor='hand';">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</FORM>
</BODY>
</HTML>