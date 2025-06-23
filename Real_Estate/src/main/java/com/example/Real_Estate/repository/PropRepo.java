package com.example.Real_Estate.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.Real_Estate.entity.Properties;
import com.example.Real_Estate.entity.PropertyStatus;
import com.example.Real_Estate.entity.PropertyType;

@Repository
public interface PropRepo extends JpaRepository<Properties,Long>{
    @Query("select p from Properties p where " +
            "(:city is null or LOWER(p.city) LIKE LOWER(CONCAT('%', :city, '%'))) and " +
            "(:address is null or LOWER(p.address) LIKE LOWER(CONCAT('%', :address, '%'))) and " +
            "(:status is null or p.status = :status) and " +
            "(:price is null or p.price <= :price) and " +
            "(:propertyType is null or p.propertyType = :propertyType) and " +
            "(:area is null or p.area = :area) and " +
            "(:areaUnit is null or p.areaUnit = :areaUnit)")
    List<Properties> findAllByFilter(
        @Param("city") String city,
        @Param("address") String address,
        @Param("status") PropertyStatus status,
        @Param("price") Long price,
        @Param("propertyType") PropertyType propertyType,
        @Param("area") Double area,
        @Param("areaUnit") String areaUnit
    );

    @Query("SELECT p FROM Properties p WHERE p.user_id.email = :email")
    List<Properties> findByEmail(@Param("email") String email);

    @Query("SELECT p.propertyType, COUNT(p) FROM Properties p WHERE p.user_id.email = :email GROUP BY p.propertyType")
    List<Object[]> countByPropertyTypeForAgent(@Param("email") String email);

    @Query("SELECT p.city, COUNT(p) FROM Properties p WHERE p.user_id.email = :email GROUP BY p.city")
    List<Object[]> countByCityForAgent(@Param("email") String email);
}