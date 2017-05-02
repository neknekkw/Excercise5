<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<h1>ユーザ管理</h1>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>掲示板システム</title>
</head>
<body>
	<div class="main-contents">

		<div class="header">
			<a href="./">ホーム</a> <a href="userRegistration">ユーザー新規登録</a> <a
				href="logout">ログアウト</a>
		</div>

		<table border="1">
			<tr>
				<td>ログインID</td>
				<td>名前</td>
				<td>支店</td>
				<td>部署・役割</td>
				<td>編集</td>
				<td>状態変更</td>
			</tr>

			<c:forEach items="${ users }" var="user">
				<tr>
					<td><c:out value="${user.loginId}" /></td>
					<td><c:out value="${user.name}" /></td>
					<td><c:out value="${user.branchId}"/></td>
					<td><c:out value="${user.departmentId}"/></td>
					<td><button type="button" onclick="location.href='settings'">編集</button></td>

					<c:if test="${user.isStopped == 0}">
						<td>
							<form method="post" action="userManagement">
								<input type="hidden" name="isStopped" value=1> <input
									type="hidden" name="id" value="${user.id}"> <input
									type="submit" onClick="return confirm('本当に停止しますか？')" value="停止" />
							</form>
						</td>
					</c:if>

					<c:if test="${user.isStopped == 1}">
						<td>
							<form method="post" action="userManagement">
								<input type="hidden" name="isStopped" value=0> <input
									type="hidden" name="id" value="${user.id}"> <input
									type="submit" name="isStoppedButton"
									onClick="return confirm('本当に復活しますか？')" value="復活">
							</form>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
	</div>


</body>
</html>