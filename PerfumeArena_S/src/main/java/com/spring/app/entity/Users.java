package com.spring.app.entity;

import java.time.LocalDateTime;

import com.spring.app.users.domain.UsersDTO;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "users")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class Users {
	
	@Id
	@Column(name = "id", nullable = false, length = 40 )
	private String id;
	
	@Column(nullable = false, length = 30)
	private String name;
	
	@Column(nullable = false, length = 200)
	private String password;
	
	@Column(nullable = false, length = 200)
	private String email;
	
	@Column(nullable = false, length = 200)
	private String mobile;
	
	@Column(length = 5)
	private String postcode;
	
	@Column(length = 200)
	private String address;
	
	@Column(name = "ADDRESSDETAIL", length = 200)
	private String addressDetail;
	
	@Column(name = "ADDRESSEXTRA", length = 200)
	private String addressExtra;
	
	private int point;
	
	@Column(length = 20)
	private String grade;
	
	@Column(nullable = false, columnDefinition = "DATE DEFAULT SYSDATE",
  		    insertable = false, updatable = false) 
	private LocalDateTime registerday;
	
	@Column(name = "passwordchanged",
			nullable = false, columnDefinition = "DATE DEFAULT SYSDATE",
			insertable = false)
	private LocalDateTime passwordChanged;
	
	@Column(name = "isdormant", nullable = false)
	private String isDormant;
	
	@Column(name = "isdeleted", nullable = false)
	private String isDeleted;
	
	public UsersDTO toDTO() {
		return UsersDTO.builder()
				.id(this.id)
				.name(this.name)
				.password(this.password)
				.email(this.email)
				.mobile(this.mobile)
				.postcode(this.postcode)
				.address(this.address)
				.addressDetail(this.addressDetail)
				.addressExtra(this.addressExtra)
				.point(this.point)
				.grade(this.grade)
				.registerday(this.registerday)
				.passwordChanged(this.passwordChanged)
				.isDormant(this.isDormant)
				.isDeleted(this.isDeleted)
				.build();
	}
 
}
