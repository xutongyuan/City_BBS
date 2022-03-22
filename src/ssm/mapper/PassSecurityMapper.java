package ssm.mapper;

import ssm.po.PassSecurity;

public interface PassSecurityMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(PassSecurity record);

    PassSecurity selectByUserId(String userId);

    int updateByPrimaryKeySelective(PassSecurity passSecurity);
    
    PassSecurity selectQuestOneAndTwo(String UserId);
    
    PassSecurity selectUserByQuest(PassSecurity passSecurity);

}