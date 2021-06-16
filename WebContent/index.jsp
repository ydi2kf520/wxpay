<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*"
    contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">
<title>公众号支付测试</title>
<style type="text/css">
html,body {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>
<script src="jquery.js"></script>
<script src="9yousdk.js"></script>
<script type="text/javascript">
    function payItem(body, totalFee, orderId, openId) {
        var sdk = window.JYSDK;
        sdk.pay(body, totalFee, orderId, openId, function(success, desc) {
            alert("success : " + success + "\n\n" + "desc : " + desc);
        });
    }
    window.onload = function() {
        loadGame("http://fish-h5.9you-nj.cn/QPFish/index.html", 0);
        // loadGame("lucyfish.html", 0);
        document.getElementById("gameFrame").onload = function() {
            console.log("iframe loaded");
        };
    }
    function OnMessage(data) {
        alert(data);
    }
    if (window.addEventListener) { // all browsers except IE before version 9
        window.addEventListener("message", OnMessage, false);
    } else {
        if (window.attachEvent) { // IE before version 9
            window.attachEvent("onmessage", OnMessage);
        }
    }
</script>
</head>
<body style="text-align: center">
    <%
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String body = "腾讯充值中心-QQ会员充值";
        int totalFee = 1;
        String orderId = sdf.format(new Date())
                + String.valueOf(System.currentTimeMillis());
        String openId = "oUpF8uMuAJO_M2pxb1Q9zNjWeS6o";
    %>
    <table align=center>
        <tr>
            <td>商品描述</td>
            <td>&nbsp;&nbsp;:&nbsp;&nbsp;</td>
            <td style="text-align: left"><%=body%></td>
        </tr>
        <tr>
            <td>支付金额</td>
            <td>&nbsp;&nbsp;:&nbsp;&nbsp;</td>
            <td style="text-align: left"><%=totalFee%>&nbsp;分</td>
        </tr>
        <tr>
            <td>商户订单</td>
            <td>&nbsp;&nbsp;:&nbsp;&nbsp;</td>
            <td style="text-align: left"><%=orderId%></td>
        </tr>
        <tr>
            <td>用户标示</td>
            <td>&nbsp;&nbsp;:&nbsp;&nbsp;</td>
            <td style="text-align: left"><%=openId%></td>
        </tr>
    </table>
    <br />
    <form action="pay.jsp" method="post">
        <input type="hidden" name="body" value="<%=body%>" />
        <input type="hidden" name="total_fee" value="<%=totalFee%>" />
        <input type="hidden" name="order_id" value="<%=orderId%>" />
        <input type="hidden" name="open_id" value="<%=openId%>" />
        <button type="submit" style="height: 2.5em;">页面跳转支付</button>
    </form>
    <br />
    <br />
    <button style="height: 2.5em;"
        onclick="payItem('<%=body%>', '<%=totalFee%>', '<%=orderId%>', '<%=openId%>');">JS跨域支付</button>
</body>
</html>