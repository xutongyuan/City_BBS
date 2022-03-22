package ssm.mapper;

import ssm.po.ApiNewsTemp;
import ssm.po.Theme;

import java.util.ArrayList;
import java.util.List;

public interface ApiNewsTempMapper {
    int deleteByPrimaryKey(Integer postId);

    int insertSelective(ApiNewsTemp record);

    List<ApiNewsTemp> findNoPostNews();

    int updateByPrimaryKeySelective(ApiNewsTemp record);

    
  
}