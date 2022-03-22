package ssm.po;

public class Admin {
    private Integer admId;

    private String admUsername;

    private String admPassword;

    private String admNicename;

    private Integer roleId;

    public Integer getAdmId() {
        return admId;
    }

    public void setAdmId(Integer admId) {
        this.admId = admId;
    }

    public String getAdmUsername() {
        return admUsername;
    }

    public void setAdmUsername(String admUsername) {
        this.admUsername = admUsername == null ? null : admUsername.trim();
    }

    public String getAdmPassword() {
        return admPassword;
    }

    public void setAdmPassword(String admPassword) {
        this.admPassword = admPassword == null ? null : admPassword.trim();
    }

    public String getAdmNicename() {
        return admNicename;
    }

    public void setAdmNicename(String admNicename) {
        this.admNicename = admNicename == null ? null : admNicename.trim();
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

	@Override
	public String toString() {
		return "Admin [admId=" + admId + ", admUsername=" + admUsername
				+ ", admPassword=" + admPassword + ", admNicename="
				+ admNicename + ", roleId=" + roleId + "]";
	}
    
}