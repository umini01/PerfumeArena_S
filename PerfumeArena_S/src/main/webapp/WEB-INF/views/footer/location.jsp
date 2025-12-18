<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../header/header.jsp" />

	<style type="text/css">
		.root_daum_roughmap_landing {padding:150px 0; margin: auto;}
		.companySt {width:32%;box-shadow:2px 3px 8px 6px #ddd;padding:5%;}
		@media screen and (max-width:1250px){
			div.st {display:flex;flex-wrap:wrap;width:100%;padding:0 10%;}
			.root_daum_roughmap_landing {width:100% !important;}
			.companySt {width:62%;margin:0 auto;}
		} 
	</style>

	<!-- * 카카오맵 - 지도퍼가기 -->
	<!-- 1. 지도 노드 -->
	<div style="padding:5% 0;">
		<div class="text-center mb-12" style="padding:30px 0;">
	    	<h2 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4" style="font-size:2rem;font-weight:600;">오시는 길</h2>
	    	<p class="text-xl text-gray-600 max-w-2xl mx-auto" style="font-size:15pt;">저희 회사에 오신 것을 환영합니다.</p>
		</div>
	
		<div class="st" style="max-width:1200px;margin:0 auto;display:flex;align-items:center;justify-content:space-between;">
			<div id="daumRoughmapContainer1751598824585" class="root_daum_roughmap root_daum_roughmap_landing" style="margin:0;width:50%;padding:0;"></div>
			<div class="companySt">
				<h2>오시는 길</h2>
				<div style="display:flex;justify-content:space-between;align-items:center;  ">
					<i class="fas fa-map-marker-alt text-xl" style="color:purple;"></i>
					<div style="max-width:220px;width:100%;padding:5% 0;">
					  주소
					  <br>서울시 강남구 (역삼동)
					  <br>한독빌딩, 8층
					</div>
				</div>
				<div style="display:flex;justify-content:space-between;align-items:center;">
					<i class="fas fa-clock text-xl" style="color:blue;"></i>
					<div style="max-width:220px;width:100%;padding:5% 0;">
					  Hours
					  <br>Monday - Friday: 9AM - 5PM
					  <br>일요일 휴무
					</div>
				</div>
				<div style="display:flex;justify-content:space-between;align-items:center;">
					<i class="fas fa-phone-alt text-xl" style="color:green;"></i>
					<div style="max-width:220px;width:100%;padding:5% 0;">
					  Contact
					  <br>Phone: (123) 456-7890
					  <br>Email: info@example.com
					</div>
				</div>
			</div>
		</div>
		<!--
			2. 설치 스크립트
			* 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다.
		-->
		<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
	
		<!-- 3. 실행 스크립트 -->
		<script charset="UTF-8">
			new daum.roughmap.Lander({
				"timestamp" : "1751598824585",
				"key" : "4ntx67ndpn3",
				"mapWidth" : "750",
				"mapHeight" : "500"
			}).render();
		</script>
	</div>
</div>

<jsp:include page="footer.jsp" />
