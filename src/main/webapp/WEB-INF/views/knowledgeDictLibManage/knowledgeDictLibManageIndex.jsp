<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>

<script type="text/javascript"> 
function todo(url){
	parent.document.getElementById("middleFrame").src = url;
}
</script>

</head>
<body>
<div class="con">
<!-- topNav start -->
	<div class="topNav">
		<c:forEach items="${menuList}" var="one_menu">
				<c:if test="${one_menu.status eq 1}">
					<div <c:choose>
					       <c:when test="${one_menu.id eq pMenuId}">
					       	class="navDiv act"
					       </c:when>
					       <c:otherwise>
					       	class="navDiv"
					       </c:otherwise>
						</c:choose>
					>
					<a href="${one_menu.menuUrl}/${one_menu.id}" >${one_menu.menuName}</a>
					</div>
				</c:if>
		</c:forEach>
	</div>
<!-- topNav end -->

<!-- table content start -->
	<div class="tableContent">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top">
				<div class="tableContentLeft">
					<c:forEach items="${menu.subMenuList}" var="fir_menu">
						<c:if test="${fir_menu.status eq 1}">
							<div class="navSubTitle">
								<a <c:choose>
								       <c:when test="${fir_menu.id eq sMenuId}">
								       	class="act"
								       </c:when>
								       <c:otherwise>
								       	class=""
								       </c:otherwise>
									</c:choose>
								href="${fir_menu.menuUrl}/${fir_menu.id}" >
								${fir_menu.menuName}
								</a>
							</div>
							<c:forEach items="${fir_menu.subMenuList}" var="sec_menu">
								<c:if test="${sec_menu.status eq 1}">
									<div class="navSupTitle">
										<a <c:choose>
										       <c:when test="${sec_menu.id eq sMenuId}">
										       	class="act"
										       </c:when>
										       <c:otherwise>
										       	class=""
										       </c:otherwise>
											</c:choose>
										href="${sec_menu.menuUrl}/${sec_menu.id}" >
										${sec_menu.menuName}
										</a>
									</div>
								</c:if>
							</c:forEach>
						</c:if>
					</c:forEach>
				</div>
			</td>
			<td class="tdBak" valign="top">
				<div class="tableContentRight">
					<div class="currentPosition">
					&nbsp;&nbsp;&nbsp;&nbsp;当前位置：&nbsp;&nbsp;<a href="${fUrl }" >${fMenu }</a>
					&nbsp;>&nbsp;<a href="${sUrl }" >${sMenu }</a>
					<c:if test="${not empty tMenu}">&nbsp;>&nbsp;<a href="${tUrl }" >${tMenu }</a></c:if>
					</div>
				
					<!-- 页面内容 start -->		
<!-- 信息统计 start -->
					<div class="information">
						<div class="informationSourceTitle">
							<span class="sourceLeft">舆情词库</span>
							<shiro:user>
								<shiro:hasPermission name="28">
								<span class="sourceRight sourceRight1"><a href="/knowledgeDictLibManage/knowledgeDictLibManageItemManage"></a></span>
								</shiro:hasPermission>
							</shiro:user>
							
						</div>
<!-- 今天 start -->
						<div class="basic">
							<div class="informationDiv">
								<div class="lconBox">
									<div class="lconDiv knowledgeWidth1">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">本月新增词条</div>
											<div class="lconNumber"><tt>${newCountOfMonth}</tt>条</div>
										</div>
										<div class="lconbak3"></div>
									</div>

									<div class="lconDiv knowledgeWidth1">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">本年新增词条</div>
											<div class="lconNumber"><tt>${newCountOfYear}</tt>条</div>
										</div>
										<div class="lconbak3"></div>
									</div>

									<div class="lconDiv knowledgeWidth1">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">词条总数</div>
											<div class="lconNumber"><tt>${totalitem }</tt>条</div>
										</div>
										<div class="lconbak3"></div>
									</div>

									<div class="lconDiv knowledgeWidth1">
										<div class="lconbak1"></div>
										<div class="lconbak2">
											<div class="lconTitle">一级词库总数</div>
											<div class="lconNumber"><tt>${countOfLevelOneLib}</tt>个</div>
										</div>
										<div class="lconbak3"></div>
									</div>
								</div>
							</div>
						</div>
<!-- 今天 end -->

					</div>
<!-- 信息统计 end -->

<!-- 采集信息来源明细 start -->
					<div class="informationSource">
						<div class="sourceChartBox marginTop">
						<div class="sourceChartBoxLeft">
<!-- column chart start -->
							<div class="sourceChartBoxLeftDiv knowledgeDivW">
							<div class="sourceChartBoxLeftTitle"><a>本年度词条增长情况</a></div>
							<div class="sourceChartBoxLeftSelect">&nbsp;</div>
							<div class="clear"></div>
							<div class="informationChart" id="help_continuous_date_chart"></div>
							</div>

							<div class="knowledgeDiv">
						<!-- the data is from database-->
						    <c:forEach  var="kdl" items="${listlib}" >
								<div class="lconDiv knowledgeWidth2">
									<div class="lconbak1"></div>
									<div class="lconbak2">								
										<div class="lconTitle">${kdl.kdlName}</div>
										<div class="lconNumber"><tt>${kdl.kdlCount}</tt></div>		
									</div>
									<div class="lconbak3"></div>
								</div>
							</c:forEach>
                          <!-- data end -->
								
							</div>
<!-- column chart end -->
						</div>

						<div class="sourceChartBoxRight">
<!-- 最新词条 start -->
							<div class="surceWebBox marginTop">
								<div class="surceWebTitle">
									<span class="webTitle">最新词条</span>
								</div>
								<div class="webContent">
								<div class="webContentTable">
									<div class="webContentTh">
										<span class="sort">排序</span>
										<span class="title">词条</span>
										<span class="time">时间</span>
										<div class="clear"></div>
									</div>

							
									<div class="webContentTh webContentTd">
									<% int i=1; %>
									<c:forEach var="kdi" items="${listitem}">	
										<span class="sort"><%= i++ %></span>
										<span class="title">${kdi.kdiName}</span>
										<span class="time"> ${kdi.kdiCreateDate} </span>
										<div class="clear"></div>
										</c:forEach>
									</div>
							

								</div>
								</div>
							</div>
<!-- 最新词条 end -->
						</div>

						</div>
					</div>

			<!-- 页面内容 end -->	
		
		</div>
			</td>
		</tr>
	</table>
	</div>
<!-- table content end -->
</div>

<%@include file="../bottom.jsp"%>
</body>
</html>
