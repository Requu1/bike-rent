package com.bike_rent_potepa_patla.controller;

import com.bike_rent_potepa_patla.dto.customer.CustomerCreateDto;
import com.bike_rent_potepa_patla.dto.customer.CustomerResponseDto;
import com.bike_rent_potepa_patla.dto.customer.FilteredCustomerDto;
import com.bike_rent_potepa_patla.service.CustomerService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/customers")
@RequiredArgsConstructor
public class CustomerController {
    private final CustomerService customerService;

    @PostMapping
    public ResponseEntity<CustomerResponseDto> addCustomer(@RequestBody CustomerCreateDto dto) {
        return ResponseEntity.ok(customerService.addCustomer(dto));
    }

    @GetMapping
    public ResponseEntity<FilteredCustomerDto> getFilteredCustomer(@RequestParam String phone) {
        return ResponseEntity.ok(customerService.getFilteredCustomer(phone));
    }
}
