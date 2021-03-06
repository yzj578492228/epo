<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>
<script type="text/javascript" src="${ctx }/static/js/knowledge/lib.js"></script>
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
				
<!-- table content start -->
	
					
					<div class="addPoint dataBaseBox">
<!-- addPointCon start -->
					<div class="addPointCon dataBase">
						<div class="addPointConBntLine"></div>
						<div class="addPointConBnt">
						<form action="/knowledgeDictLibManage/getlistLibByParentId">
					
							<div class="addPointConBntDiv addPointConBntAct""><input type="hidden" name="all" value="1">一级词库</div>
							<c:forEach var="lib" items="${listlib}">
							<div class="addPointConBntDiv" ><input type="hidden" name="ss" value="${lib.id }">${lib.kdlName}</div>
							</c:forEach>
						
						</div>
						<input type="hidden" name="kdlParentId" id="kdlParentId" value="1">
						</form>

					<div class="addPointConContent">
<!-- 基本配置1 start -->
					<div class="basic">
					<div class="tableListDiv dataBasetableListDiv">
						<div class="tableListDivNav">
							<div class="tableListDivNavLeft" id="pageInfo" >
								
							</div>
							<shiro:user>
								<shiro:hasPermission name="27">
							<div class="tableListDivAddDataBase">
								<a href="/knowledgeDictLibManage/knowledgeDictLibManageToAddLib"></a>
							</div>
								</shiro:hasPermission>
							</shiro:user>

						</div>
						<div class="tableListDivTable">
							<table cellpadding="0" cellspacing="0" id="tableContainer">
								
							</table>
<!-- 分页 start -->
							<div class="tablePage" id="pageContainer">
								
							</div>
<!-- 分页 end -->
						</div>
					</div>
					</div>
<!-- 基本配置1 end -->
							</div>
						</div>
<!-- addPointCon end -->

					</div>
					
	
<!-- table content end -->

<script type="text/javascript">
$(function()
{	//初始化分页数据页面
	var initPageInfo = window.location.toString().match(/page(=|\/)([0-9]+)/);
	getItemList(initPageInfo ? initPageInfo[2] : 0);
    
	//执行按钮切换效果
	changeBnt("addPointConBntDiv","basic");
})


//按钮切换效果
function changeBnt(bnt,con)
{
	$("."+bnt).click(function()
	{
		$("."+bnt).removeClass("addPointConBntAct");
		$(this).addClass("addPointConBntAct");
		//$("."+con).addClass("hidden");
		//$($("."+con)[$(this).index()]).removeClass("hidden");
			
		$('#kdlParentId').attr("value",$(this).find("input[type='hidden']").val());
		var initPageInfo = window.location.toString().match(/page(=|\/)([0-9]+)/);
		getItemList(initPageInfo ? initPageInfo[2] : 0);

	}) ;
	

}
</script>



				
				<!-- 页面内容  end -->
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
