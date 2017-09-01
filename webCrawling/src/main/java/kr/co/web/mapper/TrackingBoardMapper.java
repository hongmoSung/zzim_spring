package kr.co.web.mapper;

import java.util.List;

import kr.co.web.vo.BoardVO;
import kr.co.web.vo.PriceHistoryVO;
import kr.co.web.vo.ReplyVO;
import kr.co.web.vo.SearchVO;
import kr.co.web.vo.TrackingBoardVO;

public interface TrackingBoardMapper {
	public List<TrackingBoardVO> selectBoard(String id) throws Exception;
	public List<TrackingBoardVO> infiniteScrollDown(TrackingBoardVO tboard) throws Exception;
	
	public List<Integer> priceList(int pNo)throws Exception;
	public int priceUpdate(TrackingBoardVO tboard)throws Exception;
	public int delete(int pNo) throws Exception;
	public List<PriceHistoryVO> selectPriceHistory(int pNo);
	
}
