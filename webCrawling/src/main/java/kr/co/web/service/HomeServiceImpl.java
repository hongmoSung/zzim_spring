package kr.co.web.service;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.web.mapper.HomeMapper;
import kr.co.web.vo.TrackingBoardVO;

@Service
public class HomeServiceImpl implements HomeService{
	
	@Autowired
	public HomeMapper hMapper; 

	@Override
	public List<TrackingBoardVO> trackingRank() {
		return hMapper.trackingRank();
	}

	@Override
	public List<TrackingBoardVO> selectDown() {
		return hMapper.selectDown();
	}

	@Override
	public List<TrackingBoardVO> recentProduct() {
		return hMapper.recentProduct();
	}
}
