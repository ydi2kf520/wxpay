package com.nj9you.wxpay.model;

/**
 * 统一下单参数
 * 
 * @author Administrator
 *
 */
public class OrderParams {
    /**商家名称-销售商品类目 如:腾讯-游戏 */
    private String body;

    /**商户订单号*/
    private String outTradeNo;

    /**自定义参数，可以为终端设备号(门店号或收银设备ID)，PC网页或公众号内支付可以传"WEB"*/
    private String deviceInfo;

    /**标价币种*/
    private String feeType = "CNY";

    /**订单总金额，单位为分*/
    private String totalFee;

    /**终端IP, APP和网页支付提交用户端ip，Native支付填调用微信支付API的机器IP。*/
    private String createIp;

    /**异步接收微信支付结果通知的回调地址，通知url必须为外网可访问的url，不能携带参数。*/
    private String notifyUrl;

    /**交易类型*/
    private String tradeType = "JSAPI";

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getOutTradeNo() {
        return outTradeNo;
    }

    public void setOutTradeNo(String outTradeNo) {
        this.outTradeNo = outTradeNo;
    }

    public String getDeviceInfo() {
        return deviceInfo;
    }

    public void setDeviceInfo(String deviceInfo) {
        this.deviceInfo = deviceInfo;
    }

    public String getFeeType() {
        return feeType;
    }

    public void setFeeType(String feeType) {
        this.feeType = feeType;
    }

    public String getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(String totalFee) {
        this.totalFee = totalFee;
    }

    public String getCreateIp() {
        return createIp;
    }

    public void setCreateIp(String createIp) {
        this.createIp = createIp;
    }

    public String getNotifyUrl() {
        return notifyUrl;
    }

    public void setNotifyUrl(String notifyUrl) {
        this.notifyUrl = notifyUrl;
    }

    public String getTradeType() {
        return tradeType;
    }

    public void setTradeType(String tradeType) {
        this.tradeType = tradeType;
    }

    @Override
    public String toString() {
        return "OrderParams [body=" + body + ", outTradeNo=" + outTradeNo + ", deviceInfo=" + deviceInfo + ", feeType="
                + feeType + ", totalFee=" + totalFee + ", createIp=" + createIp + ", notifyUrl=" + notifyUrl
                + ", tradeType=" + tradeType + "]";
    }

}
