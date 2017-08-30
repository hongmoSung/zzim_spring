package kr.co.web.vo;


public class PageResultVO {
	private int listSize = 10;
	private int tabSize = 10;
	private int pageNo;
	private int bCount;
	
	private int lastPage;
	private int beginPage;
	private int endPage;
	
	private boolean prev, next;
	
	public PageResultVO(int pageNo, int bCount){
		this.pageNo = pageNo;
		this.bCount = bCount;
		
		this.lastPage = (int)Math.ceil(bCount / (double)listSize);
		int currentTab = (pageNo - 1) / tabSize + 1;
		this.beginPage = (currentTab - 1) * tabSize + 1;
		this.endPage = (currentTab * tabSize > lastPage) ? lastPage : currentTab * tabSize;
		this.prev = (beginPage != 1);
		this.next = (endPage != lastPage);
	}
	public int getbCount() {
		return bCount;
	}
	public int getPageNo() {
		return pageNo;
	}
	public int getLastPage() {
		return lastPage;
	}
	public int getBeginPage() {
		return beginPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public boolean getPrev() {
		return prev;
	}
	public boolean getNext() {
		return next;
	}
}
