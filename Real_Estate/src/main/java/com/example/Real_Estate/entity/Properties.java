package com.example.Real_Estate.entity;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Properties {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false)
	private User user_id;
	@Column
	private Long price;
	@Enumerated(EnumType.STRING)
	@Column
	private PropertyType propertyType; 
	@Enumerated(EnumType.STRING)
	@Column
	private PropertyStatus status; 
	@Column
	private String address;
	@Column
	private String city;
	@Column
	private String state;
	@Column
	private String zipCode;
	@Column
	private Double area;
	@Column
	private String areaUnit;
	@Column
	private String image;
	
	
	public Properties(Long id, User user_id, Long price, PropertyType propertyType, PropertyStatus status,
			String address, String city, String state, String zipCode, Double area, String areaUnit,
			String image) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.price = price;
		this.propertyType = propertyType;
		this.status = status;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zipCode = zipCode;
		this.area = area;
		this.areaUnit = areaUnit;
		this.image = image;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	@Override
	public String toString() {
		return "Properties [id=" + id + "user_id="+user_id+", propertyType=" + propertyType
				+ ", status=" + status + ", address=" + address + ", city=" + city + ", state=" + state + ", zipCode="
				+ zipCode + ", price="+price+", area="+area+", areaUnit="+areaUnit+"]";
	}
	public Properties() {}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public User getUser_id() {
		return user_id;
	}
	public void setUser_id(User user_id) {
		this.user_id = user_id;
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
}
