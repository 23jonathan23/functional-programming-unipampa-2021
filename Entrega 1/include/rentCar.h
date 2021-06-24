#ifndef __RENTCAR__
#define __RENTCAR__

#include <car.h>
#include <customer.h>

void removeFromAvailableCars(TCar car);

void addToRentedCars(TCar car, TCustomer customer);

void rentCar(TCar car, TCustomer customer);

#endif