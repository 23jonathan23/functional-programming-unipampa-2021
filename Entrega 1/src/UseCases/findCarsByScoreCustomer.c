#define _GNU_SOURCE
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <Car.h>
#include <Customer.h>

#include <FileUtils.h>
#include <findCarsByScoreCustomer.h>

void findCarsByScoreCustomer(TCar *cars, TCustomer customer) {
    FILE *carList = loadFile("src\\Infra\\DataBase\\availableCars.txt");
    //continue
}