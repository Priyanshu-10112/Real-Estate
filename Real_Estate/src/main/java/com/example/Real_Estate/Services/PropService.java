package com.example.Real_Estate.Services;


import java.util.List;

import com.example.Real_Estate.dto.PropertyDto;
import com.example.Real_Estate.entity.Properties;

public interface PropService {
	public Properties add(Properties p);
	public List<Properties> findAllProperties();
	public List<Properties> findByFilter(PropertyDto propertyDto);
	public Properties findById(Long id);
}
