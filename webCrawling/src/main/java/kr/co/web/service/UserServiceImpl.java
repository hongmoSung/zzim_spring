package kr.co.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.web.mapper.UserMapper;
import kr.co.web.vo.UserMasterVO;
import kr.co.web.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper mapper;

	@Override
	public void join(UserVO user) {
	    user.setPassword(user.getPassword());
		mapper.insertUser(user);
	}

	@Override
	public String checkEmail(String email) {
		return mapper.selectEmail(email);
	}

	@Override
	public List<UserMasterVO> masterList(String email) {
		return mapper.selectMasterList(email);
	}

	@Override
	public String deleteMaster(UserMasterVO user) {
		String msg = "Fail, Please do it again later";
		int result = mapper.deleteMaster(user);
		if(result == 1)
			msg = "complete";
		return msg;
	}

	@Override
	public String writeMaster(UserMasterVO user) {
		String msg = "Fail, Please check your Insert Content";
		int result = mapper.insertMaster(user);
		if (result == 1)
			msg = "Complete"; 
		return msg;

	}

	@Override
	public String updateMaster(UserMasterVO user) {
		String msg = "Fail, Please check your Insert Content";
		int result = mapper.updateMaster(user);
		if (result == 1)
			msg = "Complete";
		return msg;
	}
}
