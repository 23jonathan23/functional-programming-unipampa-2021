#ifndef __RENTCAR__
#define __RENTCAR__

#include <car.h>
#include <customer.h>

void removeFromAvailableCars(TCar cars[], TCar car);

void loadCars(TCar cars[], int size);

void addToRentedCars(TCar car, TCustomer customer);

void rentCar(TCar car, TCustomer customer);

#endif