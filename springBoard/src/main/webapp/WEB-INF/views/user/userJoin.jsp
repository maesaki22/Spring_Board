<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>userJoin</title>
</head>
<script type="text/javascript">
let inputValueSubmit = false;
let inputBoolId = false;
let inoutBoolDuplicateId = false;
let inputBoolPw = false;
let inputBoolName = false;
let inputBoolPhone2 = false;
let inputBoolPhone3 = false;
let inputBoolAddr1 = false;
let inputBoolAddr2 = false;
let inputBoolCompany = false;

// input value 정규식 설정  /^    $/
const userIdCheck = /^[A-Za-z0-9_\-]{2,15}$/;
const userPwCheck = /[A-Za-z\d!@#$%^&*?]{6,12}/;
const userNameCheck = /^[가-힣]{2,10}$/;
const userPhoneCheck = /\d{4}/;
const userAddr1Check = /^\d{3}-\d{3}$/;
const userAddr2Check = /.{0,50}/;
const userCompanyCheck = /.{0,20}/;


	function inputValidation() {
		// id check 	 	:: not null, 2~15자리이하
		// pw check 	 	:: not null, 6~12자리 , pwck와 동일
		// pwck check		:: not null, 6~12자리 , pw와 동일
		// name check		:: not null, 15자리이하
		// phoen2 check 	:: not null, 4자리 , 숫자만
		// phoen3 check		:: not null, 4자리 , 숫자만

		// addr1 check		:: null , 8자리 ex) 123-123
		// addr2 check		:: null , 150자리이하
		// company check	:: null , 60자리이하
		let inputUserId = $j('input[name=userId]');
		let inputUserPw = $j('input[name=userPw]');
		let inputUserPwcheck = $j('input[name=userPwcheck]');
		let inputUserName = $j('input[name=userName]');
		let inputUserPhone2 = $j('input[name=userPhone2]');
		let inputUserPhone3 = $j('input[name=userPhone3]');
		let inputUserAddr1 = $j('input[name=userAddr1]');
		let inputUserAddr2 = $j('input[name=userAddr2]');
		let inputUserCompany = $j('input[name=userCompany]');

		// id check 	 	:: not null, 2~15자리이하  :: 
		if ( !(inputUserId.val() == "") ) {

			///^[A-Za-z0-9_\-]{2,15}$/
			if (!userIdCheck.test(inputUserId.val())) {
				inputBoolId = false;
				alert("아이디의 길이는 2~15자리. 영어대소문자, 특수문자(_,-)만 사용해주세요.");
				inputUserId.focus();
				return false;
			} else
				inputBoolId = true;

		} else {
			inputBoolId == false;
			alert("아이디를 입력해주세요.");
			inputUserId.focus();
			return false;
		}
		// pw check 	 	:: not null, 6~12자리 , pwck와 동일
		if (!(inputUserPw.val() == "")) {
			///[A-Za-z\d!@#$%^&*?]{6,12}/
			if (!userPwCheck.test(inputUserPw.val())) {
				inputBoolPw = false;
				alert("비밀번호는 영어 대소문자, 특수문자만 사용해 6~12자리로 해주세요.");
				inputUserPw.focus();
				return false;
			} else
				inputBoolPw = true;

		} else {
			inputBoolPw == false;
			alert("비밀번호를 입력해주세요");
			inputUserPw.focus();
			return false;
		}
		// pwch check 	 	:: not null, 6~12자리 , pwck와 동일
		if (!(inputUserPwcheck.val() == "")) {
			///[A-Za-z\d!@#$%^&*?]{6,12}/
			if (!userPwCheck.test(inputUserPwcheck.val())) {
				inputBoolPw = false;
				alert("비밀번호는 영어 대소문자, 특수문자만 사용해 6~12자리로 해주세요.");
				inputUserPwcheck.focus();
				return false;
			} else {
				// pw != pwcheck
				if (inputUserPwcheck.val() != inputUserPw.val()) {
					inputBoolPw = false;
					alert("비밀번호와 비밀번호 재확인이 일치하지 않습니다.");
					inputUserPwcheck.focus();
					return false;
				} else
					inputBoolPw = true;
			}
		} else {
			inputBoolPw == false;
			alert("비밀번호 재확인을 입력해주세요.");
			inputUserPwcheck.focus();
			return false;
		}

		// name check		:: not null, 15자리이하
		if (!(inputUserName.val() == "")) {
			///^[가-힣a-zA-Z0-9]{2,10}$/;
			if (!userNameCheck.test(inputUserName.val())) {
				inputBoolName = false;
				alert("이름은 한글,영문대소문자,숫자만 사용해주세요.(2자리이상)");
				inputUserName.focus();
				return false;
			} else {
				inputBoolName = true;
			}
		} else {
			inputBoolName == false;
			alert("이름을 입력해주세요.");
			inputUserName.focus();
			return false;
		}

		// phoen2 check 	:: not null, 4자리 , 숫자만
		if (!(inputUserPhone2.val() == "")) {
			///\d{4}/;
			if (!userPhoneCheck.test(inputUserPhone2.val())) {
				inputBoolPhone2 = false;
				alert("숫자 4자리를 입력해주세요.");
				inputUserPhone2.focus();
				return false;
			} else
				inputBoolPhone2 = true;

		} else {
			inputBoolPhone2 == false;
			alert("전화번호(2)를 입력해주세요.");
			inputUserPhone2.focus();
			return false;
		}

		// phoen3 check 	:: not null, 4자리 , 숫자만
		if (!(inputUserPhone3.val() == "")) {
			///\d{4}/;
			if (!userPhoneCheck.test(inputUserPhone3.val())) {
				inputBoolPhone3 = false;
				alert("숫자 4자리를 입력해주세요.");
				inputUserPhone3.focus();
				return false;
			} else
				inputBoolPhone3 = true;

		} else {
			inputBoolPhone3 == false;
			alert("전화번호(3)를 입력해주세요.");
			inputUserPhone3.focus();
			return false;
		}

		// addr1 check		:: null , 8자리 ex) 123-123 
		if (!(inputUserAddr1.val() == "")) {
			if (!userAddr1Check.test(inputUserAddr1.val())) {
				inputBoolAddr1 = false;
				alert("숫자 6자리를 입력해주세요.");
				inputUserAddr1.focus();
				return false;
			} else
				inputBoolAddr1 = true;
		}

		// id duplicatck
		if (!inoutBoolDuplicateId) {
			alert("아이디 중복체크를 해주세요.");
			inputUserId.focus();
			return false;
		}
		
		if (!userAddr2Check.test(inputUserAddr2.val())) {
			inputBoolAddr2 = false;
			alert("address 길이가 길어요.");
			inputUserAddr2.focus();
			return false;
		}
		if (!userCompanyCheck.test(inputUserCompany.val())) {
			inputBoolCompany = false;
			alert("Company 길이가 길어요.");
			inputUserCompany.focus();
			return false;
		}
		
		return true;
	}

	$j(document).ready(function() {

		// input 값의 변화가 생길떄. 
		$j("input[name=userId]").on("input", function() {
			this.value = this.value.replace(/[^A-Za-z0-9\-_]/g, '');
			inoutBoolDuplicateId = false;
		});

		$j("input[name=userName]").on("input", function() {
			this.value = this.value.replace(/[^ㄱ-힣]/g, '');
		});

		$j("input[name=userPhone2]").on("input", function() {
			this.value = this.value.replace(/\D/g, '');
		});

		$j("input[name=userPhone3]").on("input", function() {
			this.value = this.value.replace(/\D/g, '');
		});

		//  ex)  123-123    string + "-" + string
		$j("input[name=userAddr1]").on("input", function() {
			var postNo = "";
			this.value = this.value.replace(/\D/g, '');
			if (this.value.length > 3) {
				postNo = this.value.substr(0, 3);
				postNo += "-";
				postNo += this.value.substr(3, 3);
				console.log(postNo);
				this.value = postNo;
			}
		});

		$j("#duplicateCheck").on("click", function() {

			let inputUserId = $j('input[name=userId]');
			if (userIdCheck.test(inputUserId.val())) {
				var AllData = {"userId" : $j('input[name=userId]').val()};
				$j.ajax({
					url : "/user/userIdDuplicateCheck.do",
					dataType : "json",
					type : "GET",
					data : AllData,
					success : function(data, textStatus, jqXHR) {
						// usercontroller 에서 반환값 user를 받는다.
						if (data.success == "N") {
							inoutBoolDuplicateId = true;
							alert("사용 가능한 아이디입니다.");
						} else {
							alert("이미 사용 중인 아이디입니다.");
							$j('input[name=userId]').val("");
							inoutBoolDuplicateId = false;
						}

					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("실패");
					}
				});
			} else if (inputUserId.val() == "") {
				inoutBoolDuplicateId = false;
				alert("아이디를 입력하세요.");
				return;
			} else if (inputUserId.val().length < 2) {
				inoutBoolDuplicateId = false;
				alert("아이디를 2~15자리로 만들어주세요.");
				return;
			}
		});

		$j("#submit").on("click", function() {

			var validation = inputValidation();
			
			if(validation){
				var $frm = $j('.userjoin :input');
				var param = $frm.serialize();				
				$j.ajax({
				    url : "/user/userJoinAction.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
				    	console.log(param);
				    	alert("가입완료");
						alert("메세지:"+data.success);
						location.href = "/board/boardList.do";
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	inoutBoolDuplicateId = false;
				    	alert("실패");
				    }
				})	
			}
		});
	});
</script>
<body>
<form class="userjoin">
	<table align="center">
			<tr>
				<td align="left"><a href="/board/boardList.do">List</a>
				</td>
				<td>
				</td>
			</tr>
			<tr>
				<td>
					<table id="joinTable" border ="1">
					<tr>
						<td width="80" align="center">id</td>
						<td >
							<input type="text" name="userId" maxlength="15" placeholder="abcd">
							<input type="button" id="duplicateCheck" value="중복확인" >
						</td>
					</tr>
					<tr>
						<td width="80" align="center">pw</td>
						<td>
							<input type="password" name="userPw" maxlength="16"placeholder="" >
						</td>
					</tr>
					<tr>
						<td width="80" align="center">pw check</td>
						<td>
							<input type="password" name="userPwcheck" maxlength="16">
						</td>
					</tr>
					<tr>
						<td width="80" align="center">name</td>
						<td>
							<input type="text" name="userName" maxlength="15" placeholder="홍길동" >
						</td>
					</tr>
					<tr>
						<td width="80" align="center">phone</td>
						<td>
							<select name="userPhone1">
								<c:forEach items="${comCodeList}" var="list">
									<option value="${list.codeName}">${list.codeName}</option>
								</c:forEach>
							</select>-
							<input type="text" name="userPhone2" size="5" maxlength="4">-
							<input type="text" name="userPhone3" size="5" maxlength="4">
						</td>
					</tr>
					<tr>
						<td width="80" align="center">postNo</td>
						<td>
							<input type="text" name="userAddr1" maxlength="8">
						</td>
					</tr>
					<tr>
						<td width="80" align="center">address</td>
						<td >
							<input type="text" name="userAddr2" maxlength="50">
						</td>
					</tr>
					<tr>
						<td width="80" align="center">company</td>
						<td>
							<input type="text" name="userCompany" maxlength="20">
						</td>
					</tr>
					</table>
				</td>	
			</tr>
			<tr>
			<td align="right">
				<input id="submit" type="button" value="가입">
			</td>
		</tr>
	</table>
</form>	
</body>
</html>