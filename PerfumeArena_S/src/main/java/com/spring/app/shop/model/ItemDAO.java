package com.spring.app.shop.model;

import java.util.List;

import com.spring.app.category.domain.CategoryDTO;
import com.spring.app.shop.domain.ItemDTO;

public interface ItemDAO {

	// 메인페이지 카테고리 불러오기
	List<CategoryDTO> categoryList();

	// 제품 등록 실행
	int itemRegister(ItemDTO itemDto);

}
