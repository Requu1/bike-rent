package com.bike_rent_potepa_patla.repository;

import com.bike_rent_potepa_patla.dto.views.*;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.DataClassRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ViewRepository {
    private final JdbcTemplate jdbcTemplate;

    public List<ViewActiveRentsDto> viewActiveRents() {
        String sql = "select * from view_active_rents";
        return jdbcTemplate.query(sql,new DataClassRowMapper<>(ViewActiveRentsDto.class));
    }

    public List<ViewBestSellersDto> viewBestSellers() {
        String sql = "select * from view_bestsellers";
        return jdbcTemplate.query(sql,new DataClassRowMapper<>(ViewBestSellersDto.class));
    }

    public List<ViewBestSellingBrandsDto> viewBestSellingBrands() {
        String sql = "select * from view_bestselling_brands";
        return jdbcTemplate.query(sql, new DataClassRowMapper<>(ViewBestSellingBrandsDto.class));
    }

    public List<ViewBikeStockDto> viewBikeStock() {
        String sql = "select * from view_bike_stock";
        return jdbcTemplate.query(sql, new DataClassRowMapper<>(ViewBikeStockDto.class));
    }

    public List<ViewCustomersDto> viewCustomers(){
        String sql = "select * from view_customers";
        return jdbcTemplate.query(sql, new DataClassRowMapper<>(ViewCustomersDto.class));
    }

    public List<ViewMostRentedCategoryDto> viewMostRentedCategory(){
        String sql = "select * from view_most_rented_category";
        return jdbcTemplate.query(sql, new DataClassRowMapper<>(ViewMostRentedCategoryDto.class));
    }

    public List<ViewHistPriceDto> viewHistPrice(){
        String sql = "select * from view_hist_price";
        return jdbcTemplate.query(sql, new DataClassRowMapper<>(ViewHistPriceDto.class));
    }

    public List<ViewHistRentsDto> viewHistRents(){
        String sql = "select * from view_hist_rents";
        return jdbcTemplate.query(sql, new DataClassRowMapper<>(ViewHistRentsDto.class));
    }

    public List<ViewBrandsDto> viewBrands(){
        String sql = "select * from view_brands";
        return jdbcTemplate.query(sql, new DataClassRowMapper<>(ViewBrandsDto.class));
    }

    public List<ViewCategoriesDto> viewCategories(){
        String sql = "select * from view_categories";
        return jdbcTemplate.query(sql, new DataClassRowMapper<>(ViewCategoriesDto.class));
    }
}
