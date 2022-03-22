package ssm.po.readonly;

public class IntegrationUsersRead {
    private String userId;

    private Integer onlineTime;

    private Integer postNum;

    private Integer backNum;

    private Integer goodPostNum;

    private Integer score;

    private String monicker;
    
    private String nickname;
    
    private String image;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Integer getOnlineTime() {
        return onlineTime;
    }

    public void setOnlineTime(Integer onlineTime) {
        this.onlineTime = onlineTime;
    }

    public Integer getPostNum() {
        return postNum;
    }

    public void setPostNum(Integer postNum) {
        this.postNum = postNum;
    }

    public Integer getBackNum() {
        return backNum;
    }

    public void setBackNum(Integer backNum) {
        this.backNum = backNum;
    }

    public Integer getGoodPostNum() {
        return goodPostNum;
    }

    public void setGoodPostNum(Integer goodPostNum) {
        this.goodPostNum = goodPostNum;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getMonicker() {
        return monicker;
    }

    public void setMonicker(String monicker) {
        this.monicker = monicker == null ? null : monicker.trim();
    }

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
    
    
}