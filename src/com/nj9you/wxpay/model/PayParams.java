package com.nj9you.wxpay.model;

import com.github.wxpay.sdk.WXPayUtil;

public class PayParams {

    /** 公众号ID */
    private String appId;
    /** 时间戳 */
    private String timpStamp = String.valueOf(System.currentTimeMillis() / 1000);
    /** 随机字符串 */
    private String nonceStr = WXPayUtil.generateNonceStr();
    /** 订单详情扩展字符串 */
    private String packageExt;
    /** 微信订单 */
    private String prepayId;
    /** 签名方式 */
    private String signType = "MD5";
    /** 签名 */
    private String paySign;

    /** 填充错误信息 */
    private String error;

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getTimpStamp() {
        return timpStamp;
    }

    public void setTimpStamp(String timpStamp) {
        this.timpStamp = timpStamp;
    }

    public String getNonceStr() {
        return nonceStr;
    }

    public void setNonceStr(String nonceStr) {
        this.nonceStr = nonceStr;
    }

    public String getPackageExt() {
        return packageExt;
    }

    public void setPackageExt(String packageExt) {
        this.packageExt = packageExt;
    }

    public String getPrepayId() {
        return prepayId;
    }

    public void setPrepayId(String prepayId) {
        this.prepayId = prepayId;
    }

    public String getSignType() {
        return signType;
    }

    public void setSignType(String signType) {
        this.signType = signType;
    }

    public String getPaySign() {
        return paySign;
    }

    public void setPaySign(String paySign) {
        this.paySign = paySign;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    @Override
    public String toString() {
        return "PayParams [appId=" + appId + ", timpStamp=" + timpStamp + ", nonceStr=" + nonceStr + ", packageExt="
                + packageExt + ", prepayId=" + prepayId + ", signType=" + signType + ", paySign=" + paySign + ", error="
                + error + "]";
    }
}
