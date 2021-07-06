#include <stdio.h>
#include <string.h>
#include <time.h>

#include <loadCars.h>
#include <loadCustomers.h>
#include <fileUtils.h>

#include <customer.h>
#include <car.h>
#include <rentedCar.h>

#include <deliverCar.h>

float returnCar(char plate[], float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers) {
    float value;
    TRentedCar car;
    getRentedCar(plate, &car);

    value = removeFromRentedCars(car, pricePerDayCategory, pricePerExtraQuilometer, quilometers);
    returnToAvailableCars(car, quilometers);
    return value;
}

void returnToAvailableCars(TRentedCar car, int quilometers) {
    int records = getTotalAvailableCars();
    TCar cars[records];
    loadCars(cars);

    FILE *file = loadFile("..\\src\\Infra\\DataBase\\availableCars.txt", "w");

    fprintf(file, "%i", records + 1);

    for (int i = 0; i < records; i++) {
        fprintf(file, "\n%s;%s;%s;%i;%i;%i",
        cars[i].plate,
        cars[i].brand,
        cars[i].model,
        cars[i].year,
        cars[i].mileage,
        cars[i].category);
    }

    fprintf(file, "\n%s;%s;%s;%i;%i;%i",
        car.car.plate,
        car.car.brand,
        car.car.model,
        car.car.year,
        quilometers,
        car.car.category);

    fclose(file);
}

float removeFromRentedCars(TRentedCar car, float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers) {
    int records = getTotalRentedCars();
    TRentedCar rentedCars[records];
    loadRentedCars(rentedCars);

    FILE *file = loadFile("..\\src\\Infra\\DataBase\\rentedCars.txt", "w");

    fprintf(file, "%i", records - 1);

    float priceToPay = calculatePrice(pricePerDayCategory, pricePerExtraQuilometer, quilometers, car);
    addPoints(car, quilometers);

    for (int i = 0; i < records; i++) {
        if (strcmp(rentedCars[i].car.plate, car.car.plate) != 0) {
            fprintf(file, "\n%s;%s;%s;%i;%i;%i;%s;%li",
            rentedCars[i].car.plate, 
            rentedCars[i].car.brand,
            rentedCars[i].car.model,
            rentedCars[i].car.year,
            rentedCars[i].car.mileage,
            rentedCars[i].car.category,
            rentedCars[i].cpf,
            rentedCars[i].seconds);
        }
    }

    fclose(file);
    
    return priceToPay;
}

void addPoints(TRentedCar rentedCar, int quilometers) {
    int records = getTotalCustomers();
    TCustomer customers[records];
    loadCustomers(customers);

    FILE *file = loadFile("..\\src\\Infra\\DataBase\\customers.txt", "w");

    fprintf(file, "%i", records);

    for (int i = 0; i < records; i++) {
        if (strcmp(customers[i].document, rentedCar.cpf) == 0) {
            customers[i].score += (quilometers - rentedCar.car.mileage) / 10;
        }

        fprintf(file, "\n%s;%s;%i",
            customers[i].name,
            customers[i].document,
            customers[i].score);
    }
    fclose(file);
}

float calculatePrice(float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers, TRentedCar rentedCar) {
    float price = 0.0;
    
    time_t currentSeconds;
    currentSeconds = time(NULL);

    long seconds = currentSeconds - rentedCar.seconds;
    long days = seconds / 86400;

    price += (float) days * pricePerDayCategory;

    price += (quilometers - rentedCar.car.mileage) * pricePerExtraQuilometer;

    return price;
}