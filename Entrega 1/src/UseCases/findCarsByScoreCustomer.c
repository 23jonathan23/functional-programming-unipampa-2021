#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <car.h>
#include <customer.h>

#include <fileUtils.h>
#include <customerHasScoreToRentThisCar.h>

#include <findCarsByScoreCustomer.h>

void findCarsByScoreCustomer(TCar *cars, TCustomer customer) {
    FILE *carList = loadFile("src\\Infra\\DataBase\\availableCars.txt", "r");
    
    int maxRowLength = 100;
    int maxFieldPerRow = 6;
    char row[maxRowLength];
    char delimiter[3] = ";";
    char *field;
    char fieldCars[maxFieldPerRow][100];

    int countCars = 0;

    while (!feof(carList)){
        fgets(row, maxRowLength, carList);
        
        if(countCars > 0) {
            field = strtok(row, delimiter);

            int index = 0;
            while(field != NULL){
                strcpy(&fieldCars[index][0], field);

                field = strtok(NULL, delimiter);

                index++;
            }
            
            int categoryCar = atoi(&fieldCars[5][0]);
            
            if(customerHasScoreToRentThisCar(customer.score, categoryCar)) {
                strcpy(cars[countCars-1].plate, &fieldCars[0][0]);
                strcpy(cars[countCars-1].brand, &fieldCars[1][0]);
                strcpy(cars[countCars-1].model, &fieldCars[2][0]);
                
                cars[countCars-1].year = atoi(&fieldCars[3][0]);
                cars[countCars-1].mileage = atoi(&fieldCars[4][0]);
                cars[countCars-1].category = categoryCar;
            }

        }

        countCars++;
    }
}