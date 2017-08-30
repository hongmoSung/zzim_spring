package kr.co.web.service;

import java.util.List;

import kr.co.web.vo.LoginDTO;
import kr.co.web.vo.UserMasterVO;
import kr.co.web.vo.UserVO;

public interface UserService {

	public void join(UserVO user);

	public String checkEmail(String email);
	
	public List<UserMasterVO> masterList(String email);

	public void deleteMaster(String[] valueArray);

	public String writeMaster(UserMasterVO user);

	public String updateMaster(UserMasterVO user);
}
