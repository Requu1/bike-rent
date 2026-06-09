package com.bike_rent_potepa_patla.service;

import com.bike_rent_potepa_patla.dto.rent.RentCreateDto;
import com.bike_rent_potepa_patla.repository.RentRepository;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;

import java.time.LocalDateTime;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class RentServiceTest {
    @Mock
    private RentRepository rentRepository;

    @InjectMocks
    private RentService rentService;

    @Test
    void shouldAllowOnlyOneRentWhenTwoCustomersTryToRentConcurrently() throws InterruptedException {
        // GIVEN
        int bikeId = 99;
        RentCreateDto customer1Request = new RentCreateDto(bikeId, 1);
        RentCreateDto customer2Request = new RentCreateDto(bikeId, 2);

        AtomicBoolean isBikeRented = new AtomicBoolean(false);

        when(rentRepository.addNewRent(eq(bikeId), anyInt())).thenAnswer(invocation -> {
            if (isBikeRented.compareAndSet(false, true)) {
                return 1;
            } else {
                throw new RuntimeException("Rower niedostępny - brak na stanie (Constraint Violation)");
            }
        });

        var mockRentEntity = mock(com.bike_rent_potepa_patla.model.Rent.class);
        when(mockRentEntity.getRentDate()).thenReturn(LocalDateTime.now());
        lenient().when(rentRepository.findRentById(1)).thenReturn(mockRentEntity);

        int numberOfThreads = 2;
        ExecutorService executorService = Executors.newFixedThreadPool(numberOfThreads);
        CountDownLatch readyLatch = new CountDownLatch(numberOfThreads);
        CountDownLatch startLatch = new CountDownLatch(1);
        CountDownLatch doneLatch = new CountDownLatch(numberOfThreads);

        AtomicInteger successCount = new AtomicInteger(0);
        AtomicInteger failureCount = new AtomicInteger(0);

        Runnable task1 = () -> {
            try {
                readyLatch.countDown();
                startLatch.await();
                rentService.addRent(customer1Request);
                successCount.incrementAndGet();
            } catch (Exception e) {
                failureCount.incrementAndGet();
            } finally {
                doneLatch.countDown();
            }
        };

        Runnable task2 = () -> {
            try {
                readyLatch.countDown();
                startLatch.await();
                rentService.addRent(customer2Request);
                successCount.incrementAndGet();
            } catch (Exception e) {
                failureCount.incrementAndGet();
            } finally {
                doneLatch.countDown();
        }
        };

        // WHEN
        executorService.submit(task1);
        executorService.submit(task2);

        readyLatch.await();
        startLatch.countDown();
        doneLatch.await();

        // THEN
        assertEquals(1, successCount.get(), "Tylko jedno wypożyczenie powinno się udać");
        assertEquals(1, failureCount.get(), "Jedno wypożyczenie powinno zostać odrzucone");

        verify(rentRepository, times(2)).addNewRent(eq(bikeId), anyInt());
        verify(rentRepository, times(1)).findRentById(anyInt());
    }

    @Test
    void shouldAllowOnlyOneReturnWhenTwoThreadsEndRentConcurrently() throws InterruptedException {
        // GIVEN
        Integer rentIdToReturn = 42;

        AtomicBoolean isAlreadyReturned = new AtomicBoolean(false);
        AtomicInteger simulatedBikeQuantity = new AtomicInteger(5);

        doAnswer(invocation -> {
            if (isAlreadyReturned.compareAndSet(false, true)) {
                simulatedBikeQuantity.incrementAndGet();
                return null;
            } else {
                throw new RuntimeException("To wypozyczenie zostalo zakonczone lub nie istnieje.");
            }
        }).when(rentRepository).endRent(rentIdToReturn);

        int numberOfThreads = 2;
        ExecutorService executorService = Executors.newFixedThreadPool(numberOfThreads);
        CountDownLatch readyLatch = new CountDownLatch(numberOfThreads);
        CountDownLatch startLatch = new CountDownLatch(1);
        CountDownLatch doneLatch = new CountDownLatch(numberOfThreads);

        AtomicInteger successCount = new AtomicInteger(0);
        AtomicInteger failureCount = new AtomicInteger(0);

        Runnable endRentTask = () -> {
            try {
                readyLatch.countDown();
                startLatch.await();
                rentService.endRent(rentIdToReturn);
                successCount.incrementAndGet();
            } catch (Exception e) {
                failureCount.incrementAndGet();
            } finally {
                doneLatch.countDown();
            }
        };

        // WHEN
        executorService.submit(endRentTask);
        executorService.submit(endRentTask);

        readyLatch.await();
        startLatch.countDown();
        doneLatch.await();

        // THEN
        assertEquals(1, successCount.get(), "Tylko jedna próba zwrotu powinna się udać.");
        assertEquals(1, failureCount.get(), "Druga próba zwrotu powinna rzucić wyjątek.");

        assertEquals(6, simulatedBikeQuantity.get(), "Ilość rowerów (quantity) powinna zwiększyć się tylko o 1.");
        verify(rentRepository, times(2)).endRent(rentIdToReturn);
    }

}