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
	<label for="loginId">ログインID</label>
	<input name="loginId" value="${user.loginId}" id="loginId"/><br />

	<label for="password">パスワード</label>
	<input name="password" type="password" id="account"/><br />

	<label for="checkPassword">確認用パスワード</label>
	<input name="checkPassword" type="password" id="checkPassword"/><br />

	<label for="name">名前</label>
	<input name="name" value="${user.name}" id="password"/> <br />

	<label for="branchId">支店番号</label>
	<input name="branchId" value="${user.branchId}" id="email"/> <br />

	<label for="departmentId">部署・役職番号</label>
	<input name="departmentId" value="${user.branchId}"><br />

	<input type="submit" value="登録" /> <br />
	<a href="userManagement">戻る</a>
</form>
<div class="copyright">Copyright(c)Watanabe Kenta</div>
</div>
</body>
</html>
