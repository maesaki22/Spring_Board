<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click",function(){
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			let blank_pattern = false;
			
			$j("#wirteTable tr input").each ( function(i) {
				if( $j("#wirteTable tr input").eq(i).val() ==''){
					alert("Title이 비어 있습니다.");
					blank_pattern = false;
					$j("#wirteTable tr input").eq(i).focus();
					return false;
				}else
					blank_pattern=true;
				
				if( $j("#wirteTable tr textarea").eq(i).val() =='') {
					blank_pattern = false;
					alert("Commnet가 비어 있습니다.");
					$j("#wirteTable tr textarea").eq(i).focus();
					return false;
				}else
					blank_pattern=true;
			});
			
			
			console.log("dd");
			if(blank_pattern){
				
				$j.ajax({
				    url : "/board/boardWriteAction.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
				    	alert(param)
				    	console.log(param);
				    	alert("작성완료");
						alert("메세지:"+data.success);
	
						location.href = "/board/boardList.do";
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("실패");
				    }
				});					
			}
		}),
		
		
		$j("#addTbody").click(function(){
			// 1번 tr 복사 + 초기값설정
			var newFRow = $j(".1rows").eq(0);
			$j("#wirteTable tr:last").before(newFRow.clone(true));
			$j("#wirteTable tr:last").prev().find('select option:eq(0)').prop("selected",true);
			
			// 복사된 tr의 배열순서 iedex 잡아주기
			var fTrlen = $j("#wirteTable tr").length;
			var fIdx =  parseInt(fTrlen/3);
			console.log("select :" + fIdx);
			$j("#wirteTable tr:last").prev().find('select').attr('name','boardVoList['+fIdx+'].boardType');
			
			// 2번 tr 복사 + 초기값설정
			var newSRow = $j(".2rows").eq(0);
			$j("#wirteTable tr:last").before(newSRow.clone(true));
			$j("#wirteTable tr:last").prev().find('input').val('');
			
			// 복사된 tr의 배열순서 iedex 잡아주기
			var sTrlen = $j("#wirteTable tr").length;
			var sIdx =   ( parseInt(sTrlen/3) ) - 1;
			console.log("input :" + sIdx);
			$j("#wirteTable tr:last").prev().find('input').attr('name','boardVoList['+sIdx+'].boardTitle');
			
			// 3번 tr 복사 + 초기값설정
			var newTRow = $j(".3rows").eq(0);
			$j("#wirteTable tr:last").before(newTRow.clone(true));
			$j("#wirteTable tr:last").prev().find('textarea').val('');
			
			// 복사된 tr의 배열순서 iedex 잡아주기
			var tTrlen = $j("#wirteTable tr").length;
			var tIdx =    ( parseInt(tTrlen/3) ) - 1;
			console.log("input :" + tIdx);			
			$j("#wirteTable tr:last").prev().find('textarea').attr('name','boardVoList['+tIdx+'].boardComment');
		}),
		
		$j(document).on("click","#rmTbody",function(){ 
			// 클릭한(버튼) 의 부모의부모
			var delFRow = $j(this).parent().parent();
			// 위의 다음 tr
			var delSRow = delFRow.next();
			// 위의 다음 tr
			var delHRow = delSRow.next();
			var tinit = $j("#wirteTable tr").length;
			// 첫 input/textarea 유지
			if(tinit == 4){
				console.log(" last tr : 더이상 삭제 불가능");
			} else{
				delFRow.remove(); 
				delSRow.remove(); 	
				delHRow.remove();
			}
			
			// 삭제 후 select / input / textarea 배열 당겨주는 작업 ( null 로넘어가는 값 방지)
			$j("#wirteTable tr select").each ( function(i) {
				$j("#wirteTable tr select").eq(i).attr('name','boardVoList['+i+'].boardType');
			});
			
			$j("#wirteTable tr input").each ( function(i) {
				$j("#wirteTable tr input").eq(i).attr('name','boardVoList['+i+'].boardTitle');
			});
			
			$j("#wirteTable tr textarea").each ( function(i) {;
				$j("#wirteTable tr textarea").eq(i).attr('name','boardVoList['+i+'].boardComment');
			});
		});
	});
	
	
</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
			<button id="addTbody" type="button">++</button>
			<input id="submit" type="button" value="작성">
			</td>
		</tr>
		<tr>
			<td>
				<table id="wirteTable" border ="1">
					<tr class="1rows">
						<td width="120" align="center">
						Type
						</td>
						<td>
							<select name="boardVoList[0].boardType">
								<c:forEach items="${comCodeList}" var="list">
									<option value="${list.codeId}">${list.codeName}</option>
								</c:forEach>
							</select>
							<button id="rmTbody" type="button">삭제</button>
						</td>
					</tr>
					<tr class="2rows">
						<td width="120" align="center">
						Title
						</td>
						<td width="450">
							<input name="boardVoList[0].boardTitle" type="text" size="50" value="${board.boardTitle}">
							 
						</td>
					</tr>
					<tr class="3rows">
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardVoList[0].boardComment"  rows="20" cols="62">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						${loginUser.userName}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>