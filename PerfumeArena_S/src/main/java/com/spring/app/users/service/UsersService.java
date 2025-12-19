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

	// 아이디 찾기
	UsersDTO findByNameAndEmail(String name, String email);

	// 비밀번호 찾기
	Users findByIdAndEmail(String id, String email);

	// 비밀번호 변경
	void updatePassword(String id, String newPassword);

	

}
