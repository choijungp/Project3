<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*" import="java.sql.*"
pageEncoding="euc-kr"%>
<%request.setCharacterEncoding("euc-kr");%>
<%@ include file = "/includes/dbinfo.jsp" %>
<link href="/includes/all.css" rel="stylesheet" type="text/css" />
<%
    String id=request.getParameter("id");
    boolean fnd=false;

    if(id==null)
        id="";
    else{
        ResultSet rs = null;

        Statement stmt=con.createStatement();
        String strSQL="SELECT user_id FROM user WHERE user_id='"+id+"'";
        rs=stmt.executeQuery(strSQL);

        if(rs.next()) fnd=true;

        stmt.close();
        con.close();
    }
%>
<html>
<head>
    <title>id_check</title>
</head>

<script language="JavaScript">
    function id_search(){
        if(document.form1.value==""){
            alert("아이디를 입력해 주세요");
            document.form1.id.focus();
        }
        else{
            document.form1.submit();
        }
    }
   function id_ok(a) {
        opener.document.frm1.userid.value = a;
       window.close();
    }
</script>

<body>
    <CENTER>
        <BR>
        <P align=center">사용하고자하는 ID를 입력하고 검색버튼을 누르세요.</P>
        <FORM NAME="form1" ACTION="id_check.jsp" METHOD="POST">
            <TABLE WIDTH="200">
                <TR>
                    <TD WIDTH="100"><INPUT TYPE="text" NAME="id" SIZE="20" MAXLENGTH="10" VALUE="<%=id%>" class="info_text"></TD>
                    <TD WIDTH="40"><INPUT TYPE="button" VALUE="검색" onclick="id_search()" class="id_button" onmouseover="this.style.cursor='hand';"></TD>
                </TR>
            </TABLE>
        </FORM>
        <%
            if(id!=""&&fnd==false)
            {
        %>
        사용 가능한 ID 입니다.<P>
        확인을 누르시면 회원가입 화면으로 돌아갑니다.
        <INPUT TYPE="button" VALUE="확인" onmouseover="this.style.cursor='hand';" onclick="javascript:id_ok('<%=id%>')" class="id_button">
        <%
            }
            else if(id!=""&&fnd==true)
            {
        %>
        이미 사용중인 아이디입니다.
        <%
            }
        %>
    </CENTER>
</body>
</html>
