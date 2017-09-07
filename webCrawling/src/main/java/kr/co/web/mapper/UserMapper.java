package kr.co.web.mapper;

import java.util.List;

import kr.co.web.vo.LoginDTO;
import kr.co.web.vo.UserMasterVO;
import kr.co.web.vo.UserVO;

public interface UserMapper {

	// 로그인 관련
	public String selectEmail(String email);
	
	public UserVO selectUser(String email);

	public void insertUser(UserVO user);

	// 개인 페이지
	public List<UserMasterVO> selectMasterList(String email);

	public int deleteMaster(UserMasterVO userMaster);

	public int insertMaster(UserMasterVO userMaster);

	public int updateMaster(UserMasterVO userMaster);
}
