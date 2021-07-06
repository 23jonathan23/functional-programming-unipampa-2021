#ifndef __FINDCARS__
#define __FINDCARS__

#include <car.h>
#include <customer.h>

/* Função principal que realiza todo processo de encontrar os veiculos para serem alugados
que estão disponiveis para o cliente*/
void findCarsByScoreCustomer(TCar *cars, TCustomer customer);

/* Função que localiza um carro pela placa dele*/
void findCarByPlate(TCar *car, TCustomer customer, char plate[10]);

#endif