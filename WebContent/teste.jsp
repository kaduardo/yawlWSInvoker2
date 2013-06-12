<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page 
	import="org.yawlfoundation.yawl.wsinvoker.WSInvoker,
	org.jdom.Element,java.util.Map,java.net.URL,
	org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory"
	%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%
try {
	out.println("Iniciando");
	JaxWsDynamicClientFactory factory = JaxWsDynamicClientFactory.newInstance();
	
	String wsdlLocation = "http://localhost:8082/Architecture.xadl.proxy.service/ReconfigurationProxyService?wsdl";
	String serviceName = "{http://service.proxy.xadl.architecture/}ReconfigurationProxyService";
	String bindingName = "[BindingInfo http://schemas.xmlsoap.org/wsdl/soap/]";
	String operationName = "getMyArchInstance";

	Element wsRequestData = new Element("elemento");

	Object rawReplyFromWebServiceBeingInvoked = 
			new WSInvoker().
			invoke(
				new URL(wsdlLocation), 
				serviceName, bindingName,
			operationName, wsRequestData);

	Map<String, Object> replyFromWebServiceBeingInvoked = WSInvoker
			.ExtractFields(rawReplyFromWebServiceBeingInvoked);

	for (String varName : replyFromWebServiceBeingInvoked.keySet()) {
		System.out.println("----------");
		Object replyMsg = replyFromWebServiceBeingInvoked.get(varName);
		System.out.println("replyMsgProperty class = "
				+ replyMsg.getClass().getName());
		String varVal = replyMsg.toString();
		System.out.println("Valor: " + varVal);
	}

	
}catch (Exception e) {
	out.println(e.getMessage());
	e.printStackTrace();
}
%>
Nada
</body>
</html>