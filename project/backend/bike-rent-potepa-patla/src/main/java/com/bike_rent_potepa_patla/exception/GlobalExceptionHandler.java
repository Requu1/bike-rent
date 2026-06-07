package com.bike_rent_potepa_patla.exception;

import com.bike_rent_potepa_patla.dto.error.ErrorResponseDto;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(BrandNotFoundException.class)
    public ResponseEntity<?> brandNotFoundException(BrandNotFoundException e){
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
    }

    @ExceptionHandler(CategoryNotFoundException.class)
    public ResponseEntity<?> categoryNotFoundException(CategoryNotFoundException e){
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
    }

    @ExceptionHandler(DataAccessException.class)
    public ResponseEntity<ErrorResponseDto> handleDatabaseExceptions(DataAccessException ex) {
        String errorMessage = ex.getMostSpecificCause().getMessage();
        ErrorResponseDto error = ErrorResponseDto.builder()
                .errorName("DATABASE_ERROR")
                .errorMsg(errorMessage)
                .build();
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
    }

    @ExceptionHandler(InvalidPhoneException.class)
    public ResponseEntity<?> invalidPhoneException(InvalidPhoneException e){
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
    }
}
