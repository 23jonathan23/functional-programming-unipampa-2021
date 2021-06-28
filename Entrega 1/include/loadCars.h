#ifndef __LOADCARS__
#define __LOADCARS__

#include <car.h>
#include <rentedCar.h>

void loadCars(TCar *cars);

void loadRentedCars(TRentedCar rentedCars[]);

int getTotalAvailableCars();

int getTotalRentedCars();

#endif