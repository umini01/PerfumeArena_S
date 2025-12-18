package com.spring.app.users.model;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.app.entity.Users;

public interface UsersRepository extends JpaRepository<Users, String> {

}
