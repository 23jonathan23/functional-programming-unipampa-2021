#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <carRental.h>

#include <car.h>
#include <customer.h>

#include <loadCars.h>

#include <findCarsByScoreCustomer.h>
#include <rentCar.h>

void execute() {
    int size = getTotalAvailableCars();
    TCar cars[size];
    TCustomer customer;

    customer.score = 6;
    strcpy(customer.document, "62346535423");
    
    findCarsByScoreCustomer(cars, customer);

    printf("%s \n", cars[4].model);

    rentCar(cars[0], customer);
}