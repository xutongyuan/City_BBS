package ssm.mapper.readonly;

import java.util.ArrayList;

import ssm.po.readonly.MessageRead;

public interface MessageReadMapper {

//发信箱查询
    ArrayList<MessageRead> selectByRecevId(String recevId);
    
    MessageRead selectByPrimaryKeyA(Integer messId);
//收信箱查询
    ArrayList<MessageRead> selectByPostId(String postId);
  
    MessageRead selectByPrimaryKeyB(Integer messId);
}