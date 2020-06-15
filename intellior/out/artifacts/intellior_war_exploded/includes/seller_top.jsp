<%@ page contentType="text/html; charset=utf-8" language="java"  %>
<tr>
    <td height="67"><table width="815" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="180" height="67" rowspan="2" align="center"><a href="/seller/seller_index.jsp"><img src="/icons/logo.png" width="150" height="70" border="0" /></a></td>
            <td width="605" height="30" colspan="5" align="right">


                <%
                    String s_id = (String)session.getAttribute("G_ID");
                    String nm = (String)session.getAttribute("G_NM");

                    if (s_id == null)
                    {
                %>
                <a href="/admin/admin_login.jsp">관리자 로그인</a> | <a href="mem_join.jsp">회원가입</a> | <a href="../login.jsp">로그인</a>
                <%
                }
                else
                {
                %>
                <a href="seller_info_update.jsp">회원정보변경</a> | <%= nm %> 님 환영합니다. | <a href="/seller/goodsinfo_insert.jsp">상품등록</a> | <a href="/seller/mypage_seller.jsp">마이페이지</a> | <a href="../logout.jsp">로그아웃</a>
                <%
                    }
                %>
            </td>
        </tr>
        <tr>
            <td align="left">
                <a href="/goodsdisplay.jsp?category=가구" class="navi">가구</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="/goodsdisplay.jsp?category=침구" class="navi">침구</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="/goodsdisplay.jsp?category=소품" class="navi">소품</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="/goodsdisplay.jsp?category=반려동물" class="navi">반려동물</a>
            </td>
            <td align="right" width="220">
                <FORM NAME="frm1" ACTION="/goodsSearch.jsp" METHOD="post">
                    <div class="search_div">
                        <select name="search_key" class="search_select">
                            <option value="">전체</option>
                            <option value="가구">가구</option>
                            <option value="침구">침구</option>
                            <option value="소품">소품</option>
                        </select>
                        <INPUT TYPE="text" NAME="search_value" placeholder="검색어 입력" class="search_input">
                        <button class="search_button" onmouseover="this.style.cursor='hand';"><img src="/icons/search.png" height="80%" ></button>
                    </div>
                </FORM>
            </td>
        </tr>
    </table>
    </td>
</tr>