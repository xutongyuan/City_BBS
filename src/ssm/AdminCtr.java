package ssm;

import java.io.Console;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import ssm.po.Admin;
import ssm.po.Permission;
import ssm.po.Role;
import ssm.po.Users;
import ssm.po.readonly.ThemeRead;
import ssm.po.readonly.UsersInfo;
import ssm.service.AdminService;

@Controller
@RequestMapping("admin")
public class AdminCtr {

	@Autowired
	AdminService adminService;

	//校验是否登录
	@RequestMapping("/isLogin")
	@ResponseBody
	public Map<String, String> isLogin(HttpSession session){
		Map<String, String> map = new HashMap<>();
		Object admin1 = session.getAttribute("admin");
		if(admin1!=null){
			map.put("res", "success");
			map.put("mes", "验证成功");
		}else{
			map.put("res", "false");
			map.put("mes", "验证失败");
		}
		return map;
	}

	//退出登录
	@RequestMapping("/logout")
	@ResponseBody
	public Map<String, String> logout(HttpSession session){
		Map<String, String> map = new HashMap<>();
		session.removeAttribute("admin");
		map.put("res", "success");
		map.put("mes", "退出登录成功");

		return map;
	}

	//管理员登录
	@RequestMapping("/adminLogin")
	@ResponseBody
	public Map<String, String> adminLogin(Admin admin,HttpSession session){
		Map<String, String> map = new HashMap<>();
		Admin admin2 =  adminService.findAdmin(admin);
		if(admin2!=null){
			session.setAttribute("admin", admin2);
			map.put("res", "success");
			map.put("mes", "登录成功，点击确定跳转页面");
		}else {
			map.put("res", "fail");
			map.put("mes", "登录失败，请重新登录");
		}
		return map;
	}
	/*
	 * 权限操作*/
	@RequestMapping("/getPermissionList")
	@ResponseBody
	public Map<String, Object> getPermissionList(Integer page,Integer rows){
		Map<String,Object> map = new HashMap<>();
		ArrayList<Permission> arrayList = new ArrayList<>();
		if(page==null||rows==null){
			arrayList = adminService.findPermissionsAll();
			map.put("rows", arrayList);
		}else{
			Integer count = adminService.findPermissionCount();
			PageHelper.startPage(page, rows);
			Page<Permission> list= (Page<Permission>)adminService.findPermissionsAll();
			map.put("total", count);
			map.put("rows", list);
		}
		
		return map;
	
	} 
	
	@RequestMapping("/savePermission")
	@ResponseBody
	public Map<String, String> savePermissions(Permission permission){
		int rows= adminService.insertPermission(permission);
		Map<String,String > map = new HashMap<>();
		if(rows>0){
			map.put("res", "success");
		}else{
			map.put("res", "fail");
		}
		return map;
	
	} 
	
	@RequestMapping("/editPermission")
	@ResponseBody
	public Map<String, String> editPermissions(Permission permission){
		int rows= adminService.updatePermission(permission);
		Map<String,String > map = new HashMap<>();
		if(rows>0){
			map.put("res", "success");
		}else{
			map.put("res", "fail");
		}
		return map;
	} 
	
	@RequestMapping("/deletePermission")
	@ResponseBody
	public Map<String, String> deletePermission(Integer pmsId){
		int rows= adminService.deletePermission(pmsId);
		Map<String,String > map = new HashMap<>();
		if(rows>0){
			map.put("res", "success");
		}else{
			map.put("res", "fail");
		}
		return map;
	} 
	
	/*
	 * 角色操作*/
	@RequestMapping("/getRoleList")
	@ResponseBody
	public Map<String, Object> getRoleList(Integer page,Integer rows){
		Map<String,Object> map = new HashMap<>();
		ArrayList<Role> arrayList = new ArrayList<>();
		if(page==null||rows==null){
			arrayList =  adminService.findRoleAll();
			map.put("rows", arrayList);
		}else{
			Integer count = adminService.findRoleCount();
			PageHelper.startPage(page, rows);
			Page<Role> list= (Page<Role>)adminService.findRoleAll();
			map.put("total", count);
			map.put("rows", list);
		}
		return map;
	
	} 
	
	@RequestMapping("/saveRole")
	@ResponseBody
	public Map<String, String> saveRole(Role role){
		int rows= adminService.insertRole(role);
		Map<String,String > map = new HashMap<>();
		if(rows>0){
			map.put("res", "success");
		}else{
			map.put("res", "fail");
		}
		return map;
	
	} 
	
	@RequestMapping("/editRole")
	@ResponseBody
	public Map<String, String> editRole(Role role){
		Map<String,String > map = new HashMap<>();
		int rows= adminService.updateRole(role);
		if(rows>0){
			map.put("res", "success");
		}else{
			map.put("res", "fail");
		}
	return map;
	} 
	
	@RequestMapping("/deleteRole")
	@ResponseBody
	public Map<String, String> deleteRole(Integer roleId){
		int rows= adminService.deleteRole(roleId);
		Map<String,String > map = new HashMap<>();
		if(rows>0){
			map.put("res", "success");
		}else{
			map.put("res", "fail");
		}
		return map;
	} 
	
	//用户操作
	@RequestMapping("/getUserList")
	@ResponseBody
	public Map<String, Object> getUserList(int page,int rows){
		Map<String,Object> map = new HashMap<>();
		Integer count = adminService.findUsersInfoCount();
		PageHelper.startPage(page, rows);
		Page<UsersInfo> list= (Page<UsersInfo>)adminService.findUsersInfo();
		map.put("total", count);
		map.put("rows", list);
		return map;
	
	} 
	
	@RequestMapping("/editUsers")
	@ResponseBody
	public Map<String, String> editUsers(Users user){
		int rows= adminService.updateUsers(user);
		Map<String,String > map = new HashMap<>();
		if(rows>0){
			map.put("res", "success");
		}else{
			map.put("res", "fail");
		}
		return map;
	} 
}
