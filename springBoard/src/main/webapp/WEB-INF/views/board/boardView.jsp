<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardView</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#delete").on("click",function(){
			//var $frm = $j('.boardDelete :input');
			//var param = $frm.serialize();
			$j.ajax({
			    url : "/board/${boardType}/${boardNum}/boardDeleteAction.do",
			    dataType: "json",
			    type: "POST",
			    success: function(data, textStatus, jqXHR)
			    {
			    	alert("삭제완료");
					alert("메세지:"+data.success);
					
					//location.href = "/board/boardList.do?pageNo=";
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
	});
	

</script>
<body>
<table align="center">
		<tr>
			<td>
				<table border="1">
					<tr>
						<td width="120" align="center">Title</td>
						<td width="400">${board.boardTitle}</td>
					</tr>
					<tr>
						<td height="300" align="center">Comment</td>
						<td>${board.boardComment}</td>
					</tr>
					<tr>
						<td align="center">Writer</td>
						<td>${board.userVo.userName}</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<c:if test= "${loginUser.userId == board.userVo.userId }">
					<a href="/board/${boardType}/${boardNum}/boardUpdate.do"><button>Update</button></a>&ensp;
					<input id="delete" class="boardDelete" type="button" value="Delete">&ensp;
				</c:if>
				<a href="/board/boardList.do"><button>List</button></a>
			</td>
		</tr>
	</table>	
</body>
</html>