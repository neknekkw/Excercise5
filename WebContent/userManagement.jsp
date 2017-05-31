<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>掲示板システム</title>
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

				<h1>ユーザー管理</h1>
			</div>
		</div>
	</div>

	<div id="header" class="container">
		<div class="row">
			<div id="header" class="col-md-12" style = "margin-left: -14px;">
				<a class="btn btn-primary" href="./" role="button">ホーム</a> <a
					class="btn btn-primary" role="button" href="userRegistration">ユーザー新規登録</a>
				<a class="btn btn-primary" role="button" href="./">戻る</a>
			</div>
		</div>
	</div>

	<br />

	<c:if test="${ not empty errorMessages }">
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

	<div id="header" class="container">
		<div class="row">
			<div id="header" class="col-md-12" style="background: #FFFFBB">
				<br /><br/>
				<table class="table table-bordered">
					<tr>
						<th style="border: black solid 1px;">ログインID</th>
						<th style="border: black solid 1px;">名前</th>
						<th style="border: black solid 1px;">支店</th>
						<th style="border: black solid 1px;">部署・役割</th>
						<th style="border: black solid 1px;">編集</th>
						<th style="border: black solid 1px;">状態</th>
						<th style="border: black solid 1px;">削除</th>
					</tr>

					<c:forEach items="${ users }" var="user">
						<tr>
							<td style="border: black solid 1px;"><c:out value="${user.loginId}" /></td>
							<td style="border: black solid 1px;"><c:out value="${user.name}" /></td>
							<td style="border: black solid 1px;"><c:forEach items="${ branchNames }" var="branchName">
									<c:if test="${user.branchId == branchName.branchId}">
										<c:out value="${branchName.branchName}" />
									</c:if>
								</c:forEach></td>
							<td style="border: black solid 1px;"><c:forEach items="${ departmentNames }"
									var="departmentName">
									<c:if
										test="${user.departmentId == departmentName.departmentId}">
										<c:out value="${departmentName.departmentName}" />
									</c:if>
								</c:forEach></td>
							<td style="border: black solid 1px;">
								<form method="get" action="settings">
									<input type="hidden" name="id" value="${user.id}"> <input
										type="submit" value="編集">
								</form>
							</td>

							<td style="border: black solid 1px;"><c:if test="${user.id != loginUser.id}">
									<c:if test="${user.isStopped == 0}">
										<form method="post" action="userManagement">
											<input type="hidden" name="isStopped" value=1> <input
												type="hidden" name="id" value="${user.id}"> <input
												type="submit" onClick="return confirm('本当に停止しますか？')"
												value="停止" />
										</form>
									</c:if>

									<c:if test="${user.isStopped == 1}">
										<form method="post" action="userManagement">
											<input type="hidden" name="isStopped" value=0> <input
												type="hidden" name="id" value="${user.id}"> <input
												type="submit" name="isStoppedButton"
												onClick="return confirm('本当に復活しますか？')" value="復活">
										</form>
									</c:if>
								</c:if></td>

							<td style="border: black solid 1px;"><c:if test="${user.id != loginUser.id}">
									<form method="post" action="deleteId">
										<input type="hidden" name="deleteId" value="${user.id}"><input
											type="submit" onClick="return confirm('本当に削除しますか')"
											name="delete" value="削除">
									</form>
								</c:if></td>
						</tr>
					</c:forEach>
				</table>
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