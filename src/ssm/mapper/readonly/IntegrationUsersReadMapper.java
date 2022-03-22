package ssm.mapper.readonly;

import ssm.po.readonly.IntegrationUsersRead;

public interface IntegrationUsersReadMapper {

    IntegrationUsersRead selectByPrimaryKey(String userId);

}