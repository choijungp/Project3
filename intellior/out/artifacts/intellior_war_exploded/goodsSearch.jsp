<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<% /* Get & Save information about search */
    String category=request.getParameter("search_key"); //search criteria
    if(category==null) category="";
    String in_search_value=request.getParameter("search_value"); //search word
    if(in_search_value==null) in_search_value="";
%>
<HTML>
<HEAD>
    <TITLE> 상품 진열</TITLE>
    <link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" valign="top">
            <table width="815" border="0" cellspacing="0" cellpadding="0">
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
                    <%
                        String strPageNum = request.getParameter("PageNum"); // 선택된 페이지 번호 참조
                        if (strPageNum == null) {
                            strPageNum = "1";
                        }

                        int currentPage = Integer.parseInt(strPageNum);         // 현재 페이지

                        int pageSize   = 6;

                        ResultSet rs = null, rs2 = null;

                        Statement stmt  = con.createStatement();

                        String SQL = "select count(*) from product";

                        if(!category.equals(""))
                            SQL = SQL +" where category ='" + category + "'";
                        if (!in_search_value.equals("")) {
                            if(category.equals(""))
                                SQL = SQL + " where product_name like '%" + in_search_value + "%'";
                            else
                                SQL = SQL + " and product_name like '%" + in_search_value + "%'";
                        }
                        rs2 = stmt.executeQuery(SQL);
                        rs2.next();

                        int totalRecords   = 0;  // ResultSet 객체 내의 레코드 수를 저장하기 위한 변수
                        if (rs2.getInt(1) == 0){  // 만약 테이블에 아무것도 없다면
                    %>
                    <TD colspan=7><center>"<%=in_search_value%>"의 검색결과가 없습니다.</center></TD>
                    <%
                    }
                    else
                    {
                    %>
                    <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
                        <%
                            totalRecords = rs2.getInt(1);

                            //SQL = "select top " + pageSize ;
                            SQL = "select product_name, product_price, product_id, product_thumnail from product";

                            if(!category.equals(""))
                                SQL = SQL +" where category ='" + category + "'";
                            if (!in_search_value.equals("")) {
                                if(category.equals(""))
                                    SQL = SQL + " where product_name like '%" + in_search_value + "%'";
                                else
                                    SQL = SQL + " and product_name like '%" + in_search_value + "%'";
                            }

                            rs = stmt.executeQuery(SQL);   // 현재 페이지에 출력할 회원만 select

                            int pageSize_temp = pageSize;         // 현재 표시될 라인을 하나씩 줄임

                            int cnt = 0;      //
                            while(rs.next() && pageSize_temp > 0 ){

                                cnt ++;

                                String n_product_name      = rs.getString("product_name");
                                String n_product_id      = rs.getString("product_id");

                                int n_product_price         = rs.getInt("product_price");
                                String n_product_thumnail   = rs.getString("product_thumnail");

                                if ( cnt == 1) {
                        %>
                        <tr>
                            <td height="45" align="left" class="new_tit">"<%= in_search_value %>"의 검색결과 </td>
                            <td height="45" colspan="3" align="right">검색 결과</td>
                        </tr>
                        <tr>
                            <%
                                }
                            %>
                            <TD>
                                <TABLE border = "1" cellspacing = "1" cellpadding = "2" width = "200">
                                    <TR>
                                        <TD>
                                            <a href="goodsdetail.jsp?product_id=<%= n_product_id %>"><img src="/images/<%= n_product_thumnail %>" height=200 width =200></a>
                                        </TD>
                                    </TR>
                                    <TR>
                                        <TD align=center>
                                            <%= n_product_name %>
                                        </TD>
                                    </TR>
                                    <TR>
                                        <TD align=center>
                                            <%
                                                DecimalFormat df = new DecimalFormat("###,###,##0");
                                                out.println(df.format(n_product_price));
                                            %>
                                            원
                                        </TD>
                                    </TR>
                                </TABLE>
                            </TD>

                            <%
                                    pageSize_temp = pageSize_temp - 1;      // 현재 표시될 라인을 하나씩 줄임

                                    if (cnt == 3)
                                        out.print("</TR><TR>");
                                }
                            %>
                        </tr>
                    </table></td>
                    <%
                        }
                    %>

                </tr>
                <tr>
                    <td colspan=4 align=center>
                        <%
                            // 총 페이지 수 계산
                            int intTotPages   = 0;
                            int intR      = totalRecords % pageSize;
                            if   (intR == 0) {
                                intTotPages = totalRecords / pageSize;
                            }
                            else
                            {
                                intTotPages = totalRecords / pageSize + 1;          // 나머지가 0 보다 크면 총 페이지수는 몫 + 1
                            }

                            int intGrpSize  = 1;                           // 그룹 당 페이지 수 설정
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
                            if (intGrpEndPage > intTotPages){
                                intGrpEndPage         = intTotPages;
                            }
                            if (currentGrp > 1){
                        %>
                        [<A href="goodsdisplay.jsp?category=<%=category%>&PageNum=<%= intGrpStartPage - 1 %>">이전</A>]
                        <%
                            }

                            int   intGrpPageCount      = intGrpSize;                        // 그룹 당 페이지 수
                            int intIndex               = intGrpStartPage;               // 현 그룹 시작 페이지

                            while (intGrpPageCount > 0 && intIndex <= intGrpEndPage){
                        %>
                        [<A href="goodsdisplay.jsp?category=<%=category%>&PageNum=<%= intIndex %>&search_value=<%=in_search_value%>"><%= intIndex %></A>] &nbsp;
                        <%
                                intIndex = intIndex + 1;
                                intGrpPageCount    = intGrpPageCount    - 1;
                            }

                            if (intIndex <= intTotPages){
                        %>
                        [<A href="goodsdisplay.jsp?category=<%=category%>&PageNum=<%= intIndex %>">다음</A>]
                        <%
                            }
                        %>
                    </td >
                </tr>
                <%@ include file="/includes/bottom.jsp" %>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
<%
    if (stmt  != null) stmt.close();
    if (rs    != null) rs.close();
    if (rs2   != null) rs2.close();
    if (con   != null) con.close();
%>
</BODY>