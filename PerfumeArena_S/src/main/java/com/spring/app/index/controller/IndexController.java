package com.spring.app.index.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.app.category.domain.CategoryDTO;
import com.spring.app.item.service.ItemService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor // final 인스턴스 생성자 처리해주기
@Controller
@RequestMapping("/")
public class IndexController {
	
	private final ItemService itemService;

	@GetMapping("")
	public String start() {
		return "redirect:/index";
	}
	
	// 인덱스 카테고리 불러오기
	@GetMapping("index") 
	public String index(Model model) {
		  
		List<CategoryDTO> categoryList = itemService.categoryList();
		model.addAttribute("categoryList", categoryList);
	  
		return "index"; 
	}
	 
	// footer 오시는 길
	@GetMapping("location")
	public String location() {
		return "footer/location";
	}
	
	// footer 이용약관
	@GetMapping("serviceInfo")
	public String serviceInfo() {
		return "footer/serviceInfo";
	}
	
	// footer 개인정보처리방침
	@GetMapping("privacyInfo")
	public String privacyInfo() {
		return "footer/privacyInfo";
	}

}
