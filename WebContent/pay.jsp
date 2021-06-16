<%@ page language="java" import="java.util.*"
    contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.nj9you.wxpay.model.PayParams"%>
<%@ page import="com.nj9you.wxpay.service.OrderService"%>
<%@ page import="com.nj9you.wxpay.service.impl.OrderServiceImpl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>公众号支付测试</title>
<style type="text/css">
body {
    margin: 0;
    padding: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
}

#paying {
    position: fixed;
    left: 50%;
    top: 50%;
    transform: perspective(1200px) translate3d(-50%, -50%, 0) scale(1);
    color: white;
    font-size: 2em;
    background: rgba(64, 64, 64, 0.8);
    visibility: hidden;
}
</style>
</head>
<body>
    <%!
        boolean autoConfirmPay = true;
    %>
    <%
        request.setCharacterEncoding("UTF-8");
        String body = request.getParameter("body");
        String orderId = request.getParameter("order_id");
        String totalFee = request.getParameter("total_fee");
        String openId = request.getParameter("open_id");
        OrderService service = new OrderServiceImpl();
        PayParams payParams = service.generatePayParams(body, orderId, totalFee, openId);
    %>
    <table align=center cellspacing="10">
        <tr>
            <td>公众号Id<br /><%=payParams.getAppId()%></td>
        </tr>
        <tr>
            <td>时间戳<br /><%=payParams.getTimpStamp()%></td>
        </tr>
        <tr>
            <td>随机字符串<br /><%=payParams.getNonceStr()%></td>
        </tr>
        <tr>
            <td>扩展字符串<br />
            <span style="word-break: break-all"><%=payParams.getPackageExt()%></span></td>
        </tr>
        <tr>
            <td>签名方式<br /><%=payParams.getSignType()%></td>
        </tr>
        <tr>
            <td>签名<br /><%=payParams.getPaySign()%></td>
        </tr>
        <tr>
            <td>错误信息<br />
            <span style="word-break: break-all"><%=payParams.getError()%></span></td>
        </tr>
    </table>
    <br />
    <%
        if (!autoConfirmPay) {
            out.print("<div style='text-align:center'><button onclick='execPay();' style='width:10em;height:2.5em;'>确认支付</button></div>");
        }
    %>

    <span id="paying">支付中...</span>
    <script type="text/javascript">
        function onBridgeReady(){
           // document.getElementById("paying").style.visibility = "visible";
           WeixinJSBridge.invoke(
               'getBrandWCPayRequest', {
                   "appId":"<%=payParams.getAppId()%>",         // 公众号名称，由商户传入
                   "timeStamp":"<%=payParams.getTimpStamp()%>", // 时间戳，自1970年以来的秒数
                   "nonceStr":"<%=payParams.getNonceStr()%>",   // 随机串
                   "package":"<%=payParams.getPackageExt()%>",  // 扩展字段
                   "signType":"<%=payParams.getSignType()%>",   // 微信签名方式
                   "paySign":"<%=payParams.getPaySign()%>"      // 微信签名 
               },
               function(res){
                   // document.getElementById("paying").style.visibility = "hidden";
                   alert(JSON.stringify(res));
                   // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
                   if(res.err_msg == "get_brand_wcpay_request:ok" ) {
                      queryPayResult();
                   } else if (res.err_msg == "get_brand_wcpay_request:fail") {
                   }
               }
           );
        }
        function execPay() {
            if (typeof WeixinJSBridge == "undefined"){
               if( document.addEventListener ){
                   document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
               }else if (document.attachEvent){
                   document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
                   document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
               }
            }else{
               onBridgeReady();
            }
        }
        /**支付成功，查询支付结果*/
        function queryPayResult() {
        }
        <%
            if (autoConfirmPay) {
                out.print("execPay()");
            }
        %>
    </script>
</body>
</html>