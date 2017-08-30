package kr.co.web.mapper;

import java.util.List;

import kr.co.web.vo.BoardVO;
import kr.co.web.vo.ReplyVO;
import kr.co.web.vo.SearchVO;

public interface BoardMapper {
	// 보드 
	public List<BoardVO> selectBoardList(SearchVO search);
//	public List<BoardVO> selectMyList(SearchVO search);
	public BoardVO selectBoardOne(int bNo);
	public int insertBoard(BoardVO board);
	public int updateBoard(BoardVO board);
	public int deleteBoard(int bNo);

	public int updateReplyCount(int bNo);
	public int deleteReplyCount(int bNo);
	
	
	
	// 댓글
	public int selectReplyCount(int bNo);
	public ReplyVO replyList(int bNo);
	public void insertReply(ReplyVO reply);
	public void deleteReply(int rNo);
	public void updateReply(ReplyVO reply);
	
	
	// 전체 수
	public int selectBoardCount(SearchVO search);
//	public int selectMyCount(SearchVO search);
	
	// 조회수
	public int updateBoardHit(int bNo);

	// 검색
	public List<BoardVO> searchResult(BoardVO board);
}
