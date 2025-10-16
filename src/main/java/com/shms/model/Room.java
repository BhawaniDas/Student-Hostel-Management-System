package com.shms.model;

public class Room {
    private int id;
    private String roomNo;
    private String floor;
    private int capacity;
    private int occupancy; // <- Add this line

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getRoomNo() { return roomNo; }
    public void setRoomNo(String roomNo) { this.roomNo = roomNo; }

    public String getFloor() { return floor; }
    public void setFloor(String floor) { this.floor = floor; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    // Getter and Setter for occupancy
    public int getOccupancy() { return occupancy; }
    public void setOccupancy(int occupancy) { this.occupancy = occupancy; }
}
