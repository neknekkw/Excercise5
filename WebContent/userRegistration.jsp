<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<h1>ユーザー新規登録</h1>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>ユーザー登録</title>
	<link href="./css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="main-contents">
<c:if test="${ not empty errorMessages }">
	<div class="errorMessages">
		<ul>
			<c:forEach items="${errorMessages}" var="message">
				<li><c:out value="${message}" />
			</c:forEach>
		</ul>
	</div>
	<c:remove var="errorMessages" scope="session"/>
</c:if>
<form action="userRegistration" method="post"><br />
	<label for="loginId">ログインID</label> (半角英数字6文字以上20文字以下)<br />
	<input name="loginId" value="${user.loginId}" id="loginId"/><br />

	<label for="password">パスワード</label> (記号含む半角文字6文字以上255文字以下)<br />
	<input name="password" type="password" id="account"/><br />

	<label for="checkPassword">確認用パスワード</label><br />
	<input name="checkPassword" type="password" id="checkPassword"/><br />

	<label for="name">名前</label>(10文字以下)<br />
	<input name="name" value="${user.name}" id="password"/> <br />
	支店：
		<select name="branchId">
		<option value="1">本社</option>
		<option value="2">支店A</option>
		<option value="3">支店B</option>
		<option value="4">支店C</option>
	</select><br />
	部署・役職：
		<select name="departmentId">
		<option value="1">総務人事担当者</option>
		<option value="2">情報管理担当者</option>
		<option value="3">支店長</option>
		<option value="4">社員</option>
	</select><br />


		<input type="submit" value="登録" /> <br />
		<a href="userManagement">戻る</a>
</form>
<div class="copyright">Copyright(c)Watanabe Kenta</div>
</div>
</body>
</html>
