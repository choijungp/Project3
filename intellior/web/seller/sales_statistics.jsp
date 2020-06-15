<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<HTML>
<HEAD>
    <TITLE>판매 통계</TITLE>
    <link href="/includes/all.css" rel="stylesheet" type="text/css" />
</HEAD>
<%
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String today = formatter.format(new java.util.Date());

    ResultSet rs = null, rs2 = null;
    Statement stmt  = con.createStatement();
    String s_id2 = (String)session.getAttribute("G_ID");
    String SQL="select order_count, order_date";
    SQL = SQL +" from intelior.order";
    SQL = SQL +" where seller_id = '" + s_id2 + "' order by order_date asc";

    rs = stmt.executeQuery(SQL);


%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);
    function drawChart() {
        var data_month= google.visualization.arrayToDataTable([
            ['Month', 'Sales']
            <%
            int cnt_m=1;
            int count=0;
            String order_date=null;
            if(rs.next()){ //행이 있다면
                order_date = rs.getString("order_date");
            }
            while(cnt_m<13){
                count=0;
                out.print(", ");
                if(order_date!=null){
                    while( Integer.parseInt(order_date.substring(5, 7))==cnt_m){ //가져온 행이 해당하는 달일 때
                        count			+= rs.getInt("order_count");
                        if(rs.next())
                            order_date		= rs.getString("order_date");
                        else{
                            order_date=null;
                            break;
                        }
                    }
                }
                out.print("["+cnt_m+", "+count+"]");
                cnt_m++;
            }
            %>
        ]);

        var option_month = {
            chart: {
                title: 'Monthly sales statistics',
                subtitle: 'Sales : 1-12',
            }
        };

        var chart_month = new google.charts.Bar(document.getElementById('columnchart_material_month'));

        chart_month.draw(data_month, google.charts.Bar.convertOptions(option_month));

        var data_day = google.visualization.arrayToDataTable([
            ['Day', 'Sales']
            <%
            SQL="select order_count, order_date";
            SQL = SQL +" from intelior.order";
            SQL = SQL +" where seller_id = '" + s_id2 + "' and order_date like '%" + today.substring(0,7) + "%' order by order_date asc";
            rs = stmt.executeQuery(SQL);

            count=0;
            order_date=null;
            if(rs.next()){ //행이 있다면
                order_date = rs.getString("order_date");
            }

            int cnt_d=1;
            while(cnt_d<31){
                count=0;
                out.print(", ");
                if(order_date!=null){
                    while( Integer.parseInt(order_date.substring(8, 10))==cnt_d){ //가져온 행이 해당하는 일일 때
                        count			+= rs.getInt("order_count");
                        if(rs.next())
                            order_date		= rs.getString("order_date");
                        else{
                            order_date=null;
                            break;
                        }
                    }
                }
                out.print("["+cnt_d+", "+count+"]");
                cnt_d++;
            }
            %>
        ]);

        var option_day = {
            chart: {
                title: 'Daily sales statistics',
                subtitle: 'Sales : 1-30',
            }
        };

        var chart_day = new google.charts.Bar(document.getElementById('columnchart_material_day'));

        chart_day.draw(data_day, google.charts.Bar.convertOptions(option_day));

        var data_time = google.visualization.arrayToDataTable([
            ['Time', 'Sales']
            <%
            SQL="select order_count, order_date";
            SQL = SQL +" from intelior.order";
            SQL = SQL +" where seller_id = '" + s_id2 + "' and order_date like '%" + today.substring(0,10) + "%' order by order_date asc";
            rs = stmt.executeQuery(SQL);

            count=0;
            order_date=null;
            if(rs.next()){ //행이 있다면
                order_date = rs.getString("order_date");
            }
            int cnt_t=0;
            while(cnt_t<24){
                count=0;
                out.print(", ");
                if(order_date!=null){
                    while( Integer.parseInt(order_date.substring(11, 13))==cnt_t){ //가져온 행이 해당하는 일일 때
                        count			+= rs.getInt("order_count");
                        if(rs.next())
                            order_date		= rs.getString("order_date");
                        else{
                            order_date=null;
                            break;
                        }
                    }
                }
                out.print("["+cnt_t+", "+count+"]");
                cnt_t++;
            }
            %>
        ]);

        var option_time = {
            chart: {
                title: 'Hourly sales statistics',
                subtitle: 'Sales : 00-24',
            }
        };

        var chart_time = new google.charts.Bar(document.getElementById('columnchart_material_time'));

        chart_time.draw(data_time, google.charts.Bar.convertOptions(option_time));

    }
</script>
<BODY>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center" valign="top"><table width="815" border="0" cellspacing="0" cellpadding="0">
            <%@ include file="/includes/seller_top.jsp" %>
            <tr>
                <td>
                    <img src="/icons/sub_bg.png" width="810"/>
                </td>
            </tr>
            <tr>
                <td align="center"><br><br>-<%=s_id%> 님의 판매 통계 그래프(월별)-<br><br></td>
            </tr>
            <tr>
                <td>
                    <div id="columnchart_material_month" style="width: 800px; height: 500px;"></div>
                </td>
            </tr>
            <tr>
                <td align="center"><br><br>-<%=s_id%> 님의 판매 통계 그래프(일별)-<br><br></td>
            </tr>
            <tr>
                <td>
                    <div id="columnchart_material_day" style="width: 800px; height: 500px;"></div>
                </td>
            </tr>
            <tr>
                <td align="center"><br><br>-<%=s_id%> 님의 판매 통계 그래프(시간별)-<br><br></td>
            </tr>
            <tr>
                <td>
                    <div id="columnchart_material_time" style="width: 800px; height: 500px;"></div>
                </td>
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