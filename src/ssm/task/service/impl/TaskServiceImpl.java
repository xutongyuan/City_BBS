package ssm.task.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ssm.ContentCtr;
import ssm.mapper.ApiNewsTempMapper;
import ssm.po.ApiNewsTemp;
import ssm.po.Theme;
import ssm.po.readonly.ThemeRead;
import ssm.service.ContentService;
import ssm.service.LoginService;
import ssm.task.api.BaiduPushApi;
import ssm.task.api.NewsApi;
import ssm.task.service.TaskService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TaskServiceImpl implements TaskService {


    @Autowired
    ApiNewsTempMapper apiNewsTempMapper;
    @Autowired
    ContentCtr contentCtr;
    @Autowired
    ContentService contentService;
    @Autowired
    LoginService loginService;

    @Override
    @Transactional
    public int addNewsTemp(String chan) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = sdf.format(new Date());
        List<ApiNewsTemp> list = NewsApi.NewGet(chan);
        int num = 0;
        for (ApiNewsTemp entity:list
             ) {
            //每次只新增5条，已存在的不新增
            if(num<5){
                List<ThemeRead> exist = contentService.findPostListByTitle(entity.getTitle());
                if(exist!=null&&exist.isEmpty()){
                    if(entity.getContent().length()>10000){//超过1000字，后面不保存
                        entity.setContent(entity.getContent().substring(0,9999));
                    }
                    entity.setCreationDate(date);
                    entity.setSync("0");
                    apiNewsTempMapper.insertSelective(entity);
                    num++;
                }
            }
        }
        return list.size();
    }

    @Transactional
    public int autoPost() throws Exception {
        //获取未发布新闻
        List<ApiNewsTemp> noPostNews = apiNewsTempMapper.findNoPostNews();

        List<ApiNewsTemp> apiNewsTemps = new ArrayList<>();
        List<Theme> themes = new ArrayList<>();
        int i=0;
        for (ApiNewsTemp temp:noPostNews
             ) {
            Theme theme = new Theme();
            theme.setTitle(temp.getTitle());
            theme.setContent(temp.getContent());
            theme.setArea(20);//新闻模块
            //前3条新闻设置首页展示
            if(i<3){
                theme.setIsNav("Y");
                i++;
            }
            themes.add(theme);
            apiNewsTemps.add(temp);
        }
       //发布帖子
        themes.forEach(x->{
            contentCtr.submitPost(x, null);
        });
        //更新中间表标志
        apiNewsTemps.forEach(x->{
            apiNewsTempMapper.updateByPrimaryKeySelective(x);
        });
        //有图片的更新到轮播图
        contentService.insertBannerList(themes);
        //推送到百度收录
        List<String> urlList = themes.stream().map(x -> BaiduPushApi.SITE_URL + "/content/showDetail?postId=" + x.getPostId() + "&userId=" + x.getUserId() + "&area=" + x.getArea()).collect(Collectors.toList());
        BaiduPushApi.pushBatch(urlList);

        return noPostNews.size();
    }

    @Transactional
    public int ThemePush() throws Exception {
        //全量推送帖子到百度
        List<ThemeRead> list = loginService.findThemeReadByuserId("cz4153");
        List<String> urlList = list.stream().map(x -> BaiduPushApi.SITE_URL + "/content/showDetail?postId=" + x.getPostId() + "&userId=" + x.getUserId() + "&area=" + x.getArea()).collect(Collectors.toList());
        BaiduPushApi.pushBatch(urlList);
        System.out.println(urlList.size());
        return urlList.size();
    }
}
