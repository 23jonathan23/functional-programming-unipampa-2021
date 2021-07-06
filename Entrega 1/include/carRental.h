#ifndef __CARRENDAL__
#define __CARRENDAL__

#include <car.h>

void execute();

int menu();

void printCarsByCategory(TCar *cars, int size, int category);

/* Interação responsável por intermediar a comunicação do cliente com 
a funcionalidade de encontrar carros disponiveis para serem alugados com
base no score do cliente*/
void findCarsMenu();

/* Interação responsável por intermediar a comunicação do cliente com 
a funcionalidade de alugar um carro*/
void rentCarMenu();

/* Interação responsável por intermediar a comunicação do cliente com 
a funcionalidade de devolver um carro alugado*/
void deliverCarMenu();

// função que gera o relatório de carros disponiveis e alugados
void reportCarsMenu();

#endif