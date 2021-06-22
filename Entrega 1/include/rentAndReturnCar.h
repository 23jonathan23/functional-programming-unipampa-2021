#ifndef __RENTCAR__
#define __RENTCAR__

#include <car.h>
#include <customer.h>
#include <stdbool.h>

void addToRentedCars(TCar car, TCustomer customer);
bool removeFromAvailableCars(TCar cars[], TCar car);
void loadCars(TCar cars[], int size);
void addToRentedCars(TCar car, TCustomer customer);

#endif