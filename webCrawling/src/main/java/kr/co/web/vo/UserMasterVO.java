package kr.co.web.vo;

public class UserMasterVO {
	private String reWebsite;
	private String reWebsiteId;
	private String reWebsitePw;
	private String email;
	private String website;
	private String websiteId;
	private String websitePw;

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

	public String getWebsitePw() {
		return websitePw;
	}

	public void setWebsitePw(String websitePw) {
		this.websitePw = websitePw;
	}

	public String getReWebsite() {
		return reWebsite;
	}

	public String getReWebsiteId() {
		return reWebsiteId;
	}

	public String getReWebsitePw() {
		return reWebsitePw;
	}

	public void setReWebsitePw(String reWebsitePw) {
		this.reWebsitePw = reWebsitePw;
	}

	@Override
	public String toString() {
		return "UserMasterVO [reWebsite=" + reWebsite + ", reWebsiteId=" + reWebsiteId + ", reWebsitePw=" + reWebsitePw
				+ ", email=" + email + ", website=" + website + ", websiteId=" + websiteId + ", websitePw=" + websitePw
				+ "]";
	}

	

	
}
