package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.model.Brand;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BrandRepository extends JpaRepository<Brand,Long> {
    @Procedure(name="AddBrand_p")
    void addNewBrand(@Param("brandName_v")String brandName);

    Brand findByBrandName(String brandName);
}
