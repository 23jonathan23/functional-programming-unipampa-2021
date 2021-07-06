#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include <stdbool.h>

#include <car.h>
#include <rentedCar.h>
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

bool isCarRented(char plate[]) {
    int records = getTotalRentedCars();
    TRentedCar rentedCars[records];
    loadRentedCars(rentedCars);

    for (int i = 0; i < records; i++) {
        if (strcmp(plate, rentedCars[i].car.plate) == 0) {
            return true;
        }
    }
    return false;
}

void getRentedCar(char plate[], TRentedCar *car) {
    int records = getTotalRentedCars();
    TRentedCar rentedCars[records];
    loadRentedCars(rentedCars);

    for (int i = 0; i < records; i++) {
        if (strcmp(plate, rentedCars[i].car.plate) == 0) {
            strcpy(car->car.plate, rentedCars[i].car.plate);
            strcpy(car->car.brand, rentedCars[i].car.brand);
            strcpy(car->car.model, rentedCars[i].car.model);
            car->car.year = rentedCars[i].car.year;
            car->car.mileage = rentedCars[i].car.mileage;
            car->car.category = rentedCars[i].car.category;
            strcpy(car->cpf, rentedCars[i].cpf);
            car->seconds = rentedCars[i].seconds;
        }
    }
}

void loadRentedCars(TRentedCar rentedCars[]) {
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\rentedCars.txt", "r");
    
    char ch;
    ch = fgetc(file);
    while (ch != '\n' && ch != EOF) {
        ch = fgetc(file);
    }

    int length = 0;
    int counter = 0;
    int spot;
    char *line;

    int endSpot;
    while (ch != EOF) {
        spot = ftell(file);

        ch = fgetc(file);
        length++;
        while (ch != EOF && ch != '\n') {
            ch = fgetc(file);
            length++;
        }

        endSpot = ftell(file);

        fseek(file, spot, SEEK_SET);

        line = malloc(sizeof(char) * length);
        fgets(line, length, file);

        strcpy(rentedCars[counter].car.plate, strtok(line, ";"));
        strcpy(rentedCars[counter].car.brand, strtok(NULL, ";"));
        strcpy(rentedCars[counter].car.model, strtok(NULL, ";"));
        rentedCars[counter].car.year = atoi(strtok(NULL, ";"));
        rentedCars[counter].car.mileage = atoi(strtok(NULL, ";"));
        rentedCars[counter].car.category = atoi(strtok(NULL, ";"));

        strcpy(rentedCars[counter].cpf, strtok(NULL, ";"));
        rentedCars[counter].seconds = atol(strtok(NULL, ";"));
        
        fseek(file, endSpot, SEEK_SET);
        free(line);

        length = 0;
        counter++;
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