<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<%
	String id = (String)session.getAttribute("G_ID");
	if (id == null)
	{
		out.print("<script type=text/javascript>");
		out.print("alert('판매자 로그인을 하시기 바랍니다.!!!');");
		out.print("location.href = 'seller_index.jsp';");
		out.print("</script>");
	}
	String in_sort	= request.getParameter("sort");
	if (in_sort == null) in_sort = "";
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>판매자 상품리스트</title>
<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
	function orderby(){
		document.select_frm.submit();
	}
</script>
<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
			<%@ include file="/includes/seller_top.jsp" %>
		<tr>
			<td height="80" background="/icons/sub_bg.png">&nbsp;</td>
		</tr>
		<tr>
			<td align="center" valign="top">
				<table width="800" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="547" height="45" align="left" class="new_tit">상품리스트</td>
					</tr>
					<tr>
						<td colspan="2" align="left" valign="top">
							<FORM name="select_frm" id="select_frm" action="seller_goodslist.jsp" METHOD="post">
								<SELECT NAME="sort" id="sort" class="sort_select" onchange="orderby()">
									<OPTION VALUE="1" <% if(in_sort.equals("1")) out.print (" selected"); %>>최신순</OPTION>
									<OPTION VALUE="2" <% if(in_sort.equals("2")) out.print (" selected"); %>>인기순</OPTION>
									<OPTION VALUE="3" <% if(in_sort.equals("3")) out.print (" selected"); %>>낮은 가격순</OPTION>
									<OPTION VALUE="4" <% if(in_sort.equals("4")) out.print (" selected"); %>>높은 가격순</OPTION>
								</SELECT>
								<br><br>
							</FORM>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left" valign="top">
							<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
								<tr>
									<td width="20%" align="center" bgcolor="#EEEEEE">상품명</td>
									<td width="09%" align="center" bgcolor="#EEEEEE">카테고리</td>
									<td width="10%" align="center" bgcolor="#EEEEEE">가격</td>
									<td width="20%" align="center" bgcolor="#EEEEEE">판매자</td>
								</tr>
								<%
									String strPageNum = request.getParameter("PageNum"); // 선택된 페이지 번호 참조
									if (strPageNum == null) {
										strPageNum = "1";
									}
									int currentPage = Integer.parseInt(strPageNum);			// 현재 페이지
									int pageSize		= 5;
									ResultSet rs = null, rs2 = null;

									Statement stmt  = con.createStatement();

									String SQL = null;

									if(in_sort.equals("1")||in_sort.equals("")){
										SQL= "SELECT product_id, product_name, category, product_price, seller_id FROM product where seller_id = '"+ id +"'";
									}
									else if(in_sort.equals("2")){
										SQL= "SELECT product_id, product_name, category, product_price, seller_id FROM product "+"where seller_id = '"+ id +"'"+ " ORDER BY product_view_count DESC";
									}
									else if(in_sort.equals("3")){
										SQL= "SELECT product_id, product_name, category, product_price, seller_id FROM product "+"where seller_id = '"+ id +"'"+ " ORDER BY product_price ASC";
									}
									else if(in_sort.equals("4")){
										SQL= "SELECT product_id, product_name, category, product_price, seller_id FROM product "+"where seller_id = '"+ id +"'"+ " ORDER BY product_price DESC";
									}


									rs2 = stmt.executeQuery(SQL);
									int totalRecords	= 0;			// ResultSet 객체 내의 레코드 수를 저장하기 위한 변수
									if (rs2.next() == false){		// 만약 테이블에 아무것도 없다면
								%>
								<tr>
									<TD colspan=7><center>등록된 상품이 없습니다</center></TD>
								</tr>
								<%
								}
								else
								{
									totalRecords = rs2.getInt(1);
									rs = stmt.executeQuery(SQL);			// 현재 페이지에 출력할 상품만 select
									int pageSize_temp = pageSize;			// 현재 표시될 라인을 하나씩 줄임
									while(rs.next() && pageSize_temp > 0){
										String product_name			= rs.getString("product_name");
										String category			= rs.getString("category");
										int product_price			= rs.getInt("product_price");
										String seller_id			= rs.getString("seller_id");
										int product_id  			= rs.getInt("product_id");
								%>
								<tr>

									<td align="center" bgcolor="#FFFFFF"><a href="/seller/seller_goodsinfo_update.jsp?product_id=<%= product_id %>"><%= product_name %></a></td>
									<td align="center" bgcolor="#FFFFFF"><%= category		%></td>
									<td align="center" bgcolor="#FFFFFF">
											<%
												DecimalFormat df = new DecimalFormat("###,###,##0");
												out.println(df.format(product_price));
											%>
									</td>
									<td align="center" bgcolor="#FFFFFF"><%= seller_id		%></td>
								</tr>
								<%
											pageSize_temp = pageSize_temp - 1;      // 현재 표시될 라인을 하나씩 줄임
										}
									}
								%>
								<tr>
									<td colspan = 7 align="center" bgcolor="#EEEEEE">

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
											int intGrpSize  = 10;									// 그룹 당 페이지 수 설정
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
										[<A href="goodslist.jsp?PageNum=<%= intGrpStartPage - 1 %>">이전</A>]
										<%
											}
											int	intGrpPageCount		= intGrpSize;								// 그룹 당 페이지 수
											int intIndex					= intGrpStartPage;					// 현 그룹 시작 페이지
											while (intGrpPageCount > 0 && intIndex <= intGrpEndPage){
										%>
										[<A href="goodslist.jsp?PageNum=<%= intIndex %>"><%= intIndex %></A>] &nbsp;
										<%
												intIndex = intIndex + 1;
												intGrpPageCount    = intGrpPageCount    - 1;
											}
											if (intIndex <= intTotPages){
										%>
										[<A href="goodslist.jsp?PageNum=<%= intIndex %>">다음</A>]
										<%
											}
										%>
									</td>
								</tr>
								<tr>
									<td colspan = 7 align="center" bgcolor="#FFFFFF"><a href="/seller/goodsinfo_insert.jsp">신규등록</a></td>
								</tr>
							</table>
				</table>
			</td>
		</tr>
		</tr>
	</table >
			<%
if (stmt  != null) stmt.close();
if (rs    != null) rs.close();
if (rs2   != null) rs2.close();
if (con   != null) con.close();
%>
</BODY>
</html>