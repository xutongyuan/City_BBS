package ssm.po.readonly;


public class UsersInfo {
    private String email;

    private String userId;

    private String registerTime;

    private Integer roleId;

    private String pmsArea;

    private String phone;

    private String nickname;

    private String sex;

    private String signature;

    private String image;

    private String county;

    private String loginTime;
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }


    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(String registerTime) {
        this.registerTime = registerTime;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

   

	public String getPmsArea() {
		return pmsArea;
	}

	public void setPmsArea(String pmsArea) {
		this.pmsArea = pmsArea;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}

	@Override
	public String toString() {
		return "UsersInfo [email=" + email + ", userId=" + userId
				+ ", registerTime=" + registerTime + ", roleId=" + roleId
				+ ", pmsArea=" + pmsArea + ", phone=" + phone + ", nickname="
				+ nickname + ", sex=" + sex + ", signature=" + signature
				+ ", image=" + image + ", county=" + county + ", loginTime="
				+ loginTime + "]";
	}


}