package ssm.service;

import java.util.ArrayList;






import ssm.po.Admin;
import ssm.po.Permission;
import ssm.po.Role;
import ssm.po.Users;
import ssm.po.readonly.UsersInfo;

public interface AdminService {
	//管理员登录
	Admin findAdmin(Admin admin);
	
	//权限操作
	ArrayList<Permission> findPermissionsAll();
	
	int insertPermission(Permission permission);
	
	int updatePermission(Permission permission);
	
	Integer findPermissionCount();
	
	int deletePermission(Integer pmsId);
	
	//角色操作
	ArrayList<Role> findRoleAll();
	
	int insertRole(Role role);
	
	int updateRole (Role role);
	
	Integer findRoleCount();
	
	int deleteRole(Integer pmsId);
	
	//用户操作
	ArrayList<UsersInfo> findUsersInfo();
	
	Integer findUsersInfoCount();
	
	int updateUsers(Users user);
	

	
}
