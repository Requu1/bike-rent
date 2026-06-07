package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.model.RentPriceHist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Repository
public interface RentPriceHistRepository extends JpaRepository<RentPriceHist, Integer> {
    @Procedure(procedureName = "ChangeRentPrice_p")
    Integer changeRentPrice(@Param("bike_id_v")Integer bikeId,@Param("hourly_price_v")Integer hourlyPrice);

    @Query(value="SELECT AvgBikeRentPrice_f(:bikeId,:startDate,:endDate)",nativeQuery = true)
    BigDecimal avgBikeRentPrice(@Param("bikeId")Integer bikeId, @Param("startDate") LocalDateTime startDate, @Param("endDate")LocalDateTime endDate);

    @Query(value="SELECT RentalPrice_f(:rentId)")
    Integer getRentalPrice(@Param("rentId")Integer rentId);

    RentPriceHist findRentPriceHistById(Integer id);
}
