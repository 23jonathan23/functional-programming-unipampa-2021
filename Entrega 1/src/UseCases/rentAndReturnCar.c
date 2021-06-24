#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <car.h>
#include <customer.h>
#include <fileUtils.h>
#include <loadCars.h>
#include <rentAndReturnCar.h>

void rentCar(TCar car, TCustomer customer) {
    int size = getTotalAvailableCars();
    TCar cars[size];
    loadCars(cars); 

    removeFromAvailableCars(cars, car);
    addToRentedCars(car, customer);
}

void removeFromAvailableCars(TCar *cars, TCar car) {
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

void addToRentedCars(TCar car, TCustomer customer) {
    FILE *file = loadFile("src\\Infra\\DataBase\\rentedCars.txt", "r");

    int quantity;
    
    fscanf(file, "%i", &quantity);

    quantity++;

    char lines[100][1000];
    
    int qdtLine = readLines(file, lines);

    fclose(file);

    file = loadFile("src\\Infra\\DataBase\\rentedCars.txt", "w");

    fprintf(file, "%i",quantity);

    for(int i = 0; i < qdtLine; i++) {
        fprintf(file,"\n%s", &lines[i][0]);
    }

    fprintf(
        file, 
        "\n%s;%s;%s;%i;%i;%i;%s", 
        car.plate, 
        car.brand, 
        car.model, 
        car.year, 
        car.mileage, 
        car.category, 
        customer.document
    );

    fclose(file);
}