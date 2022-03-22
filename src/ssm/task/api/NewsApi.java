package ssm.task.api;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

//import api.util.HttpUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import ssm.po.ApiNewsTemp;
import ssm.util.HttpUtil;

public class NewsApi {

//   新闻api接口，用的是这个网站，可以自己上去注册，每天免费调用100次 https://api.binstd.com/
    public static final String APPKEY = "fddebd6ceae00d35";// 你的appkey
    public static final String URL = "https://api.binstd.com/news/get";
    public static final String channel = "头条";// utf8  新闻频道(头条,财经,体育,娱乐,军事,教育,科技,NBA,股票,星座,女性,健康,育儿)
    public static final int num = 5;// 数量 默认10，最大40

    public static List<ApiNewsTemp> NewGet() throws Exception {
        String result = null;
        String url = URL + "?channel=" + URLEncoder.encode(channel, "utf-8") + "&num=" + num + "&appkey=" + APPKEY;
        List<ApiNewsTemp> entityList = new ArrayList<>();
        try {
            result = HttpUtil.sendGet(url, "utf-8");
            JSONObject json = JSONObject.fromObject(result);
            if (json.getInt("status") != 0) {
                System.out.println(json.getString("msg"));
            } else {
                JSONObject resultarr = (JSONObject) json.opt("result");
                String channel = resultarr.getString("channel");
                String num = resultarr.getString("num");
                System.out.println(channel + " " + num);
                JSONArray list = resultarr.optJSONArray("list");
//                for (int i = 0; i < list.size(); i++) {
//                    JSONObject obj = (JSONObject) list.opt(i);
//                    String title = obj.getString("title");
//                    String time = obj.getString("time");
//                    String src = obj.getString("src");
//                    String category = obj.getString("category");
//                    String pic = obj.getString("pic");
//                    String content = obj.getString("content");
//                    String url1 = obj.getString("url");
//                    String weburl = obj.getString("weburl");
//                    System.out.println(title + " " + time + " " + src + " " + category + " " + pic + " " + content + " "
//                            + url1 + " " + weburl);
//                }
                entityList = JSONArray.toList(list, ApiNewsTemp.class);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return entityList;
    }
}