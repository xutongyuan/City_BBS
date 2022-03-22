package ssm.mapper;

import java.util.ArrayList;

import ssm.po.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer roleId);

    int insert(Role role);

    Role selectByPrimaryKey(Integer roleId);
    
    ArrayList<Role> selectAll();
    
    Integer selectRoleCount();

    int updateByPrimaryKeySelective(Role role);

}