#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <customer.h>
#include <fileUtils.h>
#include <loadCustomers.h>

void loadCustomers(TCustomer *customers) {
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\customers.txt", "r");
    int size = getTotalCustomers();

    int maxRowLength = 100;
    int maxFieldPerRow = 3;
    char row[maxRowLength];
    char delimiter[3] = ";";
    char *field;
    char fieldCustomer[maxFieldPerRow][maxRowLength];

    int count = 0;
    while(!feof(file)){
        fgets(row, maxRowLength, file);
        
        if(count > 0) {
            field = strtok(row, delimiter);

            int index = 0;
            while(field != NULL){
                strcpy(&fieldCustomer[index][0], field);

                field = strtok(NULL, delimiter);

                index++;
            }
            
            strcpy(customers[count-1].name, &fieldCustomer[0][0]);
            strcpy(customers[count-1].document, &fieldCustomer[1][0]);
            
            customers[count-1].score = atoi(&fieldCustomer[2][0]);
        }

        if(count >= size) break;

        count++;
    }

    fclose(file);
}

void getCustomerByDocument(char document[11], TCustomer *customer) {
    int size = getTotalCustomers();
    TCustomer customers[size];

    loadCustomers(customers);

    for(int i = 0; i < size; i++) {
        if(strcmp(customers[i].document, document) == 0) {
            strcpy(customer->name, customers[i].name);
            strcpy(customer->document, customers[i].document);

            customer[i].score = customers[i].score;
            break;
        }
    }
}

int getTotalCustomers() {
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\customers.txt", "r");

    int qtdTotal = 0;

    fscanf(file, "%d\n", &qtdTotal);

    fclose(file);

    return qtdTotal;
}