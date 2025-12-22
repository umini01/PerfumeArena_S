<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../header/header.jsp" />  


<style type="text/css">
    body {
        background-color: #f5f9ff;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .page-title {
		width: 80%;
        max-width: 1200px;
   		 margin: 50px auto 10px auto;
        font-size: 28px;
        font-weight: bold;
        color: #2a4e8a;
        border-bottom: 3px solid #4a90e2;
        padding-bottom: 15px;
        text-align: left;
        padding-top:60px;
        
    }

    table#ItemInput {
        border-collapse: separate;
        border-spacing: 0;
        width: 80%;
        max-width: 1200px;
        margin: 0% auto;
        font-size: 16px;
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(74, 144, 226, 0.1);
        overflow: hidden;
    }

    table#ItemInput td {
        border: 1px solid #d4e3fc;
        padding: 15px;
        transition: background-color 0.3s;
    }

    table#ItemInput tr:hover td {
        background-color: #f0f7ff;
    }

    .itemInputName {
        background-color: #e6f0ff;
        font-weight: bold;
        width: 25%;
        text-align: right;
        padding-right: 20px;
        color: #2a4e8a;
    }

    table#ItemInput td input[type="text"],
    table#ItemInput td input[type="file"],
    table#ItemInput td select,
    table#ItemInput td textarea {
        width: 100%;
        max-width: 400px;
        box-sizing: border-box;
        padding: 8px 12px;
        border: 1px solid #c4d8f9;
        border-radius: 4px;
        background-color: #f9fcff;
        transition: all 0.3s;
    }

    table#ItemInput td input:focus,
    table#ItemInput td select:focus,
    table#ItemInput td textarea:focus {
        outline: none;
        border-color: #4a90e2;
        box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
    }

    .error {
        color: #e74c3c;
        font-weight: bold;
        font-size: 12px;
        margin-left: 10px;
    }

    #btnRegister {
        background-color: #4a90e2;
        border-color: #4a90e2;
    }

    #btnRegister:hover {
        background-color: #3a7bc8;
        border-color: #3a7bc8;
    }

    #previewImg {
        max-width: 100%;
        height: auto;
        border: 1px solid #d4e3fc;
        border-radius: 4px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    @media (max-width: 768px) {
        .page-title {
            font-size: 22px;
            text-align: center;
        }
        
        table#ItemInput {
            width: 95%;
            font-size: 14px;
        }
        
        .itemInputName {
            width: 30%;
            padding-right: 10px;
        }
        
        table#ItemInput td {
            padding: 10px 8px;
        }
    }

    @media (max-width: 480px) {
        .page-title {
            font-size: 20px;
        }
        
        table#ItemInput {
            display: block;
        }
        
        table#ItemInput tbody,
        table#ItemInput tr,
        table#ItemInput td {
            display: block;
            width: 100% !important;
            text-align: left !important;
        }
        
        .itemInputName {
            background-color: transparent;
            font-weight: bold;
            color: #2a4e8a;
            padding-bottom: 5px;
        }
    }
</style>

<script type="text/javascript">

  let total_fileSize = 0; 

  $(function(){
	  
	  $('span.error').hide();
	  
	  $('input[name="itemAmount"]').spinner({
			spin:function(event,ui){
				if(ui.value > 999) {
					$(this).spinner("value", 999);
					return false;
				}
				else if(ui.value < 1) {
					$(this).spinner("value", 1);
					return false;
				}
			}
	  });
	   
	  $(document).on("change", "input.itemPhotoPath", function(e){
		   const input_file = $(e.target).get(0);
		   const fileReader = new FileReader();
		   fileReader.readAsDataURL(input_file.files[0]);
		   fileReader.onload = function(){
		       document.getElementById("previewImg").src = fileReader.result;
		   };
		   total_fileSize += input_file.files[0].size; 
	  });
	  
	  // ===== 제품등록하기 =====
      $(document).on('click', 'input:button[id="btnRegister"]', function(){
         $('span.error').hide();
         let is_infoData_OK = true;
         $('.infoData').each(function(index, elmt){
            if($(elmt).val().trim() == "") {
               $(elmt).next().show();
               is_infoData_OK = false;
               return false;
            }
         });
         if(is_infoData_OK) {
            if(total_fileSize >= 20*1024*1024) {
               alert("첨부한 파일의 총합의 크기가 20MB 이상이어서 제품등록을 할 수 없습니다.");
               return;
            }
            var formData = new FormData($("form[name='itemInputFrm']").get(0));
            $.ajax({
            	url:"${pageContext.request.contextPath}/item/admin/itemRegister.do",
            	type:"post",
               data:formData,
               processData:false,
               contentType:false,
               dataType:"json",
               success:function(json){
                  if(json.result == 1) {
                     location.href="${pageContext.request.contextPath}/item/mallHome.do";
                  }
               },
               error: function(request, status, error){
                  //alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
               }
            });
         }
      });

	  // === 취소하기 ===
      $('input[type="reset"]').click(function(){
         $('span.error').hide();
         $('img#previewImg').hide();
      });
	  
  }); // end of $(function(){})
</script>


<div class="page-title" style="margin-top:20px; margin-bottom:10px;">일반상품 등록</div>
<div align="center" style="margin-top:20px; margin-bottom: 20px;">

	
	<form name="itemInputFrm" enctype="multipart/form-data"> 
	      
		<table id="ItemInput" style="width: 80%;">
		<tbody>
			<tr>
				<td width="25%" class="itemInputName" style="padding-top: 10px;">카테고리</td>
				<td width="75%" align="left" style="padding-top: 10px;" >
					<select name="fk_catagory_no" class="infoData">
					
					    <option value="">:::선택하세요:::</option>
					    <c:forEach var="cvo" items="${requestScope.categoryList}">
					        <option value="${cvo.categoryNo}">${cvo.categoryName}</option>
					    </c:forEach>
					</select>
					<span class="error">필수입력</span>
				</td>	
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제품명</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;" >
					<input type="text" style="width: 300px;" name="itemName" class="box infoData" />
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제조사</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="text" style="width: 300px;" name="company" class="box infoData" />
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">용량</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
		           	<input name="volume" style="width: 50px; height: 20px;"> ML
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제품정가(판매가)</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="text" style="width: 100px;" name="price" class="box infoData" /> 원
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제품재고량</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
		           	<input name="itemAmount" value="1" style="width: 30px; height: 20px;"> 개
					<span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">제품이미지(대표이미지)</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="file" name="itemPhotoPath" class="itemPhotoPath" accept='image/*' /><span class="error">필수입력</span>
				</td>
			</tr>
			<tr>
				<td width="25%" class="itemInputName">상세정보이미지</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<input type="file" name="infoImg" class="infoImg" accept='image/*' /><span class="error">필수입력</span>
				</td>
			</tr>
			
		
			
			
			<tr>
				<td width="25%" class="itemInputName">제품설명</td>
				<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
					<textarea name="itemInfo" rows="5" cols="60"></textarea>
				</td>
			</tr>
			
			
		    
		    
		    <%-- ==== 이미지파일 미리보여주기 ==== --%>
		    <tr>
		       	<td width="25%" class="itemInputName" style="padding-bottom: 10px;">이미지파일 미리보기</td>
		       	<td>
		       		<img id="previewImg" width="300" />
		       	</td>
		    </tr>
			
			<tr style="height: 70px;">
				<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden; padding: 50px 0;">
				    <input type="button" value="제품등록" id="btnRegister" style="width: 120px;" class="btn btn-info btn-lg mr-5" /> 
				    <input type="reset" value="취소"  style="width: 120px;" class="btn btn-danger btn-lg" />	
				</td>
			</tr>
		</tbody>
		</table>
		
	</form>

</div>

<jsp:include page="../footer/footer.jsp" />  
    