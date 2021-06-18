#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <carRental.h>

#include <car.h>
#include <customer.h>

#include <findCarsByScoreCustomer.h>

void execute() {
    TCar cars[100];
    TCustomer customer;

    customer.score = 6;
    
    findCarsByScoreCustomer(cars, customer);
}