package ssm.mapper;

import java.util.ArrayList;

import ssm.po.News;

public interface NewsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(News news);
    News selectByPrimaryId(Integer id);
    
    ArrayList<News> selectByPostIdandRecevId(News news);
    
    ArrayList<News> selectByPostIdAndType(News news);
    
    ArrayList<News> selectByRecevIdAndType(News news);
    
    int updateByPrimaryKeySelective(News record);

}