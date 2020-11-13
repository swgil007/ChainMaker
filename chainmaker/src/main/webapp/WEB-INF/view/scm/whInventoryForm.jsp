<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<title>WhInventoryForm</title>

<!-- common Include -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script>
	//상단테이블 페이징 설정
	var pageSizeWHInventory = 5;
	var pageBlockSizeWHInventory = 5;
	
	//하단테이블 페이징 설정
	var pageSizeWHProduct = 5;
	var pageBlockSizeWHProduct = 10;
	
	//Vue.js 사용 변수 설정
	var whInventoryvm;
	var whproductvm;
	
	//페이지로드 작동 메서드
	$(document).ready(function(){
		
		init();
		
		//창고별 제품 목록 조회		
		whInventoryList();
	});
	
	function init(){
		
		searchvm = new Vue({
			el:"#searcharea",
			data:{
				searchKey:'all',
				searchWord:''
			}
		})
		
		whInventoryvm = new Vue({
			el:"#divWHInventoryList",
			components:{	
				"bootstrap-table":BootstrapTable
			},
			data:{
				items:[],
				ware_no:'',
				pro_no:'',
			},
			methods:{
				rowClick:function(row){
					
					//알람 삭제 예정
					//alert("sub 그리드 연결~!");
					
					var tdArr = new Array();
					
					//클릭된 row (#divWHInventoryList > <tr>)
					var tr=$(row);
					var td=tr.children();
					
					td.each(function(i){
						tdArr.push(td.eq(i).text());
					});
					console.log("tdArr[0] : " + tdArr[0]);					
					console.log("tdArr[1] : " + tdArr[1]);					
					console.log("tdArr[2] : " + tdArr[2]);					
					console.log("tdArr[3] : " + tdArr[3]);					
					console.log("tdArr[4] : " + tdArr[4]);					
					console.log("tdArr[5] : " + tdArr[5]);					
					console.log("tdArr[6] : " + tdArr[6]);					
					console.log("tdArr[7] : " + tdArr[7]);					
					
					this.ware_no = tdArr[0];
					this.pro_no = tdArr[1];
					
					whProductList();
				}
			}
		});
		
		whproductvm = new Vue({
			el:"#divWHProductList",
			components:{	
				"bootstrap-table":BootstrapTable
			},
			data:{
				items:[]				
			}
		});
	}
	
	/* 		
	<input type="text" id="" name="" v-for="no"/>
		whproductvm.no = "111";
	   */
	   
	//창고별 재고 조회
	function whInventoryList(currentPage){
		currentPage=currentPage || 1;
		
		var param={
				currentPage : currentPage,
				pageSize : pageSizeWHInventory,
				searchKey : searchvm.searchKey,
				searchWord : searchvm.searchWord
		}
		
		var resultCallback = function(data){
			whInventoryListResult(data, currentPage);
		}
		
		callAjax("/scm/whInventoryList.do", "post", "json", true, param, resultCallback);
	}
	//창고별 재고 조회 콜백
	function whInventoryListResult(data, currentPage){
		//console.log(data);
		
		whInventoryvm.items=[];
		whInventoryvm.items=data.listWHInventory;
		
		//총 개수 추출
		var whInventoryFormTotal=data.whInventoryFormTotal;
		
		//페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, whInventoryFormTotal, pageSizeWHInventory, pageBlockSizeWHInventory, "whInventoryList");
		
		$("#WHInventoryPagination").empty().append( paginationHtml );
		
		$("#currentPageWHInventory").val(currentPage);		
	}
	
	
	
	//제품별 입출고 내역 (특정 창고의 특정 제품 입출고 내역)
	function whProductList(currentPage){
		currentPage=currentPage || 1;
		
		//알람 삭제 예정
		//alert("no : " + whInventoryvm.ware_no);
		
		var param={
				currentPage : currentPage,
				pageSize : pageSizeWHProduct,	
				ware_no : whInventoryvm.ware_no,
				pro_no : whInventoryvm.pro_no
		}
		
		var resultCallback = function(data){
			whProductListResult(data, currentPage);
			console.log("whProductList 콜백 데이터 : "+data);
		}
		
		callAjax("/scm/whProductList.do", "post", "json", true, param, resultCallback);
	}
	//제품별 입출고 내역 (특정 창고의 특정 제품 입출고 내역) 콜백
	function whProductListResult(data, currentPage){
		console.log("whProductList 데이터 : " + data);
		
		whproductvm.items=[];
		whproductvm.items=data.listWHProduct;
		
		//총 개수 추출
		var whProductTotal=data.whProductTotal;
		console.log("whProductTotal : " + whProductTotal)
		//페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, whProductTotal, pageSizeWHProduct, pageBlockSizeWHProduct, "whProductList");
		
		$("#WHProductPagination").empty().append( paginationHtml );
		
		$("#currentPageWHProduct").val(currentPage);
	}
</script>

</head>
<body>	
	<form id="myForm" action=""  method="">
		<input type="hidden" name="currentPageWHInventory" id="currentPageWHInventory" value="">
		<input type="hidden" name="whProduct" id="whProduct" value="">
		
		<div id="wrap_area">
		
			<!-- header Include -->
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			
			<div id="container">
				<ul>
					<li class="lnb">
					
						<!-- lnb Include --> 
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						
					</li>
					<li class="contents">						
						<div class="content">
							
							<!-- 메뉴 경로 영역 -->
							<p class="Location">
								<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <a href="#"
									class="btn_nav">거래내역</a> <span class="btn_nav bold">창고별 재고 현황</span> <a href="#" class="btn_set refresh">새로고침</a>
							</p>
							
							<!-- 검색 영역 -->
							<p class="search">
	
							</p>
							<p class="conTitle" id="searchArea">
								 <span>창고별 재고 현황</span>
								 <span class="fr"> 
									<select id="searchKey" name="searchKey" style="width: 80px;" v-model="searchKey">
									    <option value="all" id="option1" selected="selected">ㅡㅡㅡㅡ</option>
										<option value="ware_no" id="option2">창고명</option>
										<option value="pro_no" id="option3">제품명</option>
									</select> 
									<input type="text" id="searchWord" name="searchWord" v-model="searchWord"
										placeholder="" style="height: 28px;"> <a
										class="btnType blue" href="javascript:whInventoryList()"
										onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>			
								</span>
							</p>
							
							<!-- 상단 테이블 영역 -->
							<div class="divWHInventoryList" id="divWHInventoryList">
								<table class="col">
									<colgroup>
									    <col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="45%">
									</colgroup>
					
									<thead>
										<tr>
										    <th scope="col">창고 코드</th>
											<th scope="col">제품 번호</th>
											<th scope="col">창고 명</th>
											<th scope="col">제품 명</th>
											<th scope="col">재고 수량</th>
											<th scope="col">창고 위치</th>
										</tr>
									</thead>
									
									<!-- 상단테이블 DB데이터 출력 영역 -->
									<tbody id="listWHInven">
									<!-- whInventoryvm에 담긴 items의 정보를 가져와 테이블에 뿌리는 코드 (Vue.js) -->
										<template v-for="(row, index) in items" v-if="items.length">
											<tr onclick="whInventoryvm.rowClick(this)">
											    <td>{{ row.ware_no }}</td>
												<td>{{ row.pro_no }}</td>
												<td>{{ row.ware_name }}</td>
												<td>{{ row.pro_name }}</td>
												<td>{{ row.pro_ware_qty }}</td>
												<td>{{ row.ware_address + " " + row.ware_dt_address }}</td>						
											</tr>
										</template>
									</tbody>
								</table>
							</div>	<!-- .divWhInventoryList 종료 -->
							
							<!-- 상단테이블 페이지 네비게이션 영역 -->
							<div class="pagingArea"  id="WHInventoryPagination"> </div>
							
							<p class="conTitle mt50">
								<span>제품별 입출고 내역</span> 
								<span class="fr"></span>
							</p>
							
							<!-- 하단 테이블 영역 -->
							<div class="divWHProductList" id="divWHProductList">
								<table class="col">
									<colgroup>
										<col width="25%">
										<col width="25%">
										<col width="25%">
										<col width="25%">
									</colgroup>
		
									<thead>
										<tr>
										    <th scope="col">제품 번호</th>
											<th scope="col">제품 명</th>
											<th scope="col">입고 량</th>
											<th scope="col">출고 량</th>
										</tr>
									</thead>
									
									<!-- 하단테이블 DB 데이터 출력 영역 -->
									<tbody id="listWHProduct">
										<template v-for="(row, index) in items" v-if="items.length">
											<tr>
												<td>{{ row.pro_no }}</td>
												<td>{{ row.pro_name }}</td>
												<td>{{ row.pro_io_qty }}</td>					
												<td>{{ row.pro_io_qty }}</td>					
											</tr>
										</template>
									</tbody>
								</table>
							</div>
						<!-- 하단테이블 Pagenation 영역 -->
						<div class="pagingArea"  id="WHProductPagination"> </div>
						</div>	<!-- .content 종료 -->
					</li>	<!-- .content 종료 -->
				</ul>				
			</div>	<!-- #container 종료 -->
			
			<!-- footer Include -->
			<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
			
		</div>	<!-- #wrap_area 종료 -->
	</form>	
</body>
</html>