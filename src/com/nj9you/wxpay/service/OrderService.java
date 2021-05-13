package com.nj9you.wxpay.service;

import java.util.Map;

import com.nj9you.wxpay.model.PayParams;

public interface OrderService {

    /**
     * 生成支付参数
     * @param body 商品描述
     * @param merOrderId 商户订单
     * @param totalFee 总金额
     * @return
     */
    public PayParams generatePayParams(String body, String merOrderId, String totalFee);

    /**
     * 订单查询
     * 
     * @param outTradeNo
     * @return
     */
    public Map<String, String> orderOrder(String outTradeNo);

    /**
     * 退款查询
     * 
     * @param outTradeNo
     * @return
     */
    public Map<String, String> refundQuery(String outTradeNo);

    /**
     * 下载对账单
     * 
     * @param billDate
     * @param billType
     * @return
     */
    public Map<String, String> downloadBill(String billDate, String billType);

    /**
     * 验证签名
     * 
     * @param notifyData
     * @return
     */
    public Map<String, String> validateSign(String notifyData);
}
