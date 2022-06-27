<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="common.utils.common.CmmnUtil"  %>
<%@ page import="common.utils.common.PentasMap"  %>
<%@ page import="common.utils.string.StringUtil"  %>
<%@ page import="common.config.properties.SettingProperties"  %>
<%@ page import="java.util.List"  %>
<%@ page import="common.utils.json.JsonUtil"  %>
<%
	SettingProperties settingProperties = (SettingProperties)CmmnUtil.getBean("settingProperties");
	String rscVer = settingProperties.getRscVer();
	
	String USR_PK_ID = StringUtil.defaultString((String) session.getAttribute("USR_PK_ID")); // 사용자 PK
	String USR_ID = StringUtil.defaultString((String) session.getAttribute("USR_ID")); // 사용자 아이디
	String USR_NAME = StringUtil.defaultString((String) session.getAttribute("USR_NAME")); // 사용자 이름
	String USR_LV = StringUtil.defaultString((String) session.getAttribute("USR_LV")); // 사용자 구분
%>
