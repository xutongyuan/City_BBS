package ssm.mapper;

import ssm.po.Admin;

public interface AdminMapper {
    int deleteByPrimaryKey(Integer admId);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Integer admId);
    
    Admin selectByUsernameAndPassword(Admin admin);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);
}