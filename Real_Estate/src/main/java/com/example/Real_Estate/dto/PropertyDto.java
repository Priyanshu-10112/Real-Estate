package com.example.Real_Estate.dto;

import com.example.Real_Estate.entity.PropertyStatus;
import com.example.Real_Estate.entity.PropertyType;
import com.example.Real_Estate.entity.User;
import jakarta.persistence.*;

public class PropertyDto {

    private Long price;
    private PropertyType propertyType;
    private PropertyStatus status;
    private String address;
    private String city;
    private String state;
    private String zipCode;
    private Double area;
    private String areaUnit;
    

    
    
    public PropertyDto(Long price, PropertyType propertyType, PropertyStatus status, String address, String city,
			String state, String zipCode, Double area, String areaUnit) {
		super();
		this.price = price;
		this.propertyType = propertyType;
		this.status = status;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zipCode = zipCode;
		this.area = area;
		this.areaUnit = areaUnit;
	}
    
	@Override
	public String toString() {
		return "PropertyDto [price=" + price + ", propertyType=" + propertyType + ", status=" + status + ", address="
				+ address + ", city=" + city + ", state=" + state + ", zipCode=" + zipCode + ", area=" + area
				+ ", areaUnit=" + areaUnit + "]";
	}

	public Double getArea() {
		return area;
	}

	public void setArea(Double area) {
		this.area = area;
	}

	public String getAreaUnit() {
		return areaUnit;
	}

	public void setAreaUnit(String areaUnit) {
		this.areaUnit = areaUnit;
	}

	public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    public PropertyType getPropertyType() {
        return propertyType;
    }

    public void setPropertyType(PropertyType propertyType) {
        this.propertyType = propertyType;
    }

    public PropertyStatus getStatus() {
        return status;
    }

    public void setStatus(PropertyStatus status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }
}
