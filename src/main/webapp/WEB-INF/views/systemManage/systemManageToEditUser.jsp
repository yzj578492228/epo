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


//表单提交
function submitForm(){
	//获取表单数据对象
	var formLabel = $("form").find('input[type="text"],input[type="password"],select');
	//获取表单数据
	var dataLabel = requiredLabel(formLabel);
	//如果检测必填数据为空，返回页面
	if(dataLabel==false){
		return false;
	}
	//是否有错误提示
	var hasErrors = inputPrompt();
	
	//提交表单
	if(hasErrors==false){
		$.ajax({url:$("form").attr("action"),
		type:'post',
		async:false,
		data:dataLabel,
		dataType:"json",
		success:function(msg){
			if(msg.errors){
				$(".restate span").html("<img src=\"<?php echo Yii::app()->request->baseUrl; ?>/images/loading.gif\" />");
				$(".importPrompt").html();
				$(".restate span").append("用户信息修改失败");
				$(".restate").css("display","block");
			}else{
				$(".restate span").html("<img src=\"<?php echo Yii::app()->request->baseUrl; ?>/images/loading.gif\" />");
				$(".importPrompt").html();
				$(".restate span").append("用户信息修改成功");
				$(".restate").css("display","block");
			}

			setInterval("$('.restate').css('display','none')",3000);
			
		}
	});
	
	}


}

//验证不能为空，若都有值则返回表单数组、密码验证、邮箱验证
function requiredLabel(objLabel){
	
	var data = {};

	var status="";

	for(var i=0;i<objLabel.length;i++){
		data[$(objLabel[i]).attr("name")] = $(objLabel[i]).val();
		var labelText = $(objLabel[i]).parent().prev().text();

		if($(objLabel[i]).parent().prev().find("tt").text()=="*" && $(objLabel[i]).val()==""){
			$(objLabel[i]).parent().next().html(labelText.substr(1,labelText.length-2)+"不能为空");
			status = 1;
		}else{
			$(objLabel[i]).parent().next().html("");
		}
	}

	//邮箱验证
	var temp = $("#email");
	var myreg = /^([a-zA-Z0-9]+[_|\_|\.|\-]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	
	if(!myreg.test(temp.val()))
	{	status = 1;
		$(temp).parent().next().html("邮箱地址不符合电子邮箱格式");
	}

	if(status!=1){
		return data;
	}else{
		return false;
	}
}


//是否有错误提示
function inputPrompt(){
	for(var i=0;i<$(".inputPrompt").length;i++){
			if($($(".inputPrompt")[i]).html()==""){
				return false;
			}else{
				return true;
			}
	}
}



</script>


</head>
<body>
<div class="con">
<!-- topNav start -->
	<div class="topNav">
		<div class="navDiv"><a href="/mainMedia/index" >主流媒体舆情</a></div>
		<div class="navDiv"><a href="/warning/index" >舆情预警</a></div> 
		<div class="navDiv"><a href="/cityRecognize/index" >城市形象与认知度</a></div>
		<div class="navDiv"><a href="/leaderRecognition/index" >舆论领袖识别</a></div>
		<div class="navDiv"><a href="/knowledgeDictLibManage/index" >知识库管理</a></div>
		<div class="navDiv act"><a href="/systemManage/index" >系统管理</a></div>
	</div>
<!-- topNav end -->

<!-- table content start -->
	<div class="tableContent">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top">
				<div class="tableContentLeft">
					<div class="navTitle"><a href="/systemManage/index" >系统管理</a></div>
					<div class="navSubTitle"><a href="/systemManage/toSiteManage" >站点管理</a></div>
					<div class="navSupTitle"><a href="/systemManage/toAddSite" ><span>添加站点</span></a></div>
					<div class="navSupTitle"><a href="/systemManage/statistics" ><span>信息统计</span></a></div>
					
					<div class="navSubTitle"><a href="/systemManage/toGatherManage" >采集点管理</a></div>
					<div class="navSupTitle"><a href="/systemManage/toAddGather" ><span>添加采集点</span></a></div>
					
					<div class="navSubTitle"><a href="/systemManage/personalCenter" >个人中心</a></div>
					<div class="navSupTitle"><a href="/systemManage/toChangePass" ><span>更改密码</span></a></div>
					<div class="navSupTitle"><a class="act" href="/systemManage/toEditUser" ><span>修改信息</span></a></div>
					
					<div class="navSubTitle"><a href="/systemManage/toUserManage" >用户管理</a></div>
					<div class="navSupTitle"><a class="" href="/systemManage/toAddUser" ><span>添加用户</span></a></div>
				</div>
			</td>
			<td class="tdBak" valign="top">
				<div class="tableContentRight">
					<div class="currentPosition">
					&nbsp;&nbsp;&nbsp;&nbsp;当前位置：&nbsp;&nbsp;<a href="/systemManage/index" >系统管理</a>&nbsp;>&nbsp;<a href="/systemManage/personalCenter" >个人中心</a>&nbsp;>&nbsp;<a href="/systemManage/toEditUser" >修改信息</a>
					</div>
				
				<!-- 页面内容 start -->
				
				<div class="addPoint" style="height:430px;">
<!-- addPointInput start -->

						<form action="/user/editUser" method="post" id="form" name="form">
						<div class="addPointInput modifyIndiv">
							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>用户名：</span>
								<span class="inputDiv inputModifyDiv"><input id="loginName" type="text" maxlength="16" readonly="readonly" name="loginName" value="${user.loginName }"/></span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>用户昵称：</span>
								<span class="inputDiv inputModifyDiv"><input id="username" type="text" maxlength="16" name="username" value="${user.username }"/></span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>用户级别：</span>
								<span class="inputDiv inputModifyDiv"><select id="userType" name="userType" disabled="disabled">
																		<option value="">--</option>
																		<option <c:if test="${user.userType eq 1}">selected="selected"</c:if> value="1">系统管理员</option>
																		<option <c:if test="${user.userType eq 2}">selected="selected"</c:if> value="2">部负责人</option>
																		<option <c:if test="${user.userType eq 3}">selected="selected"</c:if> value="3">处室负责人</option>
																		<option <c:if test="${user.userType eq 4}">selected="selected"</c:if> value="4">处室人员</option>
																		<option <c:if test="${user.userType eq 5}">selected="selected"</c:if> value="5">中心负责人</option>
																		<option <c:if test="${user.userType eq 6}">selected="selected"</c:if> value="6">中心人员</option>
																		</select></span>
								<span class="inputPrompt"></span>
							</div>

							<div class="addPointInputBox">
								<span class="inputTitle inputModifyTitle"><tt>*</tt>电子邮箱：</span>
								<span class="inputDiv inputModifyDiv"><input id="email" type="text" maxlength="64" name="email" value="${user.email }"/></span>
								<span class="inputPrompt"></span>
							</div>
						
						

						</div>
<!-- addPointInput end -->

<!-- submit start -->
						<div class="submitBox modifyBox">
							<span class="submitBnt_1"><a href="###" onclick="submitForm()"></a></span>
							<span class="returnBnt"><a href="/systemManage/personalCenter"></a></span>
						</div>
<!-- submit end -->

<!-- submit success start -->
						<div class="restate" style="display:none">
							<span ><img src="/static/images/loading.gif" /></span>
						</div>
<!-- submit success end -->
						</form>
					</div>
					


				
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
