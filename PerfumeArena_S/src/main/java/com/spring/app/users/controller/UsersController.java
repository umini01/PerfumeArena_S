package com.spring.app.users.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.app.entity.Users;
import com.spring.app.mail.controller.GoogleMail;
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
	private final GoogleMail mail;
	
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
	
	// 회원가입 폼
	@GetMapping("userRegister")
	public String userRegister() {
		return "users/register";
	}
	
	// 회원가입
	@PostMapping("register")
	public String register(@RequestParam(name="id") String id,
						   @RequestParam(name="password") String pwd,
						   @RequestParam(name="hp1") String hp1,
						   @RequestParam(name="hp2") String hp2,
						   @RequestParam(name="hp2") String hp3,
						   Users user, HttpServletRequest request, HttpSession session) {
		
		// 연락처 합쳐서 저장
		String mobile = hp1 + hp2 + hp3;
		user.setMobile(mobile);
		
		try {
			// 회원가입
			usersService.register(user);
			UsersDTO usersDto = usersService.getUser(id, pwd);
			
			// 세션에 로그인 정보 저장
			session.setAttribute("loginUser", usersDto);
			return "redirect:/index";
			
		} catch (Exception e) {
			e.printStackTrace();
			String message = "회원가입 실패!!";
			String loc = request.getContextPath()+"/login/register"; // 로그인 페이지로 이동

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			return "msg";
		}
	}
	
	// 아이디 중복 확인
	@PostMapping("checkIdDuplicate")
	@ResponseBody
	public Map<String, Boolean> checkIdDuplicate(@RequestParam(name="id") String id) {
		
		boolean isExists = usersService.isIdExists(id);
		
		Map<String, Boolean> map = new HashMap<>();
		map.put("isExists", isExists);
		
		return map;
	}
	
	// 이메일 중복 확인
	@PostMapping("checkEmailDuplicate")
	@ResponseBody
	public Map<String, Boolean> checkEmailDuplicate(@RequestParam(name="email") String email) {
		
		boolean isExists = usersService.isEmailExists(email);
		
		Map<String, Boolean> map = new HashMap<>();
		map.put("isExists", isExists);
		
		return map;
	}
	
	// 아이디 찾기 폼
	@GetMapping("idFind")
	public String idFind() {
		return "login/idFind";
	}
	
	// 아이디 찾기
	@PostMapping("idFind")
	public String idFind(@RequestParam(name="name") String name,
						 @RequestParam(name="email") String email,
						 Model model, HttpServletRequest request) {
		
		UsersDTO users = usersService.findByNameAndEmail(name, email);
		
		if(users != null) {
			model.addAttribute("users", users.getId());
		}
		
		request.setAttribute("method", "POST");
		
		return "login/idFind";
	}
	
	// 비밀번호 찾기 폼
	@GetMapping("passwordFind")
	public String passwordFind() {
		return "login/passwordFind";
	}
	
	// 비밀번호 찾기
	@PostMapping("passwordFind")
	public String passwordFind(@RequestParam(name="id") String id,
							   @RequestParam(name="email") String email,
							   HttpServletRequest request, HttpSession session) {
		// 1. 유저 존재 여부 확인
        Users users = usersService.findByIdAndEmail(id, email);

        if(users == null) {
        	request.setAttribute("n", 0);
            request.setAttribute("method", "POST");
            return "login/pwdFind"; 
        }
        
        // 2. 인증코드 생성 (6자리 랜덤 숫자)
        String certification_code = String.valueOf((int)(Math.random() * 900000) + 100000);

        // 3. 세션에 저장 
        session.setAttribute("certification_code", certification_code);
        
        // 4. 메일 전송
        try {
        	mail.send_certification_code(email, certification_code);
        	
			request.setAttribute("n", 1); 
        	
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("n", 0);
        }

        // JSP에서 보여줄 값 세팅
        request.setAttribute("id", id);
        request.setAttribute("email", email);
        request.setAttribute("method", "POST");

        return "login/passwordFind";
        
	}
	
	// 이메일 인증코드 인증
	@PostMapping("verifyCertification")
	public String verifyCertification(@RequestParam(name="userCertificationCode") String userCertificationCode,
									  @RequestParam(name="id") String id,
									  HttpSession session,
									  HttpServletRequest request) {

		String certification_code = (String) session.getAttribute("certification_code");
		
		String message = "";
		String loc = "";
		
		if(certification_code != null && certification_code.equals(userCertificationCode)) {
		
			message = "인증이 성공되었습니다.";
			loc = request.getContextPath() + "/users/pwdUpdate?id=" + id;
		
		}
		else {
		
		message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요.";
		loc = request.getContextPath() + "/users/passwordFind";
		
		}
		
		request.setAttribute("id", id);
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
		session.removeAttribute("certification_code");
		
		return "msg";
	}
	
	// 비밀번호 변경 폼
	@GetMapping("pwdUpdate")
	public String pwdUpdateForm(@RequestParam(name="id") String id
			      			  , Model model) {
		model.addAttribute("id", id);
		return "login/passwordUpdate";
	}
	
	// 비밀번호 변경
	@PostMapping("passwordUpdate")
	public String pwdUpdate(@RequestParam(name="id") String id
						  , @RequestParam(name="newPassword2") String newPassword
						  , HttpServletRequest request) {
		
		usersService.updatePassword(id, newPassword);
		
		String message = "비밀번호가 변경되었습니다.";
		String loc = request.getContextPath() + "/index";
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
		return "msg";
	}
	
	
	
}
