#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <car.h>
#include <customer.h>

#include <fileUtils.h>
#include <loadCars.h>
#include <customerHasScoreToRentThisCar.h>

#include <findCarsByScoreCustomer.h>

void findCarsByScoreCustomer(TCar *cars, TCustomer customer) {

    int size = getTotalAvailableCars();
    TCar carList[size];
    
    loadCars(carList);

    int availableCarsCount = 0;
    for(int i = 0; i < size; i++) {
       if(customerHasScoreToRentThisCar(customer.score, carList[i].category)) {
            memcpy(cars[availableCarsCount].plate, carList[i].plate, sizeof carList[i].plate);
            memcpy(cars[availableCarsCount].brand, carList[i].brand, sizeof carList[i].brand);
            memcpy(cars[availableCarsCount].model, carList[i].model, sizeof carList[i].model);

            cars[availableCarsCount].year = carList[i].year;
            cars[availableCarsCount].mileage = carList[i].mileage;
            cars[availableCarsCount].category = carList[i].category;

            availableCarsCount++;
       }
    }
}