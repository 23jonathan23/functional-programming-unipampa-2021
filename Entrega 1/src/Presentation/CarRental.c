#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <CarRental.h>

#include <Car.h>
#include <Customer.h>

#include <findCarsByScoreCustomer.h>

void execute() {
    TCar cars[100];
    TCustomer customer;
    
    findCarsByScoreCustomer(cars, customer);
}