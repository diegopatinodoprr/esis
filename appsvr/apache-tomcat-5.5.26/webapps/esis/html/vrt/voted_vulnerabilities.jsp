<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- the HTML header allows us to view the jsp as an html file in web browsers -->
<%--
  -- ESIS
  --
  -- Copyright (c) 2004-2008 Entelience SARL,  Copyright (c) 2008-2009 Equity SA
  --
  -- Projects contributors : Philippe Le Berre, Thomas Burdairon, Benjamin Baudel,
  --                         Benjamin S. Gould, Diego Patinos Ramos, Constantin Cornelie
  -- 
  -- This file is part of ESIS.
  --
  -- ESIS is free software: you can redistribute it and/or modify
  -- it under the terms of the GNU General Public License as published by
  -- the Free Software Foundation version 3 of the License.
  --
  -- ESIS is distributed in the hope that it will be useful,
  -- but WITHOUT ANY WARRANTY; without even the implied warranty of
  -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  -- GNU General Public License for more details.
  --
  -- You should have received a copy of the GNU General Public License
  -- along with ESIS.  If not, see <http://www.gnu.org/licenses/>.
  --
  -- $Id: voted_vulnerabilities.jsp 11 2009-07-07 15:02:53Z tburdairon $
  --
  --%>
<%@ page import="com.entelience.soap.soapVulnerabilityReview" %>
<%@ page import="com.entelience.objects.vrt.VotedVulnerability" %>
<%@ page import="com.entelience.util.DateHelper" %>
<%@ page import="com.entelience.sql.DbHelper" %>
<%@ page extends="com.entelience.servlet.JspBase" %>
<%
// code

try {
	// Check session id validity
	Integer peopleId = getSession(request);
	initTimeZone(peopleId);
	String order = getParam(request, "order");
	String way = getParam(request, "way");
	Integer pageNumber = getParamInteger(request, "page");
	Boolean my = getParamBoolean(request, "my");
	if(my == null)
		my = Boolean.FALSE;
	Boolean excludeWithDecision = getParamBoolean(request,"excludeWithDecision");
	if(excludeWithDecision == null)
		excludeWithDecision = Boolean.FALSE;
    
	// Now we can use webservices
	soapVulnerabilityReview vr = new soapVulnerabilityReview(peopleId);
	String todaysDate = formatDate(DateHelper.now());
	VotedVulnerability[] votedVulns = vr.getVotedVulnerabilities(my.booleanValue(), excludeWithDecision.booleanValue(), order, way, pageNumber); 
	// end code
%>
<!-- Now begins HTML page ...-->
<head>
<title>New vulnerabilities with vote - <%= todaysDate %></title>
<%@ include file="../style.inc.jsp" %>
</head>
<body>
<table width="100%" border="0" align="center" bgcolor="white">
<tr>
	<td>
		<div align="center">
		<!-- Header //-->
		<table width="100%" border="0" align="center" cellpadding="4" cellspacing="0">
		<tr>
			<td width="20%" rowspan="2" align="left"><a href="http://esis.sourceforge.net/" target="_blank"><%@ include file="../icon.inc.jsp" %></a></td>
			<td width="80%" align="center" class="title">New vulnerabilities with vote(s)</td>
		</tr>
		<tr>
			<td align="center"><%= todaysDate %></td>
		</tr>
		</table>
		<br/>
		<%
		if (votedVulns == null || votedVulns.length == 0) {
		%>
		<!-- no Vulns -->
		<br/>
		<table border="1" cellspacing="0" cellpadding="4" width="90%">
		<tr>
			<td align="center">No new vulnerabilities with vote.</td>
		</tr>
		</table>
		<%
		} else {
		// display Vulns
		%>
		<table border="1" cellspacing="0" cellpadding="4" width="90%">
		<tr>
			<td>
				&nbsp;<br/>
				<ul>
				<%
				for(int i=0; i<votedVulns.length; ++i) {
				VotedVulnerability vil = votedVulns[i];
				%>
				<li>
					<div align="left"><b><%= vil.getVuln_name() %></b> - 
			        <%= HTMLTitle(vil.getDescription(), null) %>&nbsp;</div>
			        <%
					if(DbHelper.nullify(vil.getMy_vote()) != null){
					%>
			        <div align="left"> - My vote: <b><%=vil.getMy_vote()%></b></div>
			        <%
					}
					if(DbHelper.nullify(vil.getDecision()) != null){
					%>
			        <div align="left"> - Current decision: <b><%=vil.getDecision()%></b></div>
			        <%
					}
					%>
			        <br>
				</li>
				<%
				} // end for
				%>
				</ul>
			</td>
		</tr>
		</table>
		<%
		} // end if votedVulns
		%>
		<%@ include file="../copyright.inc.jsp" %>
		</div>
	</td>
</tr>
</table>
</body>
</html>
<%
} catch(Exception e){
	_logger.error("Exception during JSP execution", e);
	setErrorMessage(response, e, getSessionId(request));
}
%>