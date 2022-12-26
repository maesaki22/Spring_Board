<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>list</title>
</head>
<script type="text/javascript">

function loginCheck(){
	if ( ${empty loginUser} ){
		alert("로그인을 해주세요");
		return false;
	}
	return true; 
}

	$j(document).ready(function(){
		
		
		$j("#cbTypesummit").on("click",function(){
			var $frm = $j(':checkbox');
			var param = $frm.serialize();
			$j.ajax({
			    url : "/board/boardSelectTypeList.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {

			    	// tr 첫줄을 남기고나머지 tr 다삭제
			    	while ( $j("#boardTable > tbody tr").length -1 ){
			    		$j("#boardTable > tbody tr:last").remove();
			    		
			    	}
					// 선택자가 아니라 객체 (each 사용 실패)

		    		/////////////////////////////////
		    		// 	<tr>
		    		//		<td> data[i].comcode.codeName
		    		//		</td>
		    		//		<td> data[i].boardNum
		    		//		</td>
		    		//		<td>
		    		//			<a href = "/board/"+data[i].boardType+"/"+data[i].boardNum+"/boardView.do?pageNo="> data[i].boardTitle
		    		//			</a>
		    		//		</td>
		    		//	</tr>
		    		/////////////////////////////////	
		    		
			    	for(var i=0;i<data.length;i++){
			    		var innerHtml = "";
			    		innerHtml +='<tr>';
			    		innerHtml +='<td>'+data[i].comcodeVo.codeName+'</td>';
			    		innerHtml +='<td>'+data[i].boardNum+'</td>';
			    		innerHtml +='<td><a href="/board/'+data[i].boardType+'/'+data[i].boardNum+'/boardView.do?pageNo='+${pageNo} + '">'
			    					+ data[i].boardTitle + '</a></td>';
			    		innerHtml +='</tr>';
			    		console.log(i);
			    		console.log(innerHtml);
			    		$j("#boardTable > tbody tr:last").after(innerHtml);
			    	 }

		    		$j("#totalCnt").text("total : "+data[0].totalCnt); 
		    		

			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("선택된 항목이 없습니다.");
			    }
			});
		});
	
		$j("#cbx_all").click(function(){
			if($j("#cbx_all").is(":checked")){
				$j("input[name=boardSelectType]").prop("checked",true);
				
			}else {
				$j("input[name=boardSelectType]").prop("checked",false);
			}
		});
		
		$j("input[name=boardSelectType]").click(function(){
			var total = $j("input[name=boardSelectType]").length;
			var checked = $j("input[name=boardSelectType]:checked").length;
			
			if(total != checked) {
				$j("#cbx_all").prop("checked",false);
			}else {
				$j("#cbx_all").prop("checked",true);
			}		
		});
		

	});

</script>
<body>
<table  align="center">
	<tr>
		<td>
			<table width="100%" >
				<tr>
					<td>
						<c:choose>
						<c:when test="${empty loginUser}">
							<span style="width:49%;">
							<a href="/user/userLogin.do">login</a>
							<a href="/user/userJoin.do">join</a>
							</span>
						</c:when>
						<c:when test="${!empty loginUser}">
							<span style="width:49%;">
							${loginUser.userName}님
							</span>
						</c:when>
						</c:choose>
					</td>
					<td id="totalCnt" align ="right">total : ${totalCnt}
					</td >	
					</tr>		
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
							${list.comcodeVo.codeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>		
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do" onclick="return loginCheck();">글쓰기</a>
			<c:if test="${! empty loginUser}">
				<a href ="/user/uesrLogout.do">logout</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td>
			<input type="checkbox" id="cbx_all" />전체
			 <c:forEach	items="${comCodeList}" var="list">
					<input type="checkbox" 	name="boardSelectType" value="${list.codeId}">${list.codeName}
			</c:forEach>
			<button id="cbTypesummit" type="button">조회</button>
			</td>
	</tr>
</table>	
</body>
</html>