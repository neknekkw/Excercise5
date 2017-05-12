<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<h1>ログイン</h1>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>ログイン</title>
	<link href="./css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="main-contents">

<c:if test="${ not empty errorMessage }">
	<div class="errorMessage">
		<ul>
			<c:forEach items="${errorMessage}" var="message">
				<li><c:out value="${message}" />
			</c:forEach>
		</ul>
	</div>
	<c:remove var="errorMessages" scope="session"/>
</c:if>

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

<form action="login" method="post"><br />
	<label for="loginId">ログインID</label> (半角英数字で6文字以上20文字以下)<br />
	<input name="loginId" id="loginId"/> <br />

	<label for="password">パスワード</label> (記号含む半角文字で6文字以上255文字以下)<br />
	<input name="password" type="password" id="password"/> <br />

	<input type="submit" value="ログイン" /> <br />
</form>
<div class="copyright">Copyright(c)Kenta Watanabe</div>
</div>
</body>
</html>
