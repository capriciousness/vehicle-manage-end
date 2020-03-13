var printArr=new Array();//打印错误
var errElement=document.querySelectorAll(".err-tips");
var checkFlag=[0,0,0];//注册判断，前端正则验证时要用
printArr=[
    "",
    "用户名由数字或字母或下划线组成的6到16位的字符串",
    "姓名为2-5个汉字",
    "请输入正确的11位数字",
    "密码为6位字母或数字的组合",
];
function submitOrNot(){
    for(var i=0;i<checkFlag.length;i++){
        if(checkFlag[i]==0||checkFlag[i]==1)
        {
            alert('请填写正确的信息');
            return false;
        }
    }
    return true;
}
window.onload=function(){
    $('#userName').on('blur',function(){
        var myreg=/^\w{6,16}$/;
        if(!myreg.test(this.value)){
            checkFlag[0]=1;//错误
            errElement[0].innerHTML=printArr[1];
        }
        else{
            checkFlag[0]=2;//正确
            errElement[0].innerHTML=printArr[0];
        }
    });
    $('#realName').on('blur',function(){
        var myreg=/^[\u4E00-\u9FA5]{2,5}$/;
        if(!myreg.test(this.value)){
            checkFlag[1]=1;//错误
            errElement[1].innerHTML=printArr[2];
        }
        else{
            checkFlag[1]=2;//正确
            errElement[1].innerHTML=printArr[0];
        }
    });
    $('#userPhone').on('blur',function(){
        var myreg=/(^1[3|4|5|7|8|9]\d{9}$)|(^09\d{8}$)/;
        if(!myreg.test(this.value)){
            checkFlag[2]=1;//错误
            errElement[2].innerHTML=printArr[3];
        }
        else{
            checkFlag[2]=2;//正确
            errElement[2].innerHTML=printArr[0];
        }
    });
    $('#password').on('blur',function(){
        var myreg=/^[0-9A-Za-z]{6}$/
        if(!myreg.test(this.value)){
            checkFlag[3]=1;//错误
            errElement[3].innerHTML=printArr[4];
        }
        else{
            checkFlag[3]=2;//正确
            errElement[3].innerHTML=printArr[0];
        }
    });
    //登录时ajax请求
    $("#submit-login").on('click',function(){
        var username=$('#user-login').val();
        var password=$('#psw-login').val();
        // var ifcheck=document.getElementById("ifCheck").checked;
        // console.log(ifcheck);
        console.log(username,password);
         var meta_data = {"username":username, "password":password};
        // var meta_data = {"username":username', "password":'+password+'};
        $.ajax({
            type:'POST',
            dataType :'JSON',
            contentType: 'application/json',
            url:'http://localhost:10010/zccar/staff/login',
            data:JSON.stringify(meta_data),
            // xhrFields: {
            //     withCredentials: true
            // },
            crossDomain: true,
            success:function(data){
                if(data.errorCode == 0){
                    setCookie("username", data.data.name)
                    setCookie("role", data.data.role)
                    window.location.href="./index.html";
                }
                else{
                    alert(data.error);
                }
    
            },
            error:function(err){
                console.log(err);
            }
        })
    })
    //注册时ajax请求
    $("#userSubmit111").on('click',function(){
        var userName=$('#userName').val();
        var password=$('#password').val();
        var userPhone=$('#userPhone').val();
        var realName=$('#realName').val();
        //alert(userName);
        $.ajax({
            type:'POST',
            dataType :'JSON',
            contentType: 'application/json',
            url:'http://localhost:10010/zccar/staff/register',
            data:JSON.stringify({
                user:{
                    username:userName,
                    password:password,
                    name:realName,
                    phone:userPhone
                }
            }),
            // xhrFields: {
            //     withCredentials: true
            // },
            crossDomain: true,
            success:function(data){
                // console.log(data);
                if(data.errorCode == 0){
                    alert('注册成功');
                    window.location.href="./login.html";
                }
                else{
                    alert('注册失败');
                    //alert(data.error);
                }
    
            },
            error:function(err){
                alert('注册失败');
                console.log(err);
            }
    
        })
    })
}