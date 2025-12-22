package com.spring.app.shop.service;

import java.io.File;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.app.category.domain.CategoryDTO;
import com.spring.app.shop.domain.ItemDTO;
import com.spring.app.shop.model.ItemDAO;

import jakarta.servlet.http.HttpSession;
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

	
	// 제품 등록하기 (관리자)
	@Override
	public int itemRegister(ItemDTO itemDto, MultipartFile itemPhoto, MultipartFile infoImg, HttpSession session) {
		
		// 파일 업로드 경로 설정
		String rootPath = session.getServletContext().getRealPath("/images");
		// 메인 이미지 
		String mainImgDir = rootPath + File.separator + "item";
		// 상세 이미지 경로
	    String infoImgDir = rootPath + File.separator + "iteminfo";
		
		try {
			// 메인 이미지 파일 처리
			if(itemPhoto != null && !itemPhoto.isEmpty()) {
				String newFileName = getNewFileName(itemPhoto);
				File dest = new File(mainImgDir + File.separator + newFileName);
				itemPhoto.transferTo(dest); // 파일 저장
				itemDto.setItemPhotoPath(newFileName); // DTO에 저장된 파일명
			}
			
			// 상세 이미지 파일 처리
			if(infoImg != null && !infoImg.isEmpty()) {
				String newFileName = getNewFileName(infoImg);
				File dest = new File(infoImgDir + File.separator + newFileName);
				infoImg.transferTo(dest); // 파일 저장
				itemDto.setInfoImg(newFileName); // DTO에 저장된 파일명 세팅
			}
			
			return itemDao.itemRegister(itemDto);
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	
	// 파일명 생성 로직
	private String getNewFileName(MultipartFile file) {
		
		String fileName = file.getOriginalFilename();
		String newFilename = fileName.substring(0, fileName.lastIndexOf("."));
        newFilename += "_" + String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance());
        newFilename += System.nanoTime();
        newFilename += fileName.substring(fileName.lastIndexOf("."));
        
		return newFilename;
	}

	

}
