<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>

<style type="text/css">
	.adminFunc {font-size:18pt;cursor: pointer}
	/* .adminTab {position: absolute;right:0;height:860px;background:#fff;top:65px;width:150px;border-left:1px solid #ddd;z-index:20;} */
	.adminTab p {padding:40px 13px;border-bottom:1px solid #ddd;cursor:pointer;}
	.adminTab p:hover, .adminTab p:hover a {background-color:#000;color:#fff}

	.adminTab-wrapper {
  		position: fixed; top: 63px; right: -250px; z-index: 0; width: 250px; height: 880px; overflow: hidden;
	}
	.adminTab-wrapper.wrapperOpen {
		z-index: 21; right:0px;
	}
	.adminTab {
  		width: 250px; height: 100%; position: absolute; right: -250px; top: 0; background: rgba(255, 255, 255, 0.6); transition: right 0.9s ease;
  		border-left: 1px solid #ddd; border-top: 1px solid #ddd; z-index: 11;
	}
	.adminTab.adminTab-open {
  		right: 0;
	}
</style>

<li class="logins" style="font-size:19pt;cursor:pointer;"><i class="fas fa-user-circle mr-2"></i></li>
<li class="adminFunc"><i class="fa-solid fa-list"></i></li>

<div class="adminTab-wrapper">
	<div class="adminTab">
		<p><a href="<%= ctxPath %>/admin/usersList">회원목록 전체보기</a></p>
		<p><a href="<%= ctxPath %>/admin/itemRegister">제품 등록하기</a></p>
		<p><a href="<%= ctxPath %>/admin/chart">주문통계 차트보기</a></p>
	</div>
</div>