package com.spring.board.vo;


public class PageVo {
	
	private int pageNo = 0;
	private String[] boardSelectType;

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String[] getBoardSelectType() {
		return boardSelectType;
	}

	public void setBoardSelectType(String[] boardSelectType) {
		this.boardSelectType = boardSelectType;
	}
}
