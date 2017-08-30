package kr.co.web.vo;


public class UserMasterVO {
	private String reWebsite;
	private String reWebsiteId;
	private String reWebsitePassword;
	private String email;
	private String website;
	private String websiteId;
	private String websitePassword;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setReWebsite(String reWebsite) {
		this.reWebsite = reWebsite;
	}
	public void setReWebsiteId(String reWebsiteId) {
		this.reWebsiteId = reWebsiteId;
	}
	public void setReWebsitePassword(String reWebsitePassword) {
		this.reWebsitePassword = reWebsitePassword;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getWebsiteId() {
		return websiteId;
	}
	public void setWebsiteId(String websiteId) {
		this.websiteId = websiteId;
	}
	public String getWebsitePassword() {
		return websitePassword;
	}
	public void setWebsitePassword(String websitePassword) {
		this.websitePassword = websitePassword;
	}
	@Override
	public String toString() {
		return "UserMasterVO [reWebsite=" + reWebsite + ", reWebsiteId=" + reWebsiteId + ", reWebsitePassword="
				+ reWebsitePassword + ", email=" + email + ", website=" + website + ", websiteId=" + websiteId
				+ ", websitePassword=" + websitePassword + "]";
	}
	
	
}
