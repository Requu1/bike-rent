package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.dto.bike.FilteredBikeDto;
import com.bike_rent_potepa_patla.model.Bike;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BikeRepository extends JpaRepository<Bike,Long> {
    @Procedure(procedureName="AddBike_p")
    Long addNewBikeWithNewPriceHist
            (@Param("brandId_v")Long brandId,@Param("categoryId_v")Long categoryId,@Param("hourly_price_v")Integer hourlyPrice);

    @Procedure(procedureName="AddQuantity_p")
    void addBikeQuantity(@Param("quantity_v")int quantity,@Param("bikeID_v")Long bikeID);

    @Query(value="CALL FilterBike_p(:categoryName,:brandName)",nativeQuery = true)
    List<FilteredBikeDto> getBikesByCategoryAndBrand(@Param("categoryName_v")String categoryName, @Param("brandName_v")String brandName);
}
