package ssm.po;

public class Permission {
    private Integer pmsId;

    private String pmsForm;

    private String pmsDescription;

    public Integer getPmsId() {
        return pmsId;
    }

    public void setPmsId(Integer pmsId) {
        this.pmsId = pmsId;
    }

    public String getPmsForm() {
        return pmsForm;
    }

    public void setPmsForm(String pmsForm) {
        this.pmsForm = pmsForm == null ? null : pmsForm.trim();
    }

    public String getPmsDescription() {
        return pmsDescription;
    }

    public void setPmsDescription(String pmsDescription) {
        this.pmsDescription = pmsDescription == null ? null : pmsDescription.trim();
    }

	@Override
	public String toString() {
		return "Permission [pmsId=" + pmsId + ", pmsForm=" + pmsForm
				+ ", pmsDescription=" + pmsDescription + "]";
	}
    
}