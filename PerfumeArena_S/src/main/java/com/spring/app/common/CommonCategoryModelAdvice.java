
package com.spring.app.common;

import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.spring.app.category.domain.CategoryDTO;
import com.spring.app.item.service.ItemService;

import lombok.RequiredArgsConstructor;

@ControllerAdvice(basePackages = "com.spring.app")
@RequiredArgsConstructor
public class CommonCategoryModelAdvice {
	
	private final ItemService itemService;
	
	@ModelAttribute
    public void categoryList(Model model) {
		
		List<CategoryDTO> categoryList = itemService.categoryList();
		model.addAttribute("categoryList", categoryList);
		
    }
	
}
