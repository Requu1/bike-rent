package com.bike_rent_potepa_patla.controller;

import com.bike_rent_potepa_patla.dto.bike.BikeCreateDto;
import com.bike_rent_potepa_patla.dto.bike.BikeResponseDto;
import com.bike_rent_potepa_patla.dto.bike.FilteredBikeDto;
import com.bike_rent_potepa_patla.service.BikeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/bikes")
@RequiredArgsConstructor
public class BikeController {
    private final BikeService bikeService;

    @PostMapping
    public ResponseEntity<BikeResponseDto> addBike(@RequestBody BikeCreateDto bikeCreateDto) {
        return ResponseEntity.ok(bikeService.addBike(bikeCreateDto));
    }

    @PatchMapping("/{bikeId}/add-quantity")
    public ResponseEntity<?> updateBikeQuantity(@PathVariable Integer bikeId, @RequestParam Integer quantity) {
        bikeService.addBikeQuantity(bikeId, quantity);
        return ResponseEntity.ok().build();
    }

    @GetMapping
    public ResponseEntity<List<FilteredBikeDto>> getFilteredBikes(@RequestParam(required = false) String categoryName,
                                                                  @RequestParam(required = false) String brandName) {
        return ResponseEntity.ok(bikeService.filterBikesByCategoryAndBrand(categoryName, brandName));
    }

}
