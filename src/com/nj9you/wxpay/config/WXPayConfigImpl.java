package com.nj9you.wxpay.config;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;

import com.github.wxpay.sdk.WXPayConfig;

public class WXPayConfigImpl implements WXPayConfig {
    private static WXPayConfigImpl sWXPayConfigImpl = null;
    static {
        try {
            sWXPayConfigImpl = new WXPayConfigImpl();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private byte[] certData;
    public static WXPayConfigImpl get() {
        return sWXPayConfigImpl;
    }

    private WXPayConfigImpl() throws Exception {
        String certPath = WXProperty.get("apiclient_cert");
        System.out.println("certPath : " + certPath);
        URL url =  WXPayConfigImpl.class.getResource("/" + certPath);
        File file = new File(url.getPath());
        InputStream certStream = new FileInputStream(file);
        this.certData = new byte[(int) file.length()];
        certStream.read(this.certData);
        certStream.close();
    }

    public String getAppID() {
        return WXProperty.get("wx_app_id");
    }

    public String getMchID() {
        return WXProperty.get("mch_id");
    }

    public String getKey() {
        return WXProperty.get("app_key");
    }

    public InputStream getCertStream() {
        ByteArrayInputStream certBis = new ByteArrayInputStream(this.certData);
        return certBis;
    }

    public int getHttpConnectTimeoutMs() {
        return 8000;
    }

    public int getHttpReadTimeoutMs() {
        return 10000;
    }
}
