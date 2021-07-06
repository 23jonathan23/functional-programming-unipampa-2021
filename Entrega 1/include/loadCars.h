#ifndef __LOADCARS__
#define __LOADCARS__

#include <car.h>
#include <rentedCar.h>
#include <stdbool.h>

/* Função responsável por carregar em uma matriz todos os carros disponiveis registrados*/
void loadCars(TCar *cars);

/* Função que valida se um carro está alugado ou não*/
bool isCarRented(char plate[]);

/* Função responsável por encontrar um carro alugado pela sua placa*/
void getRentedCar(char plate[], TRentedCar *car);

/* Função responsável por carregar em uma matriz todos os carros alugados registrados*/
void loadRentedCars(TRentedCar rentedCars[]);

/* Função recupera o numero de carros disponiveis*/
int getTotalAvailableCars();

/* Função recupera o numero de carros alugados*/
int getTotalRentedCars();

#endif