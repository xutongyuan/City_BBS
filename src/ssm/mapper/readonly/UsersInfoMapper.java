package ssm.mapper.readonly;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import ssm.po.Users;
import ssm.po.readonly.UsersInfo;

public interface UsersInfoMapper {
    int deleteByPrimaryKey(String email);

    int insert(Users record);

    int insertSelective(Users record);

    UsersInfo selectByUserId(UsersInfo usersInfo);
    
    ArrayList<UsersInfo> selectAll();

    int updateByPrimaryKeySelective(Users record);

    int updateByPrimaryKey(Users record);
    
    Integer selectUsersInfoCount();
}