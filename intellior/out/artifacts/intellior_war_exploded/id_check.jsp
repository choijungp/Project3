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
            alert("���̵� �Է��� �ּ���");
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
        <P align=center">����ϰ����ϴ� ID�� �Է��ϰ� �˻���ư�� ��������.</P>
        <FORM NAME="form1" ACTION="id_check.jsp" METHOD="POST">
            <TABLE WIDTH="200">
                <TR>
                    <TD WIDTH="100"><INPUT TYPE="text" NAME="id" SIZE="20" MAXLENGTH="10" VALUE="<%=id%>" class="info_text"></TD>
                    <TD WIDTH="40"><INPUT TYPE="button" VALUE="�˻�" onclick="id_search()" class="id_button" onmouseover="this.style.cursor='hand';"></TD>
                </TR>
            </TABLE>
        </FORM>
        <%
            if(id!=""&&fnd==false)
            {
        %>
        ��� ������ ID �Դϴ�.<P>
        Ȯ���� �����ø� ȸ������ ȭ������ ���ư��ϴ�.
        <INPUT TYPE="button" VALUE="Ȯ��" onmouseover="this.style.cursor='hand';" onclick="javascript:id_ok('<%=id%>')" class="id_button">
        <%
            }
            else if(id!=""&&fnd==true)
            {
        %>
        �̹� ������� ���̵��Դϴ�.
        <%
            }
        %>
    </CENTER>
</body>
</html>
