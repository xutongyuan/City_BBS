package ssm.po.readonly;



public class ThemeRead {
    private Integer postId;

    private String title;

    private String content;

    private String postingTime;

    private String userId;

    private Integer area;
    
    private String goodPost;

    private String nickname;
    
    private String image;
    
    private Integer backcount;
    
    private Integer readcount;
    
    
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

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


	public Integer getBackcount() {
		return backcount;
	}

	public void setBackcount(Integer backcount) {
		this.backcount = backcount;
	}

	public Integer getReadcount() {
		return readcount;
	}

	public void setReadcount(Integer readcount) {
		this.readcount = readcount;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	

	public String getGoodPost() {
		return goodPost;
	}

	public void setGoodPost(String goodPost) {
		this.goodPost = goodPost;
	}

	@Override
	public String toString() {
		return "ThemeRead [postId=" + postId + ", title=" + title
				+ ", content=" + content + ", postingTime=" + postingTime
				+ ", userId=" + userId + ", area=" + area + ", goodPost="
				+ goodPost + ", nickname=" + nickname + ", image=" + image
				+ ", backcount=" + backcount + ", readcount=" + readcount + "]";
	}


	
	



	
    
}