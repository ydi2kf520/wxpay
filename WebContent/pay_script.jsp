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
        OrderService service = new OrderServiceImpl();
        PayParams payParams = service.generatePayParams(body, orderId, totalFee);
%>
function onBridgeReady(){
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
           // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
              onPayResult(true, res.err_desc);
           } else if (res.err_msg == "get_brand_wcpay_request:fail") {
              onPayResult(false, res.err_desc);
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
callbackjw75bua86qe3f7qv9ep16xdlocjxoexw();
