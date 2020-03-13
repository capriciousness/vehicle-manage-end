//车辆台账页面交互处理，共两个按钮，一个查看所有台账数据，不能进行审核操作
//一个查看待审核数据，可以进行审核操作
/*function deltable(nowTr){//删除表格特定某行
    $(nowTr).parents('tr').remove()
}*/

window.onload=function(){
    var vehicleTbody=document.getElementById("vehicleTable");
    $(document).ready(function (){
        $("#this_role").html(getCookie("role"))     // 更新欢迎语
        $("#this_username").html(getCookie("username"))

    })
    $(document).on("click","#vehicleDisAll",function(){//获取所有数据
        $("tr").remove(".doDele");
        console.log("bbb");
        $.ajax({
            type:'POST',
            dataType :'JSON',
            contentType: "application/json",
            url:'http://localhost:10010/zccar/record/asearch',
            data:JSON.stringify({
                status1: 2
            }),
            // xhrFields: {
            //     withCredentials: true
            // },
            crossDomain: true,
            success:function(data){
                console.log(data)
                if(data.errorCode == 0){
                   // window.location.href="./index.html";
                    console.log(data)
                    if(data.data){
                        var str="";
                        var data=data.data;//因为返回的数据格式不确定，可能有问题，调试的时候可能需要修改
                        for(i in data){
                            str+="<tr class='doDele'>"+
                            "<td id='data'>"+data[i].id+"</td>"+
                            "<td id='vehicleId'>"+data[i].vehicleId+"</td>"+
                            "<td>"+data[i].departDate+"</td>"+
                            "<td>"+data[i].backDate+"</td>"+
                            "<td>"+data[i].level+"</td>"+
                            "<td>"+data[i].event+"</td>"+
                            "<td>"+data[i].realDepartDate+"</td>"+
                            "<td>"+data[i].realBackDate+"</td>"+
                            "<td>"+data[i].timeout+"</td>"+
                            "<td>"+data[i].username+"</td>"+
                            "<td>"+data[i].name+"</td>";
                            if(data[i].status1==0){
                                str+="<td>待审核</td>";
                            }
                            else{
                                str+="<td>已处理</td>"
                            }
                            str+="<td>禁止操作</td>";
                            str+="</tr>";
                        }
                        $("#vehicleTable").append(str);
                        // vehicleTbody.innerHTML=str;
                    }
                }
                else{
                    //alert(data.error);
                }
    
            },
            error:function(err){
    
            }
        })
    })

    $(document).on("click","#vehicleDispatch",function(){//待审核的数据操作
        $("tr").remove(".doDele");
        console.log("aaa");
        $.ajax({
            type:'POST',
            dataType :'JSON',
            contentType: "application/json",
            url:'http://localhost:10010/zccar/record/asearch',
            data:JSON.stringify({
                status1: 0
            }),
            // xhrFields: {
            //     withCredentials: true
            // },
            crossDomain: true,
            success:function(data){
                if(data.errorCode == 0){
                    // window.location.href="./index.html";
                    console.log(data)
                    if(data.data){
                        var str="";
                        var data=data.data;//因为返回的数据格式不确定，可能有问题，调试的时候可能需要修改
                        for(i in data){
                            str+="<tr class='doDele'>"+
                                "<td id='data'>"+data[i].id+"</td>"+
                                "<td id='vehicleId'>"+data[i].vehicleId+"</td>"+
                                "<td>"+data[i].departDate+"</td>"+
                                "<td>"+data[i].backDate+"</td>"+
                                "<td>"+data[i].level+"</td>"+
                                "<td>"+data[i].event+"</td>"+
                                "<td>"+data[i].realDepartDate+"</td>"+
                                "<td>"+data[i].realBackDate+"</td>"+
                                "<td>"+data[i].timeout+"</td>"+
                                "<td>"+data[i].username+"</td>"+
                                "<td>"+data[i].name+"</td>";
                            if(data[i].status1==0){
                                str+="<td>待审核</td>";
                            }
                            else{
                                str+="<td>已处理</td>"
                            }
                            str+="<td>"+'<button class="manage-allow" >处理</button>'+"</td>";
                            str+="</tr>";
                        }
                        $("#vehicleTable").append(str);
                        // vehicleTbody.innerHTML=str;
                    }
                }
                else{
                    //alert(data.error);
                }

            },
            error:function(err){

            }
        })

    })

    //<button class="manage-allow" onclick="deltable dealWithVehicle(id,vehicleId,nowTr)">处理</button>
    $(document).on("click",".manage-allow",function () {
        var id = $(this).parents("tr").children("td#data").text();
        var vehicleId = $(this).parents("tr").children("td#vehicleId").text();
        //console.log(id);
        $.ajax({
            type:'POST',
            dataType:'JSON',
            contentType: "application/json",
            url:'http://localhost:10010/zccar/record/updateRecord',
            data:JSON.stringify({
                record:{
                    id:id,
                    vehicleId:vehicleId
                }
            }),
            crossDomain: true,
            success:function(data){
                console.log("aaa");
            } ,
            error:function(){
                //$(this).parents('tr').remove()
            }

        })
        $(this).parents('tr').remove();
        //$(nowTr).parents('tr').remove()
    })


}