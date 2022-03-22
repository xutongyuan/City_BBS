package ssm.service;

import java.util.ArrayList;
import java.util.Map;

import ssm.po.Friend;
import ssm.po.Integration;
import ssm.po.Message;
import ssm.po.News;
import ssm.po.PassSecurity;
import ssm.po.Userdetail;
import ssm.po.Users;
import ssm.po.readonly.IntegrationUsersRead;
import ssm.po.readonly.MessageRead;
import ssm.po.readonly.ThemeRead;
import ssm.po.readonly.Theme_BackRead;
import ssm.po.readonly.UsersInfo;


public interface LoginService {

	Users findUserByEmail(String email);
	
	int saveUser(Users u, Userdetail ud,Integration integration);
	
	//查询个人信息
	Users findUser(Users u);
	
	UsersInfo findUsersInfo(UsersInfo usersInfo);
	
	Integration findIntegration(String userId);
	
	//个人信息修改
	int updateUserDetail(Userdetail userdetail);
	
	int updateUser(Users user);
	
	PassSecurity findPassSecurity(String userId);
	int insertPassSecurity(PassSecurity passSecurity);
	int updatePassSecurity(PassSecurity passSecurity);
	
	Users findUserId(String email);
	PassSecurity findPassSecurityQuest(String userId);
	PassSecurity findPassSecurityRecord(PassSecurity passSecurity);
	
	//查看其他人信息
	IntegrationUsersRead findIntegrationUsersRead(String userId);
	 ArrayList<ThemeRead> findThemeReadByuserId(String userId);
	 ArrayList<Theme_BackRead> findTheme_BackRead(String userId);
	 ArrayList<ThemeRead> findThemeReadByuserIdAndGood(String userId);
	 
	//好友功能
	 int insertNews(News news);
	 ArrayList<News> findNewsByPostIdandRecevId(News news);
	 ArrayList<News> findNewsByPostIdandType(News news);
	 ArrayList<News> findNewsByRecevIdandType(News news);
	 Userdetail findUserdetail(String userId);
	 int deleteNews(Integer id);
	 int updateNewsAndInsertFriend(News news);
	 int updateNews(News news);
	 ArrayList<Friend> findFriends(String useraId);
	 int deleteFriend(String useraId,String userbId);
	 Friend findFriendByUserAB(Friend friend);
	 ArrayList<Userdetail> findUserdetails(Map<String, Object> map);
	 ArrayList<Userdetail> findUserdetails(String nicknameSql);
	 
	 
	 //站内信功能
	 int insertMessage(Message mes);
	 ArrayList<MessageRead> findMessages(String RecevId);
	 MessageRead findMessageReadA(Integer messId);
	 int deleteMessage(Integer messId);
	 int updateLookedOfMessage(Message mes);
	 //收信箱
	 ArrayList<MessageRead> findMessageReads(String postId);
	 MessageRead findMessageReadB(Integer messId);
}
