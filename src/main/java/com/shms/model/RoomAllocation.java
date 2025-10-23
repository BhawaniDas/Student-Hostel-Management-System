package com.shms.model;

import java.util.Date;

public class RoomAllocation {
    private int id;
    private int roomId;
    private int studentId;
    private Date dateFrom;
    private Date dateTo;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public Date getDateFrom() { return dateFrom; }
    public void setDateFrom(Date dateFrom) { this.dateFrom = dateFrom; }

    public Date getDateTo() { return dateTo; }
    public void setDateTo(Date dateTo) { this.dateTo = dateTo; }
}
