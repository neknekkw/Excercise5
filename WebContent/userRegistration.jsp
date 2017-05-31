<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ユーザー登録</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap Sample</title>
<!-- BootstrapのCSS読み込み -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<!-- jQuery読み込み -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- BootstrapのJS読み込み -->
<script src="js/bootstrap.min.js"></script>
</head>
<body>

	<div id="header" class="container">
		<div class="row">
			<div id="header" class="col-md-12" style="background: #FFFF00">

				<h1>ユーザー新規登録</h1>
			</div>
		</div>
	</div>

	<div id="header" class="container">
		<div class="row">
			<div id="header" class="col-md-12" style = "margin-left: -14px;">
				<a class="btn btn-primary" role="button" href="./">ホーム</a> <a
					class="btn btn-primary" role="button" href="userManagement">戻る</a>
			</div>
		</div>
	</div>

	<c:if test="${ not empty errorMessages }">
		<br />
		<div id="header" class="container">
			<div class="row">
				<div id="header" class="col-mid-12 alert alert-danger" role="alert">
					<div class="errorMessages">
						<ul>
							<c:forEach items="${errorMessages}" var="message">
								<li><c:out value="${message}" />
							</c:forEach>
						</ul>
					</div>
					<c:remove var="errorMessages" scope="session" />
				</div>
			</div>
		</div>
	</c:if>

	<br />
	<div id="header" class="container">
		<div class="row">
			<div id="header" class="col-md-12" style="background: #FFFFBB">
				<form action="userRegistration" method="post">
					<br /> <label for="loginId">ログインID</label> (半角英数字6文字以上20文字以下)<br />
					<input name="loginId" value="${user.loginId}" id="loginId" /><br />
					<br /> <label for="password">パスワード</label> (記号含む半角英数字6文字以上255文字以下)<br />
					<input name="password" type="password" id="account" /><br />
					<br /> <label for="checkPassword">確認用パスワード</label><br /> <input
						name="checkPassword" type="password" id="checkPassword" /><br />
					<br /> <label for="name">名前</label>(10文字以下)<br /> <input
						name="name" value="${user.name}" id="password" /> <br />
					<br /> 支店： <select name="branchId">
						<c:forEach items="${branchNames}" var="branchName">
							<option value="${branchName.branchId}"
								<c:if test="${user.branchId == branchName.branchId}">selected</c:if>>${branchName.branchName}</option>
						</c:forEach>
					</select><br />
					<br /> 部署・役職： <select name="departmentId">
						<c:forEach items="${departmentNames}" var="departmentName">
							<option value="${departmentName.departmentId}"
								<c:if test="${user.departmentId == departmentName.departmentId}">selected</c:if>>${departmentName.departmentName}</option>
						</c:forEach>
					</select><br />
					<br /> <input type="submit" value="登録" /> <br />
				</form>
				<br />
			</div>
		</div>
	</div>
	<br />
	<div class="copyright text-center">
		Copyright(c)Kenta Watanabe<br />
		<br />
	</div>
</body>
</html>
