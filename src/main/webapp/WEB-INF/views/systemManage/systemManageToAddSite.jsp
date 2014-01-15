<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>
<script type="text/javascript" src="${ctx}/static/js/site.js"></script>
<script type="text/javascript">

//提交表单
function submitNormalForm(objForm)
{
	//获取表单对象
	var formMainContainer = $(objForm);
	
	//装载表单数据容器
	var formMainData = {};

	//表单输入项
	var formItemList = formMainContainer.find('input[type="text"], select');

	//遍历输入项，检查必填项
	for (var i=0; i<formItemList.length; i++) {
		if ($(formItemList[i]).parent().parent().find('tt').length && $(formItemList[i]).val() == ""){
			//alert($(formItemList[i]).parent().parent().find('span').text()+"不能为空");
			var msg = {};
			msg[$(formItemList[i]).attr("id")] = $(formItemList[i]).parent().parent().find('span').text()+"不能为空";
			responseMessage(msg);
			$(formItemList[i]).focus();
			return ;
		}

		//写入数据
		formMainData[$(formItemList[i]).attr("name")] = $(formItemList[i]).val();
	}

	//网址验证
	var temp = $("#wsmHome");
	if(temp.val()!=''){
		var websiteCheck = IsURL(temp.val());
		//如果网址检测不正确，返回页面
		if(websiteCheck==false){
			var message = {};
			message['wsmHome'] = '格式不正确!';
			responseMessage(message);
			return false;
		}
	}

	messageContent(1,'正在提交数据');
	

	//提交表单
	$.post(formMainContainer.attr("action"),formMainData,function(response){
		//后端返回错误
		if (response.success){
			//操作成功处理
			messageContent(1,'添加成功');
			setTimeout('window.location = document.referrer;', 2000);

		} else {
			//错误处理
			responseMessage(response);
			messageContent(0,'');
		}
	},'json').error(function() { messageContent(1,'网络发生错误');});
}
//验证网址
function IsURL(str_url){
    var strRegex = /^((https|http|ftp|rtsp|mms)?:\/\/)+[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
    var re=new RegExp(strRegex);
    //re.test()
    if (re.test(str_url)){
        return (true);
    }else{
        return (false);
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
					<div class="navSupTitle"><a class="act" href="/systemManage/toAddSite" ><span>添加站点</span></a></div>
					<div class="navSupTitle"><a href="/systemManage/statistics" ><span>信息统计</span></a></div>
					
					<div class="navSubTitle"><a href="/systemManage/toGatherManage" >采集点管理</a></div>
					<div class="navSupTitle"><a href="/systemManage/toAddGather" ><span>添加采集点</span></a></div>
					
					<div class="navSubTitle"><a href="/systemManage/personalCenter" >个人中心</a></div>
					<div class="navSupTitle"><a href="/systemManage/toChangePass" ><span>更改密码</span></a></div>
					<div class="navSupTitle"><a href="/systemManage/toEditUser" ><span>修改信息</span></a></div>
					
					<div class="navSubTitle"><a href="/systemManage/toUserManage" >用户管理</a></div>
					<div class="navSupTitle"><a class="" href="/systemManage/toAddUser" ><span>添加用户</span></a></div>
				</div>
			</td>
			<td class="tdBak" valign="top">
				<div class="tableContentRight">
					<div class="currentPosition">
					&nbsp;&nbsp;&nbsp;&nbsp;当前位置：&nbsp;&nbsp;<a href="/systemManage/index" >系统管理</a>&nbsp;>&nbsp;<a href="/systemManage/toSiteManage" >站点管理</a>&nbsp;>&nbsp;添加站点
					</div>
				<!-- 页面内容 start -->
				
				<div class="addPoint">
	<div class="addPointInput">

		<form action="/webSiteMain/addSite" method="post" id="form">
		<div class="addPointInputBox">
			<span class="inputTitle inputModifyTitle"><tt>*</tt>站点名称：</span>
			<span class="inputDiv inputModifyDiv">
				<input id="wsmName" type="text" name="wsmName" onchange="checkUnique(this,'/webSiteMain/ajaxUnique','')" maxlength="255" />
			</span>
		</div>

		<div class="addPointInputBox">
			<span class="inputTitle inputModifyTitle"><tt>*</tt>首页地址：</span>
			<span class="inputDiv inputModifyDiv"><input id="wsmHome" type="text" name="wsmHome" maxlength="128" onchange="resetMessage('wsmHome')" /></span>
		</div>

		<div class="addPointInputBox">
			<span class="inputTitle inputModifyTitle">站点类别：</span>
			<span class="inputDiv inputModifyDiv"><select id="wsmClass" name="wsmClass">
												<option value="1">综合门户</option>
												<option value="2">新闻门户</option>
												<option value="3">地方新闻</option>
												<option value="4">消费资讯</option>
												<option value="5">微博</option>
												<option value="6">社区论坛</option>
												<option value="7">博客</option>
												<option value="8">其他</option>
												</select></span>
		</div>

		<div class="addPointInputBox">
			<span class="inputTitle inputModifyTitle">站点性质：</span>
			<span class="inputDiv inputModifyDiv"><select id="wsmProperty" name="wsmProperty">
													<option value="1">中央媒体网站</option>
													<option value="2">地方媒体网站</option>
													<option value="3">商业网站</option>
													<option value="4">其他网站</option>
													</select></span>
		</div>

		<div class="addPointInputBox">
			<span class="inputTitle inputModifyTitle">所在地区：</span>
			<span class="inputDiv inputModifyDiv"><select id="wsmRegion" name="wsmRegion">
													<option value="1">北京</option>
													<option value="2">上海</option>
													<option value="3">天津</option>
													<option value="4">重庆</option>
													<option value="5">河北</option>
													<option value="6">山西</option>
													<option value="7">辽宁</option>
													<option value="8">吉林</option>
													<option value="9">黑龙江</option>
													<option value="10">江苏</option>
													<option value="11">浙江</option>
													<option value="12">安徽</option>
													<option value="13">福建</option>
													<option value="14">江西</option>
													<option value="15">山东</option>
													<option value="16">河南</option>
													<option value="17">湖北</option>
													<option value="18">湖南</option>
													<option value="19">广东</option>
													<option value="20">海南</option>
													<option value="21">四川</option>
													<option value="22">贵州</option>
													<option value="23">云南</option>
													<option value="24">陕西</option>
													<option value="25">甘肃</option>
													<option value="26">青海</option>
													<option value="27">台湾</option>
													<option value="28">内蒙古</option>
													<option value="29">西藏</option>
													<option value="30">广西</option>
													<option value="31">宁夏</option>
													<option value="32">新疆</option>
													<option value="33">香港</option>
													<option value="34">澳门</option>
													<option value="35">境外</option>
													</select></span>
		</div>

		<div class="addPointInputBox">
			<span class="inputTitle inputModifyTitle">是否境内：</span>
			<span class="inputDiv inputModifyDiv"><select id="wsmIsAbroad" name="wsmIsAbroad">
												<option selected="selected" value="0">境内</option>
												<option value="1">境外</option>
												</select></span>
		</div>
		</form>
	</div>
	<!-- addPointInput end -->

	<!-- submit start -->
	<div class="submitBox">
		<span class="submitBnt"><a onclick="submitNormalForm($('form')[0])" href="###"></a></span>
		<span class="returnBnt"><a id="backUrl" href="/systemManage/toSiteManage"></a></span>
	</div>
	<!-- submit end -->

<!-- submit success start -->
	<div class="restate" style="display:none;">
		<span><img src="/static/images/loading.gif" />&nbsp;</span>
	</div>
<!-- submit success end -->
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
