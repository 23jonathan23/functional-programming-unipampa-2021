#ifndef __DELIVERCAR__
#define __DELIVERCAR__

#include <car.h>
#include <customer.h>

/* Função principal reponsável orquestrar os passos para o processo de devolvução de um carro*/
float returnCar(char plate[], float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers);

/* Função responsável por retornar um carros aos registros de carros disponiveis*/
void returnToAvailableCars(TRentedCar car, int quilometers);

/* Função responsável por remover um carro dos registros de carros alugados*/
float removeFromRentedCars(TRentedCar car, float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers);

/* Função responsável por adicionar pontos ao registro do cliente*/
void addPoints(TRentedCar rentedCar, int quilometers);

/* Função responsável por calcular o preço que o cliente vai pagar pelo carro*/
float calculatePrice(float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers, TRentedCar rentedCar);

#endif