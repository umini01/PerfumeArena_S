package com.spring.app.item.service;

import java.util.List;

import com.spring.app.category.domain.CategoryDTO;

public interface ItemService {

	// 인덱스 카테고리 리스트
	List<CategoryDTO> categoryList();

}
