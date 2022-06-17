package ssm.task.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ssm.ContentCtr;
import ssm.mapper.ApiNewsTempMapper;
import ssm.po.ApiNewsTemp;
import ssm.po.Theme;
import ssm.service.ContentService;
import ssm.task.api.NewsApi;
import ssm.task.service.TaskService;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class TaskServiceImpl implements TaskService {


    @Autowired
    ApiNewsTempMapper apiNewsTempMapper;
    @Autowired
    ContentCtr contentCtr;
    @Autowired
    ContentService contentService;

    @Override
    @Transactional
    public int addNewsTemp(String chan) throws Exception {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = sdf.format(new Date());
        List<ApiNewsTemp> list = NewsApi.NewGet(chan);
        for (ApiNewsTemp entity:list
             ) {
            if(entity.getContent().length()>10000){//超过1000字，后面不保存
                entity.setContent(entity.getContent().substring(0,9999));
            }
            entity.setCreationDate(date);
            entity.setSync("0");
            apiNewsTempMapper.insertSelective(entity);
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

        return noPostNews.size();
    }
}
