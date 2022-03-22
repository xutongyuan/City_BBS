package ssm.mapper;

import org.apache.ibatis.annotations.Param;

import ssm.po.Users;

public interface UsersMapper {
    int deleteByPrimaryKey(String email);

    int insert(Users record);

    int insertSelective(Users record);

    Users selectByIdAndPassword(@Param("email")String email,@Param("password")String password);

    Users selectByEmail(String email);
    
    int updateByUserId(Users user);
    
    Users selectUserIdByEmail(String email);

}