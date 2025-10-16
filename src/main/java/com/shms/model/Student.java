package com.shms.model;

public class Student {
    private int id;
    private String rollNo;
    private String name;
    private String contact;
    private String address;
    private String feeStatus;
    private double totalFeePaid;

    // Updated constructor - initializes all fields used in your project
    public Student(int id, String rollNo, String name, String contact, String address, double totalFeePaid, String feeStatus) {
        this.id = id;
        this.rollNo = rollNo;
        this.name = name;
        this.contact = contact;
        this.address = address;
        this.totalFeePaid = totalFeePaid;
        this.feeStatus = feeStatus;
    }

    // No-argument (default) constructor
    public Student() {
        // No-argument constructor
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getRollNo() { return rollNo; }
    public void setRollNo(String rollNo) { this.rollNo = rollNo; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getFeeStatus() { return feeStatus; }
    public void setFeeStatus(String feeStatus) { this.feeStatus = feeStatus; }

    public double getTotalFeePaid() { return totalFeePaid; }
    public void setTotalFeePaid(double totalFeePaid) { this.totalFeePaid = totalFeePaid; }
}
