package com.spring.app.users.service;

import com.spring.app.users.domain.UsersDTO;

public interface UsersService {

	UsersDTO getUser(String id, String pwd);

}
