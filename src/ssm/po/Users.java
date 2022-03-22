package ssm.po;


public class Users {
    private String email;

    private String password;

    private String userId;

    private String registerTime;

    private Integer roleId;

    private String pmsArea;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
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

	@Override
	public String toString() {
		return "Users [email=" + email + ", password=" + password + ", userId="
				+ userId + ", registerTime=" + registerTime + ", roleId="
				+ roleId + ", pmsArea=" + pmsArea + "]";
	}
    
}