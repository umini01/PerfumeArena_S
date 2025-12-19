package com.spring.app.users.model;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.app.entity.Users;

public interface UsersRepository extends JpaRepository<Users, String> {
	
	// 아이디 중복 확인
	boolean existsById(String id);

	// 이메일 중복 확인
	boolean existsByEmail(String encryptedEmail);

}
