<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>userLogin</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click",function(){
			var $frm = $j('.userLogin :input');
			var param = $frm.serialize();	
			$j.ajax({
			    url : "/user/userLoginAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
			    	alert("로그인 완료");
					alert(data.userName+ "님 환영합니다.");
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("로그인 실패");
					$j('input[name=userId]').val("");
					$j('input[name=userPw]').val("");
			    }
			});	
		});
	});
	
	
</script>
<body>
<form class="userLogin">
	<table align="center">
		<tr>
			<td>
				<table border ="1">
					<tr>
						<td width="80" align="center">
						id
						</td>
						<td width="200">
							<input type="text" name="userId" maxlength="15">
						</td>
					</tr>
					<tr>
						<td width="80" align="center">
						pw
						</td>
						<td>
						<input type="password" name="userPw" maxlength="16" >
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<input id="submit" type="button" value="login">
			</td>
		</tr>
	</table>
</form>	
</body>
</html>