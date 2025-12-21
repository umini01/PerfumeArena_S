package com.spring.app.admin.service;

import org.json.simple.JSONObject;
import org.springframework.data.domain.Page;

import com.spring.app.users.domain.UsersDTO;

public interface AdminService {

	// 회원 목록 보기
	Page<UsersDTO> getPageUserList(String searchType, String searchWord, int currentShowPageNo, int sizePerPage) throws Exception;

	// 회원 상세 보기
	UsersDTO getUsers(String id);

	// 문자 메시지 보내기
	JSONObject smsSend(String mobile, String smsContent, String datetime) throws Exception;

	

	
}
