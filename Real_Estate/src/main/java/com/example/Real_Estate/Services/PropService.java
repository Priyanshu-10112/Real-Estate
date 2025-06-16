package com.example.Real_Estate.Services;

import java.util.List;

import com.example.Real_Estate.dto.PropertyDto;
import com.example.Real_Estate.entity.Properties;

public interface PropService {

	Properties add(Properties p);

	List<Properties> findAllProperties();

	List<Properties> findByFilter(PropertyDto propertyDto);

	Properties findById(Long id);

	List<Properties> findByEmail(String email);

}
