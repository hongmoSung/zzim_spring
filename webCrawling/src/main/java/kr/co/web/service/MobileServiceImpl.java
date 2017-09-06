package kr.co.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.web.mapper.MobileMapper;
import kr.co.web.vo.MobileVO;

@Service
public class MobileServiceImpl implements MobileService {
	
	@Autowired
	private MobileMapper mapper;
	
	@Override
	public void saveToken(MobileVO vo) {
		mapper.insertToken(vo);
	}
	
}
