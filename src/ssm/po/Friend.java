package ssm.po;

public class Friend {
    private Integer id;

    private String useraId;

    private String userbId;

    private String addTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUseraId() {
        return useraId;
    }

    public void setUseraId(String useraId) {
        this.useraId = useraId == null ? null : useraId.trim();
    }

    public String getUserbId() {
        return userbId;
    }

    public void setUserbId(String userbId) {
        this.userbId = userbId == null ? null : userbId.trim();
    }

    public String getAddTime() {
        return addTime;
    }

    public void setAddTime(String addTime) {
        this.addTime = addTime == null ? null : addTime.trim();
    }
}