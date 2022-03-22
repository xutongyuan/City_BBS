package ssm.mapper;

import ssm.po.PostCount;

public interface PostCountMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(PostCount record);

    int insertSelective(PostCount record);
    
    PostCount selectByPostId(Integer postId);

    int updateByPostId(PostCount record);
    


}