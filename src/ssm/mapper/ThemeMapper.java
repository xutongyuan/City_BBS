package ssm.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import ssm.po.Theme;

public interface ThemeMapper {
    int deleteByPrimaryKey(Integer postId);

    int insertSelective(Theme record);

    Theme selectByPrimaryKey(Integer postId);

    int updateByPrimaryKeySelective(Theme record);

    ArrayList<Theme> selectPostByRecentBack();
    
    ArrayList<Theme> selectThemeByRecentPost(@Param(value = "isNav")String isNav);
    
  
}