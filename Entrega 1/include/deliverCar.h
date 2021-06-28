#ifndef __DELIVERCAR__
#define __DELIVERCAR__

#include <car.h>
#include <customer.h>

float returnCar(TCar car, float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers);

void returnToAvailableCars(TCar car, int quilometers);

float removeFromRentedCars(TCar car, float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers);

void addPoints(TRentedCar rentedCar, int quilometers);

float calculatePrice(float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers, TRentedCar rentedCar);

#endif