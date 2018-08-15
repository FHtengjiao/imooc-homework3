<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="UTF-8">
	<title>课程批量导入(Excel)</title>
	<link rel="stylesheet" href="../../../css/common.css" type="text/css">
	<link rel="stylesheet" href="../../../css/form_common.css" type="text/css">
	<link rel="stylesheet" href="../../../css/importCourse_special.css" type="text/css">
	<script src="../../../js/jquery-3.3.1.js"></script>
	<script src="../../../js/common.js"></script>
	<script>
        $(document).ready(function () {
            $("button").on("click",function () {
                $("#excel").trigger("click");
            });
            $("#excel").on("change", function () {
                var filepath = $("#excel").val().split("\\");
                var filename = filepath[filepath.length-1];
                if(confirm("确定上传"+ filename +"吗？")){
                    $(".error_msg").html("");
                    uploadexcel();
                }
                else {
                    $("#excel").val("");
                }
            });

            function uploadexcel() {
                var excel = $("#excel").prop("files")[0];
                var formData = new FormData();
                formData.append("excel", excel);
                $.ajax({
                    type: "post",
                    url: "CourseImport.do",
                    data: formData,
                    dataType: 'json',
                    processData: false,  // 注意：让jQuery不要处理数据
                    contentType: false,
                    success: function (data) {
                        console.log(data.result);
                        console.log(data.msg);
                        if (data.result === "success") {
                            location.assign("http://localhost:8080/GetCourse.do");
                            $(window.parent.document).find("a:eq(3)").removeClass("on");
                            $(window.parent.document).find("a:eq(4)").addClass("on");
                            localStorage.setItem("msg",data.msg);
                        } else {
                            $(".error_msg").html(data.msg);
                            $("#excel").val("");
                        }
                    }
                });
            }
        });
	</script>
</head>
<body>
<div class="header">
	<span>课程管理</span>>><span>课程批量导入(Excel)</span>>>
</div>
<div class="main_box">
	<div class="title">课程批量导入</div>
	<div class="error_msg">${msg}</div>
	<div class="form_box">
		<input type="file" style="display: none" id="excel" name="excel">
		<div class="file_btn">
			<button type="button"></button>
		</div>
	</div>
</div>
</body>
</html>