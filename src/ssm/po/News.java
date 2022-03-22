package ssm.po;

public class News {
    private Integer id;

    private String postId;
    
    private String postNickname;

    private String recevId;
    
    private String recevNickname;

    private String type;

    private String status;

    private String time;

    private String looked;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId == null ? null : postId.trim();
    }

    public String getRecevId() {
        return recevId;
    }

    public void setRecevId(String recevId) {
        this.recevId = recevId == null ? null : recevId.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time == null ? null : time.trim();
    }

    public String getLooked() {
        return looked;
    }

    public void setLooked(String looked) {
        this.looked = looked == null ? null : looked.trim();
    }

	public String getPostNickname() {
		return postNickname;
	}

	public void setPostNickname(String postNickname) {
		this.postNickname = postNickname;
	}

	public String getRecevNickname() {
		return recevNickname;
	}

	public void setRecevNickname(String recevNickname) {
		this.recevNickname = recevNickname;
	}
    
    
}