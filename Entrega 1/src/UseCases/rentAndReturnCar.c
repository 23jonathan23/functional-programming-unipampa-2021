#include <stdio.h>
#include <stdlib.h>

#include <car.h>
#include <customer.h>
#include <fileUtils.h>
#include <string.h>
#include <rentAndReturnCar.h>

void rentCar(TCar car, TCustomer customer) {
    FILE *file = loadFile("src\\Infra\\DataBase\\availableCars.txt", "r");
    int size = getTotalRecords(file);
    TCar cars[size];

    loadCars(cars, size);    
    removeFromAvailableCars(cars, car);
    addToRentedCars(car, customer);
}

void removeFromAvailableCars(TCar cars[], TCar car) {
    FILE *fileWrite = loadFile("src\\Infra\\DataBase\\availableCars.txt", "w");
    FILE *file = loadFile("src\\Infra\\DataBase\\availableCars.txt", "r");
    int length = getTotalRecords(file);

    fprintf(fileWrite, "%i\n", length - 1);

    for (int i = 0; i < length; i++) {
        if (strcmp(cars[i].plate, car.plate) != 0) {
            fprintf(fileWrite, "%s;%s;%s;%i;%i;%i\n", cars[i].plate, cars[i].brand, cars[i].model, cars[i].year, cars[i].mileage, cars[i].category);
        }
    }
    fclose(fileWrite);
    fclose(file);
}

void loadCars(TCar cars[], int size) {
    FILE *file = loadFile("src\\Infra\\DataBase\\availableCars.txt", "r");

    char currentChar = fgetc(file);
    while (currentChar != '\n') {
        currentChar = fgetc(file);
    }

    int lineLength = 0;
    char *line = malloc(100);
    char c;
    for (int i = 0; i < size; i++) {
        c = fgetc(file);
        while (c != '\n') {
            lineLength++;
            c = fgetc(file);
        }
        fseek(file, lineLength * -1, SEEK_CUR);
        fgets(line, lineLength, file);

        strcpy(cars[i].plate, strtok(line, ";"));
        strcpy(cars[i].brand, strtok(NULL, ";"));
        strcpy(cars[i].model, strtok(NULL, ";"));
        cars[i].year = atoi(strtok(NULL, ";"));
        cars[i].mileage = atoi(strtok(NULL, ";"));
        cars[i].category = atoi(strtok(NULL, ";"));

        lineLength = 0;

        printf("%s\n", cars[i].plate);
    }
    fclose(file);
}

void addToRentedCars(TCar car, TCustomer customer) {
    FILE *fileRead = loadFile("src\\Infra\\DataBase\\rentedCars.txt", "r");
    int size = getTotalRecords(fileRead);
    char *cars[size];
    
    int lineLength = 0;
    char c;
    for (int i = 0; i < size; i++) {
        c = fgetc(fileRead);
        while (c != '\n') {
            lineLength++;
            c = fgetc(fileRead);
        }
        fseek(fileRead, lineLength * -1, SEEK_CUR);
        fgets(cars[i], lineLength, fileRead);
    }

    FILE *fileWrite = loadFile("src\\Infra\\DataBase\\rentedCars.txt", "w");
    fprintf(fileWrite, "%i\n", size + 1);

    for (int j = 0; j < size; j++) {
        fprintf(fileWrite, "%s\n", cars[j]);
    }
    
    char *plate = car.plate;
    char *brand = car.brand;
    char *model = car.model;
    int year = car.year;
    int mileage = car.mileage;
    int category = car.category;
    char *cpf = customer.document;

    fprintf(fileWrite, "%s;%s;%s;%i;%i;%i;%s\n", plate, brand, model, year, mileage, category, cpf);
    fclose(fileWrite);
    fclose(fileRead);
}