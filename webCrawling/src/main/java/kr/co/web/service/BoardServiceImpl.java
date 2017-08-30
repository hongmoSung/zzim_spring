package kr.co.web.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.web.mapper.BoardMapper;
import kr.co.web.vo.BoardVO;
import kr.co.web.vo.PageResultVO;
import kr.co.web.vo.ReplyVO;
import kr.co.web.vo.SearchVO;


@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;

	@Override
	public int updateBoardHit(int bNo) {
		return mapper.updateBoardHit(bNo);
	}

	@Override
	public Map<String, Object> readBoardList(SearchVO search) {
		if (search.getbTitle() == null)
			search.setbTitle("");
		if (search.getSearchName() == null)
			search.setSearchName("");
		if (search.getEmail() == null)
			search.setEmail("null");
		if (search.getbContent() == null)
			search.setbContent("");
		List<BoardVO> list = mapper.selectBoardList(search);
		int pageNo = search.getPageNo();
		int begin = search.getBegin();
		int end = search.getEnd();
		int bCount = mapper.selectBoardCount(search);
		Map<String, Object> map = new HashMap<String, Object>();
		if (!list.isEmpty()) {
			map.put("list", list);
		}
		map.put("bCount", bCount);
		map.put("bTitle", search.getbTitle());
		map.put("bContent", search.getbContent());
		map.put("email", search.getEmail());
		map.put("pageResult", new PageResultVO(pageNo, bCount));
		return map;
	}

	@Override
	public Map<String, Object> readBoardDetail(int bNo) {
		BoardVO board = mapper.selectBoardOne(bNo);
		Map<String, Object> map = new HashMap<String, Object>();
		ReplyVO reply = mapper.replyList(bNo);

		int rCount = mapper.selectReplyCount(bNo);
		map.put("reply", reply);
		map.put("rCount", rCount);
		map.put("board", board);
		return map;
	}

	@Override
	public String deleteBoard(int bNo) {
		String msg = "delete fail";
		int result = mapper.deleteBoard(bNo);
		if (result == 1)
			msg = "delete success";
		return msg;
	}

	@Override
	public String write(BoardVO board) {
		String msg = "write fail";
		int result = mapper.insertBoard(board);
		if (result == 1)
			msg = "write success";
		return msg;
	}

	@Override
	public String update(BoardVO board) {
		String msg = "update fail";
		int result = mapper.updateBoard(board);
		if (result == 1)
			msg = "update success";
		return msg;
	}

	// 답변

	@Transactional
	public ReplyVO insertReply(ReplyVO reply) {
		mapper.insertReply(reply);
		mapper.updateReplyCount(reply.getbNo());
		return mapper.replyList(reply.getbNo());
	}
	
	@Transactional
	public void deleteReply(ReplyVO reply) {
		mapper.deleteReplyCount(reply.getbNo());
		mapper.deleteReply(reply.getrNo());
	}

	@Override
	public void updateComment(ReplyVO reply) {
		mapper.updateReply(reply);
	}

	@Override
	public int commentCount(int bNo) {
		return mapper.selectReplyCount(bNo);
	}

}
