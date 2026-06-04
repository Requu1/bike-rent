package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.model.RentPriceHist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface RentPriceHistRepository extends JpaRepository<RentPriceHist, Long> {
    @Procedure(name="ChangeRentPrice_p")
    void changeRentPrice(@Param("bike_id_v")Long bikeId,@Param("hourly_price_v")int hourlyPrice);

    @Query(value="SELECT AvgBikeRentPrice_f(:bikeId,:startDate,:endDate)",nativeQuery = true)
    int avgBikeRentPrice(@Param("bikeId")Long bikeId, @Param("startDate") Date startDate, @Param("endDate")Date endDate);

    @Query(value="SELECT RentalPrice_f(:rentId)")
    int getRentalPrice(@Param("rentId")Long rentId);

    RentPriceHist findRentPriceHistById(Long id);
}
