package com.spring.app.shop.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.category.domain.CategoryDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ItemDAO_imple implements ItemDAO {
	
	@Qualifier("sqlsession")
	private final SqlSessionTemplate sql;
	
	// 메인페이지 카테고리 리스트
	@Override
	public List<CategoryDTO> categoryList() {
		List<CategoryDTO> categoryList = sql.selectList("item.categoryList");
		return categoryList;
	}
	
	

}
