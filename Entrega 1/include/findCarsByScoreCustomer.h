#ifndef __FINDCARS__
#define __FINDCARS__

#include <car.h>
#include <customer.h>

void findCarsByScoreCustomer(TCar *cars, TCustomer customer);

void findCarByPlate(TCar *car, TCustomer customer, char plate[10]);

#endif