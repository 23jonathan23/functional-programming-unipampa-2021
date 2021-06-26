#ifndef __LOADCUSTUMERS__
#define __LOADCUSTUMERS__

#include <customer.h>

void loadCustomers(TCustomer *customers);

void getCustomerByDocument(char document[11], TCustomer *customer);

int getTotalCustomers();

#endif