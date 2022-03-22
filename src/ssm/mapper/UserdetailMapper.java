package ssm.mapper;

import java.util.ArrayList;
import java.util.Map;

import ssm.po.Userdetail;

public interface UserdetailMapper {
    int deleteByPrimaryKey(String userId);

    int insert(Userdetail record);

    int insertSelective(Userdetail record);

    Userdetail selectByPrimaryKey(String userId);
    
    ArrayList<Userdetail> selectByUserIdjihe(Map<String, Object> map);
    
    ArrayList<Userdetail> selectByPmsArea(String area);
    
    
    ArrayList<Userdetail> selectByNickName(String nicknameSql);

    int updateByPrimaryKeySelective(Userdetail record);

    
}