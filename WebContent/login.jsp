<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>ログイン</title>
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
<br />

<div id="header" class="container">

<c:if test="${ not empty loginErrorMessages }">
<br />
	<div class="row">
	<div id="header" class="col-mid-12 alert alert-danger" role="alert">
	<div class="loginErrorMessages">
		<ul>
			<c:forEach items="${loginErrorMessages}" var="message">
				<li><c:out value="${message}" />
			</c:forEach>
		</ul>
	</div>
	<c:remove var="loginErrorMessages" scope="session"/>
</div></div>
</c:if>


<c:if test="${ not empty errorMessages }">
<br />
	<div class="row">
	<div id="header" class="col-mid-12 alert alert-danger" role="alert">
	<div class="errorMessages">
		<ul>
			<c:forEach items="${errorMessages}" var="message">
				<li><c:out value="${message}" />
			</c:forEach>
		</ul>
	</div>
	<c:remove var="errorMessages" scope="session"/>]
	</div></div>
</c:if>

	<div class="row">
	<div id="header" class="col-mid-12 text-center" style="background:#FFFF99">

<br /><br /><br /><h1>ログイン</h1><br/>

<form action="login" method="post">

	<label for="loginId">ログインID</label><br />
	<input name="loginId" id="loginId" value="${enteredLoginId}"/> <br /><br /><br />

	<label for="password">パスワード</label><br />
	<input name="password" type="password" id="password" value="${enteredPassword}"/> <br /><br />

	<br /><input type="submit" value="ログイン" />
</form>
<br /><br /><br /><br />
</div></div></div>
<br /><div class="copyright text-center">
		Copyright(c)Kenta Watanabe<br /></div>
</body>
</html>
