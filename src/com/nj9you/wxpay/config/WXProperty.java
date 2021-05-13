package com.nj9you.wxpay.config;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class WXProperty {

    private static final Properties sProperties;
    static {
        sProperties = new Properties();
        try {
            sProperties.load(WXProperty.class.getResourceAsStream("/wxpay.properties"));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String get(String key) {
        if (sProperties != null) {
            return String.valueOf(sProperties.get(key));
        }
        return null;
    }
}
