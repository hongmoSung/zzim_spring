package kr.co.web.vo;

public class PageVO {
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
}
