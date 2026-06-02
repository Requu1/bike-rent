package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.model.Category;
import com.bike_rent_potepa_patla.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryService {
    private final CategoryRepository categoryRepository;

    Category findByName(String categoryName) {
        return categoryRepository.findByCategoryName(categoryName);
    }
}
