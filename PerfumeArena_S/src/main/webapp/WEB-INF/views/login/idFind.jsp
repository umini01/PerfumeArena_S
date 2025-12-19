<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<% 
  String ctxPath = request.getContextPath(); 
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header/header.jsp" />

	<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/css/users/idFind.css" />
	
	<style type="text/css">
		.headerNav {position:relative;}
		.btn.btn-success {width: 100%;margin: 25px 0 0;}
		body {background-color: #f5f3ff;background-image: url(https://img.freepik.com/free-vector/hand-painted-watercolor-floral-pattern_23-2148931052.jpg);background-size: cover;background-position: center;background-attachment: fixed;background-blend-mode: overlay;}
		#idBox{background-color:#fff;}
	</style>

	<script type="text/javascript" >
	
		$(function(){
		
	   		const method = "${requestScope.method}";
		
		   	if(method != "POST") {
		      	$('div#div_findResult').prop('hidden', true);
		   	} 
		   	else {
		      	$('div#div_findResult').prop('hidden', false);
		      	$('input:text[name="name"]').val("${requestScope.name}");
		      	$('input:text[name="email"]').val("${requestScope.email}");
		      	<%-- idfind class파일에서 setAttribute에서 name과 email을 넘겨줘서 여기서 쓸 수 있었다.--%>
		   	} 
		
		   	$('button.btn-success').click(function(){
		      	goFind();
		   	});
		   
		   	$('input:text[name="email"]').bind('keyup',function(e){
		      	if(e.keyCode == 13){
		         	goFind();
		      	}
		   	});
		   
		}); 
		
	 	function goFind() {
		   
	   		const name = $('input:text[name="name"]').val().trim();
		   	if (name == ""){
		      	alert('성명을 입력하십시오.');
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
		   	const frm = document.idFindFrm;
		   	frm.action = "<%= ctxPath%>/users/idFind";
		   	frm.method = "POST";
		   	frm.submit();
		}
		
	 	function form_reset_empty(){
	       	document.querySelector('form[name="idFindFrm"]').reset();
	       	$('div#div_findResult').empty(); 
	       	<%-- 해당 태그내에 값들을 싹 비우는것.--%>
	 	}
	
	</script>

   	<div id="idFindWrap">
  		<form id="idFindFrm" name="idFindFrm">
    		<p id="idTitle">아이디 찾기</p>

    		<div class="inputRow">
      			<label for="name">성명</label>
      			<input type="text" name="name" id="name" />
    		</div>

		    <div class="inputRow">
		      	<label for="email">이메일</label>
		      	<input type="text" name="email" id="email" />
		    </div>

	    	<div class="submitBtn" style="text-align:center;">
	      		<button type="button" class="btn btn-success" onclick="goFind()" style="background-color:#c084fc !important;border:0px solid #fff !important;width:30%;">찾기</button>
	   		</div>

		    <div id="div_findResult">
		      	<c:if test="${not empty requestScope.users}">
					<p style="margin:15pt 0;text-align:center; ">아이디는 <strong style="color:#000; font-size: 16pt; ">${requestScope.users}</strong> 입니다.</p>
				</c:if>
				<c:if test="${empty requestScope.users}">
					<p>입력하신 정보와 일치하는 아이디가 없습니다.</p>
				</c:if>
		    </div>
  		</form>
	</div>

<jsp:include page="../footer/footer.jsp" />