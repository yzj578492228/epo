<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../top.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>广州广报</title>
<script type="text/javascript" src="${ctx }/static/js/knowledge/ajaxfileupload.js"></script>
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
		<div class="navDiv"><a href="/mainMedia/index" >主流媒体舆情</a></div>
		<div class="navDiv"><a href="/warning/index" >舆情预警</a></div> 
		<div class="navDiv"><a href="/cityRecognize/index" >城市形象与认知度</a></div>
		<div class="navDiv"><a href="/leaderRecognition/index" >舆论领袖识别</a></div>
		<div class="navDiv act"><a href="/knowledgeDictLibManage/index" >知识库管理</a></div>
		<div class="navDiv"><a href="/systemManage/index" >系统管理</a></div>
	</div>
<!-- topNav end -->

<!-- table content start -->
	<div class="tableContent">
	<table cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top">
				<div class="tableContentLeft">
					<div class="navTitle"><a href="/knowledgeDictLibManage/index" >知识库概况</a></div>
					<div class="navSubTitle"><a href="/knowledgeDictLibManage/knowledgeDictLibManageLibManage" >词库管理</a></div>
					<div class="navSupTitle"><a href="/knowledgeDictLibManage/knowledgeDictLibManageToAddLib" ><span>添加词库</span></a></div>
					
					<div class="navSubTitle"><a href="/knowledgeDictLibManage/knowledgeDictLibManageItemManage" >词条管理</a></div>
					<div class="navSupTitle"><a href="/knowledgeDictLibManage/knowledgeDictLibManageToAddItem" ><span>添加词条</span></a></div>
					<div class="navSupTitle"><a class="act" href="/knowledgeDictLibManage/knowledgeDictLibManageUploadItem" ><span>导入词条</span></a></div>
				</div>
			</td>
			<td class="tdBak" valign="top">
				<div class="tableContentRight">
					<div class="currentPosition">
					&nbsp;&nbsp;&nbsp;&nbsp;当前位置：&nbsp;&nbsp;知识库管理&nbsp;>&nbsp;词条管理&nbsp;>&nbsp;导入词条
					</div>
				
				<!-- 页面内容 start -->
				
<!-- table content start -->
	
					
					<div class="systemSearch systemImport">
	
                      <form id="FORM" action="/knowledgeDictLibManage/uploadFile">
						<span class="systemSearchRight space2">
	                       <select name="parentId" id="parentId" class="select">
								<option value="">--</option>
								    <c:forEach var="lib" items="${listParentLib}">
								       <option value="${lib.id }" <c:if test="${parentId eq lib.id }"> selected="selected" </c:if>>${lib.name }</option>
								     </c:forEach>
							</select> 
						</span>
						<span class="systemSearchRight space2">
	 					     <select name="child" id="child" class="select">
	 					         <option value="">--</option>
	 					          <c:forEach var="lib" items="${listLib}">
								       <option value="${lib.id }" <c:if test="${id eq lib.id }"> selected="selected" </c:if>>${lib.name }</option>
								     </c:forEach>
	 					     </select>
						</span>
						<span class="input1"><input type="file" size="30" value="上传文件" name="excel" id="excel" /></span>
	                </form>
					</div>
					<div class="clear"></div>
					<div class="importPrompt"></div>
					
<!-- submit start -->
					<div class="submitBox">
						<span class="submitBnt importBnt"><a href="###" onclick="submitForm()"></a></span>
						<span class="returnBnt"><a href="/knowledgeDictLibManage/knowledgeDictLibManageItemManage"></a></span>
						

				
					</div>
<!-- submit end -->

<!-- submit success start -->
					<div class="restate" style="display:none">
						<span ><img src="${ctx}/static/images/loading.gif" /></span>
					</div>
<!-- submit success end -->

					<input type="hidden" id="getlist" value="/knowledgeDictLibManage/getChildrenLibList">

<script type="text/javascript">

//表单提交
function submitForm(){

	if($("form").find("input[type='file']").val()==""){
		$(".importPrompt").html("导入文件不能为空");
		return false;
	}
	
	var libselect = $("form").find("select");
	var postData={};
	if($(libselect[0]).val()=="" && $(libselect[1]).val()==""){
		alert("至少选择一个所属词库");
		return false;
	}
	postData[$(libselect[0]).attr("name")]=$(libselect[0]).val();
	postData[$(libselect[1]).attr("name")]=$(libselect[1]).val();
	alert(postData["parentId"]);
	//文件开始上传
	 $.ajaxFileUpload({

		url:$("form").attr("action"), //需要链接到服务器地址
		type: 'post',
		data: postData,
		secureuri:false,

		fileElementId:'excel', //文件选择框的id属性

		dataType: 'json', //服务器返回的格式，可以是json
    
		success: function(data) //相当于java中try语句块的用法
		{ 
			alert("nimei");
			if(data.error){
				alert("error");
				$(".importPrompt").html(data.error);
			}
			else{//文件上传成功后，把POST的表单数据也同时提交
alert("开始进行解析");
				var postData={};

				var objLabel = $("form").find('select');

				for(var i=0;i<objLabel.length;i++){
					postData[$(objLabel[i]).attr("name")] = $(objLabel[i]).val();	
				}

				postData['path']=data.path;
				postData['name']=data.name;
				postData['hz']=data.hz;
				
				$.ajax({url:$("form").attr("action"),  
					type: 'post',
					async: false,
					data: postData,
					dataType:'json',
					success: function(msg)
					{
						if(msg.error){
							
							$(".restate span").html("<img src=\"${ctx}/images/loading.gif\" />");
							$(".importPrompt").html();
							$(".restate span").append(msg.data);
							$(".restate").css("display","block");
						}else{
							
							$(".restate span").html("<img src=\"${ctx}/images/loading.gif\" />");
							$(".importPrompt").html();
							$(".restate span").append(msg.data);
							$(".restate").css("display","block");
						}

						setInterval("$('.restate').css('display','none')",5000);
					}
				});  
			}
		}
	});

}

//2级节点切换
$('#parentId').change(function() {
	var options = "<option value=\"\">" + "--" + "</option>";
	if($('#parentId').val()==""){
		$("#child").html(options); // 数据插入到子分类下拉表！
	}else{
		$.ajax({url:$("#getlist").val(),  //获取子分类的URL
				type: 'get',
				async: false,
				data: {id:$('#parentId').val()},
				success: function(msg)
				{
					for(var n=0; n<msg.length; n++){
						options += "<option value=" + msg[n].id+ ">" + msg[n].name + "</option>"; //遍历赋值
					}
					$("#child").html(options); // 数据插入到子分类下拉表！
				}
         });
	}
 });

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
