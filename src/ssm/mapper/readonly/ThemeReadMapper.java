package ssm.mapper.readonly;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import ssm.po.readonly.ThemeRead;

public interface ThemeReadMapper {


    ArrayList<ThemeRead> selectAllByArea(int area);
    ArrayList<ThemeRead> selectAllByGood();
    ArrayList<ThemeRead> selectAllByGoodAndArea(int area);

    ThemeRead selectPostById(Integer postId);
    //模糊搜索帖子
    ArrayList<ThemeRead> selectAllBySearch(String sql);
    
    ArrayList<ThemeRead> selectThemeByUserId(String userId);

    ArrayList<ThemeRead> selectThemeByUserIdAndGood(String userId);
    
}