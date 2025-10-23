package com.shms.model;

import java.util.Date;

public class LeaveApplication {
    private int id;
    private String reason;
    private Date fromDate;
    private Date toDate;
    private String status;
    private String guardianNumber;
    private String rollNo;
    private String remarks; // remarks can be null when leave is pending

    // Constructors
    public LeaveApplication() {}

    public LeaveApplication(int id, String reason, Date fromDate, Date toDate,
                            String status, String guardianNumber, String rollNo, String remarks) {
        this.id = id;
        this.reason = reason;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.status = status;
        this.guardianNumber = guardianNumber;
        this.rollNo = rollNo;
        this.remarks = remarks;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public Date getFromDate() { return fromDate; }
    public void setFromDate(Date fromDate) { this.fromDate = fromDate; }

    public Date getToDate() { return toDate; }
    public void setToDate(Date toDate) { this.toDate = toDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getGuardianNumber() { return guardianNumber; }
    public void setGuardianNumber(String guardianNumber) { this.guardianNumber = guardianNumber; }

    public String getRollNo() { return rollNo; }
    public void setRollNo(String rollNo) { this.rollNo = rollNo; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }
}