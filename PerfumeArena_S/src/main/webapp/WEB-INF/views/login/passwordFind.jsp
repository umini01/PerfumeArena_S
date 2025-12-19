<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
  String ctxPath = request.getContextPath(); 
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header/header.jsp" />

	<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/css/users/pwFind.css" />
	<style type="text/css">
		.finder {padding:15px 0;background-color:gray !important;width:30%;padding:7px;margin-bottom:15px;border:0;}
		.pwFindWrap > #pwFindFrm > .pwBox p {position:relative;}
		.pwFindWrap > #pwFindFrm > .pwBox p::after {content: "";display: inline-block;width: 5px;height: 5px;background-color: red;border-radius: 50%;position: absolute;left: 48px;top: 1px;}
	</style>

	<script type="text/javascript">
	
		$(function(){
		
			$(function() {
				const loginid = localStorage.getItem('saveid');
				if (loginid != null && loginid !== "") {
					$('.loginBox input:text[name="id"]').val(loginid);
					$('input#saveid').prop("checked", true); 
				}
			});
			
			const method = "${requestScope.method}";
		
			if(method == "GET") {
				$('div#div_findResult').prop('hidden', true);				
			} 
			else {
				$('div#div_findResult').prop('hidden', false);
				$('input:text[name="id"]').val("${requestScope.id}");
				$('input:text[name="email"]').val("${requestScope.email}");
				<%-- idfind class파일에서 setAttribute에서 name과 email을 넘겨줘서 여기서 쓸 수 있었다.--%>
			} 
		
			$('button.btn-success').click(function(){
				    pwFind();
			});
			
			$('input:text[name="email"]').bind('keyup',function(e){
				if(e.keyCode == 13){
					pwFind();
				}
			});
			
		}); 

	 	function pwFind() {
		
		 	const id = $('form[name="pwFindFrm"] input[name="id"]').val().trim();
			console.log("아이디 값:", id); // 콘솔 디버깅
			if (id == ""){
				alert('아이디를 입력하십시오.');
				return; 
			}
		
			const email = $('input:text[name="email"]').val();
			const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
			if ( !regExp_email.test(email) ){
				// 이메일이 정규표현식에 위배된 경우
				alert('이메일을 올바르게 입력하십시오.');
				return; // goFind() 함수종료
			}
		
			// 다 올바른 경우
			const frm = document.pwFindFrm;
			frm.action = "<%=ctxPath%>/users/passwordFind";
			frm.method = "POST";
			frm.submit();
	  	}

		function form_reset_empty() {
			document.querySelector('form[name="pwFindFrm"]').reset();
			$('div#div_findResult').empty();
			<%-- 해당 태그내에 값들을 싹 비우는것.--%>
		}
	
		// === 인증하기 버튼 클릭 시 이벤트 첳리해주기 시작 == //
		$(document).on('click', 'button.btn-info', function() {
    		const input_confirmCode = $('input:text[name="input_confirmCode"]').val().trim();

    		if (input_confirmCode == "") {
        		alert("인증코드를 입력하세요");
        		return;
    		}

	    	const frm = document.verifyCertificationFrm;
	    	frm.userCertificationCode.value = input_confirmCode;
	    	frm.id.value = $('form[name="pwFindFrm"] input[name="id"]').val();
	
	    	frm.action = "<%= ctxPath%>/users/verifyCertification";
	    	frm.method = "post";
	    	frm.submit();
		});

	</script>
	
   	<div class="pwFindWrap" id="pwFindWrap">
	 	<form id="pwFindFrm" name="pwFindFrm">
 			<p class="pwContain" style="text-align:center;">비밀번호 찾기</p>
 			
			<div class="pwBox">
				<p>아이디</p>
				<input type="text" id="id" name="id">
			</div>
		
			<div class="pwBox">
				<p>이메일</p>
				<input type="text" id="email" name="email">
			</div>
			
			<div class="submitBtn">
				<button type="button" class="btn btn-success" onclick="pwFind()" style="background-color:#c084fc !important;border:0px solid #fff !important;">찾기</button>
			</div>
			
			<%-- <div id="div_findResult">${requestScope.n}</div> --%>
			<c:if test="${requestScope.n == 1}">
				<div style="text-align:center;">
					<p style="text-align:center;line-height:22px;">인증코드가 ${requestScope.email} 로 발송되었습니다.<br> 인증코드를 입력해주세요</p>
					<input type="text" name="input_confirmCode" style="margin-top:15px;" />
					<br><br>
					<button type="button" class="btn btn-info finder">인증하기</button>
				</div>
			</c:if>
			<c:if test="${requestScope.n == 0}"><p style="text-align:center;line-height:22px;margin:10px 0 25px;font-size:16pt;">없습니다.</p></c:if>
	   	</form> 
	</div>

	<%-- 인증하기 form --%>
	<form name="verifyCertificationFrm">
		<input type="hidden" name ="userCertificationCode" />
		<input type="hidden" name ="id" />
	</form>
	
<jsp:include page="../footer/footer.jsp" />