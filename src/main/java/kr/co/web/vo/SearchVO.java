package kr.co.web.vo;

import java.util.Date;

public class SearchVO {
	private int bNo;
	private String bTitle;
	private String email;
	private String bContent;
	private Date bRegDate;
	private String searchName;
	
	private int pageNo = 1;

	public int getBegin() {
		return (pageNo -1) * 10 + 1;
	}
	public int getEnd() {
		return pageNo * 10;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public Date getbRegDate() {
		return bRegDate;
	}
	public void setbRegDate(Date bRegDate) {
		this.bRegDate = bRegDate;
	}
	public String getSearchName() {
		return searchName;
	}
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}
	
}
