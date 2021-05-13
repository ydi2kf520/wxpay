<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java"  import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>公众号支付测试</title>
<script src="pay_script.js"></script>
<script type="text/javascript">
    function payItem(body, totalFee, orderId) {
        WXPay.pay(body, totalFee, orderId, function(success, desc){
            alert("success : " + success + "\n\ndesc : '" + desc + "'");
        });
    }
</script>
</head>
<body style="text-align:center">
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    String body = "腾讯充值中心-QQ会员充值";
    int totalFee = 1;
    String orderId = sdf.format(new Date()) + String.valueOf(System.currentTimeMillis());
%>
<table align=center>
    <tr>
        <td>商品描述</td>
        <td>&nbsp;&nbsp;:&nbsp;&nbsp;</td>
        <td style="text-align:left"><%=body %></td>
    </tr>
    <tr>
        <td>支付金额</td>
        <td>&nbsp;&nbsp;:&nbsp;&nbsp;</td>
        <td style="text-align:left"><%=totalFee %>&nbsp;分</td>
    </tr>
        <tr>
        <td>商户订单</td>
        <td>&nbsp;&nbsp;:&nbsp;&nbsp;</td>
        <td style="text-align:left"><%=orderId %></td>
    </tr>
</table>
<br/>
<form action="pay.jsp" method="post">
<input type="hidden" name="body" value="<%=body%>"/>
<input type="hidden" name="total_fee" value="<%=totalFee%>"/>
<input type="hidden" name="order_id" value="<%=orderId%>"/>
<button type="submit" style="width:5em;height:2.5em;">支付</button>
</form>
<br/>
<br/>
<button style="height:2.5em;" onclick="payItem('<%=body%>', '<%=totalFee%>', '<%=orderId%>');">JS跨域支付</button>
</body>
</html>