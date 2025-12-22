package com.spring.app.shop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.app.category.domain.CategoryDTO;
import com.spring.app.shop.model.ItemDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ItemService_imple implements ItemService {
	
	private final ItemDAO itemDao;

	// 메인페이지 카테고리 불러오기
	@Override
	public List<CategoryDTO> categoryList() {
		List<CategoryDTO> categoryList = itemDao.categoryList();
		return categoryList;
	}

}
