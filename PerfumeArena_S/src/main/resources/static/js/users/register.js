
let b_idcheck_click = false;
// "아이디중복확인" 을 클릭했는지, 클릭을 안했는지 여부를 알아오기 위한 용도

let b_emailcheck_click = false;
// "이메일중복확인" 을 클릭했는지, 클릭을 안했는지 여부를 알아오기 위한 용도

$(function(){
	
	$('span.error').hide();
	$('input#name').focus();
 
    $('input#name').blur((e) => { 
	   
	 // alert($(e.target).val());
		

	// "취소" 버튼 클릭 시 이전 페이지로 이동
 	$('#btnCancel').click( () => {
 	    history.back();
 	});
	 
		const name = $(e.target).val().trim();
		if(name == "") {
			// 입력하지 않거나 공백만 입력했을 경우
			
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
			
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 공백이 아닌 글자를 입력했을 경우
			$('table#tblUserRegister :input').prop('disabled', false);
			
		 // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
			
	});	// end of $('input#name').blur((e) => {})-------------------
	
	
	
	$('input#id').blur((e) => { 
		   
	 // alert($(e.target).val());
			
		const id = $(e.target).val().trim();
		if(id == "") {
			// 입력하지 않거나 공백만 입력했을 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().next().next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 공백이 아닌 글자를 입력했을 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().next().next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#id').blur((e) => {})-------------------
	
	
	$('input#password').blur((e) => { 
		
	    const regExp_password = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
		// 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
		
		const bool = regExp_password.test($(e.target).val());
		
		if(!bool) {
			// 암호가 정규표현식에 위배된 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			//$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 암호가 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#password').blur((e) => {})-------------------	
	
	
	$('input#passwordCheck').blur((e) => { 
	 	
		if( $('input#password').val() != $(e.target).val() ) {
			// 암호와 암호확인값이 틀린 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$('input#password').prop('disabled', false);
			$(e.target).prop('disabled', false);
			
			//$('input#password').val('').focus();
			//$(e.target).val('');
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 암호와 암호확인값이 같은 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#passwordCheck').blur((e) => {})-------------------
	
	
	$('input#email').blur((e) => { 
		
	    const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
		// 이메일 정규표현식 객체 생성
		
		const bool = regExp_email.test($(e.target).val());
		
		if(!bool) {
			// 이메일이 정규표현식에 위배된 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().parent().find('span.error').show();
		}
		else {
			// 이메일이 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().parent().find('span.error').hide();
		}
				
	});	// end of $('input#email').blur((e) => {})-------------------	
	

	
	$('input#hp2').blur((e) => { 
			
	    const regExp_hp2 = /^[1-9][0-9]{3}$/; 
		// 연락처 국번( 숫자 4자리인데 첫번째 숫자는 1-9 이고 나머지는 0-9) 정규표현식 객체 생성
		
		const bool = regExp_hp2.test($(e.target).val());
		
		if(!bool) {
			// 연락처 국번이 정규표현식에 위배된 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 연락처 국번이 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#hp2').blur((e) => {})-------------------	
	
	
	$('input#hp3').blur((e) => { 
				
	 // const regExp_hp3 = /^[0-9]{4}$/;
	 // 또는
		const regExp_hp3 = /^\d{4}$/;
		// 연락처 마지막 4자리( 숫자만 되어야 함) 정규표현식 객체 생성
		
		const bool = regExp_hp3.test($(e.target).val());
		
		if(!bool) {
			// 연락처 마지막 4자리가 정규표현식에 위배된 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 연락처 마지막 4자리가 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#hp3').blur((e) => {})-------------------	
	
	
	
	$('input#postcode').blur((e) => { 
					
	 // const regExp_hp3 = /^[0-9]{4}$/;
	 // 또는
		const regExp_postcode = /^\d{5}$/;
		// 숫자 5자리만 들어오도록 정규표현식 객체 생성
		
		const bool = regExp_postcode.test($(e.target).val());
		
		if(!bool) {
			// 우편번호가 정규표현식에 위배된 경우
				
			$('table#tblUserRegister :input').prop('disabled', true);
			$(e.target).prop('disabled', false);
			$(e.target).val('').focus();
				
		//	$(e.target).next().show();
		//  또는
		    $(e.target).parent().find('span.error').show();
		}
		else {
			// 우편번호가 정규표현식에 맞는 경우
			$('table#tblUserRegister :input').prop('disabled', false);
				
	     // $(e.target).next().next().hide();
		 // 또는
			$(e.target).parent().find('span.error').hide();
		}
				
	});	// end of $('input#postcode').blur((e) => {})-------------------
	
	
	//////////////////////////////////////////////////////////////////////
	
	/*	
        >>>> .prop() 와 .attr() 의 차이 <<<<	         
             .prop() ==> form 태그내에 사용되어지는 엘리먼트의 disabled, selected, checked 의 속성값 확인 또는 변경하는 경우에 사용함. 
             .attr() ==> 그 나머지 엘리먼트의 속성값 확인 또는 변경하는 경우에 사용함.
	*/
	
	// 우편번호를 읽기전용(readonly)로 만들기 
	$('input#postcode').attr('readonly', true);
	
	// 주소를 읽기전용(readonly)로 만들기 
	$('input#address').attr('readonly', true);
	
	// 참고항목을 읽기전용(readonly)로 만들기 
	$('input#addressExtra').attr('readonly', true);
	
	// ==== "우편번호찾기"를 클릭했을때 이벤트 처리하기 ==== //
	$('img#postcodeSearch').click(function(){
		new daum.Postcode({
		    oncomplete: function(data) {
		        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		        let addr = ''; // 주소 변수
		        let extraAddr = ''; // 참고항목 변수

		        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		            addr = data.roadAddress;
		        } else { // 사용자가 지번 주소를 선택했을 경우(J)
		            addr = data.jibunAddress;
		        }

		        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		        if(data.userSelectedType === 'R'){
		            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                extraAddr += data.bname;
		            }
		            // 건물명이 있고, 공동주택일 경우 추가한다.
		            if(data.buildingName !== '' && data.apartment === 'Y'){
		                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		            }
		            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		            if(extraAddr !== ''){
		                extraAddr = ' (' + extraAddr + ')';
		            }
		            // 조합된 참고항목을 해당 필드에 넣는다.
		            document.getElementById("addressExtra").value = extraAddr;
		        
		        } else {
		            document.getElementById("addressExtra").value = '';
		        }

		        // 우편번호와 주소 정보를 해당 필드에 넣는다.
		        document.getElementById('postcode').value = data.zonecode;
		        document.getElementById("address").value = addr;
		        // 커서를 상세주소 필드로 이동한다.
		        document.getElementById("addressDetail").focus();
		    }
		}).open();
				
	});// end of $('img#postcodeSearch').click(function(){})---------------


	 
	 // "아이디중복확인" 을 클릭했을 때 이벤트 처리하기 시작 // 
	 $('span#idCheck').click(function(){
		 b_idcheck_click = true;
      	// 비동기식으로 처리해야함.
 		// 지금 페이지에 머무른 채로, (일처리가 마무리 되기전에)
		// json형식으로 백단에 주고받아 아이디 체크할 것.
		if($('input#id').val().trim() === '') {
			alert("아이디를 입력해주세요.")
			return;
		} // 만약 아이디를 입력하지 않았다면, 경고 후 함수종료시키기.
		 $.ajax({
			url: ctxPath + "/users/checkIdDuplicate",
			data:{"id":$('input#id').val().trim()},  
			// data 속성은 http://localhost:9090/SemiProject/user/userRegister.do 로 
			// 전송해야할 데이터를 말한다.   
			type:"post", // type 을 생략하면 type:"get" 이다.
			async:true,   
			dataType:"json",
			
		 	success:function(json){
				console.log(json);
				
				if(json.isExists) {
					// 입력한 id 가 이미 사용중이라면 
					$('span#idCheckResult')
					.html($('input#id').val() + "은 이미 사용중 이므로 다른 아이디를 입력하세요")
					.css({"color":"red"});
				}
				else {
					// 입력한 id 가 존재하지 않는 경우라면 
					$('span#idCheckResult')
					.html($('input#id').val() + "은 사용가능 합니다.")
					.css({"color":"blue"});
				}
			},
			
			error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		 });
		
	 });
	 // "아이디중복확인" 을 클릭했을 때 이벤트 처리하기 끝 //
	 
	 // 아이디값이 변경되면 가입하기 버튼 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지 알아보기 위한 용도 초기화 시키기 
	 $('input#id').bind('change', function(){
		b_idcheck_click = false;
		$('span#idCheckResult').html("");
	 });// 만약 아이디 입력을 변경했다면, 중복확인 html은 지워주기.
	 
	 
	 // "이메일중복확인" 을 클릭했을 때 이벤트 처리하기 시작 // 
	 $('span#emailCheck').click(function(){
		b_emailcheck_click = true;
		// 비동기 방식으로 id와 마찬가지 이메일 체크하기	
			
		if($('input#email').val().trim() === '') {
			alert("이메일을 입력해주세요.")
			return;
		} // 만약 이메일을 입력하지 않았다면, 경고 후 함수종료시키기.
		$.ajax({
			url: ctxPath + "/users/checkEmailDuplicate",
			data:{"email":$('input#email').val().trim()},
			// data 속성은 http://localhost:9090/SemiProject/user/userRegister.do 로 
			// 전송해야할 데이터를 말한다.
			type:"post",
			async:true, 
			dataType:"json",  
			
			success:function(json){
				console.log(json);
				// {"isExists":false} 또는 {"isExists":true}
				
				if(json.isExists) {
					// 입력한 email 이 이미 사용중이라면 
					$('span#emailCheckResult')
					.html($('input#email').val() + "은 이미 사용중 이므로 다른 이메일을 입력하세요")
					.css({"color":"red"});
				}
				else {
					// 입력한 email 이 존재하지 않는 경우라면 
					$('span#emailCheckResult')
					.html($('input#email').val() + "은 사용가능 합니다.")
					.css({"color":"blue"});
				}
				
			},
			
			error: function(request, status, error){
                //alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }				  
		});
			
	 });
	 // "이메일중복확인" 을 클릭했을 때 이벤트 처리하기 끝 //	 
	 
	
	 // 이메일값이 변경되면 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지 알아보기 위한 용도 초기화 시키기 
 	 $('input#email').bind('change', function(){
		b_emailcheck_click = false;
		$('span.emailCheckResult').html("");
 	 });// 만약 이메일 입력을 변경했다면, 중복확인 html은 지워주기.
	 	
	 
		
});// end of $(function(){})--------------------------------


// Function Declaration
// "가입하기" 버튼 클릭시 호출되는 함수
function register() {
	
	// **** 필수입력사항에 모두 입력이 되었는지 검사하기 시작 **** //
	let b_requiredInfo = true;
	
	$('input.requiredInfo').each(function(index, elmt){
		const data = $(elmt).val().trim();
		if(data == "") {
			alert("필수입력사항을 모두 입력해주세요.");
			b_requiredInfo = false;
			return false; // break; 라는 뜻이다.
		}
	});
	
	if(!b_requiredInfo) {
		return; // register() 함수를 종료한다.
	}
	// **** 필수입력사항에 모두 입력이 되었는지 검사하기 끝 **** //
	
	
	// **** "아이디중복확인" 을 클릭했는지 검사하기 시작 **** //
	if(!b_idcheck_click) {
		// "아이디중복확인" 을 클릭 안 했을 경우
		
		alert("아이디 중복확인을 클릭하셔야 합니다.");
		return; // register() 함수를 종료한다.
	}
	// **** "아이디중복확인" 을 클릭했는지 검사하기 끝 **** //
	
	
	// **** "이메일중복확인" 을 클릭했는지 검사하기 시작 **** //
	if(!b_emailcheck_click) {
		// "이메일중복확인" 을 클릭 안 했을 경우
		
		alert("이메일 중복확인을 클릭하셔야 합니다.");
		return; // register() 함수를 종료한다.
	}	
    // **** "이메일중복확인" 을 클릭했는지 검사하기 끝 **** //
	
	
	/* **** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 **** //
	let b_addressInfo = true;
	
	const arr_addressInfo = [];
	arr_addressInfo.push($('input#postcode').val());
	arr_addressInfo.push($('input#address').val());
	arr_addressInfo.push($('input#detailAddress').val());
	arr_addressInfo.push($('input#extraAddress').val());
	
	for(let addressInfo of arr_addressInfo) {
		if(addressInfo.trim() == "") {
			alert("우편번호 및 주소를 입력하셔야 합니다.");
			b_addressInfo = false;
			break;
		}
	}// end of for---------------------
	
	if(!b_addressInfo) {
		return; // register() 함수를 종료한다.
	}
	// **** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 **** /*/
	
	
	const form = document.registerForm;
	form.method = "post";
 	form.action =  ctxPath + "/users/register";
    form.submit();
	
}// end of function register()-----------------------------
