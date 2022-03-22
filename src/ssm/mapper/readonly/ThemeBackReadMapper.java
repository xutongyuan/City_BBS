package ssm.mapper.readonly;

import java.util.ArrayList;

import ssm.po.ThemeBack;
import ssm.po.readonly.ThemeBackRead;

public interface ThemeBackReadMapper {

    ArrayList<ThemeBackRead> selectByBackThemeId(Integer backThemeId);
}