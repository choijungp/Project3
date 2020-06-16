<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<HEAD>
	<TITLE> 장바구니</TITLE>
	<link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>

<script type="text/javascript">

	function totViewCreate(a){
		var totAmt = a.toString();
		var temp  = "";

		for (idx = totAmt.length - 1; idx >= 0; idx--){
			schar = totAmt.charAt(idx);
			temp	= schar  + temp;

			if(idx % 3 == totAmt.length % 3 && idx != 0){ temp = ',' + temp; }
		}

		document.all.totAmtView.innerHTML = temp;
	}

	function amtViewCreate(i, valPrice, valQty){
		var amt			= valPrice * valQty;
		var strAmt	= amt.toString();
		var temp		= "";

		for(idx = strAmt.length - 1; idx >= 0; idx--){
			schar = strAmt.charAt(idx);
			temp	= schar  + temp;

			if(idx % 3 == strAmt.length % 3 && idx != 0){ temp = ',' + temp; }
		}

		eval("document.all.amtView" + i + ".innerHTML = temp");

		var  chkArr				= document.getElementsByName('chkName');
		var  chkArr_size	=	chkArr.length;
		var	 tot					= 0;

		for(var i = 1; i <= chkArr_size; i ++ ){
			var temp			= eval("document.getElementById('chkId" + i + "').checked");
			if (temp == true){

				var valPrice	= eval("document.frm1.unitPriceId"+ i + ".value");
				var valQty		= eval("document.frm1.qtyId" + i +".value");
				tot						= tot + valPrice * valQty;
			}
		}
		totViewCreate(tot);
	}

	function orderPage() {

		document.frm1.action = "goodsCartUpdate.jsp";
		document.frm1.submit();
	}

	function delChk() {

		document.frm1.action = "goodsCartDelete.jsp";
		document.frm1.submit();
	}

	function allCheck(){ // chkAll 체크박스로 전체 체크박스들을 체크하거나 체를 해제 함
		var  chkArr				= document.getElementsByName('chkName');
		var  chkArr_size	=	chkArr.length;
		var	 tot					= 0;

		if(document.frm1.chkAll.checked == true){
			for(var i = 1; i <= chkArr_size; i ++ ){
				var temp			= "document.getElementById('chkId" + i + "').checked = true";
				eval(temp);

				var valPrice	= eval("document.frm1.unitPriceId"+ i + ".value");
				var valQty		= eval("document.frm1.qtyId" + i +".value");

				tot						= tot + valPrice * valQty;
			}

			totViewCreate(tot);

		}else{
			for(var i = 1; i <= chkArr_size; i ++ ){
				var  temp = "document.getElementById('chkId" + i + "').checked = false";
				eval(temp);
			}

			totViewCreate(0);

		}
	}

	function allSelReset(){ // chkAll 전체를 체크한 후에 개별 row의 체크박스를 체크 해제할 때 chkAll을 reset
		var  chkArr				= document.getElementsByName('chkName');
		var  chkArr_size	=	chkArr.length;
		var	 tot					= 0;
		var  cnt					= 0;

		for(var i = 1; i <= chkArr_size; i ++){
			var  temp = "document.getElementById('chkId" + i + "').checked";
			var  rv = eval(temp);
			if ( rv == true )
			{
				var valPrice	= eval("document.frm1.unitPriceId"+ i + ".value");
				var valQty		= eval("document.frm1.qtyId" + i +".value");

				tot						= tot + valPrice * valQty;
				cnt						= cnt + 1;
			}
			else
			{
				document.frm1.chkAll.checked = false;
			}
		}

		if (cnt == chkArr_size)
		{document.frm1.chkAll.checked = true;}
		else
		{document.frm1.chkAll.checked = false;}

		totViewCreate(tot);
	}

	function qtyUpDown(a, i){  //수량 Up Down
		var chkArr			= document.getElementsByName('chkName');
		var chkArr_size	=	chkArr.length;

		if(a == 1){
			//				alert("1씩 증가");
			var valPrice	= eval("document.frm1.unitPriceId" + i +".value");
			var valQty		= eval("document.frm1.qtyId" + i +".value");
			valQty ++;
			eval("document.frm1.qtyId" + i +".value = valQty");
		}else if(a == 2){
			//				alert("1씩 감소");
			var valPrice	= eval("document.frm1.unitPriceId" + i +".value");
			var valQty		= eval("document.frm1.qtyId" + i +".value");
			valQty --;
			if(valQty > 0){
				eval("document.frm1.qtyId" + i +".value = valQty");
			}else{
				alert("최소 1개이상입니다.");
				return;
			}
		}
		amtViewCreate(i, valPrice, valQty);
	}

</script>

<BODY>
<FORM NAME = frm1 METHOD = POST>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
				<%@ include file="/includes/top.jsp" %>
				<tr>
					<td>
						<img src="/icons/sub_bg.png" width="810"/>
					</td>
				</tr>
				<tr>
					<td align="center" valign="top"><table width="800" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="547" height="45" align="left" class="new_tit">장바구니</td>
							<td width="253" align="right">HOME &lt; 장바구니</td>
						</tr>
						<tr>
							<td colspan="2" align="left" valign="top">
								<table width="100%" border="0" cellspacing="1" cellpadding="7" bgcolor="#D7D7D7">
									<tr>
										<td width="5%" align="center" bgcolor="#EEEEEE">선택
											<INPUT type = checkbox name = "chkAll" onClick = "allCheck()"></td>
										<td width="9%" align="center" bgcolor="#EEEEEE">상품이미지</td>
										<td width="12%" align="center" bgcolor="#EEEEEE">상품코드</td>
										<td width="20%" align="center" bgcolor="#EEEEEE">상품명</td>
										<td width="10%" align="center" bgcolor="#EEEEEE">상품가격</td>
										<td width="14%" align="center" bgcolor="#EEEEEE">수량</td>
										<td width="10%" align="center" bgcolor="#EEEEEE">금액</td>
									</tr>
									<%

										String userid			=	(String)session.getAttribute("G_ID");

										ResultSet rs = null;
										DecimalFormat df	= new DecimalFormat("###,###,##0");
										int amt						= 0;
										int totAmt				= 0;

										Statement stmt  = con.createStatement();

										String SQL = "select a.*, b.* from cart a ";
										SQL = SQL + " inner join product b on a.product_id = b.product_id ";
										SQL = SQL + " where a.user_id = '" + userid + "'";
										rs = stmt.executeQuery(SQL);

										int cnt = 0;
										int i		= 0;
										while(rs.next()){

											i ++;
											String product_id		= rs.getString("product_id");
											String product_name		= rs.getString("product_name");

											int product_price			= rs.getInt("product_price");
											int qty						= rs.getInt("p_count");

											String product_thumnail	= rs.getString("product_thumnail");
											String chkYN			= rs.getString("chkYN");
											amt								= product_price * qty;
											if (chkYN.equals("Y")) {
												totAmt					= totAmt + amt;
											}
									%>

									<TR align=center>
										<INPUT type = hidden name = "idx" value = "<%= product_id %>">
										<TD><INPUT type = checkbox name = "chkName" value = "<%= product_id %>" id = "chkId<%= i %>"
											<% if (chkYN.equals("Y")) {
													out.print(" checked ");
													cnt ++;
												}
										%>
												   onClick = "allSelReset()"></TD>
										<td align="center" bgcolor="#FFFFFF"><IMG src="/images/<%= product_thumnail %>" height = 50 width = 50></td>
										<td align="center" bgcolor="#FFFFFF"><%= product_id					%></td>
										<td align="center" bgcolor="#FFFFFF"><%= product_name		%></td>

										<td align="right" bgcolor="#FFFFFF"><%= df.format(product_price)%></TD><INPUT type = hidden name = "unitPrice" value = "<%= product_price %>" id = "unitPriceId<%= i %>"</td>
										<td align="center" bgcolor="#FFFFFF"><INPUT type = text name = "qty" value = "<%= qty %>" size = 3 maxlength = 2 id = "qtyId<%= i %>">
											<IMG src = "/icons/qty_up.png"  height = 20 width = 20 onclick = "qtyUpDown(1, <%= i %>)">
											<IMG src = "/icons/qty_down.png" height = 20 width = 20 onclick = "qtyUpDown(2, <%= i %>)"></td>
										<td align="right" bgcolor="#FFFFFF"><SPAN id = "amtView<%= i %>"><%= df.format(amt) %></SPAN></td>
									</TR>
									<TR>
											<%
							}
							if ( i == cnt ){
								out.print("<script type='text/javascript'>");
								out.print("document.frm1.chkAll.checked = true;");
								out.print("</script>");
							}
							%>
								</table>
							</td>
						</tr>
					</table></td>
				</tr>

				<tr>
					<td height="50" align="right">합계&nbsp;&nbsp;<SPAN id = "totAmtView"><%= df.format(totAmt) %></SPAN>&nbsp;원</td>
				</tr>
				<tr>
					<td height="25" align="center">
						<input type = "button" id = "button"  value = "선택상품 삭제"  onClick = "delChk();"/>
						<input type = "button" id = "button2" value = "선택상품 주문" onClick = "orderPage();"/>
					</td>
				</tr>
				<%@ include file="/includes/bottom.jsp" %>
			</table>
					<%
if (stmt  != null) stmt.close();
if (rs    != null) rs.close();
if (con   != null) con.close();
%>
</FORM>
</BODY>
</html>