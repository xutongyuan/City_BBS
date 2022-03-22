package ssm.po;

public class ThemeBack {
    private Integer backId;

    private Integer backThemeId;

    private String userId;

    private String content;

    private String replyTime;

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
}