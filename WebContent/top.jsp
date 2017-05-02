<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>掲示板システム</title>
<link href="./css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="main-contents">

		<div class="header">
			<a href="./">ホーム</a> <a href="newPost">新規投稿</a> <a
				href="userManagement">ユーザー管理</a> <a href="logout">ログアウト</a>
		</div>

		<div class="form-area">
			<form action="newMessage" method="post">
				件名<br />
				<textarea name="subject" cols="50" rows="1" class="tweet-box"></textArea>
				<br /> 本文<br />
				<textarea name="message" cols="100" rows="5" class="tweet-box"></textarea>
				<br /> カテゴリー<br />
				<textarea name="category" cols="30" rows="1" class="tweet-box"></textarea>
				<br /> <input type="submit" value="つぶやく">
			</form>
		</div>
		<div class="messages">
			<C:forEach items="${messages}" var="message">
				<br>
				<div class="message">
					<div class="name">
						<span class="name"><C:out value="${message.name}" /></span>
					</div>
					<div class="text">
						<C:out value="${message.text}" />
					</div>
					<div class="date">
						<fmt:formatDate value="${message.insertDate}"
							pattern="yyyy/MM/dd HH:mm:ss" />
					</div>
				</div>
			</C:forEach>
		</div>
		<div class="copyright">Copyright(c)Kenta Watanabe</div>
	</div>
</body>
</html>