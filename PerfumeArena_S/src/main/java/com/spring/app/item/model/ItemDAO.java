package com.spring.app.item.model;

import java.util.List;

import com.spring.app.category.domain.CategoryDTO;

public interface ItemDAO {

	// 메인페이지 카테고리 불러오기
	List<CategoryDTO> categoryList();

}
