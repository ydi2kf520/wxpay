// 定义支付成功的回调
var WXPay = {
    payCallback : null,
    pay : function (body, totalfee, orderId, callback) {
        payCallback = callback;
        fetchData(body, totalfee, orderId);
    }
};
/*
 *使用JS跨域的方案，向服务器请求数据
 *测试服务器使用的代码
 */
function fetchData(body, totalfee, orderId) {
    var script = document.createElement("script");
    var url = "pay_script.jsp";
    url += "?";
    url += "body=" + body;
    url += "&";
    url += "total_fee=" + totalfee;
    url += "&";
    url += "order_id=" + orderId;

    script.src = url;
    script.type = "text/javascript";
    script.id = "pay_script";
    var head = document.getElementsByTagName("head");
    if (head && head[0]) {
        head[0].appendChild(script);
    }
}
function onPayResult(success, desc) {
    if (payCallback) {
        payCallback(success, desc);
    }
}
// js跨域回调函数
function callbackjw75bua86qe3f7qv9ep16xdlocjxoexw() {
    execPay();
}