package kr.co.web.service;

import java.util.List;
import java.util.Map;

import kr.co.web.vo.BoardVO;
import kr.co.web.vo.PriceHistoryVO;
import kr.co.web.vo.ReplyVO;
import kr.co.web.vo.SearchVO;
import kr.co.web.vo.TrackingBoardVO;


public interface TrackingBoardService {
	
	public List<TrackingBoardVO> readTrackingList(String id) throws Exception;
	public List<TrackingBoardVO> infiniteScrollDown(TrackingBoardVO tboard) throws Exception;
	
	public List<Integer> readChartList(int pNo)throws Exception;
	public int priceUpdate(TrackingBoardVO tboard)throws Exception;
	public int deleteTracking(int pNo) throws Exception;
	public List<PriceHistoryVO> getChartData(int pNo);
	
	
}
