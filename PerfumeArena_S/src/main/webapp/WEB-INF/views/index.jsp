<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
  
<%
	String ctxPath = request.getContextPath();
%> 

<script type="text/javascript">
	$(document).ready(function() {
	  	// 로고 페이드 인 > 2초간 유지 > 페이드 아웃
	  	$('#footerLogo').fadeTo(2000, 1, function() {
	    	setTimeout(function() {
	      		$('#splashScreen').fadeOut(800, function() {
       				$('#mainContent').fadeIn(300); // 메인 내용 보여줌
	      		});
	    	}, 1000); // fadeIn 후 1초 대기
	  	});
	});
</script>

<style type="text/css">
    #leftSide { display: none !important; }
   	#splashScreen { 
   		position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: #000; /* 또는 원하는 배경 */
		display: flex; justify-content: center; align-items: center; z-index: 9999; 
	}
	#splashScreen img#footerLogo {
  		width: 300px; /* 원하는 초기 로고 크기 */ height: auto; opacity: 0;
	}
</style>

<jsp:include page="header/header.jsp" />

	<div class="col-md-12" style="padding:0;">
		<div class="container-fluid">		
			<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="height:100%;">
		  		
		  		<ol class="carousel-indicators">
			    	<c:if test="${not empty requestScope.categoryList}">
			    		<c:forEach items="${requestScope.categoryList}" varStatus="status">
			    			<c:if test="${status.index==0}">
		    			    	<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="active"></li>
		    			    </c:if>
		    			    
		    			    <c:if test="${status.index>0}">
		    			    	<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}"></li>
				    		</c:if>
				    	</c:forEach>
			    	</c:if>
  	 			</ol>
  	 			
		  		<div class="carousel-inner">
				    <c:if test="${not empty requestScope.categoryList}">
			    		<c:forEach var="cvo" items="${requestScope.categoryList}" varStatus="status">
			    		
				    	  	<c:if test="${status.index ==0 }">
					    	  	<div class="carousel-item active">
					    	  		<a href="<%= ctxPath%>/item/mallHome?categoryNo=${cvo.categoryNo}">
						      			<img src="<%= ctxPath%>${cvo.categoryImagePath}" class="d-block w-100" alt="...">
						      		</a>
						      		<div class="carousel-caption d-none d-md-block">
							    		<h5 style="font-size: 18px;">${cvo.categoryName }</h5>
							  		</div>
					    		</div>
					     	</c:if>
					    
					     	<c:if test="${status.index >0 }">
						    	<div class="carousel-item">
						      		<a href="<%= ctxPath%>/item/mallHome?categoryNo=${cvo.categoryNo}">
						      			<img src="<%= ctxPath%>${cvo.categoryImagePath}" class="d-block w-100" alt="...">
						      		</a>
						      		<div class="carousel-caption d-none d-md-block">
							    		<h5 style="font-size: 18px;">${cvo.categoryName}</h5>
							  		</div>		      
						    	</div>
					     	</c:if>
			    		</c:forEach>
			    	</c:if>
		  		</div>
		  		
		  		<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
		    		<span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    		<span class="sr-only">Previous</span>
		  		</a>
			  	<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
			    	<span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
			  	</a>
			</div>
		
			<br><br>
			
		</div>
		
<jsp:include page="footer/footer.jsp" /> 