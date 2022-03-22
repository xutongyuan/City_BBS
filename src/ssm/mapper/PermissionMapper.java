package ssm.mapper;

import java.util.ArrayList;

import ssm.po.Permission;

public interface PermissionMapper {
    int deleteByPrimaryKey(Integer pmsId);

    int insert(Permission permission);

    Permission selectByPrimaryKey(Integer pmsId);
    
    ArrayList<Permission> selectAll();
    
    Integer selectPermissionCount();

    int updateByPrimaryKeySelective(Permission record);

    int updateByPrimaryKey(Permission record);
}