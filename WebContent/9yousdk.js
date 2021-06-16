// 注入js文件的代码
// var scripts = document.createElement("script"); scripts.setAttribute("src","http://10.0.0.201:8080/wxpay/src/project.js"); document.body.appendChild(scripts);

/**
 * 判断是否是微信浏览器
 * 
 * @returns {Boolean}
 */
function isWeixin() {
    var ua = navigator.userAgent.toLowerCase();
    if (ua.match(/MicroMessenger/i) == "micromessenger") {
        return true;
    } else {
        return false;
    }
}

function loadGame(gameURL, orientation) {
    if (orientation) {
        // 横屏游戏
        $("body").append('<div id="gameFrameDiv" style="width: 100%; height: 100%; '
                        +' position: absolute; top: 0px; left: 0px;">'
                        +'<iframe id="gameFrame" name="gameFrame" src="' + gameURL + '" frameborder="no" '
                        +'border="0px" marginwidth="0px" marginheight="0px" '
                        +'scrolling="auto" style="width: 100%; height: 100%;">'
                        +'</iframe>'
                        +'</div>');
        window.onorientationchange = function() {
            if (window.orientation == 90 || window.orientation == -90) {
                $("#superise").css({
                    "left" : $(window).width() - 20,
                    "top" : "30%"
                });
            }
        };
    } else {
        // 非横屏游戏
        if (/*sdk.isAvuAPP()*/false) {
            $("body").append('<div id="gameFrameDiv" style="width: '
                                    + document.body.scrollWidth
                                    + 'px; height: '
                                    + document.body.scrollHeight
                                    + 'px; position: absolute; top: 0px; left: 0px;"><iframe id="gameFrame" name="gameFrame" src="'
                                    + gameURL
                                    + '" frameborder="no" border="0px" marginwidth="0px" marginheight="0px" scrolling="auto" style="width: '
                                    + document.body.scrollWidth
                                    + 'px; height: '
                                    + document.body.scrollHeight
                                    + 'px;"></iframe></div>');
        } else {
            $("body").append('<div id="gameFrameDiv" style="width: '
                                    + $(window).width()
                                    + 'px; height: '
                                    + $(window).height()
                                    + 'px; position: absolute; top: 0px; left: 0px;"><iframe id="gameFrame" name="gameFrame" src="'
                                    + gameURL
                                    + '" frameborder="no" border="0px" marginwidth="0px" marginheight="0px" scrolling="auto" style="width: '
                                    + $(window).width() + 'px; height: '
                                    + $(window).height()
                                    + 'px;"></iframe></div>');
        }
    }
}

function onBridgeReady(appId, timeStamp, nonceStr, packageStr, signType,
        paySign) {
    WeixinJSBridge.invoke('getBrandWCPayRequest', {
        "appId" : appId, // 公众号名称，由商户传入
        "timeStamp" : timeStamp, // 时间戳，自1970年以来的秒数
        "nonceStr" : nonceStr, // 随机串
        "package" : packageStr, // 扩展字段
        "signType" : signType, // 微信签名方式
        "paySign" : paySign
    // 微信签名
    }, function(res) {
        // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回 ok，但并不保证它绝对可靠。
        if (res.err_msg == "get_brand_wcpay_request:ok") {
            onPayResult(true, res.err_desc);
        } else if (res.err_msg == "get_brand_wcpay_request:fail") {
            onPayResult(false, res.err_desc);
        }
    });
}

function execPay(appId, timeStamp, nonceStr, packageStr, signType, paySign) {
    if (typeof WeixinJSBridge == "undefined") {
        if (document.addEventListener) {
            document.addEventListener('WeixinJSBridgeReady', onBridgeReady,
                    false);
        } else if (document.attachEvent) {
            document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
            document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
        }
    } else {
        onBridgeReady(appId, timeStamp, nonceStr, packageStr, signType, paySign);
    }
}

function preparePay(data) {
    try {
        var jobj = eval("(" + data + ")");
        var appId = jobj["appId"];
        var timeStamp = jobj["timeStamp"];
        var nonceStr = jobj["nonceStr"];
        var packageStr = jobj["packageStr"];
        var signType = jobj["signType"];
        var paySign = jobj["paySign"];
        execPay(appId, timeStamp, nonceStr, packageStr, signType, paySign);
    } catch (e) {
        onPayResult(false, "解析支付数据失败");
    }
}

function requestWxPayArgs(body, total_fee, order_id, open_id) {
    $.ajax({
        url : "pay_script.jsp",
        data : {
            "body" : body,
            "total_fee" : total_fee,
            "order_id" : order_id,
            "open_id" : open_id
        },
        type : "POST",
        success : function(data) {
            preparePay(data);
        },
        error : function() {
            onPayResult(false, "请求支付数据失败");
        }
    });
}

function onPayResult(success, desc) {
    if (window.JYSDK.callback) {
        window.JYSDK.callback(success, desc);
    }
}

!function() {
    // 定义sdk
    function JouYouSdk() {
        // 回调函数
        this.callback = null;
    }

    JouYouSdk.prototype.init = function() {
    };

    // 支付
    JouYouSdk.prototype.pay = function(body, total_fee, order_id, open_id, callback) {
        this.callback = callback;
        if (isWeixin() || true) {
            requestWxPayArgs(body, total_fee, order_id, open_id);
        } else {
            alert("非微信浏览器");
        }
    };

    window.JYSDK = new JouYouSdk();
}();