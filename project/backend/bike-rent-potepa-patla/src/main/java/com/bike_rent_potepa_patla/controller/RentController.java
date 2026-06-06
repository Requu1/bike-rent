package com.bike_rent_potepa_patla.controller;

import com.bike_rent_potepa_patla.dto.rent.RentCreateDto;
import com.bike_rent_potepa_patla.dto.rent.RentResponseDto;
import com.bike_rent_potepa_patla.dto.rent.RentsForCustomerDto;
import com.bike_rent_potepa_patla.service.RentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/rents")
@RequiredArgsConstructor
public class RentController {
    private final RentService rentService;

    @GetMapping
    public ResponseEntity<List<RentsForCustomerDto>> getRentsForCustomer(@RequestParam Integer customerId){
        return ResponseEntity.ok(rentService.getRentListForCustomer(customerId));
    }

    @GetMapping("/income")
    public ResponseEntity<Integer> getIncome(@RequestParam LocalDate startDate, @RequestParam LocalDate endDate){
        return ResponseEntity.ok(rentService.getIncome(startDate,endDate));
    }

    @PatchMapping("/{rentId}/end")
    public ResponseEntity<?> endRent(@PathVariable Integer rentId){
        rentService.endRent(rentId);
        return ResponseEntity.ok().build();
    }

    @PostMapping
    public ResponseEntity<RentResponseDto> addRent(@RequestBody RentCreateDto dto){
        return ResponseEntity.ok(rentService.addRent(dto));
    }
}
