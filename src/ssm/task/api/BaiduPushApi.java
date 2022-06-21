package ssm.task.api;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import ssm.po.ApiNewsTemp;
import ssm.util.HttpUtil;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BaiduPushApi {

//   百度资源搜索平台 https://ziyuan.baidu.com/linksubmit/index?site=http://www.weiaj.com/
    public static final String URL = "http://data.zz.baidu.com/urls?site=http://www.weiaj.com&token=0fOJxOSkFP91T8W8";
    public static final String SITE_URL = "http://www.weiaj.com";

//    public static void main(String[] args) {
//        try {
//            push();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
    public static boolean pushBatch(List<String> list){
        for (String params:list
             ) {
            push(params);
        }
        return true;
    }
    public static boolean push(String params){
        String result = null;
        String url =URL;
        try {
            Map<String, String> header = new HashMap<>();
            header.put("Content-Type","text/plain");
            header.put("Accept","*/*");

//            String params = SITE_URL+"/content/showDetail?postId=3443&userId=cz4153&area=20";
            result = HttpUtil.doPostJson(url, params,header);
            if(result==null){
                return false;
            }
            JSONObject json = JSONObject.fromObject(result);
            if (json.getInt("success") >0) {
                //推送百度普通收录成功
                System.out.println("推送百度普通收录成功："+params);
            }else{
                System.out.println("推送百度普通收录失败，不合法的url列表：\r\n"+json.getString("not_valid"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }
}