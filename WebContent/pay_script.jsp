<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.nj9you.wxpay.model.PayParams"%>
<%@ page import="com.nj9you.wxpay.service.OrderService"%>
<%@ page import="com.nj9you.wxpay.service.impl.OrderServiceImpl"%>
<%
        request.setCharacterEncoding("UTF-8");
        String body = request.getParameter("body");
        String orderId = request.getParameter("order_id");
        String totalFee = request.getParameter("total_fee");
        String openId = request.getParameter("open_id");
        OrderService service = new OrderServiceImpl();
        PayParams payParams = service.generatePayParams(body, orderId, totalFee, openId);
        if (payParams != null) {
            out.clearBuffer();
            out.print(payParams.toJson());
        } else {
            out.print("{}");
        }
%>