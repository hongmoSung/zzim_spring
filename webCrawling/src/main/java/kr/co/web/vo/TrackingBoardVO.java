package kr.co.web.vo;

import java.util.Date;

public class TrackingBoardVO {
	private int page;
	private int pNo;
	private String pName;
	private String pUrl;
	private int pLowest;
	private String picUrl;
	private String crawlingUrl ;
	private String currPrice ; // 현제가(그래프)
	private String notifyPrice ; // 희망가
	private String email ; // 희망가
	private Double dRate;
	private Double pAvg;
	private int cPNo;
	private String rPLowest;
	
	public String getrPLowest() {
		return rPLowest;
	}

	public void setrPLowest(String rPLowest) {
		this.rPLowest = rPLowest;
	}

	public int getcPNo() {
		return cPNo;
	}

	public void setcPNo(int cPNo) {
		this.cPNo = cPNo;
	}

	public Double getdRate() {
		return dRate;
	}

	public void setdRate(Double dRate) {
		this.dRate = dRate;
	}

	public Double getpAvg() {
		return pAvg;
	}

	public void setpAvg(Double pAvg) {
		this.pAvg = pAvg;
	}

	public int getBegin() {
		return (page -1) * 10 ;
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNotifyPrice() {
		return notifyPrice;
	}
	public void setNotifyPrice(String notifyPrice) {
		this.notifyPrice = notifyPrice;
	}
	public String getCurrPrice() {
		return currPrice;
	}
	public void setCurrPrice(String currPrice) {
		this.currPrice = currPrice;
	}
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpUrl() {
		return pUrl;
	}
	public void setpUrl(String pUrl) {
		this.pUrl = pUrl;
	}
	public int getpLowest() {
		return pLowest;
	}
	public void setpLowest(int pLowest) {
		this.pLowest = pLowest;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public String getCrawlingUrl() {
		return crawlingUrl;
	}
	public void setCrawlingUrl(String crawlingUrl) {
		this.crawlingUrl = crawlingUrl;
	}

	@Override
	public String toString() {
		return "TrackingBoardVO [page=" + page + ", pNo=" + pNo + ", pName=" + pName + ", pUrl=" + pUrl + ", pLowest="
				+ pLowest + ", picUrl=" + picUrl + ", crawlingUrl=" + crawlingUrl + ", currPrice=" + currPrice
				+ ", notifyPrice=" + notifyPrice + ", email=" + email + ", dRate=" + dRate + ", pAvg=" + pAvg
				+ ", cPNo=" + cPNo + ", rPLowest=" + rPLowest + "]";
	}
	
}
