package com.spring.app.users.service;

import com.spring.app.entity.Users;
import com.spring.app.users.domain.UsersDTO;

public interface UsersService {

	// 로그인
	UsersDTO getUser(String id, String pwd);

	// 아이디 중복 확인
	boolean isIdExists(String id);

	// 이메일 중복 확인
	boolean isEmailExists(String email);

	// 회원가입
	void register(Users user);

}
