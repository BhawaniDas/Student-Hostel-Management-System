package com.shms.model;

import java.util.Date;

public class FeePayment {
    private int id;
    private int studentId;
    private double amount;
    private Date paymentDate;
    private String remarks;
    private String feeStatus; // "Paid" or "Pending"

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getStudentId() {
        return studentId;
    }
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }
    public Date getPaymentDate() {
        return paymentDate;
    }
    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }
    public String getRemarks() {
        return remarks;
    }
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
    public String getFeeStatus() {
        return feeStatus;
    }
    public void setFeeStatus(String feeStatus) {
        this.feeStatus = feeStatus;
    }
}
