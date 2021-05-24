// 定义支付成功的回调
var JiuYouPay = {
    payCallback : null,
    pay : function (body, totalfee, orderId, callback) {
        payCallback = callback;
        checkPayEnv(body, totalfee, orderId);
    }
};

function checkPayEnv(body, totalfee, orderId) {
    if (isWeixin()) {
        wxPayPublic(body, totalfee, orderId);
    } else {
        alert("不在微信浏览器中无法使用公众号支付");
    }
}

function isWeixin(){
    var ua = navigator.userAgent.toLowerCase();
    if(ua.match(/MicroMessenger/i)=="micromessenger") {
        return true;
     } else {
        return false;
    }
}

/**公众号支付*/
function wxPayPublic(body, totalfee, orderId) {
    loadPayScript(body, totalfee, orderId);
}
/*
 *使用JS跨域的方案，向服务器请求数据
 */
function loadPayScript(body, totalfee, orderId) {
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
    script.id = "payscript";
    var head = document.getElementsByTagName("head");
    if (head && head[0]) {
        head[0].appendChild(script);
    }
}
/**公众号支付结果回调*/
function onPayResult(success, desc) {
    if (payCallback) {
        payCallback(success, desc);
    }
}
// js跨域回调函数
function callbackjw75bua86qe3f7qv9ep16xdlocjxoexw() {
    execPay();
}