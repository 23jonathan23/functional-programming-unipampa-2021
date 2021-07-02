#ifndef __LOADCARS__
#define __LOADCARS__

#include <car.h>
#include <rentedCar.h>
#include <stdbool.h>

void loadCars(TCar *cars);

bool isCarRented(char plate[]);

void getRentedCar(char plate[], TRentedCar *car);

void loadRentedCars(TRentedCar rentedCars[]);

int getTotalAvailableCars();

int getTotalRentedCars();

#endif