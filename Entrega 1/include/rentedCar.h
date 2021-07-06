#ifndef __RENTEDCAR_H__
#define __RENTEDCAR_H__

#include <car.h>

typedef struct RentedCar{
    TCar car;
    char cpf[11];
    long seconds;
}TRentedCar;

#endif