<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Q&A 게시판</title>
    <link href="/includes/all.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
</script>

<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
                <%
                        String id_ch = (String)session.getAttribute("G_ID");
                        ResultSet rs_ch = null;
                        Statement stmt_ch=con.createStatement();
                        String strSQL_ch="SELECT seller_id FROM seller WHERE seller_id='"+ id_ch +"'";
                        rs_ch=stmt_ch.executeQuery(strSQL_ch);
                        if(rs_ch.next()){
                    %>
            <%@ include file="/includes/seller_top.jsp" %>
                <%
                        }
                        else{
                    %>
            <%@ include file="/includes/top.jsp" %>
                <%
                        }
                    %>
            <tr>
                <td>
                    <img src="/icons/sub_bg.png" width="810"/>
                </td>
            </tr>
            <tr>
                <td align="center" valign="top">
                    <table width="800" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="547" height="45" align="left" class="new_tit">Q&A 게시판</td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left" valign="top">
                                <table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
                                    <tr>
                                        <td width="5%" align="center" bgcolor="#EEEEEE">공개</td>
                                        <td width="7%" align="center" bgcolor="#EEEEEE">구분</td>
                                        <td width="45%" align="center" bgcolor="#EEEEEE">제목</td>
                                        <td width="10%" align="center" bgcolor="#EEEEEE">작성자</td>
                                    </tr>
                                    <%

                                        ResultSet rs = null, rs2 = null, rs3= null;
                                        Statement stmt = null, stmt2 = null;

                                        try
                                        {
                                            String strPageNum = request.getParameter("PageNum");   //pageNum
                                            String product_id = request.getParameter("product_id");

                                            if (strPageNum == null) { //받은 페이지 번호가 없다면 1 page
                                                strPageNum = "1";
                                            }

                                            int currentPage = Integer.parseInt(strPageNum);         // 현재 페이지
                                            int pageSize   = 10;                                    // 1 page에 10개씩 출력

                                            stmt = con.createStatement();
                                            stmt2 = con.createStatement();

                                            String strSQL = "select * from qna where product_id='" + product_id + "'";
                                            rs2 = stmt.executeQuery(strSQL);

                                            int totalRecords   = 0;   // ResultSet 객체 내의 레코드 수를 저장하기 위한 변수

                                            //rs2.next();               // 첫번째 레코드로 이동
                                            if (rs2.next() == false ){   // 만약 테이블에 데이터가 없다면
                                    %>
                                    <TR>
                                        <TD colspan=5><center>등록된 게시글이 없습니다</center></TD>
                                    </TR>
                                    <%
                                    }
                                    else
                                    {
                                        strSQL = "SELECT qna_id, lock_yn, qna_title, writer, qna_seq FROM qna  WHERE product_id='" + product_id +"'";
                                        strSQL = strSQL  + " ORDER BY qna_group DESC, qna_seq asc Limit ";
                                        strSQL = strSQL + (currentPage-1)*pageSize + "," + pageSize;


                                        rs = stmt.executeQuery(strSQL);         // 현재 페이지에 출력할 회원만 select

//        int pageSize_temp = pageSize;         // 현재 표시될 라인을 하나씩 줄임
                                        int pageSize_temp = pageSize;
                                        while(rs.next()&& pageSize_temp > 0){

                                            int qna_id               = rs.getInt("qna_id");
                                            int qna_seq               = rs.getInt("qna_seq");
                                            String lock_yn   = rs.getString("lock_yn");
                                            String qna_title      = rs.getString("qna_title");
                                            String writer      = rs.getString("writer");

                                    %>
                                    <TR>
                                        <% if (lock_yn.equals("1"))
                                        {
                                        %>
                                        <td align="center" bgcolor="#FFFFFF"><IMG SRC="/icons/lock.png" height=20 width=20></td>

                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td align="center" bgcolor="#FFFFFF"><IMG SRC="/icons/unlock.png" height=20 width=20></td>
                                        <%
                                            }
                                        %>
                                        <% if (qna_seq == 0)
                                        {
                                        %>
                                        <TD ALIGN = "center" bgcolor="#FFFFFF">[질문]</TD>

                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td align="center" bgcolor="#FFFFFF"><IMG SRC="/icons/reply.png" height=20 width=20></td>
                                        <%
                                            }
                                        %>
                                        <td  ALIGN = "center" bgcolor="#FFFFFF">  <a href="qna_view.jsp?qna_id=<%= qna_id %>"><%= qna_title %></a></TD>
                                        <TD ALIGN = "center" bgcolor="#FFFFFF"><%= writer      %></TD>
                                    </TR>
                                    <%
                                                pageSize_temp = pageSize_temp - 1;      // 현재 표시될 라인을 하나씩 줄임

                                            } // while(rs.next() && pageSize_temp > 0) end

                                        } // if (rs2.next() == false) else end
                                    %>
                                    <td colspan="7" align="center" valign="top" bgcolor="#FFFFFF">
                                        <table>
                                            <tr>
                                                <td><a href="./goodsdetail.jsp?product_id=<%= product_id %>">[제품 상세보기]           </a></td>
                                    <%
                                        ResultSet rs5 = null;
                                        Statement stmt5 = con.createStatement();
                                        String SQL = "SELECT seller_id FROM seller WHERE seller_id='"+ id_ch +"'";
                                        rs5=stmt5.executeQuery(SQL);
                                        if(!rs5.next()){
                                    %>
                                                <td><a href="./qna_write.jsp?product_id=<%= product_id %>">            [글쓰기]  </a></td>
                                    <%
                                        }
                                    %>
                                            </tr>
                                        </table>
                                    </td>
                                    <tr>
                                        <td colspan = 7 ALIGN = "center" bgcolor="#FFFFFF">
                                            <%

                                                ResultSet rs_page = null;
                                                Statement stmt_page=con.createStatement();
                                                String total = "SELECT count(*) cnt FROM qna where product_id ='"+product_id+"'"; //11
                                                rs_page = stmt_page.executeQuery(total);
                                                rs_page.next();
                                                totalRecords = rs_page.getInt(1);
                                                int Totpages = 0;
                                                int intR = totalRecords % pageSize;
                                                if (intR == 0){
                                                    Totpages = totalRecords / pageSize;
                                                }
                                                else{
                                                    Totpages = totalRecords / pageSize + 1;          // 나머지가 0 보다 크면 총 페이지수는 몫 + 1
                                                }

                                                int intGrpSize  = 10;                           // 그룹 당 페이지 수 설정
                                                int currentGrp  = 0;                           // 현 그룹 No.

                                                intR                  = currentPage % intGrpSize;
                                                if   (intR == 0) {
                                                    currentGrp      = currentPage / intGrpSize;
                                                }
                                                else
                                                {
                                                    currentGrp   = currentPage / intGrpSize + 1;
                                                }

                                                int intGrpStartPage   = (currentGrp   - 1) * intGrpSize + 1;   // 현 그룹 시작 페이지
                                                int intGrpEndPage      =  currentGrp * intGrpSize;                     // 현 그룹   끝 페이지
                                                if (intGrpEndPage > Totpages){
                                                    intGrpEndPage         = Totpages;
                                                }
                                                if (currentGrp > 1){
                                            %>
                                            <A href="qna_list.jsp?product_id=<%=product_id%>&PageNum=<%= intGrpStartPage - 1 %>">이전</A>
                                            <%
                                                }

                                                int   intGrpPageCount      = intGrpSize;                        // 그룹 당 페이지 수
                                                int intIndex          = intGrpStartPage;               // 현 그룹 시작 페이지

                                                while (intGrpPageCount > 0 && intIndex <= intGrpEndPage){
                                            %>
                                            <A href="qna_list.jsp?product_id=<%=product_id%>&PageNum=<%= intIndex %>">[<%= intIndex %>]</A>
                                            <%
                                                    intIndex = intIndex + 1;
                                                    intGrpPageCount    = intGrpPageCount    - 1;
                                                }
                                                if (intIndex <= Totpages){
                                            %>
                                            <A href="qna_list.jsp?product_id=<%=product_id%>&PageNum=<%= intIndex %>">다음</A>
                                            <%
                                                }
                                            %>
                                        </td>
                                    </tr>


                                </TABLE><br><br>


                                    <%



    } // try end

    catch(SQLException e1){
        out.println(e1.getMessage());
    } // catch SQLException end

    catch(Exception e2){
        e2.printStackTrace();
    } // catch Exception end

    finally{
        if (stmt != null) stmt.close();
        if (rs   != null) rs.close();
        if (rs2  != null) rs2.close();
        if (con  != null) con.close();
    } // finally end
%>
</BODY>
</html>