package javabean;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class ApiBean {
	public static String[] detailsApi(String ykiho) { //����ȣ�� �ָ�,������ ����Ȯ��
		String datas[] = { null, null };
		try {
			//2.������ ����ȣ�� API�� �̿��Ͽ� �������������� XML�� �޾ƿ�
			String serviceKey = "yY50rnV/Q5gzGsLd7nkUT58rIdMAa42ayT7PCfqpb5qrUTadnBeC6sGhpJx2Zo8WSd28CpW7iMzBNsnhjlJCMw==";

			StringBuilder urlBuilder = new StringBuilder(
					"http://apis.data.go.kr/B551182/medicInsttDetailInfoService/getDetailInfo"); /*URL*/
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + serviceKey);
			urlBuilder.append(
					"&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*��������ȣ*/
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "="
					+ URLEncoder.encode("10", "UTF-8")); /*�� ������ ��� ��*/
			urlBuilder.append(
					"&" + URLEncoder.encode("ykiho", "UTF-8") + "=" + URLEncoder.encode(ykiho, "UTF-8")); /*��ȣȭ�� ����ȣ*/
			URL url = new URL(urlBuilder.toString());
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

			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			factory.setNamespaceAware(true);

			InputSource is = new InputSource(new StringReader(sb.toString()));
			DocumentBuilder builder = factory.newDocumentBuilder();
			Document doc = builder.parse(is);

			XPathFactory xpathFactory = XPathFactory.newInstance();
			XPath xpath = xpathFactory.newXPath();
			XPathExpression expr = xpath.compile("//items/item");

			NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);

			for (int i = 0; i < nodeList.getLength(); i++) {
				NodeList child = nodeList.item(i).getChildNodes();

				for (int j = 0; j < child.getLength(); j++) {
					Node node = child.item(j);
					if (node.getNodeName().equals("noTrmtSun"))
						datas[0] = node.getTextContent();
					if (node.getNodeName().equals("noTrmtHoli"))
						datas[1] = node.getTextContent();

				}
			}

		} catch (Exception e) {
			
		}
		return datas;

	}
	
}
