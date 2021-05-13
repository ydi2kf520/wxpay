package com.nj9you.wxpay.service.impl;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

import com.github.wxpay.sdk.WXPay;
import com.github.wxpay.sdk.WXPayConstants.SignType;
import com.github.wxpay.sdk.WXPayUtil;
import com.nj9you.wxpay.config.WXPayConfigImpl;
import com.nj9you.wxpay.config.WXProperty;
import com.nj9you.wxpay.model.OrderParams;
import com.nj9you.wxpay.model.PayParams;
import com.nj9you.wxpay.service.OrderService;
import com.nj9you.wxpay.utils.Utils;

public class OrderServiceImpl implements OrderService {

    @Override
    public PayParams generatePayParams(String body, String merOrderId, String totalFee) {
        String notifyUrl = WXProperty.get("notify_url");
        String deviceInfo = WXProperty.get("device_info");
        String nonce_str = WXPayUtil.generateNonceStr();
        String appId = WXProperty.get("wx_app_id");
        String tradeType = WXProperty.get("trade_type");
        String appKey = WXProperty.get("app_key");
        String feeType = WXProperty.get("fee_type");
        String sign = null;
        String timpStamp = String.valueOf(System.currentTimeMillis() / 1000);

        // TODO : 需要整合
        // 存储商户订单并生成平台订单
        String platformOrder = storeMerchantIdAndGeneratePlatformOrderId(merOrderId);

        OrderParams params = new OrderParams();
        params.setBody(body);
        params.setFeeType(feeType);
        params.setTotalFee(totalFee);
        params.setOutTradeNo(platformOrder);
        params.setNotifyUrl(notifyUrl);
        params.setDeviceInfo(deviceInfo);
        try {
            params.setCreateIp(InetAddress.getLocalHost().getHostAddress());
        } catch (UnknownHostException e1) {
            e1.printStackTrace();
        }
        params.setTradeType(tradeType);
        // 调用统一下单接口
        Map<String, String> resultMap = unifiedOrder(params);
        String unifiedOrder = null;
        String errorMsg = null;
        if (resultMap != null) {
            if ("SUCCESS".equals(resultMap.get("return_code"))) {
                unifiedOrder = resultMap.get("prepay_id");
            } else if ("FAIL".equals(resultMap.get("return_code"))){
                errorMsg = resultMap.get("return_msg");
            }
        }

        Map<String, String> map = new HashMap<String, String>();
        map.put("appId", appId);
        map.put("timeStamp", timpStamp);
        map.put("nonce_str", nonce_str);
        map.put("package", "prepay_id=" + unifiedOrder);
        try {
            // 为JSAPI生成签名信息
            sign = WXPayUtil.generateSignature(map, appKey, SignType.MD5);
        } catch (Exception e) {
            e.printStackTrace();
        }
        PayParams payParams = new PayParams();
        payParams.setAppId(appId);
        payParams.setPackageExt("prepay_id=" + unifiedOrder);
        payParams.setPrepayId(unifiedOrder);
        payParams.setTimpStamp(timpStamp);
        payParams.setNonceStr(nonce_str);
        payParams.setPaySign(sign);
        payParams.setSignType(SignType.MD5.name());
        payParams.setError(errorMsg);
        return payParams;
    }

    /**
     * 存储商户订单ID， 并且声称平台订单ID
     * 
     * @param merId
     * @return
     */
    private String storeMerchantIdAndGeneratePlatformOrderId(String merId) {
        // 生成平台ID
        // 存储商户订单和平台ID对应关系
        return Utils.generateRandomString(32);
    }

    private Map<String, String> unifiedOrder(OrderParams params) {
        System.out.println("" + params);
        WXPayConfigImpl config = null;
        try {
            config = WXPayConfigImpl.get();
            WXPay wxpay = new WXPay(config);
            Map<String, String> data = new HashMap<String, String>();
            data.put("body", params.getBody());
            data.put("out_trade_no", params.getOutTradeNo());
            data.put("device_info", params.getDeviceInfo());
            data.put("fee_type", params.getFeeType());
            data.put("total_fee", params.getTotalFee());
            data.put("spbill_create_ip", params.getCreateIp());
            data.put("notify_url", params.getNotifyUrl());
            data.put("trade_type", params.getTradeType()); // 此处指定为扫码支付
            Map<String, String> resp = wxpay.unifiedOrder(data);
            return resp;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Map<String, String> orderOrder(String outTradeNo) {
        return null;
    }

    @Override
    public Map<String, String> refundQuery(String outTradeNo) {
        return null;
    }

    @Override
    public Map<String, String> downloadBill(String billDate, String billType) {
        return null;
    }

    @Override
    public Map<String, String> validateSign(String notifyData) {
        return null;
    }
}
