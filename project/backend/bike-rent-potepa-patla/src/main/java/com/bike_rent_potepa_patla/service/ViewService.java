package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.dto.views.*;
import com.bike_rent_potepa_patla.repository.ViewRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class ViewService {
    private final ViewRepository viewRepository;

    public List<ViewActiveRentsDto> viewActiveRents() {
        return viewRepository.viewActiveRents();
    }

    public List<ViewBestSellersDto> viewBestSellers() {
        return viewRepository.viewBestSellers();
    }

    public List<ViewBestSellingBrandsDto> viewBestSellingBrands() {
        return viewRepository.viewBestSellingBrands();
    }

    public List<ViewBikeStockDto> viewBikeStock() {
        return viewRepository.viewBikeStock();
    }

    public List<ViewCustomersDto> viewCustomers() {
        return viewRepository.viewCustomers();
    }

    public List<ViewMostRentedCategoryDto> viewMostRentedCategory() {
        return viewRepository.viewMostRentedCategory();
    }

    public List<ViewHistPriceDto> viewHistPrice() {
        return viewRepository.viewHistPrice();
    }

    public List<ViewHistRentsDto> viewHistRents() {
        return viewRepository.viewHistRents();
    }

    public List<ViewBrandsDto> viewBrands() {
        return viewRepository.viewBrands();
    }

    public List<ViewCategoriesDto> viewCategories() {
        return viewRepository.viewCategories();
    }
}
