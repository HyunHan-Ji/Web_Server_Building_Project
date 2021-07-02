<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ָ�, ������ ������ ����</title>
<style>
@font-face {
    font-family: 'InfinitySans-RegularA1';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/InfinitySans-RegularA1.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

body,input,select {
    font-family: 'InfinitySans-RegularA1', sans-serif;
}

* {
	margin: 0;
	padding: 0;
}

#header {
	padding: 10px;
	background: skyblue;
}

#header > h1 {
	display: inline-block;
}

#header > h4 {
	float: right;
	position: relative;
	top: 20px;
}

#nav{
	background: black;
	width: 170px;
	height: 700px;
	float: left;
}

#nav ul {
	display: block;
	background: black;
	list-style: none;
	width: 170px;
	float: left;
}

#nav li {
	padding: 20px 5px;
	text-align: center;
}

#nav a {
	display: block;
	text-decoration: none;
	color: white;
}

#nav li:hover {
	background: gray;
}

</style>

</head>
<body>
	<header>
		<div id=header>
			<h1>�ָ�, ������ ������ ����</h1>
			<h4>20165164 ������</h4>
		</div>
	</header>
	<nav>
		<div id=nav>
			<ul>
				<li><a href="main.jsp">����������</a></li>
				<li><a href="extra_charge.jsp">���� �ȳ�</a></li>
				<li><a href="outline.jsp">������Ʈ ����</a></li>
			</ul>

		</div>
	</nav>
</body>
</html>