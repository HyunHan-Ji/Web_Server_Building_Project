<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<style>
#outline{
	position: absolute;
	left: 200px;
	width: 660px;
	height: 660px;
	margin: 20px;
}
</style>
<%@ include file="design_default.jsp"%>
</head>
<body>
<div id="outline">
	<h4>개발배경</h4>
	<p>진료기관의 진료시간은 학교와 직장 시간인 오전9시부터 오후6시인 경우가 대부분 이다.<br>일반적으로 진료를 보기위해서는 조퇴 또는 외출을 통해야만 진료를 볼 수 있다.</p>
	<p>검색엔진은 주위의 병원의 위치, 병원별로 진료시간을 알려주지만 주위 병원들의 휴일 진료시간을 한눈에 알기 어렵다.</p>
	<p>따라서, 휴일에 진료를 원하는 사람들을 위해 본 웹페이지를 개발하게됨.</p>

	<br>
	<h4>기대효과</h4>
	<p>일요일, 공휴일에 진료를 원하는 경우, 진료하는 진료기관들을 한눈에  쉽게 확인 가능</p>
	<p>지도에 위치를 출력하여 사용자가 진료기관의 위치를 볼 수 있음</p>
	
</div>
</body>
</html>