package kr.co.web.mapper;

import java.util.List;

import kr.co.web.vo.TrackingBoardVO;

public interface HomeMapper {
	public int countProduct ();
	public List<TrackingBoardVO> trackingRank();
	public List<TrackingBoardVO> selectDown();
	public List<TrackingBoardVO> recentProduct();
	public TrackingBoardVO selectProduct(int pNo);
}
