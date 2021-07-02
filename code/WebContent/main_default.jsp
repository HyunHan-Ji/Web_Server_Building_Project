<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>주말, 공휴일 진료기관 정보</title>
<%@ include file="design_default.jsp"%>
<style>
#map {
	left: 20px;
	width: 660px;
	height: 660px;
	margin: 20px;
}

#select {
	position: absolute;
	left: 880px;
	top: 80px;
	width: 500px;
	height: 200px;
}

#table {
	position: absolute;
	left: 880px;
	top: 280px;
	width: 660px;
	height: 450px;
	overflow: auto;
}

th {
	position: sticky;
	top: 0px;
	background: white;
}

#table th:first-child, #table td:first-child {
	width: 210px;
}

#table th:nth-child(2), #table th:nth-child(3), #table td:nth-child(2), #table td:nth-child(3) {
	width: 195px;
}

#table th:nth-child(4), #table td:nth-child(4) {
	width: 65px;
}
#table td:nth-child(4) > button {
	width: 65px;
}

#table th:first-child{
	border-radius: 5px 0 0 0; 
}
#table th:last-child{
	border-radius: 0 5px 0 0; 
}
#table th{
	background: linear-gradient(#333 0%,#444 100%);
	color: #FFF; font-weight: bold;
	
}
#table tr:nth-child(even){
	background: #EEE;
} 
#table tr:nth-child(odd){
	background: #FDFDFD;
} 
#table tr>td:nth-child(2), #table tr>td:nth-child(3) {
	text-align: center;
} 
</style>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=lpqbxjr60s"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>//사용자의 위치를 받아옴
		navigator.geolocation.getCurrentPosition(function(pos) {
			document.getElementById('latitude').value = pos.coords.latitude;
			document.getElementById('longitude').value = pos.coords.longitude;
		});
</script>
</head>
<body>
	<div id="map"></div>	
	
	<div id=select>
		<form method=post action="search.jsp">
			<h4>지역별 검색</h4>
			주말, 공휴일 진료유무 데이터가 있는 경우만 표시 <input type="checkbox" name="haveNull"checked="checked">
			<br>
			<select name="sido" disabled>
				<option>시/도 선택</option>
				<option selected="selected">강원</option>
			</select>
			<select name="sggu">
				<option selected="selected">시/군/구 선택</option>
				<option>고성군</option>
				<option>양구군</option>
				<option>양양군</option>
				<option>영원군</option>
				<option>인제군</option>
				<option>정선군</option>
				<option>철원군</option>
				<option>평창군</option>
				<option>홍천군</option>
				<option>화천군</option>
				<option>횡성군</option>
				<option>강릉시</option>
				<option>동해시</option>
				<option>속초시</option>
				<option>원주시</option>
				<option>춘천시</option>
				<option>태백시</option>
				<option>삼척시</option>
			</select>
			<input type="text" name="yadmNm" style="padding:0 2px;">
			<input type="submit"value="Search" style="padding:0 10px; background: none;">
		</form>
		<br> <br>
		<form method=post action="searchUserPos.jsp">
			<h4>현재 위치로 검색</h4>
			주말, 공휴일 진료유무 데이터가 있는 경우만 표시 <input type="checkbox" name="haveNull"checked="checked">
			<input id=latitude name="latitude" type="text" value=0 hidden="">
			<input id=longitude name="longitude" type="text" value=0 hidden="">
			<br> 반경(단위:m)<input name="radius" type="text" value=1000 style="width:30px; text-align:right; padding:0 2px;">
			<input type="text" name="yadmNm" style="padding:0 2px;">
			<input type="submit"value="Search" style="padding:0 10px; background: none;">
		</form>
	</div>
<script>
			//지도 스크립트
			var map = new naver.maps.Map("map", {
			    center: new naver.maps.LatLng(37.8861878017772, 127.7355496910227),
			    zoom: 15,
			    mapTypeControl: true
			});
	
			var infoWindow = new naver.maps.InfoWindow({
			    anchorSkew: true
			});
	
			map.setCursor('pointer');
			
				function searchAddressToCoordinate(address) {
				    naver.maps.Service.geocode({
				        query: address
				    }, function(status, response) {
				        if (status === naver.maps.Service.Status.ERROR) {
				            return alert('Something Wrong!');
				        }

				        if (response.v2.meta.totalCount === 0) {
				            return alert('totalCount' + response.v2.meta.totalCount);
				        }

				        var htmlAddresses = [],
				            item = response.v2.addresses[0],
				            point = new naver.maps.Point(item.x, item.y);

				        if (item.roadAddress) {
				            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
				        }

				        if (item.jibunAddress) {
				            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
				        }

				        infoWindow.setContent([
				            '<div style="padding:10px;min-width:200px;line-height:150%;">',
				            '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
				            htmlAddresses.join('<br />'),
				            '</div>'
				        ].join('\n'));

				        map.setCenter(point);
				        infoWindow.open(map, point);
				    });
				}
		</script>
</body>
</html>