package ssm.mapper;

import ssm.po.Message;

public interface MessageMapper {
    int deleteByPrimaryKey(Integer messId);

    int insert(Message mes);
    
    int insertSelective(Message mes);

    Message selectByPrimaryKey(Integer messId);

    int updateByPrimaryKeySelective(Message record);

    int updateByPrimaryKey(Message record);
}