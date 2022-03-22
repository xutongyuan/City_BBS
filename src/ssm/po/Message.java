package ssm.po;

public class Message {
    private Integer messId;

    private String postmessId;

    private String recevmessId;

    private String messTitle;

    private String messContent;

    private String time;

    private String looked;

    public Integer getMessId() {
        return messId;
    }

    public void setMessId(Integer messId) {
        this.messId = messId;
    }

    public String getPostmessId() {
        return postmessId;
    }

    public void setPostmessId(String postmessId) {
        this.postmessId = postmessId == null ? null : postmessId.trim();
    }

    public String getRecevmessId() {
        return recevmessId;
    }

    public void setRecevmessId(String recevmessId) {
        this.recevmessId = recevmessId == null ? null : recevmessId.trim();
    }

    public String getMessTitle() {
        return messTitle;
    }

    public void setMessTitle(String messTitle) {
        this.messTitle = messTitle == null ? null : messTitle.trim();
    }

    public String getMessContent() {
        return messContent;
    }

    public void setMessContent(String messContent) {
        this.messContent = messContent == null ? null : messContent.trim();
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
}