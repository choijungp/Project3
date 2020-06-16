<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<HEAD>
    <TITLE> 주문 목록</TITLE>
    <link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
            <%@ include file="/includes/top.jsp" %>
            </tr>
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

                    int currentPage = Integer.parseInt(strPageNum);			// 현재 페이지

                    int pageSize	= 6;

                    ResultSet rs = null, rs2 = null;

                    Statement stmt  = con.createStatement();
                    String userid			=	(String)session.getAttribute("G_ID");
                    String cat1cd = request.getParameter("pcat1");

                    String SQL = "select count(*) from intelior.order";
                    SQL = SQL +" where user_id = '" + userid + "'";
                    rs2 = stmt.executeQuery(SQL);

                    int totalRecords	= 0;  // ResultSet 객체 내의 레코드 수를 저장하기 위한 변수
                    if (rs2.next() == false){  // 만약 테이블에 아무것도 없다면
                %>
                <TD colspan=7><center>주문이 없습니다.</center></TD>
            </TR>
            <%
            }
            else
            {
            %>
            <td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
                <%
                    totalRecords = rs2.getInt(1);


                    SQL = "select order_id, a.product_id,user_id,a.seller_id,order_state,order_payment, product_name,product_price ";
                    SQL = SQL  + " from intelior.order a inner join product b on a.product_id = b.product_id ";
                    SQL = SQL +" where user_id = '" + userid + "'";

                    rs = stmt.executeQuery(SQL);	// 현재 페이지에 출력할 회원만 select

                    int pageSize_temp = pageSize;			// 현재 표시될 라인을 하나씩 줄임

                    int cnt = 0;      //
                    while(rs.next() && pageSize_temp > 0 ){

                        cnt ++;

                        int product_id			= rs.getInt("product_id");
                        String seller_id			= rs.getString("seller_id"); //seller_name으로 수정
                        int order_state		= rs.getInt("order_state");
                        int order_id		= rs.getInt("order_id");
                        String order_payment		= rs.getString("order_payment");
                        String product_name		= rs.getString("product_name");
                        int product_price		= rs.getInt("product_price");
                        if ( cnt == 1) {
                %>
                <tr>
                    <td height="45" align="left" class="new_tit">주문목록</td>
                    <td height="45" colspan="3" align="right">HOME &lt; 주문목록</td>
                </tr>
                <tr>
                    <td width="10%" align="center" bgcolor="#EEEEEE">상품이미지</td>
                    <td width="20%" align="center" bgcolor="#EEEEEE">주문번호</td>
                    <td width="20%" align="center" bgcolor="#EEEEEE">상품명</td>
                    <td width="10%" align="center" bgcolor="#EEEEEE">상품가격</td>
                </tr>
                <tr>
                        <%
                        }
                    %>
                <TR>
                    <TD>
                        <a href="index.jsp"><img src="/images/coat.jpg" height=50 width =50></a>
                    </TD>
                    <TD align=center>
                        <%= order_id %>
                    </TD>
                    <TD align=center>
                        <%= product_name %>
                    </TD>
                    <TD align=center>
                        <%
                            DecimalFormat df = new DecimalFormat("###,###,##0");
                            out.println(df.format(product_price));
                        %>
                    </TD>
                </TR>


                <%
                            pageSize_temp = pageSize_temp - 1;      // 현재 표시될 라인을 하나씩 줄임

                            if (cnt == 3)
                                out.print("</TR><TR>");
                        }

                    }
                %>
                </tr>
            </table></td>
            </tr>
            <tr><td height=30></td>
            </tr>
            <tr>
                <td colspan=4 align=center>
                    <%
                        // 총 페이지 수 계산
                        int intTotPages	= 0;
                        int intR		= totalRecords % pageSize;
                        if	(intR == 0) {
                            intTotPages = totalRecords / pageSize;
                        }
                        else
                        {
                            intTotPages = totalRecords / pageSize + 1;          // 나머지가 0 보다 크면 총 페이지수는 몫 + 1
                        }

                        int intGrpSize  = 1;									// 그룹 당 페이지 수 설정
                        int currentGrp  = 0;									// 현 그룹 No.

                        intR						= currentPage % intGrpSize;
                        if	(intR == 0) {
                            currentGrp		= currentPage / intGrpSize;
                        }
                        else
                        {
                            currentGrp	= currentPage / intGrpSize + 1;
                        }

                        int intGrpStartPage	= (currentGrp   - 1) * intGrpSize + 1;	// 현 그룹 시작 페이지
                        int intGrpEndPage		=  currentGrp * intGrpSize;							// 현 그룹   끝 페이지
                        if (intGrpEndPage > intTotPages){
                            intGrpEndPage			= intTotPages;
                        }
                        if (currentGrp > 1){
                    %>
                    [<A href="user_orderList.jsp&PageNum=<%= intGrpStartPage - 1 %>">이전</A>]
                    <%
                        }

                        int	intGrpPageCount		= intGrpSize;								// 그룹 당 페이지 수
                        int intIndex					= intGrpStartPage;					// 현 그룹 시작 페이지

                        while (intGrpPageCount > 0 && intIndex <= intGrpEndPage){
                    %>
                    [<A href="user_orderList.jsp&PageNum=<%= intIndex %>"><%= intIndex %></A>] &nbsp;
                    <%
                            intIndex = intIndex + 1;
                            intGrpPageCount    = intGrpPageCount    - 1;
                        }

                        if (intIndex <= intTotPages){
                    %>
                    [<A href="user_orderList.jsp&PageNum=<%= intIndex %>">다음</A>]
                    <%
                        }
                    %>
                </td >
            </tr>

            </tr>
            <%@ include file="/includes/bottom.jsp" %>
        </table></td>
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