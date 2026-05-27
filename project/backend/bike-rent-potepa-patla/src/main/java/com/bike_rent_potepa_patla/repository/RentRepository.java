package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.model.Rent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface RentRepository extends JpaRepository<Rent,Long> {
    @Procedure(name="AddRent_p")
    void addNewRent(@Param("bike_id_v")Long bikeId,@Param("customer_id_v")Long customerId);

    @Procedure(name="CurrentRentsForCustomer_p")
    void getCurrentRentsForCustomer(@Param("customerId_v")Long customerId);

    @Procedure(name="EndRent_p")
    void endRent(@Param("rent_id_v")Long rentId);

    @Query(value="SELECT Income_f(:startDate,:endDate)",nativeQuery = true)
    int getIncome(@Param("startDate") Date startDate,@Param("endDate")Date endDate);
}
