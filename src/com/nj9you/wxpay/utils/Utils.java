package com.nj9you.wxpay.utils;

import java.util.Random;

public class Utils {

    /**
     * 生成随机字符串
     * 
     * @param length
     *            生成的随机字符串长度
     * @return
     */
    public static String generateRandomString(int length) {
        String base = "abcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; i++) {
            int number = random.nextInt(base.length());
            sb.append(base.charAt(number));
        }
        return sb.toString();
    }
}
