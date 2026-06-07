package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.dto.customer.FilteredCustomerDto;
import com.bike_rent_potepa_patla.model.Customer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CustomerRepository extends JpaRepository<Customer,Long> {
    @Procedure(procedureName="AddCustomer_p")
    Integer addNewCustomer
            (@Param("firstname_v")String firstname,@Param("surrname_v")String lastname,@Param("phone_v")String phone);

    @Query(value="CALL FilterCustomer_p(:customerPhone)",nativeQuery = true)
    FilteredCustomerDto filterCustomerByPhone(@Param("customerPhone")String phone);
}
