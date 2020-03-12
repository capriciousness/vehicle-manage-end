package com.internship.ds.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.internship.ds.dao.RecordDao;
import com.internship.ds.dao.VericleInfoManageDao;
import com.internship.ds.exceptionAOP.enums.ExceptionEnums;
import com.internship.ds.exceptionAOP.exception.ZcException;
import com.internship.ds.model.Record;
import com.internship.ds.model.User;
import com.internship.ds.model.VericleInfo;
import lombok.val;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
public class RecordService {
    @Autowired
    private RecordDao recordDao;

    public void application(String request, ServletRequest servletRequest) {
        val p = Objects.requireNonNull(JSON.parseObject(request));
        JSONObject json = Objects.requireNonNull(p.getJSONObject("record"));
        Record record = JSONObject.toJavaObject(json, Record.class);
        //此处需要调用车辆管理的查询车辆状态方法
        int status = recordDao.findStatus(record.getVehicleId());
        if(status == 0){
            throw new ZcException(ExceptionEnums.NOTALLOWED);
        }
        val httpRequest = (HttpServletRequest)servletRequest;
        val session = httpRequest.getSession(true);
        String username = (String)session.getAttribute("username");
        record.setUsername(username);
        String name = recordDao.findName(username);
        record.setName(name);
        recordDao.uInsert(record);

    }

    public JSONObject usearch(ServletRequest servletRequest) {
        val httpRequest = (HttpServletRequest)servletRequest;
        val session = httpRequest.getSession(true);

        String username = (String)session.getAttribute("username");
        //username = "zhangsan";
        List<Record> list = recordDao.uSearch(username);
        // 返回记录数据集合
        return new JSONObject().fluentPut("data",list);
    }

    public JSONObject asearch(String request, ServletRequest servletRequest) {
        JSONObject json = Objects.requireNonNull(JSON.parseObject(request));
        Integer status1 = Integer.parseInt(json.getString("status1"));
        List<Record> list;
        if(status1 == 0){
            list = recordDao.aSearch(status1);
        }else{
            list = recordDao.search();
        }
        // 返回记录数据集合
        return new JSONObject().fluentPut("errorCode",0).fluentPut("data",list);
    }

    public void updateRecord(ServletRequest servletRequest, String request) {
        val p = Objects.requireNonNull(JSON.parseObject(request));
        JSONObject json = Objects.requireNonNull(p.getJSONObject("record"));
        Record record = JSONObject.toJavaObject(json, Record.class);
        record.setRealDepartDate(new Date());
        int status = recordDao.findStatus(record.getVehicleId());
        if(status == 0){
            throw new ZcException(ExceptionEnums.NOTALLOWED);
        }
        recordDao.aUpdate(record);
        recordDao.updateVehicle(record.getVehicleId());

    }
}
