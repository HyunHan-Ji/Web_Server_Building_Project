<%@page import="javabean.ApiBean"%>
<%@page import="java.sql.Statement"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="javax.xml.xpath.XPathConstants"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="javax.xml.xpath.XPathExpression"%>
<%@page import="javax.xml.xpath.XPath"%>
<%@page import="javax.xml.xpath.XPathFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="java.io.StringReader"%>
<%@page import="org.xml.sax.InputSource"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="main_default.jsp"%>
</head>
<body>
	<div id=table>
		<%@ include file="dbconn.jsp"%>
		<table>
			<thead>
				<tr>
					<th>병원명</th>
					<th>일요일 휴진안내</th>
					<th>공휴일 휴진안내</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
		<%
			//전송 받은 데이터로 DB에서 시도코드, 시군구코드 받아옴
			request.setCharacterEncoding("euc-kr");
			String sido = request.getParameter("sido");
			String sggu = request.getParameter("sggu");
			String yadmNm = request.getParameter("yadmNm");
			String haveNull = request.getParameter("haveNull"); //"on" 또는null

			Statement stmt = null;
			ResultSet rs = null;
			String sql = "select cgguCd from cityCd where cgguCdNm=" + "'" + sggu + "';";
			stmt = dbconn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next())
				sggu = rs.getString("cgguCd");
	
			
				if (sggu.equals("시/군/구 선택")) {
					out.println("<script>alert('시/군/구 를 선택해주세요');</script>");
				} else if (sggu.equals("시/도 선택")) {
					out.println("<script>alert('시/도 를 선택해주세요');</script>");
				} else {
					//전송받은데이터, DB에서 받은 데이터로 API1 호출 URL생성
					int dataLength = 0;
					for (int k = 0; k < dataLength + 1; k++) {
						String serviceKey = "yY50rnV/Q5gzGsLd7nkUT58rIdMAa42ayT7PCfqpb5qrUTadnBeC6sGhpJx2Zo8WSd28CpW7iMzBNsnhjlJCMw==";

						StringBuilder urlBuilder = new StringBuilder(
								"http://apis.data.go.kr/B551182/hospInfoService/getHospBasisList"); // URL
						urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + serviceKey);
						urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "="
								+ URLEncoder.encode(String.valueOf(k + 1), "UTF-8")); //페이지번호
						urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "="
								+ URLEncoder.encode("100", "UTF-8")); /*한 페이지 결과 수*/
						urlBuilder.append(
								"&" + URLEncoder.encode("sgguCd", "UTF-8") + "=" + URLEncoder.encode(sggu, "UTF-8")); // 시군구코드 
						if (yadmNm != null)
							urlBuilder.append(
									"&" + URLEncoder.encode("yadmNm", "UTF-8") + "=" + URLEncoder.encode(yadmNm, "UTF-8"));

						URL url = new URL(urlBuilder.toString());
						
						//URL로 API 호출
						HttpURLConnection conn = (HttpURLConnection) url.openConnection();
						conn.setRequestMethod("GET");
						conn.setRequestProperty("Content-type", "application/json");
						BufferedReader rd;
						if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
							rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
						} else {
							rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
						}
						StringBuilder sb = new StringBuilder();
						String line;

						while ((line = rd.readLine()) != null) {
							sb.append(line);
						}
						rd.close();
						conn.disconnect();
						
						// API를 통해 조건에 맞는 병원들의 목록을 XML형식으로 받아옴
						DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
						factory.setNamespaceAware(true);

						InputSource is = new InputSource(new StringReader(sb.toString()));
						DocumentBuilder builder = factory.newDocumentBuilder();
						Document doc = builder.parse(is);

						XPathFactory xpathFactory = XPathFactory.newInstance();
						XPath xpath = xpathFactory.newXPath();
						XPathExpression expr = xpath.compile("//items/item");

						if (k == 0) {// 데이터의 양을 확인후 반복회수 설정
							XPathExpression expr2 = xpath.compile("//body/totalCount");
							NodeList nodeList2 = (NodeList) expr2.evaluate(doc, XPathConstants.NODESET);
							dataLength = (Integer.parseInt(nodeList2.item(0).getChildNodes().item(0).getTextContent())) / 100;
						}

						NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);

						for (int i = 0; i < nodeList.getLength(); i++) {
							NodeList child = nodeList.item(i).getChildNodes();

							String datas[] = { null, null, null, null };//병원명 주말 공휴일 주소

							for (int j = 0; j < child.getLength(); j++) {
								Node node = child.item(j);
								if (node.getNodeName().equals("yadmNm"))
									datas[0] = node.getTextContent();
								else if (node.getNodeName().equals("addr"))
									datas[3] = node.getTextContent();
								else if (node.getNodeName().equals("ykiho")) {
									String temp[] = ApiBean.detailsApi(node.getTextContent()); //ykiho를 통해 세부정보를 받아오는 함수
									datas[1] = temp[0];
									datas[2] = temp[1];
								}
							}
							if (haveNull != null) { //체크 O //주말, 공휴일 진료 데이터가  있는 경우만 출력
								if (datas[1] != null && datas[2] != null) {
									out.print("<tr>");
									for (int a = 0; a < 3; a++) {
										out.print("<td>" + datas[a] + "</td>");
									}
									out.print("<td><button onclick='searchAddressToCoordinate(\"" + datas[3] + "\")'>위치보기</button></td>");
									out.print("</tr>");
								}
							} else { //체크 X//주말, 공휴일 진료 데이터가 없는 경우도 출력
								if (datas[1] == null) {
									datas[1] = "";
								}
								if (datas[2] == null) {
									datas[2] = "";
								}
								out.print("<tr>");
								for (int a = 0; a < 3; a++) {
									out.print("<td>" + datas[a] + "</td>");
								}
								out.print("<td><button onclick='searchAddressToCoordinate(\"" + datas[3] + "\")'>위치보기</button></td>");
								out.print("</tr>");
							}
						}
					}
				}
			%>
		</table>
	</div>
</body>
</html>