package ssm.mapper;

import ssm.po.ThemeBack;

public interface ThemeBackMapper {
    int deleteByPrimaryKey(Integer backId);
    
    int deleteByBackThemeId(Integer backThemeId);

    int insertSelective(ThemeBack record);

    ThemeBack selectByPrimaryKey(Integer backId);

    int updateByPrimaryKeySelective(ThemeBack record);

    int updateByPrimaryKey(ThemeBack record);
}