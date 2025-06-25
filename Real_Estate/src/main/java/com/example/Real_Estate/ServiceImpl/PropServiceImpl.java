package com.example.Real_Estate.ServiceImpl;

import java.util.List;
//import java.util.Optional;

import com.example.Real_Estate.dto.PropertyDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Real_Estate.Services.PropService;
import com.example.Real_Estate.entity.Properties;
import com.example.Real_Estate.repository.PropRepo;

@Service
public class PropServiceImpl implements PropService{
	@Autowired
	private PropRepo p1;

	@Override
	public Properties add(Properties p) {
		return p1.save(p);
	}

	@Override
	public List<Properties> findAllProperties() {
		return p1.findAll();
	}

	@Override
	public List<Properties> findByFilter(PropertyDto propertyDto) {
		List<Properties> prop=p1.findAllByFilter(propertyDto.getCity(),propertyDto.getAddress(),propertyDto.getStatus(),propertyDto.getPrice(), propertyDto.getPropertyType(),propertyDto.getArea(),propertyDto.getAreaUnit());
		return prop;
	}
	@Override
	public Properties findById(Long id){
		return p1.findById(id).get();
	}
	@Override
	public List<Properties> findByEmail(String email){
		return p1.findByEmail(email);
	}
	
	public void deleteById(Long id) {
		p1.deleteById(id);
	}

	public List<Object[]> countByPropertyTypeForAgent(String email) {
		return p1.countByPropertyTypeForAgent(email);
	}

	public List<Object[]> countByCityForAgent(String email) {
		return p1.countByCityForAgent(email);
	}

	public Properties updateProperty(Long id, Properties updated) {
		Properties existing = p1.findById(id).orElse(null);
		if (existing == null) return null;
		// Only update allowed fields
		existing.setPrice(updated.getPrice());
		existing.setPropertyType(updated.getPropertyType());
		existing.setStatus(updated.getStatus());
		existing.setZipCode(updated.getZipCode());
		existing.setArea(updated.getArea());
		existing.setAreaUnit(updated.getAreaUnit());
		if (updated.getImage() != null && !updated.getImage().isEmpty()) {
			existing.setImage(updated.getImage());
		}
		// Do NOT update address, city, state
		return p1.save(existing);
	}
}
