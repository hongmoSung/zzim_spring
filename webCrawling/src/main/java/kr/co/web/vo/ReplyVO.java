package kr.co.web.vo;

import java.util.Date;

public class ReplyVO {
	private int rNo;
	private int bNo;
	private String rContent;
	private Date rRegDate;
	
	public int getrNo() {
		return rNo;
	}
	public void setrNo(int rNo) {
		this.rNo = rNo;
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public Date getrRegDate() {
		return rRegDate;
	}
	public void setrRegDate(Date rRegDate) {
		this.rRegDate = rRegDate;
	}
	
	
	
	
}