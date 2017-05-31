<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ja">

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

				<h1>ホーム</h1>
			</div>
		</div>
	</div>


	<div id="header" class="container">
		<div class="row">
			<div id="header" class="col-mid-12">
				<a class="btn btn-primary" href="newMessage" role="button">新規投稿</a>
				<C:if
					test="${loginUser.departmentId == 1 && loginUser.branchId == 1}">
					<a class="btn btn-primary" href="userManagement" role="button"
						class="pull-right">ユーザー管理</a>
				</C:if>
				<div class="pull-right">
					-${loginUser.name}がログイン中-　<a class="btn btn-primary pull-right"
						href="logout" role="button">ログアウト</a>
				</div>
			</div>
		</div>
	</div>


	<C:if test="${ not empty errorMessages }">
		<br />
		<div id="header" class="container">
			<div class="row">
				<div id="header" class="col-mid-12 alert alert-danger" role="alert">
					<div class="errorMessages">
						<ul>
							<C:forEach items="${errorMessages}" var="message">
								<li><C:out value="${message}" />
							</C:forEach>
						</ul>
					</div>
					<C:remove var="errorMessages" scope="session" />
				</div>
			</div>
		</div>
	</C:if>


	<br />

	<div id="header" class="container">
		<div class="row">
			<div id="header" class="col-mid-12"
				style="background: #FFFFBB">
				<form action="./" method="get">
					　カテゴリー絞込み： <select name="category">
						<option value="">未選択(ALL)</option>
						<C:forEach items="${categories}" var="category">
							<option value="${category.category}"
								<C:if test = "${(category.category).equals(selectedCategory)}">selected</C:if>><C:out
									value="${category.category}" /></option>
						</C:forEach>
					</select> 日付指定: <input type="date" name="start" value="${startDate}">から
					<input type="date" name="end" value="${endDate}">まで <input
						type="submit" value="絞り込む" />
				</form>
			</div>
		</div>
	</div>

	<br />

	<C:forEach items="${messages}" var="message">
		<div id="header" class="container">
			<div class="row">
				<div id="header" class="col-mid-12 pull-left">
					<table class="table table-bordered" style="background: #FFFFBB">

						<tr>
							<th style="border: black solid 1px;" height="30" width="100" >ユーザー名</th>
							<td style="border: black solid 1px;" height="30" width="500"><C:out value="${message.name}" /></td>
						</tr>


						<tr>
							<th style="border: black solid 1px;" height="30" width="100">件名</th>
							<td style="border: black solid 1px;" height="30" width="500"><C:out
									value="${message.subject}" /></td>
						</tr>

						<tr>
							<th style="border: black solid 1px;" height="100" width="100">本文</th>
							<td style="border: black solid 1px;" height="100" width="500"><C:forEach var="s"
									items="${fn:split(message.body, '
')}">
									<div>${s}</div>
								</C:forEach></td>
						</tr>

						<tr>
							<th style="border: black solid 1px;" height="30" width="100">カテゴリー</th>
							<td style="border: black solid 1px;" height="30" width="500"><C:out
									value="${message.category}" /></td>
						</tr>

						<tr>
							<th style="border: black solid 1px;" height="30" width="100">日付</th>
							<td style="border: black solid 1px;" height="30" width="500"><fmt:formatDate
									value="${message.insertDate}" pattern="yyyy/MM/dd HH:mm:ss" /></td>
						</tr>

					</table>
				</div>
			</div>
		</div>


		<form method="post" action="deletePostId">
			<div id="header" class="container">
				<div class="row">
					<div id="header" class="col-mid-12">
						<C:if
							test="${(loginUser.departmentId==2 && loginUser.branchId==1) || (loginUser.id == message.userId) || (loginUser.departmentId == 3 && message.departmentId == 4 && loginUser.branchId == message.branchId)}">
							<input type="hidden" name="deletePostId" value="${message.id}">
							<input type="submit" onClick="return confirm('本当に削除しますか')"
								name="delete" value="投稿削除">
						</C:if>
					</div>
				</div>
			</div>
		</form>
		<br />

		<C:forEach items="${comments}" var="comment">
			<C:if test="${comment.postId == message.id}">
				<div id="header" class="container center-block"
					style="width: 500px;">
					<div class="row">
						<div id="header" class="col-mid-12" style="background: #99FFFF">
							<table class="table table-bordered">
								<tr>
									<th height="30" width="120">ユーザー名</th>
									<td height="30" width="500"><C:out value="${comment.name}" /></td>
								</tr>
								<tr>
									<th height="100" width="120">コメント</th>
									<td height="100" width="500"><C:forEach var="s"
											items="${fn:split(comment.body, '
')}">
											<div>${s}</div>
										</C:forEach></td>
								</tr>
								<tr>
									<th height="30" width="120">日付</th>
									<td height="30" width="500"><fmt:formatDate
											value="${comment.insertDate}" pattern="yyyy/MM/dd HH:mm:ss" /></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<form method="post" action="deleteCommentId">
					<div id="header" class="container center-block"
						style="width: 500px;">
						<div class="row">
							<div id="header" class="col-mid-12">
								<C:if
									test="${(loginUser.departmentId==2 && loginUser.branchId==1) || (loginUser.id == comment.userId) || (loginUser.departmentId == 3 && comment.departmentId == 4 && loginUser.branchId == comment.branchId)}">
									<input type="hidden" name="deleteCommentId"
										value="${comment.id}">
									<input type="submit" onClick="return confirm('本当に削除しますか')"
										value="コメント削除">
								</C:if>
							</div>
						</div>
					</div>
				</form>
				<br />
			</C:if>
		</C:forEach>
		<br />

		<div id="header" class="container center-block">
			<div class="row">
				<div id="header" class="col-mid-12">
					<form action="comment" method="post">
						コメント (500文字以内まで)<br />

						<script type="text/javascript">
						<!--
							function CountDownLength(idn, str, mnum) {
								document.getElementById(idn).innerHTML = "【あと"
										+ (mnum - str.length) + "文字】";
							}
						// -->
						</script>

						<C:if test="${message.id != keepComment.postId}">
							<textarea name="comment" style="word-wrap: break-word;" cols="80" rows="2"
								onkeyup="CountDownLength('inputlength1_${message.id}', value, 500);"></textarea>
							<p id="inputlength1_${message.id}">【あと500文字】</p>
						</C:if>
						<C:if test="${message.id == keepComment.postId}">
							<textarea name="comment" style="word-wrap: break-word;" cols="80" rows="2"
								onkeyup="CountDownLength('inputlength2', value, 500);"><C:out
									value="${keepComment.body}" /></textarea>
							<p id="inputlength2">【あと500文字】</p>
						</C:if>

						<input type="hidden" name="id" value="${message.id }"><input
							type="submit" value="コメント">
					</form>
				</div>
			</div>
		</div>
		<br />
		<div id="header" class="container">
			<div class="row">
				<div id="header" class="col-mid-12 pull-left">
					<br/>==============================================================================================<br />
					<br />
				</div>
			</div>
		</div>
	</C:forEach>
	<div class="copyright text-center">
		Copyright(c)Kenta Watanabe<br />
		<br />
	<C:remove var="keepComment" scope="session" /></div>
</body>
</html>