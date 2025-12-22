package com.spring.app.shop.domain;

import com.spring.app.category.domain.CategoryDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter               // private 으로 설정된 필드 변수를 외부에서 접근하여 사용하도록 getter()메소드를 만들어 주는 것.
@Setter               // private 으로 설정된 필드 변수를 외부에서 접근하여 수정하도록 setter()메소드를 만들어 주는 것.
@AllArgsConstructor   // 모든 필드 값을 파라미터로 받는 생성자를 만들어주는 것
@NoArgsConstructor    // 파라미터가 없는 기본생성자를 만들어주는 것
@Builder  
public class ItemDTO {
	
	private int itemNo;
    private String itemName;
    private String itemPhotoPath;
    private String itemInfo;
    private int price;
    private int itemAmount;
    private int volume;
    private String company;
    private String infoImg;
    private int fk_catagory_no;

    // 관계 객체들
    private CategoryDTO categvo; 
    //private CartDTO cartvo;
    
    private int itemPoint; // 소문자 시작 권장 (자바 관례)

    // 비즈니스 로직 메서드는 Lombok이 만들어주지 않으므로 직접 추가합니다.
    public void setUserItemPoint(String grade) {
        if("bronze".equalsIgnoreCase(grade)) {
            this.itemPoint = (int) (price * 0.03);
        } else if("silver".equalsIgnoreCase(grade)) {
            this.itemPoint = (int) (price * 0.05);
        } else if("gold".equalsIgnoreCase(grade)) {
            this.itemPoint = (int) (price * 0.07);
        } else if("vip".equalsIgnoreCase(grade)) {
            this.itemPoint = (int) (price * 0.1);
        }
    }

}
