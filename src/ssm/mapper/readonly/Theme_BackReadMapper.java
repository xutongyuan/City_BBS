package ssm.mapper.readonly;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import ssm.po.readonly.Theme_BackRead;

public interface Theme_BackReadMapper {
    
	//他的回复
    ArrayList<Theme_BackRead> selectTheme_BackByUserId(String userId);

}