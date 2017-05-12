<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<h1>ホーム</h1>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>掲示板システム</title>
<link href="./css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<C:if test="${ not empty edditingErrorMessage }">
	<div class="edditingErrorMessage">
		<ul>
			<C:forEach items="${edditingErrorMessage}" var="message">
				<li><C:out value="${message}" />
			</C:forEach>
		</ul>
	</div>
	<C:remove var="edditingErrorMessages" scope="session"/>
</C:if>

<C:if test="${ not empty loginErrorMessage }">
	<div class="loginErrorMessage">
		<ul>
			<C:forEach items="${loginErrorMessage}" var="message">
				<li><C:out value="${message}" />
			</C:forEach>
		</ul>
	</div>
	<C:remove var="loginErrorMessages" scope="session"/>
</C:if>

<C:if test="${ not empty errorMessages }">
	<div class="errorMessages">
		<ul>
			<C:forEach items="${errorMessages}" var="message">
				<li><C:out value="${message}" />
			</C:forEach>
		</ul>
	</div>
	<C:remove var="errorMessages" scope="session"/>
</C:if>

	<div class="header">
		<a href="newMessage">新規投稿</a>
		<C:if test="${loginUser.departmentId == 1 && loginUser.branchId == 1}">
			<a href="userManagement">ユーザー管理</a>
		</C:if>
		<a href="logout">ログアウト</a>
	</div>
	<br />

	<form action="./" method="get">
		カテゴリー絞込み： <select name="category">
			<option value="">未選択(ALL)</option>
			<C:forEach items="${categories}" var="category">
				<option value="${category.category}">"${category.category}"</option>
			</C:forEach>
		</select> <br />
		<br /> 日付指定: <input type="date" name="start">から <input
			type="date" name="end">まで <input type="submit"
			name="categoryDateButton" value="絞り込む" />
	</form>
	<br />

	<C:forEach items="${messages}" var="message">
		<table border="1" cellspacing="0" cellpadding="0">
			<tr>
				<td height="30">ユーザー名</td>
				<td height="30" width="500"><C:out value="${message.name}" /></td>
			</tr>
			<tr>
				<td height="30">件名</td>
				<td height="30" width="500"><C:out value="${message.subject}" /></td>
			</tr>
			<tr>
				<td height="100">本文</td>
				<td height="100" width="500"><C:forEach var="s" items="${fn:split(message.body, '
')}">
    <div>${s}</div>
</C:forEach>
</td>
			</tr>
			<tr>
				<td height="30">カテゴリー</td>
				<td height="30" width="500"><C:out value="${message.category}" /></td>
			</tr>
			<tr>
				<td height="30">日付</td>
				<td height="30" width="500"><fmt:formatDate value="${message.insertDate}"
							pattern="yyyy/MM/dd HH:mm:ss" /></td>
			</tr>
		</table>

		<form method="post" action="deletePostId">
			<C:if
				test="${(loginUser.departmentId==2 && loginUser.branchId==1) || (loginUser.id == message.userId) || (loginUser.departmentId == 3 && message.departmentId == 4 && loginUser.branchId == message.branchId)}">
				<input type="hidden" name="deletePostId" value="${message.id}">
				<input type="submit" onClick="return confirm('本当に削除しますか')"
					name="delete" value="削除">
			</C:if>
		</form>

		<C:forEach items="${comments}" var="comment">
			<C:if test="${comment.postId == message.id}">
				<table border="1" cellspacing="0" cellpadding="0">
					<tr>
						<td height="30">ユーザー名</td>
						<td height="30" width="500"><C:out value="${comment.name}" /></td>
					</tr>
					<tr>
						<td height="100">コメント</td>
						<td height="100" width="500"><C:forEach var="s" items="${fn:split(comment.body, '
')}">
    <div>${s}</div>
</C:forEach></td>
					</tr>
					<tr>
						<td height="30">日付</td>
						<td height="30" width="500"><fmt:formatDate value="${comment.insertDate}"
								pattern="yyyy/MM/dd HH:mm:ss" /></td>
					</tr>
				</table>
				<form method="post" action="deleteCommentId">
					<C:if
						test="${(loginUser.departmentId==2 && loginUser.branchId==1) || (loginUser.id == comment.userId) || (loginUser.departmentId == 3 && comment.departmentId == 4 && loginUser.branchId == comment.branchId)}">
						<input type="hidden" name="deleteCommentId" value="${comment.id}">
						<input type="submit" onClick="return confirm('本当に削除しますか')"
							name="delete" value="削除">
					</C:if>
				</form>
			</C:if>
		</C:forEach>

		<form action="comment" method="post">
			コメント↑<br />
			<textarea name="comment" cols="80" rows="2" class="tweet-box"></textarea>
			<br /> <input type="hidden" name="id" value="${message.id }"><input
				type="submit" value="コメント">  (500文字以内まで)
		</form>
		<br />

	</C:forEach>
	<div class="copyright">Copyright(c)Kenta Watanabe</div>
</body>
</html>