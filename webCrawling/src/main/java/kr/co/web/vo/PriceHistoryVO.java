package kr.co.web.vo;

import java.util.Date;

public class PriceHistoryVO {

	private Date currDate;
	private int currPrice;
	private int pNo;
	private String AcurrPrice;
	

	public String getAcurrPrice() {
		return AcurrPrice;
	}

	public void setAcurrPrice(String acurrPrice) {
		AcurrPrice = acurrPrice;
	}

	public Date getCurrDate() {
		return currDate;
	}

	public void setCurrDate(Date currDate) {
		this.currDate = currDate;
	}

	public int getCurrPrice() {
		return currPrice;
	}

	public void setCurrPrice(int currPrice) {
		this.currPrice = currPrice;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	@Override
	public String toString() {
		return "PriceHistoryVO [currDate=" + currDate + ", currPrice=" + currPrice + ", pNo=" + pNo + ", AcurrPrice="
				+ AcurrPrice + "]";
	}

	
}
