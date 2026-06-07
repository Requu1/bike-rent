package com.bike_rent_potepa_patla.controller;

import com.bike_rent_potepa_patla.dto.rentPrice.RentPriceCreateDto;
import com.bike_rent_potepa_patla.dto.rentPrice.RentPriceResponseDto;
import com.bike_rent_potepa_patla.service.RentPriceHistService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@RestController
@RequestMapping("/api/rent-price-hist")
@RequiredArgsConstructor
public class RentPriceHistController {
    private final RentPriceHistService rentPriceHistService;


    @PostMapping
    public ResponseEntity<RentPriceResponseDto> changeRentPrice(@RequestBody RentPriceCreateDto dto){
        return ResponseEntity.ok(rentPriceHistService.changeRentPrice(dto));
    }

    @GetMapping("/total")
    public ResponseEntity<Integer> getRentTotalPrice(@RequestParam Integer rentId){
        return ResponseEntity.ok(rentPriceHistService.getRentTotalPrice(rentId));
    }

    @GetMapping("/avg-bike-rent-price")
    public ResponseEntity<BigDecimal> getAvgBikeRentPrice(@RequestParam Integer bikeId, @RequestParam LocalDate startDate,
                                                          @RequestParam LocalDate endDate){
        return ResponseEntity.ok(rentPriceHistService.getAvgBikeRentPrice(bikeId,startDate,endDate));
    }
}
