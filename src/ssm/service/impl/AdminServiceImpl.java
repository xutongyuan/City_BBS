package ssm.service.impl;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ssm.mapper.AdminMapper;
import ssm.mapper.PermissionMapper;
import ssm.mapper.RoleMapper;
import ssm.mapper.UsersMapper;
import ssm.mapper.readonly.UsersInfoMapper;
import ssm.po.Admin;
import ssm.po.Permission;
import ssm.po.Role;
import ssm.po.Users;
import ssm.po.readonly.UsersInfo;
import ssm.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	PermissionMapper permissionMapper;
	@Autowired
	RoleMapper roleMapper;
	@Autowired
	UsersInfoMapper usersInfoMapper;
	@Autowired
	UsersMapper usersMapper;
	@Autowired
	AdminMapper adminMapper;
	
	@Override
	public Admin findAdmin(Admin admin) {
		// TODO Auto-generated method stub
		return adminMapper.selectByUsernameAndPassword(admin);
	}
	
	@Override
	public ArrayList<Permission> findPermissionsAll() {
		// TODO Auto-generated method stub
		return permissionMapper.selectAll();
	}
	@Override
	public int insertPermission(Permission permission) {
		// TODO Auto-generated method stub
		return permissionMapper.insert(permission);
	}
	@Override
	public int updatePermission(Permission permission) {
		// TODO Auto-generated method stub
		return permissionMapper.updateByPrimaryKeySelective(permission);
	}
	@Override
	public Integer findPermissionCount() {
		// TODO Auto-generated method stub
		return permissionMapper.selectPermissionCount();
	}
	@Override
	public int deletePermission(Integer pmsId) {
		// TODO Auto-generated method stub
		return permissionMapper.deleteByPrimaryKey(pmsId);
	}
	
	//
	@Override
	public ArrayList<Role> findRoleAll() {
		// TODO Auto-generated method stub
		return roleMapper.selectAll();
	}
	@Override
	public int insertRole(Role role) {
		// TODO Auto-generated method stub
		return roleMapper.insert(role);
	}
	@Override
	public int updateRole(Role role){
		// TODO Auto-generated method stub
		return roleMapper.updateByPrimaryKeySelective(role);
	}
	@Override
	public Integer findRoleCount() {
		// TODO Auto-generated method stub
		return roleMapper.selectRoleCount();
	}
	@Override
	public int deleteRole(Integer roleId) {
		// TODO Auto-generated method stub
		return roleMapper.deleteByPrimaryKey(roleId);
	}
	
	//用户操作
	@Override
	public ArrayList<UsersInfo> findUsersInfo() {
		// TODO Auto-generated method stub
		return usersInfoMapper.selectAll();
	}
	@Override
	public Integer findUsersInfoCount() {
		// TODO Auto-generated method stub
		return usersInfoMapper.selectUsersInfoCount();
	}
	@Override
	public int updateUsers(Users user) {
		// TODO Auto-generated method stub
		return usersMapper.updateByUserId(user);
	}


}
