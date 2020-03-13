package com.internship.ds.dao;

import com.internship.ds.model.Record;
import com.internship.ds.model.VericleInfo;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface RecordDao {

    @Select("select * from tab_record where username = #{username} ")
    List<Record> uSearch(@Param("username") String username);

    @Insert("insert into tab_record(vehicleId, departDate, backDate, level, event, username, name) " +
            "values(#{r.vehicleId},#{r.departDate},#{r.backDate},#{r.level},#{r.event},#{r.username},#{r.name}) ")
    void uInsert(@Param("r") Record record);


    @Update("update tab_record set  realDepartDate = #{r.realDepartDate}, status1 = 1 where id = #{r.id} ")
    void aUpdate(@Param("r") Record record);

    @Select("select * from tab_record where status1 = #{status1} ")
    List<Record> aSearch(@Param("status1") Integer status1);

    @Select("select * from tab_record ")
    List<Record> search();

    @Update("update tab_vehicle set status = 0 where id = #{id} ")
    void updateVehicle(@Param("id") String vehicleId);

    @Select("select status from tab_vehicle where id = #{vehicleId} ")
    int findStatus(@Param("vehicleId") String vehicleId);

    @Select("select name from tab_user where username = #{username} ")
    String findName(@Param("username") String username);


}
