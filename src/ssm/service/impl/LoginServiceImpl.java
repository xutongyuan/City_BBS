package ssm.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ssm.mapper.FriendMapper;
import ssm.mapper.IntegrationMapper;
import ssm.mapper.MessageMapper;
import ssm.mapper.NewsMapper;
import ssm.mapper.PassSecurityMapper;
import ssm.mapper.UserdetailMapper;
import ssm.mapper.UsersMapper;
import ssm.mapper.readonly.IntegrationUsersReadMapper;
import ssm.mapper.readonly.MessageReadMapper;
import ssm.mapper.readonly.ThemeReadMapper;
import ssm.mapper.readonly.Theme_BackReadMapper;
import ssm.mapper.readonly.UsersInfoMapper;
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
import ssm.service.LoginService;
import ssm.util.converter.DateConverter;


@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	UsersMapper users;
	@Autowired
	UserdetailMapper udetail;
	@Autowired
	IntegrationMapper integrationMapper;
	@Autowired
	UsersInfoMapper usersInfoMapper;
	@Autowired
	PassSecurityMapper passSecurityMapper;
	@Autowired
	IntegrationUsersReadMapper iurMapper;
	@Autowired
	ThemeReadMapper themeReadMapper;
	@Autowired
	Theme_BackReadMapper theme_BackReadMapper;
	@Autowired
	NewsMapper newsMapper;
	@Autowired
	FriendMapper friendMapper;
	@Autowired
	MessageMapper messageMapper;
	@Autowired
	MessageReadMapper messageReadMapper;
	
	
	@Override
	public Users findUserByEmail(String email) {
		// TODO Auto-generated method stub
		return users.selectByEmail(email);
	}
	
	@Override
	public int saveUser(Users u,Userdetail ud,Integration integration) {
		// TODO Auto-generated method stub
		int u_row = users.insert(u);
		int ud_row = udetail.insert(ud);
		int i_row = integrationMapper.insert(integration);
		return ud_row;
	}

	@Override
	public Users findUser(Users u) {
		// TODO Auto-generated method stub
		Users user =  users.selectByIdAndPassword(u.getEmail(), u.getPassword());
		return user;
	}

	@Override
	public UsersInfo findUsersInfo(UsersInfo usersInfo) {
		// TODO Auto-generated method stub
		
		return usersInfoMapper.selectByUserId(usersInfo);
	}

	@Override
	public Integration findIntegration(String userId) {
		// TODO Auto-generated method stub
		Integration integration = integrationMapper.selectByPrimaryKey(userId);
		return integration;
	}

	@Override
	public int updateUserDetail(Userdetail userdetail) {
		// TODO Auto-generated method stub
		int rows = udetail.updateByPrimaryKeySelective(userdetail);
		return rows;
	}

	@Override
	public int updateUser(Users user) {
		// TODO Auto-generated method stub
		int rows = users.updateByUserId(user);
		return rows;
	}

	@Override
	public int insertPassSecurity(PassSecurity passSecurity) {
		// TODO Auto-generated method stub
		int rows = passSecurityMapper.insert(passSecurity);
		return rows;
	}

	@Override
	public PassSecurity findPassSecurity(String userId) {
		// TODO Auto-generated method stub
		return passSecurityMapper.selectByUserId(userId);
	}

	@Override
	public int updatePassSecurity(PassSecurity passSecurity) {
		// TODO Auto-generated method stub
		return passSecurityMapper.updateByPrimaryKeySelective(passSecurity);
	}

	@Override
	public PassSecurity findPassSecurityQuest(String userId) {
		// TODO Auto-generated method stub
		return passSecurityMapper.selectQuestOneAndTwo(userId);
	}

	@Override
	public Users findUserId(String email) {
		// TODO Auto-generated method stub
		return users.selectUserIdByEmail(email);
	}

	@Override
	public PassSecurity findPassSecurityRecord(PassSecurity passSecurity) {
		// TODO Auto-generated method stub
		return passSecurityMapper.selectUserByQuest(passSecurity);
	}

	@Override
	public IntegrationUsersRead findIntegrationUsersRead(String userId) {
		// TODO Auto-generated method stub
		return iurMapper.selectByPrimaryKey(userId);
	}

	@Override
	public  ArrayList<ThemeRead> findThemeReadByuserId(String userId) {
		// TODO Auto-generated method stub
		return themeReadMapper.selectThemeByUserId(userId);
	}

	@Override
	public ArrayList<Theme_BackRead> findTheme_BackRead(String userId) {
		// TODO Auto-generated method stub
		return theme_BackReadMapper.selectTheme_BackByUserId(userId);
	}

	@Override
	public ArrayList<ThemeRead> findThemeReadByuserIdAndGood(String userId) {
		// TODO Auto-generated method stub
		return themeReadMapper.selectThemeByUserIdAndGood(userId);
	}

	@Override
	public int insertNews(News news) {
		// TODO Auto-generated method stub
		return newsMapper.insert(news);
	}

	@Override
	public ArrayList<News> findNewsByPostIdandRecevId(News news) {
		// TODO Auto-generated method stub
		return newsMapper.selectByPostIdandRecevId(news);
	}

	@Override
	public ArrayList<News> findNewsByPostIdandType(News news) {
		// TODO Auto-generated method stub
		return newsMapper.selectByPostIdAndType(news);
	}

	@Override
	public ArrayList<News> findNewsByRecevIdandType(News news) {
		// TODO Auto-generated method stub
		return newsMapper.selectByRecevIdAndType(news);
	}

	@Override
	public Userdetail findUserdetail(String userId) {
		// TODO Auto-generated method stub
		return udetail.selectByPrimaryKey(userId);
	}

	@Override
	public int deleteNews(Integer id) {
		// TODO Auto-generated method stub
		return newsMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int updateNewsAndInsertFriend(News news) {
		// TODO Auto-generated method stub
		newsMapper.updateByPrimaryKeySelective(news);
		News news2 = newsMapper.selectByPrimaryId(news.getId());
		
		//相互添加好友
		Friend friend = new Friend();
		friend.setUseraId(news2.getPostId());
		friend.setUserbId(news2.getRecevId());
		friend.setAddTime(new DateConverter().toString(new Date()));
		friendMapper.insert(friend);
		
		friend.setUseraId(news2.getRecevId());
		friend.setUserbId(news2.getPostId());
		int rows = friendMapper.insert(friend);
		
		return rows;
	}

	@Override
	public int updateNews(News news) {
		// TODO Auto-generated method stub
		return newsMapper.updateByPrimaryKeySelective(news);
	}

	@Override
	public ArrayList<Friend> findFriends(String useraId) {
		// TODO Auto-generated method stub
		return friendMapper.selectAllByUseraId(useraId);
	}

	@Override
	public ArrayList<Userdetail> findUserdetails(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return udetail.selectByUserIdjihe(map);
	}

	@Override
	public ArrayList<Userdetail> findUserdetails(String nicknameSql) {
		// TODO Auto-generated method stub
		return udetail.selectByNickName(nicknameSql);
	}

	@Override
	public Friend findFriendByUserAB(Friend friend) {
		// TODO Auto-generated method stub
		return friendMapper.selectByUseraIdAndUserbId(friend);
	}

	@Override
	public int insertMessage(Message mes) {
		// TODO Auto-generated method stub
		return messageMapper.insert(mes);
	}

	@Override
	public ArrayList<MessageRead> findMessages(String RecevId) {
		// TODO Auto-generated method stub
		return messageReadMapper.selectByRecevId(RecevId);
	}

	@Override
	public MessageRead findMessageReadA(Integer messId) {
		// TODO Auto-generated method stub
		return messageReadMapper.selectByPrimaryKeyA(messId);
	}

	@Override
	public int deleteMessage(Integer messId) {
		// TODO Auto-generated method stub
		return messageMapper.deleteByPrimaryKey(messId);
	}

	@Override
	public int updateLookedOfMessage(Message mes) {
		// TODO Auto-generated method stub
		return messageMapper.updateByPrimaryKeySelective(mes);
	}

	@Override
	public ArrayList<MessageRead> findMessageReads(String postId) {
		// TODO Auto-generated method stub
		return messageReadMapper.selectByPostId(postId);
	}

	@Override
	public MessageRead findMessageReadB(Integer messId) {
		// TODO Auto-generated method stub
		return messageReadMapper.selectByPrimaryKeyB(messId);
	}

	@Override
	public int deleteFriend(String useraId, String userbId) {
		// TODO Auto-generated method stub
		friendMapper.deleteByUseraAndUserb(useraId, userbId);
		int rows = friendMapper.deleteByUseraAndUserb(userbId, useraId);
		return rows;
	}

	
	
	

}
