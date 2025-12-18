package com.spring.app.users.service;

import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.spring.app.common.AES256;
import com.spring.app.common.SecretMyKey;
import com.spring.app.common.Sha256;
import com.spring.app.entity.Users;
import com.spring.app.users.domain.UsersDTO;
import com.spring.app.users.model.UsersRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UsersService_imple implements UsersService {
	
	private final UsersRepository usersRepository;
	private AES256 aes;
	
	// 로그인
	@Override
	public UsersDTO getUser(String id, String pwd) {
		
		UsersDTO usersDto = null;
		
		try {
	        Optional<Users> user = usersRepository.findById(id);	// 카테고리 포함 데이터 가져오기
	   /*   Java8에서는 Optional<T> 클래스를 사용해 NullPointerException 을 방지할 수 있도록 도와준다. 
	        Optional<T>는 null이 올 수 있는 값을 감싸는 Wrapper 클래스 이므로, 참조하더라도 NullPointerException 이 발생하지 않도록 도와준다. 
	        Optional 클래스는 null 이더라도 바로 NullPointerException 이 발생하지 않으며, 클래스이기 때문에 각종 메소드를 제공해준다. */
	        aes = new AES256(SecretMyKey.KEY);
	        
	        Users users = user.get();
	        // java.util.Optional.get() 은 값이 존재하면 값을 리턴시켜주고, 값이 없으면 NoSuchElementException 을 유발시켜준다.
	        
	        try {
	        	usersDto = users.toDTO();
	        	System.out.println(usersDto.getId());
	        	System.out.println(Sha256.encrypt(pwd));
	        	// usersDto.setPassword(Sha256.encrypt(Pwd));
	          
	          	// 복호화해서 DTO에 담기
		        usersDto.setEmail(aes.decrypt(users.getEmail()));
		        usersDto.setMobile(aes.decrypt(users.getMobile()));
		        usersDto.setPoint((users.getPoint()));
	        } catch (Exception e) {   
	          e.printStackTrace();
	       }
	        
	     } catch(NoSuchElementException e) {
	         // member.get() 에서 데이터가 존재하지 않는 경우
	     } catch (Exception e) {
			e.printStackTrace();
		}
		
		return usersDto;
	}

}
