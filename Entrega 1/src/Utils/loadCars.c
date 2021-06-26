#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <car.h>
#include <fileUtils.h>
#include <loadCars.h>

void loadCars(TCar *cars) {
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\availableCars.txt", "r");
    int size = getTotalAvailableCars();

    int maxRowLength = 100;
    int maxFieldPerRow = 6;
    char row[maxRowLength];
    char delimiter[3] = ";";
    char *field;
    char fieldCars[maxFieldPerRow][maxRowLength];

    int count = 0;
    while(!feof(file)){
        fgets(row, maxRowLength, file);
        
        if(count > 0) {
            field = strtok(row, delimiter);

            int index = 0;
            while(field != NULL){
                strcpy(&fieldCars[index][0], field);

                field = strtok(NULL, delimiter);

                index++;
            }
            
            strcpy(cars[count-1].plate, &fieldCars[0][0]);
            strcpy(cars[count-1].brand, &fieldCars[1][0]);
            strcpy(cars[count-1].model, &fieldCars[2][0]);
            
            cars[count-1].year = atoi(&fieldCars[3][0]);
            cars[count-1].mileage = atoi(&fieldCars[4][0]);
            cars[count-1].category = atoi(&fieldCars[5][0]);
        }

        if(count >= size) break;

        count++;
    }

    fclose(file);
}

int getTotalAvailableCars() {
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\availableCars.txt", "r");

    int qtdTotal = 0;

    fscanf(file, "%d\n", &qtdTotal);

    fclose(file);

    return qtdTotal;
}

int getTotalRentedCars() {
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\rentedCars.txt", "r");

    int qtdTotal = 0;

    fscanf(file, "%d\n", &qtdTotal);

    fclose(file);

    return qtdTotal;
}