#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <car.h>
#include <customer.h>
#include <fileUtils.h>
#include <loadCars.h>
#include <rentCar.h>

void rentCar(TCar car, TCustomer customer) {
    removeFromAvailableCars(car);
    addToRentedCars(car, customer);
}

void removeFromAvailableCars(TCar car) {
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\availableCars.txt", "r");

    int quantity;
    
    fscanf(file, "%i", &quantity);

    quantity--;

    char lines[100][1000];
    
    int qdtLine = readLines(file, lines);

    fclose(file);

    file = loadFile("..\\src\\Infra\\DataBase\\availableCars.txt", "w");

    fprintf(file, "%i\n",quantity);

    for(int i = 0; i < qdtLine; i++) {
        if(!strstr(&lines[i][0], car.plate)) {
            fprintf(file,"%s", &lines[i][0]);
        }
    }

    fclose(file);
}

void addToRentedCars(TCar car, TCustomer customer) {
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\rentedCars.txt", "r");

    int quantity;
    
    fscanf(file, "%i", &quantity);

    quantity++;

    char lines[100][1000];
    
    int qdtLine = readLines(file, lines);

    fclose(file);

    file = loadFile("..\\src\\Infra\\DataBase\\rentedCars.txt", "w");

    fprintf(file, "%i",quantity);

    for(int i = 0; i < qdtLine; i++) {
        fprintf(file,"\n%s", &lines[i][0]);
    }

    time_t dateTimeNow;

    dateTimeNow = time(NULL);

    fprintf(
        file, 
        "\n%s;%s;%s;%i;%i;%i;%s;%ld", 
        car.plate, 
        car.brand, 
        car.model,
        car.year, 
        car.mileage, 
        car.category, 
        customer.document,
        dateTimeNow
    );

    fclose(file);
}