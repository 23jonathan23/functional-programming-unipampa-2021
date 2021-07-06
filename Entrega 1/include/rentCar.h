#ifndef __RENTCAR__
#define __RENTCAR__

#include <car.h>
#include <customer.h>

/* Função responsável por remover um carro do registro de carros disponiveis*/
void removeFromAvailableCars(TCar car);

/* Função responsável por adicionar um carro no registro de carros alugados*/
void addToRentedCars(TCar car, TCustomer customer);

/* Função principal responsável aplicar os passo necessários para alugar um carro*/
void rentCar(TCar car, TCustomer customer);

#endif