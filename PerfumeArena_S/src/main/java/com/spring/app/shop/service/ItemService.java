package com.spring.app.shop.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.app.category.domain.CategoryDTO;
import com.spring.app.shop.domain.ItemDTO;

import jakarta.servlet.http.HttpSession;

public interface ItemService {

	// 인덱스 카테고리 리스트
	List<CategoryDTO> categoryList();

	// 제품 등록하기 (관리자)
	int itemRegister(ItemDTO itemDto, MultipartFile itemPhoto, MultipartFile infoImg, HttpSession session);

}
