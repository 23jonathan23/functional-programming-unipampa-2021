#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <Car.h>
#include <Customer.h>

#include <FileUtils.h>
#include <findCarsByScoreCustomer.h>

void findCarsByScoreCustomer(TCar *cars, TCustomer customer) {
    FILE *carList = loadFile("src\\Infra\\DataBase\\availableCars.txt");
    
    int maxRowLength = 100;
    int maxFieldPerRow = 7;
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

            strcpy(cars[countCars-1].plate, &fieldCars[0][0]);
            strcpy(cars[countCars-1].brand, &fieldCars[1][0]);
            strcpy(cars[countCars-1].model, &fieldCars[2][0]);
            
            cars[countCars-1].year = atoi(&fieldCars[3][0]);
            cars[countCars-1].mileage = atoi(&fieldCars[4][0]);
            cars[countCars-1].quantity = atoi(&fieldCars[5][0]);
            cars[countCars-1].category = atoi(&fieldCars[6][0]);
        }

        countCars++;
    }
}