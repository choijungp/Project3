<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*, java.util.Calendar" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<HEAD>
	<TITLE> 주문 완료</TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<%

	String userid			=	(String)session.getAttribute("G_ID");

	String user_nm			= "";
	String user_address			= "";
	String user_phone			= "";
	int unitPrice			= 0;

	int amt						= 0;
	int totAmt				= 0;

	DecimalFormat df1	= new DecimalFormat("00");
	DecimalFormat df2	= new DecimalFormat("###,###,##0");

	String newOrdNo		= "";

	Statement stmt		= con.createStatement();
	Statement stmt2		= con.createStatement();
	Statement stmt3		= con.createStatement();
	Statement stmt4		= con.createStatement();
	ResultSet rs			= null, rs2 = null;
	String sql ="";
	try{
		//주문코드 제작
		Calendar cal		= Calendar.getInstance();

		int year				= cal.get(Calendar.YEAR);
		int mon	    		= cal.get(Calendar.MONTH) + 1;
		int seq	    		= 0;

		String strSeq		= "";
		String newCode  = "";
		String strYear  = Integer.toString(year);
		String strMon		= df1.format(mon);

		String strSQL = "select max(order_code) from intelior.order where left(order_code, 6) = " + strYear + strMon;
		rs2		= stmt2.executeQuery(strSQL);

		rs2.next() ;
		if (rs2 == null) {
			seq		= 0;
		}else{
			String maxcode	= rs2.getString(1);
			if (maxcode == null)
				seq		= 0;
			else
			{
				strSeq					= maxcode.substring(4);
				seq							= Integer.parseInt(strSeq);
			}
		}
		seq++;
		String newSeq 		= "0000" + Integer.toString(seq);
		int newSeqleng	= newSeq.length();
		newOrdNo	= strYear + strMon + newSeq.substring(newSeqleng - 4, newSeqleng);
		String order_num = newOrdNo;




		strSQL = "select c.* , p.* from cart c inner join product p on c.product_id = p.product_id";
		strSQL	= strSQL + " where user_id = '" + userid + "' and chkYN = 'Y'";

		rs			= stmt.executeQuery(strSQL);

		while(rs.next()){
			String product_id		= rs.getString("product_id");
			String product_name		= rs.getString("product_name");
			String seller_id		= rs.getString("seller_id");
			int product_price			= rs.getInt("product_price");
			int p_count						= rs.getInt("p_count");

			int tot					= 0;
			strSQL = "insert into intelior.order (product_id , user_id, seller_id, order_state, order_code,order_date, order_count) values (";
			strSQL = strSQL + "  '"	+ product_id  + "'";
			strSQL = strSQL + ",  '"	+ userid  + "'";
			strSQL = strSQL + ",  '"	+ seller_id  + "' ,";
			strSQL = strSQL + 0 ;
			strSQL = strSQL + ", '" + order_num+"'";
			strSQL = strSQL + ",     now() , ";
			strSQL = strSQL + p_count+ ")";
			stmt3.execute(strSQL);

			sql ="delete from cart where product_id = "+product_id;
			stmt4.execute(sql);
		}
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" valign="top">
			<%@ include file="/includes/top.jsp" %>
	<tr>
		<td height="80" background="/icons/sub_bg.png">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="547" height="45" align="left" class="new_tit">주문 완료</td>
				<td width="253" align="right">HOME &lt; 주문 완료</td>
			</tr>
			<tr>
				<td colspan="2" align="left" valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
					<tr>
						<td width="10%" align="center" bgcolor="#EEEEEE">상품이미지</td>
						<td width="20%" align="center" bgcolor="#EEEEEE">상품코드</td>
						<td width="20%" align="center" bgcolor="#EEEEEE">상품명</td>
						<td width="10%" align="center" bgcolor="#EEEEEE">단가</td>
						<td width="10%" align="center" bgcolor="#EEEEEE">수량</td>
						<td width="10%" align="center" bgcolor="#EEEEEE">금액</td>
					</tr>

					<%

						strSQL = "select a.*, b.*, c.* from intelior.order a ";
						strSQL = strSQL + " inner join product	b on a.product_id	= b.product_id ";
						strSQL = strSQL + " inner join intelior.user c on a.user_id	= c.user_id ";
						strSQL = strSQL + " where a.user_id = '" + userid + "' and a.order_code = " + order_num ;


						rs = stmt.executeQuery(strSQL);


						while(rs.next()){

							String product_thumnail = rs.getString("product_thumnail");
							int product_id = rs.getInt("product_id");
							String product_name = rs.getString("product_name");
							int product_price = rs.getInt("product_price");
							int order_count = rs.getInt("order_count");
							int result_price = product_price*order_count;
							totAmt			= totAmt + result_price;

							user_nm			= rs.getString("user_name");
							user_address			= rs.getString("user_address");
							user_phone			= rs.getString("user_phone");


					%>
					<tr>

						<td align="center" bgcolor="#FFFFFF"><img src="/images/<%= product_thumnail %>" width="40" height="40" /></td>
						<td align="center" bgcolor="#FFFFFF"><%= product_id					%></td>
						<td align="center" bgcolor="#FFFFFF"><%= product_name					%></td>
						<td align="center" bgcolor="#FFFFFF"><%= df2.format(product_price)%></td>
						<td align="center" bgcolor="#FFFFFF"><%= order_count			%></td>
						<td align="center" bgcolor="#FFFFFF"><%= df2.format(result_price)	%></td>
					</tr>

					<%
						}
					%>
				</table></td>
			</tr>
		</table></td>
	</tr>
	<tr>
		<td height="50" align="center">합계 <SPAN id = "totAmtView"><%= df2.format(totAmt) %></SPAN>원</td>
	</tr>
	<%


	%>
	<FORM NAME = frm1 ACTION = "index.jsp" METHOD = POST>
		<tr>
			<td align="center"><table width="800" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
				<tr>
					<td colspan="2" align="left" bgcolor="#EEEEEE">주문자 정보</td>
				</tr>
				<tr>
					<td width="24%" align="left" bgcolor="#FFFFFF">주문자 성명</td>
					<td width="76%" align="left" bgcolor="#FFFFFF"><%= user_nm %></td>
				</tr>
				<tr>
					<td align="left" bgcolor="#FFFFFF">주문자 주소</td>
					<td width="76%" align="left" bgcolor="#FFFFFF"><%= user_address %></td>
				</tr>
				<tr>
					<td align="left" bgcolor="#FFFFFF">주문자 전화</td>
					<td width="76%" align="left" bgcolor="#FFFFFF"><%= user_phone %></td>
				</tr>

			</table></td>
		</tr>

		<tr>
			<td height="50" align="center">
				<input type="submit" id="button2" value="메인으로 이동"/>
			</td>
		</tr>

		<tr>
			<%@ include file="/includes/bottom.jsp" %>
		</tr>
	</FORM>
</table>
</body>
</html>
<%
	} //try end

	catch(SQLException e1){
		e1.printStackTrace();
	} // catch SQLException end

	catch(Exception e2){
		e2.printStackTrace();
	} // catch Exception end

	finally{
		if (stmt  != null) stmt.close();
		if (stmt2 != null) stmt2.close();
		if (rs    != null) rs.close();
		if (rs2   != null) rs2.close();
		if (con   != null) con.close();
	}
%>