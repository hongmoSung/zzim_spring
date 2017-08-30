package kr.co.web.service;

import java.util.List;
import java.util.Map;

import kr.co.web.vo.BoardVO;
import kr.co.web.vo.ReplyVO;
import kr.co.web.vo.SearchVO;


public interface BoardService {
	
	// 보드
	public Map<String, Object> readBoardList(SearchVO search);
	public Map<String, Object> readBoardDetail(int bNo);
	public String write(BoardVO board);
	public String deleteBoard(int bNo);
	public String update(BoardVO board);
	public int updateBoardHit(int bNo);
	
	// 답변
	public ReplyVO insertReply(ReplyVO reply);
	public void deleteReply(ReplyVO reply);
	public void updateComment(ReplyVO reply);
	public int commentCount(int bNo);
}
