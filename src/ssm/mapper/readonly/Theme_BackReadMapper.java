package ssm.mapper.readonly;


import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import ssm.po.readonly.Theme_BackRead;

public interface Theme_BackReadMapper {
    
	//ไป็ๅๅค
    ArrayList<Theme_BackRead> selectTheme_BackByUserId(String userId);

}