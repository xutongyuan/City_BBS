package ssm.mapper;

import ssm.po.Integration;

public interface IntegrationMapper {
    int deleteByPrimaryKey(String userId);

    int insert(Integration record);

    int insertSelective(Integration record);

    Integration selectByPrimaryKey(String userId);

    int updateByPrimaryKeySelective(Integration record);

    int updateByPrimaryKey(Integration record);
    
    int updateGoodPostAddOne(String userId);
    int updateGoodPostSubOne(String userId);
}