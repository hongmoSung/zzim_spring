package kr.co.web.vo;

import java.util.Date;

public class BoardVO {
	private String bTitle;
	private String bContent;
	private int bNo;
	private String email;
	private int bHit;
	private Date bRegDate;
	private int bReply;
	private int isNotice;
	private int isSecret;
	
	public int getIsSecret() {
		return isSecret;
	}
	public void setIsSecret(int isSecret) {
		this.isSecret = isSecret;
	}
	public int getIsNotice() {
		return isNotice;
	}
	public void setIsNotice(int isNotice) {
		this.isNotice = isNotice;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getbHit() {
		return bHit;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	public Date getbRegDate() {
		return bRegDate;
	}
	public void setbRegDate(Date bRegDate) {
		this.bRegDate = bRegDate;
	}
	public int getbReply() {
		return bReply;
	}
	public void setbReply(int bReply) {
		this.bReply = bReply;
	}
	@Override
	public String toString() {
		return "BoardVO [bTitle=" + bTitle + ", bContent=" + bContent + ", bNo=" + bNo + ", email=" + email + ", bHit="
				+ bHit + ", bRegDate=" + bRegDate + ", bReply=" + bReply + ", isNotice=" + isNotice + "]";
	}
}
