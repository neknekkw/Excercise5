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

		<table border="1" cellspacing="0" cellpadding="0">
			<tr>
				<td>ログインID</td>
				<td>名前</td>
				<td>支店</td>
				<td>部署・役割</td>
				<td>編集</td>
				<td>状態変更</td>
				<td>削除</td>
			</tr>

			<c:forEach items="${ users }" var="user">
				<tr>
					<td><c:out value="${user.loginId}" /></td>
					<td><c:out value="${user.name}" /></td>
					<td>
						<c:if test = "${user.branchId == 1}">
						<c:out value="本社" />
						</c:if>
						<c:if test = "${user.branchId == 2}">
						<c:out value="支店A" />
						</c:if>
						<c:if test = "${user.branchId == 3}">
						<c:out value="支店B" />
						</c:if>
						<c:if test = "${user.branchId == 4}">
						<c:out value="支店C" />
						</c:if>
					</td>
					<td>
					<c:if test = "${user.departmentId == 1}">
					<c:out value="総務部人事" />
					</c:if>
					<c:if test = "${user.departmentId == 2}">
					<c:out value="情報管理部" />
					</c:if>
					<c:if test = "${user.departmentId == 3}">
					<c:out value="支店長" />
					</c:if>
					<c:if test = "${user.departmentId == 4}">
					<c:out value="社員" />
					</c:if>
					</td>
					<td>
						<form method="get" action="settings">
							<input type="hidden" name="settings" value="${user.id}"><input
								type="submit" name="settingsButton" value="編集">
						</form>
					</td>

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
					<td>
						<form method="post" action="deleteId">
							<input type="hidden" name="deleteId" value="${user.id}"><input
								type="submit" onClick="return confirm('本当に削除しますか')"
								name="delete" value="削除">
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>


</body>
</html>