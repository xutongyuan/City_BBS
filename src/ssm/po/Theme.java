package ssm.po;



public class Theme {
    private Integer postId;

    private String title;

    private String content;

    private String postingTime;

    private String userId;

    private Integer area;
    
    private String goodPost;
    private String isNav;
    private String isBanner;

    public String getIsNav() {
        return isNav;
    }

    public void setIsNav(String isNav) {
        this.isNav = isNav;
    }

    public String getIsBanner() {
        return isBanner;
    }

    public void setIsBanner(String isBanner) {
        this.isBanner = isBanner;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getPostingTime() {
        return postingTime;
    }

    public void setPostingTime(String postingTime) {
        this.postingTime = postingTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Integer getArea() {
        return area;
    }

    public void setArea(Integer area) {
        this.area = area;
    }

	public String getGoodPost() {
		return goodPost;
	}

	public void setGoodPost(String goodPost) {
		this.goodPost = goodPost;
	}
    
}