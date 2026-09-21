package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.dto.rent.RentsForCustomerDto;
import com.bike_rent_potepa_patla.model.Rent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface RentRepository extends JpaRepository<Rent, Integer> {
    @Procedure(procedureName = "AddRent_p")
    Integer addNewRent(@Param("bike_id_v") Integer bikeId, @Param("customer_id_v") Integer customerId);

    @Query(value = "CALL CurrentRentsForCustomer_p(:customerId)", nativeQuery = true)
    List<RentsForCustomerDto> getCurrentRentsForCustomer(@Param("customerId") Integer customerId);

    @Procedure(procedureName = "EndRent_p")
    void endRent(@Param("rent_id_v") Integer rentId);

    @Query(value = "SELECT Income_f(:startDate,:endDate)", nativeQuery = true)
    Integer getIncome(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate);

    Rent findRentById(Integer id);
}
