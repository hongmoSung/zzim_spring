package kr.co.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.web.mapper.TrackingBoardMapper;
import kr.co.web.vo.BoardVO;
import kr.co.web.vo.TrackingBoardVO;

@Service
public class TrackingBoardServiceImpl implements TrackingBoardService {
	
	@Autowired
	private TrackingBoardMapper mapper;
	
	@Override
	public List<TrackingBoardVO> readTrackingList(String id) throws Exception {
		return mapper.selectBoard(id);
	}

	@Override
	public List<TrackingBoardVO> infiniteScrollDown(TrackingBoardVO tboard) throws Exception {
		return mapper.infiniteScrollDown(tboard);
	}

	@Override
	public List<Integer> readChartList(int pNo) throws Exception {
		return mapper.priceList(pNo);
	}

	@Override
	public int priceUpdate(TrackingBoardVO tboard) throws Exception {
		return mapper.priceUpdate(tboard);
	}
	
	@Override
	public int deleteTracking(int pNo) throws Exception {
		return mapper.delete(pNo);
	}
	
}
