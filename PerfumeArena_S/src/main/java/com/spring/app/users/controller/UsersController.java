package com.spring.app.users.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.app.users.domain.UsersDTO;
import com.spring.app.users.service.UsersService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("users/")
@RequiredArgsConstructor  //Lombok이 제공하는 기능으로,final이나 @NonNull이 붙은 필드를 대상으로 생성자를 자동 생성
public class UsersController {
	
	private final UsersService usersService;
	
	// 로그인 폼
	@GetMapping("login")
	public String login() {
		return "redirect:/index";
	}
	
	// 로그인 
	@PostMapping("login")
	public String login(@RequestParam(name="id") String id,
						@RequestParam(name="password") String pwd,
						HttpServletRequest request, HttpSession session) {
		
		UsersDTO loginUser = usersService.getUser(id, pwd);
		
		if (loginUser != null) {
	        session.setAttribute("loginUser", loginUser);
	        return "redirect:/index";
	    }
	    else {
	    	request.setAttribute("message", "로그인 실패!");
	        request.setAttribute("loc", request.getContextPath()+"/users/loginForm");
	        return "msg";
	    }
	 
	}
	
	// 로그아웃
	@GetMapping("logout")
	public String loginout(HttpServletRequest request) {
	      
		HttpSession session = request.getSession();
		session.invalidate();
	      
		String message = "로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/";  // 시작 페이지로 이동
	                
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		return "msg";
	}

}
