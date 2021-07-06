#ifndef __LOADCUSTUMERS__
#define __LOADCUSTUMERS__

#include <customer.h>

/* Função responsável por carregar em uma matriz todos os cliente registrados*/
void loadCustomers(TCustomer *customers);

/* Função responsável por encontrar uma cliente pelo seu documento*/
void getCustomerByDocument(char document[11], TCustomer *customer);

/* Função recupera o numero de clientes registrados*/
int getTotalCustomers();

#endif