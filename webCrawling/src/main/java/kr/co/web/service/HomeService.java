package kr.co.web.service;

import java.util.List;
import java.util.Map;

import kr.co.web.vo.TrackingBoardVO;

public interface HomeService {
	public List<TrackingBoardVO> trackingRank ();
	public List<TrackingBoardVO> selectDown ();
	public List<TrackingBoardVO> recentProduct();
}
