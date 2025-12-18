<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>

	<title>PerfumeArena</title> 

	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="icon" type="image/png" sizes="32x32" href="<%= ctxPath%>/images/header/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="<%= ctxPath%>/images/header/favicon-16x16.png">
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 
	
	<!-- Font Awesome 6 Icons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"></script> 
	
	<%-- jQueryUI CSS 및 JS --%>
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
	<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>
	
	<!-- 직접 만든 CSS/JS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/common/common.css" />
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/main/main.css" />
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/header/header.css" />
	<script type="text/javascript" src="<%= ctxPath%>/js/main/main.js"></script>
	<script type="text/javascript" src="<%=ctxPath%>/js/login/login.js"></script>
	
	<script type="text/javascript">
	
		$(function () {
			
	    	$('div.loginBox').hide();
		
		    const loginBox = $('div.loginBox');
		    const adminTabWrapper = $('.adminTab-wrapper');
		    const adminTab = $('.adminTab');
		    const userTabWrapper = $('.userTab-wrapper');
		    const userTab = $('.userTab');
		
		    let openMenu = null; 
		    let isTransitioning = false;
			
		    function closeAllMenus(callback) {
        		if (openMenu === "login") {
	            	loginBox.fadeOut(200, () => {
	                	openMenu = null;
		                callback && callback();
		            });
		        } 
        		else if (openMenu === "admin") {
	            	adminTab.removeClass('adminTab-open');
		            adminTab.one('transitionend', function () {
		                adminTabWrapper.removeClass('wrapperOpen').css({ zIndex: 0, right: '-250px' });
		                openMenu = null;
		                callback && callback();
		            });
		        } 
        		else if (openMenu === "user") {
		            userTab.removeClass('userTab-open');
		            userTab.one('transitionend', function () {
		                userTabWrapper.removeClass('wrapperOpen').css('z-index', 0);
		                openMenu = null;
		                callback && callback();
		            });
		        } 
        		else {
	            	callback && callback();
		        }
			}
		
		    // 로그인 박스 열기/닫기
		    $(document).on("click", ".logins", function () {
	        	if (isTransitioning) return;
		        isTransitioning = true;
		
		        if (openMenu === "login") {
	            	loginBox.fadeOut(200, () => {
	                	openMenu = null;
		                isTransitioning = false;
		            });
		        } else {
	            	closeAllMenus(() => {
		                loginBox.fadeIn(200, () => {
		                    openMenu = "login";
		                    isTransitioning = false;
		                });
		            });
		        }
		    });
		
		    const loginId = "${sessionScope.loginUser.id}";
		
		    // === 관리자 메뉴 ===
		    if (loginId === 'admin') {
		        let isAdminOpen = false;
		        $('.adminFunc').on('click', function () {
		            if (isTransitioning) return;
		            isTransitioning = true;
		
		            if (openMenu === "admin") {
		                adminTab.removeClass('adminTab-open');
		                adminTab.one('transitionend', function () {
		                    adminTabWrapper.removeClass('wrapperOpen').css({ zIndex: 0, right: '-250px' });
		                    openMenu = null;
		                    isTransitioning = false;
		                });
		            } else {
		                closeAllMenus(() => {
		                    adminTabWrapper.addClass('wrapperOpen').css({ zIndex: 21, right: '0' });
		                    adminTab.addClass('adminTab-open');
		                    openMenu = "admin";
		                    isTransitioning = false;
		                });
		            }
		        });
		    }
		
		    // === 일반 사용자 메뉴 ===
		    else {
		        $('.userFunc').on('click', function () {
		            if (isTransitioning) return;
		            isTransitioning = true;
		
		            if (openMenu === "user") {
		                userTab.removeClass('userTab-open');
		                userTab.one('transitionend', function () {
		                    userTabWrapper.removeClass('wrapperOpen').css('z-index', 0);
		                    openMenu = null;
		                    isTransitioning = false;
		                });
		            } else {
		                closeAllMenus(() => {
		                    userTabWrapper.addClass('wrapperOpen').css('z-index', 21);
		                    userTab.addClass('userTab-open');
		                    openMenu = "user";
		                    isTransitioning = false;
		                });
		            }
		        });
		    }
		
		    // 로그인 저장 아이디 복원
		    if (${empty sessionScope.loginuser}) {
		        const loginid = localStorage.getItem('saveid');
		        if (loginid != null) {
		            $('input:text[name="id"]').val(loginid);
		            $('#saveid').prop("checked", true);
		        }
		    }
		
		    // 스크롤 시 header 배경 조절
		    $(window).scroll(function () {
		        const scrollTop = $(window).scrollTop();
		        if (scrollTop > 30) {
		            $('.headerNav').css('backgroundColor', 'rgba(255,255,255,0.9)');
		        } else {
		            $('.headerNav').css('backgroundColor', 'transparent');
		        }
		    });
		});
		
		function SearchItems() {
		    const searchID = $('input[name="searchID"]').val().trim();
		
		    if (searchID === "") {
		        alert("검색어를 입력하세요.");
		        return false;
		    }
		
		    const frm = document.searchFrm;
		    frm.action = "<%= ctxPath%>/item/searchResult";
		    frm.method = "get";
		    frm.submit();
		    return false; // 폼 기본 제출 막기
		}
		
	</script>
	
</head>
<body>

	<div class="userTab-wrapper">
		<div class="userTab">
			<p><a href="${pageContext.request.contextPath}/item/mallHome">전체</a></p>
			<c:forEach var="cvo" items="${applicationScope.categoryList}" varStatus="status">
				<p class="categoryNo=${cvo.categoryNo}">
					<a href="${pageContext.request.contextPath}/item/mallHome?categoryNo=${cvo.categoryNo}">
					${cvo.categoryName}
					</a>
				</p>
			</c:forEach>
		</div>
	</div>
	
	<div class="loginBox" style="height: 200px; text-align: left; padding: 11px; border-radius: 15px">
		<div class="loginTheme">
		
		  	<c:if test="${empty sessionScope.loginUser}">
				<form name="loginForm" action="<%=ctxPath%>/login/login" method="post">
					<table id="loginTbl">
						<thead>
							<tr>
								<th colspan="3">LOGIN</th>
							</tr>
						</thead>
						<tbody>
							<tr class="trTab">
								<td>ID</td>
								<td></td>
								<td>
							   		<input type="text" name="id" id="loginid" size="20" autocomplete="off" />
								</td>
							</tr>
							<tr class="trTab">
								<td>암호</td>
								<td></td>
								<td>
									<input type="password" name="password" id="loginPwd" size="20" />
								</td>
							</tr>

							<tr>
								<td colspan="3" style="padding:3% 0.5%;font-size:13px;">
									<a href="<%=ctxPath%>/login/idFind" style="cursor: pointer;">아이디찾기</a> 
									/
									<a href="<%=ctxPath%>/login/passwordFind" style="cursor: pointer;">비밀번호찾기</a>
									<a href="<%=ctxPath%>/user/userRegister" style="margin-left:30px;">회원가입</a>
								</td>
							</tr>

							<tr>
								<td colspan="3">
									<input type="checkbox" id="saveid" name="saveid" />&nbsp;
									<label for="saveid">아이디저장</label>
									<button type="button" id="btnSubmit" class="btn btn-dark btn-sm ml-3">로그인</button>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
		 	</c:if>
		 	
			 <c:if test="${not empty sessionScope.loginUser}">
		  		<table id="isLogin" style="width:100%;">
		    		<thead>
		      			<tr>
		        			<th id="loginUserId" colspan="3" style="text-align:center; font-size:18px;padding-top:10px;"> 
		          				<c:choose>
					  				<c:when test="${sessionScope.loginUser.grade eq 'bronze'}">
			    						<span id="loginUserId" class="grade-name bronze-name">${sessionScope.loginUser.id}</span>
					  				</c:when>
								  	<c:when test="${sessionScope.loginUser.grade eq 'silver'}">
								    	<span id="loginUserId" class="grade-name silver-name">${sessionScope.loginUser.id}</span>
								  	</c:when>
								  	<c:when test="${sessionScope.loginUser.grade eq 'gold'}">
								    	<span id="loginUserId" class="grade-name gold-name">${sessionScope.loginUser.id}</span>
								  	</c:when>
								  	<c:when test="${sessionScope.loginUser.grade eq 'vip'}">
								    	<span id="loginUserId" class="grade-name vip-name">${sessionScope.loginUser.id}</span>
								  	</c:when>
				  				</c:choose>
	        				</th>
	      				</tr>
	    			</thead>
		    		<tbody>
				      	<tr>
				        	<td colspan="3" style="padding-top:20px;"> 
				          		<span style="font-weight:bold;">${sessionScope.loginUser.name}님</span>
				          		&nbsp;[<a href="javascript:editInfo('${sessionScope.loginUser.id}', '<%=ctxPath %>')" style="color: #f43cff;">나의정보변경</a>]
			        		</td>
				      	</tr>
				      	<tr>
				        	<td colspan="3" style="padding-top:10px;">
				          		<span style="font-weight: bold;">포인트&nbsp;:</span>
				          		&nbsp;<fmt:formatNumber value="${sessionScope.loginUser.point}" pattern="###,###"/> POINT  
			        		</td>
				      	</tr>
				      	<tr>
					  		<td colspan="3" style="padding-top:10px;">
						    	<span style="font-weight: bold;">등급&nbsp;:</span>
						    	<span style="display: inline-flex; align-items: center;">
						      		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sessionScope.loginUser.grade}
						      		<c:choose>
							        	<c:when test="${sessionScope.loginUser.grade eq 'bronze'}">
								          	<span class="pixel-crown bronze"></span>
							        	</c:when> 
							        	<c:when test="${sessionScope.loginUser.grade eq 'silver'}">
								          	<span class="pixel-crown silver"></span>
								        </c:when>
								        <c:when test="${sessionScope.loginUser.grade eq 'gold'}">
								          	<span class="pixel-crown gold"></span>
								        </c:when>
								        <c:when test="${sessionScope.loginUser.grade eq 'vip'}">
								          	<span class="pixel-crown vip"></span>
								        </c:when>
							      	</c:choose>
						    	</span>
						  	</td>
					  	</tr>
				      	<tr>
				        	<td colspan="3" style="padding-top:10px;">
				          		<c:if test="${sessionScope.loginUser.id ne 'admin'}">
				          			<span style="font-weight: bold;"><a href="<%=ctxPath %>/item/orderList" style="color: #666363;">주문목록 보기</a></span>
				          		</c:if>
				          		&nbsp;&nbsp;&nbsp;&nbsp;<span><button type="button" class="btn btn-danger btn-sm" onclick="javascript:LogOut('<%=ctxPath%>')">Logout</button></span>
				        	</td>
				      	</tr>
		      			<tr>
		        			<td colspan="3" style="padding-top:10px;"></td>
		      			</tr>
    				</tbody>
	  			</table>
			</c:if>
		</div>
	</div>

	<nav class="headerNav">
		<ul class="headerUl">
			<li><a class="navbar-brand" href="<%= ctxPath%>/index" style="margin-right: 10%;"><img src="<%= ctxPath%>/images/header/favicon-32x32.png" /></a></li>
 			<div style="width:550px;display:flex;justify-content:space-between;align-items:center;">
	 			<li>
	 	  			<div class="input-group">
						<form name="searchFrm" id="searchFrm" onsubmit="return SearchItems();" style="display:flex;">
				  			<input type="text" name="searchID" id="searchID" placeholder="검색어를 입력하세요" />
					  		<i class="fas fa-search"></i>
					   		<button type="submit" class="btnSubmit"></button>
						</form>
				  	</div>
				</li>
				
				<c:if test="${empty sessionScope.loginUser}">
					<li class="logins" style="border:1px solid #bbb;padding:10px 25px;border-radius:30px;background:#fff;color:#000;cursor:pointer;">로그인</li>
				</c:if>
				
				<%-- 관리자가 확인하는 header --%>
				<c:if test="${not empty sessionScope.loginUser && sessionScope.loginUser.id == 'admin'}">
					<jsp:include page="headerAdmin.jsp" />
		 	 	</c:if>
			 	 	
		 		<%-- 회원들이 보는 header --%>
		 	 	<c:if test="${not empty sessionScope.loginUser && sessionScope.loginUser.id != 'admin'}">
					<li><a href="<%= ctxPath%>/item/cartList"><img src="<%= ctxPath%>/images/header/cart.png" ></a></li>
					<li class="logins" id="loginUser"style="font-size:19pt;cursor:pointer;"><i class="fas fa-user-circle mr-2"></i></li>
					<li class="userFunc" style="font-size:19pt;cursor:pointer;"><i class="fa-solid fa-bars"></i></li>
		 	 	</c:if>
		 	</div>
		</ul>
	</nav>
</div>
</div>