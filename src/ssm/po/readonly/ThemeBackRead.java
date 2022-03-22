package ssm.po.readonly;

public class ThemeBackRead {
    private Integer backId;

    private Integer backThemeId;

    private String userId;

    private String content;

    private String replyTime;
    
    private String nickname;
    
    private String image;
    
    private String monicker;

    public Integer getBackId() {
        return backId;
    }

    public void setBackId(Integer backId) {
        this.backId = backId;
    }

    public Integer getBackThemeId() {
        return backThemeId;
    }

    public void setBackThemeId(Integer backThemeId) {
        this.backThemeId = backThemeId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(String replyTime) {
        this.replyTime = replyTime == null ? null : replyTime.trim();
    }

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getMonicker() {
		return monicker;
	}

	public void setMonicker(String monicker) {
		this.monicker = monicker;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "ThemeBackRead [backId=" + backId + ", backThemeId="
				+ backThemeId + ", userId=" + userId + ", content=" + content
				+ ", replyTime=" + replyTime + ", nickname=" + nickname
				+ ", image=" + image + ", monicker=" + monicker + "]";
	}

	
    
}