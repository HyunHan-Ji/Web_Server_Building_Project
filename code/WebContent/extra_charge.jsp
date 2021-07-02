<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="design_default.jsp"%>
<style>
#extrachargetable{
	position: absolute;
	left: 200px;
	width: 660px;
	height: 660px;
	margin: 20px;
}
#extrachargetable td{
	border:1px solid;
}
#extrachargetable td{
	width:100px;
	text-align: center;
}
</style>
</head>
<body>
	<div id="extrachargetable">
		<table>
				<tr>
					<td></td>
					<td>약국,동네의원</td>
					<td>병원,상급병원</td>
				</tr>
				<tr>
					<td>평일 야간<br>18시~09시</td>
					<td>30%</td>
					<td>30%</td>
				</tr>
				<tr>
					<td>토요일 오전<br>09시~13시</td>
					<td>30%</td>
					<td>가산 없음</td>
				</tr>
				<tr>
					<td>토요일 오후<br>13시~24시</td>
					<td>30%</td>
					<td>30%</td>
				</tr>
				<tr>
					<td>공휴일<br>00시~24시</td>
					<td>30%</td>
					<td>30%</td>
				</tr>
			</table>
			<p>약 조제료, 진찰료 등 의료인의 인건비만 30%가산되고 약품값, 재료값은 그대로입니다</p>
			<p>약은 조재기본료, 복약지도료, 조제료가 가산되어 대략 전체 약값의 7~8%정도가 오릅니다</p>
			<br>
			<p>진료비 가산정보
			<a href=http://www.hira.or.kr/dummy.do?pgmid=HIRAA020033000000#none>http://www.hira.or.kr/dummy.do?pgmid=HIRAA020033000000#none</a>
		</div>
</body>
</html>