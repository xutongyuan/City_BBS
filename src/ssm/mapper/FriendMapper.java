package ssm.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import ssm.po.Friend;

public interface FriendMapper {
    int deleteByPrimaryKey(Integer id);
    
    int deleteByUseraAndUserb(@Param("useraId")String useraId,@Param("userbId")String userbId);

    int insert(Friend friend);

    Friend selectByUseraIdAndUserbId(Friend friend);
    
    Friend selectByPrimaryKey(Integer id);
    
    ArrayList<Friend> selectAllByUseraId(String useraId);

    int updateByPrimaryKeySelective(Friend record);

    int updateByPrimaryKey(Friend record);
}