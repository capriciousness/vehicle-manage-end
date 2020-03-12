package com.internship.ds.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class Record {
    private Integer id;
    private String vehicleId;
    @JsonFormat( pattern="yyyy-MM-dd HH:mm",timezone="GMT+8")
    private Date departDate;
    @JsonFormat( pattern="yyyy-MM-dd HH:mm",timezone="GMT+8")
    private Date backDate;
    private String level;
    private String event;
    private Integer status1;
    @JsonFormat( pattern="yyyy-MM-dd HH:mm",timezone="GMT+8")
    private Date realDepartDate;
    @JsonFormat( pattern="yyyy-MM-dd HH:mm",timezone="GMT+8")
    private Date realBackDate;
    private Integer status2;
    private String timeout;
    private String username;
    private String name;

}
