package kr.co.web.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.web.mapper.UserMapper;
import kr.co.web.vo.LoginDTO;
import kr.co.web.vo.UserMasterVO;
import kr.co.web.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper mapper;

	@Override
	public void join(UserVO user) {
		System.out.println("원본 비밀번호" + user.getPassword());
		
//		String hashPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
//	    user.setPassword(hashPassword);
	    user.setPassword(user.getPassword());
		
	    /*
		String password = user.getPassword();

		String passwordHash = "";
		
		try {
			MessageDigest sh = MessageDigest.getInstance("sha-256");
			sh.update(password.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			passwordHash = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			passwordHash = null;
		}
		user.setPassword(passwordHash);
	     */
//		System.out.println("해싱 비밀번호 : " + hashPassword);
		
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
	public void deleteMaster(String[] valueArray) {
		UserMasterVO user = new UserMasterVO();
		for (int i = 0; i < valueArray.length; i++) {
			if (valueArray[0].contains(",")) {
				String[] valueSplit = valueArray[i].split(",");
				for (int j = 0; j < valueSplit.length; j++) {
					user.setEmail(valueSplit[0]);
					user.setWebsite(valueSplit[1]);
					user.setWebsiteId(valueSplit[2]);
					mapper.deleteMaster(user);
				}
			} else {
				user.setEmail(valueArray[0]);
				user.setWebsite(valueArray[1]);
				user.setWebsiteId(valueArray[2]);
				mapper.deleteMaster(user);
			}
		}
	}

	@Override
	public String writeMaster(UserMasterVO user) {
		System.out.println(user.toString());
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
