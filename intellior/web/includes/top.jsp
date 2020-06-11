<%@ page contentType="text/html; charset=utf-8" language="java"  %>
<tr>
    <td height="67"><table width="815" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="210" height="67" rowspan="2" align="center"><a href="index.jsp"><img src="/icons/logo.png" width="150" height="70" border="0" /></a></td>
            <td width="605" height="30" colspan="5" align="right">

                <%
                    String id = (String)session.getAttribute("G_ID");
                    String nm = (String)session.getAttribute("G_NM");

                    if (id == null)
                    {
                %>
                <a href="/admin/admin_login.jsp">관리자 로그인</a>| <a href="mem_join.jsp">회원가입</a>| <a href="login.jsp">로그인</a>
                <%
                }
                else
                {
                %>
                <a href="user_info_update.jsp">회원정보변경</a> | <%= nm %> 님 환영합니다. | <a href="logout.jsp">로그아웃</a>
                <%
                    }
                %>


                | <a href="#">장바구니</a> | <a href="#">주문배송조회</a> | <a href="mypage_user.jsp">마이페이지</a></td>
        </tr>
        <tr>
            <td align="center">
                <a href="../goodsdisplay.jsp?category=가구" class="navi">가구</a>
            </td>
            <td align="center">
                <a href="../goodsdisplay.jsp?category=침구" class="navi">침구</a>
            </td>
            <td align="center">
                <a href="../goodsdisplay.jsp?category=소품" class="navi">소품</a>
            </td>
            <td align="center">
                <a href="../goodsdisplay.jsp?category=반려동물" class="navi">반려동물</a>
            </td>
            <td align="right" width="220">
                <!--<li class="list"><a href="/admin/admin_login.jsp" class="navi">ADMIN</a></li> //관리자 로그인 아이콘 없앨지 생각해보기-->
                <% /* Get & Save information about search */
                    String in_search_key=request.getParameter("search_key"); //search criteria
                    if(in_search_key==null) in_search_key="";
                    String in_search_value=request.getParameter("search_value"); //search word
                    if(in_search_value==null) in_search_value="";
                %>
                <FORM NAME="frm1" ACTION="../goodsdisplay.jsp" METHOD="post">
                    <div class="search_div">
                        <INPUT TYPE="text" NAME="search_value" VALUE="<%=in_search_value%>" placeholder="검색어 입력" class="search_input">
                        <button class="search_button"><img src="icons/search.png" height="80%"></button>
                    </div>
                </FORM>
            </td>
        </tr>
    </table>
    </td>
</tr>