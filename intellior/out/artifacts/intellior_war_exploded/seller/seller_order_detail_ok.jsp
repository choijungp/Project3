<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>

<%


    Statement stmt = con.createStatement();
    String order_id[]		= request.getParameterValues("chkName");

    String order_code			= request.getParameter("order_code");
    String order_state			= request.getParameter("order_state");
    String seller_id			=	(String)session.getAttribute("G_ID");

    int order_state_int = Integer.parseInt(order_state);

    try{
        String SQL ="";
        int order_id_int = 0;
        for (int ii = 0; ii < order_id.length; ii ++){
            order_id_int = Integer.parseInt(order_id[ii]);
            if(order_state_int == 0) {
                SQL = "UPDATE intelior.order set ";
                SQL = SQL + "  order_state		= " + 1;
                SQL = SQL + "  WHERE order_id	= " + order_id_int ;
            }
            else{
                SQL = "UPDATE intelior.order set ";
                SQL = SQL + "  order_state		= " + 0;
                SQL = SQL + "  WHERE order_id	= " + order_id_int ;
            }
            stmt.executeUpdate(SQL);
            out.print(SQL);
        }


        stmt.executeUpdate(SQL);
    } //try end

    catch(SQLException e1){
        e1.printStackTrace();
    } // catch SQLException end

    catch(Exception e2){
        e2.printStackTrace();
    } // catch Exception end

    finally{
        if (stmt  != null) stmt.close();
        if (con   != null) con.close();
        String str = "seller_order_detail.jsp?order_code="+order_code;
        response.sendRedirect(str);
    }
%>


