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
			<%@ include file="/includes/top.jsp" %>
			<tr>
				<td height="80" background="/icons/sub_bg.png">&nbsp;</td>
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
										<td width="20%" align="center" bgcolor="#EEEEEE">제목</td>
										<td width="10%" align="center" bgcolor="#EEEEEE">작성자</td>
									</tr>
									<%
										String strPageNum = request.getParameter("PageNum"); // 선택된 페이지 번호 참조
										String product_id = request.getParameter("product_id");
										if (strPageNum == null) {
											strPageNum = "1";
										}
										int currentPage = Integer.parseInt(strPageNum);			// 현재 페이지
										int pageSize		= 5;
										ResultSet rs = null, rs2 = null;

										Statement stmt  = con.createStatement();

										String SQL = null;
										SQL = "select * from qna";
										rs2 = stmt.executeQuery(SQL);
										int totalRecords	= 0;			// ResultSet 객체 내의 레코드 수를 저장하기 위한 변수
										if (rs2.next() == false){		// 만약 테이블에 아무것도 없다면
									%>
									<tr>
										<TD colspan=7><center>등록된 게시글이 없습니다</center></TD>
									</tr>
									<%
									}
									else
									{
										totalRecords = rs2.getInt(1);

										SQL =  "select qna_id, lock_yn, qna_title, user_id from qna where product_id";
										SQL = SQL + product_id;
										SQL = SQL  + " ORDER BY qna_group DESC, qna_seq asc";


										rs = stmt.executeQuery(SQL);			// 현재 페이지에 출력할 상품만 select
										int pageSize_temp = pageSize;			// 현재 표시될 라인을 하나씩 줄임
										while(rs.next() && pageSize_temp > 0){
											int qna_id               = rs.getInt("qna_id");
											String lock_yn   = rs.getString("lock_yn");
											String qna_title      = rs.getString("qna_title");
											String user_id      = rs.getString("user_id");

									%>
									<tr>

										<TD>
											<% if (lock_yn.equals("Y")) out.print("<img src=icon_lock.gif>"); %>
											<a href="/qna_view.jsp?pnum=<%= qna_id %>"><%= qna_title %></a></TD>
										<TD ALIGN = "center"><%= user_id      %></TD>
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
											[<A href="qna_list.jsp?PageNum=<%= intGrpStartPage - 1 %>">이전</A>]
											<%
												}
												int	intGrpPageCount		= intGrpSize;								// 그룹 당 페이지 수
												int intIndex					= intGrpStartPage;					// 현 그룹 시작 페이지
												while (intGrpPageCount > 0 && intIndex <= intGrpEndPage){
											%>
											[<A href="qna_list.jsp?PageNum=<%= intIndex %>"><%= intIndex %></A>] &nbsp;
											<%
													intIndex = intIndex + 1;
													intGrpPageCount    = intGrpPageCount    - 1;
												}
												if (intIndex <= intTotPages){
											%>
											[<A href="qna_list.jsp?PageNum=<%= intIndex %>">다음</A>]
											<%
												}
											%>
										</td>
									</tr>
									<tr>
										<td colspan = 7 align="center" bgcolor="#FFFFFF"><a href="./qna_write.jsp?product_id=<%= product_id %>">글쓰기</a></td>
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