package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.dto.customer.CustomerCreateDto;
import com.bike_rent_potepa_patla.dto.customer.CustomerResponseDto;
import com.bike_rent_potepa_patla.model.Customer;
import com.bike_rent_potepa_patla.repository.CustomerRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomerService {
    private final CustomerRepository customerRepository;

    @Transactional
    public CustomerResponseDto addCustomer(CustomerCreateDto dto) {
        Long newCustomerId=customerRepository.addNewCustomer(dto.firstName(),dto.surrName(),dto.phone());
        return CustomerResponseDto.builder()
                .customerId(newCustomerId)
                .firstName(dto.firstName())
                .surrName(dto.surrName())
                .phone(dto.phone())
                .build();
    }
}
