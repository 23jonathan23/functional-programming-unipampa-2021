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

float returnCar(TCar car, float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers) {
    int total = getTotalRentedCars();
    TRentedCar rentedCars[total];
    loadRentedCars(rentedCars);

    float value;
    value = removeFromRentedCars(rentedCars, car, pricePerDayCategory, pricePerExtraQuilometer, quilometers);
    returnToAvailableCars(car, quilometers);

    return value;
}

void returnToAvailableCars(TCar car, int quilometers) {
    int records = getTotalAvailableCars();
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\availableCars.txt", "w");

    fprintf(file, "%i\n", records + 1);

    TCar cars[records];
    loadCars(cars);

    TCar cs;
    for (int ii = 0; ii < records; ii++) {
        cs = cars[ii];
        printf("%s;%s;%s\n", cs.plate, cs.brand, cs.model);
    }

    for (int i = 0; i < records; i++) {
        fprintf(file, "%s;%s;%s;%i;%i;%i\n",
        cars[i].plate,
        cars[i].brand,
        cars[i].model,
        cars[i].year,
        cars[i].mileage,
        cars[i].category);
    }

    fprintf(file, "%s;%s;%s;%i;%i;%i\n",
        car.plate,
        car.brand,
        car.model,
        car.year,
        quilometers,
        car.category);

    fclose(file);
}

float removeFromRentedCars(TRentedCar rentedCars[], TCar car, float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers) {
    float priceToPay;

    int records = getTotalRentedCars();
    FILE *file = loadFile("..\\src\\Infra\\DataBase\\rentedCars.txt", "w");

    fprintf(file, "%i\n", records - 1);

    TRentedCar rentedCar;

    for (int j = 0; j < records; j++) {
        if (strcmp(rentedCars[j].car.plate, car.plate) == 0) {
            rentedCar = rentedCars[j];
        }
    }

    priceToPay = calculatePrice(pricePerDayCategory, pricePerExtraQuilometer, quilometers, rentedCar);
    addPoints(rentedCar, quilometers);

    for (int i = 0; i < records; i++) {
        if (strcmp(rentedCars[i].car.plate, car.plate) != 0) {
            fprintf(file, "%s;%s;%s;%i;%i;%i;%s;%li\n",
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
    FILE *customersFile = loadFile("..\\src\\Infra\\DataBase\\customers.txt", "r");
    int records = getTotalRecords(customersFile);

    FILE *file = loadFile("..\\src\\Infra\\DataBase\\customers.txt", "w");
    TCustomer customers[records];
    loadCustomers(customers);

    fprintf(file, "%i\n", records);

    for (int i = 0; i < records; i++) {
        if (strcmp(customers[i].document, rentedCar.cpf) != 0) {
            fprintf(file, "%s;%s;%i\n",
            customers[i].name,
            customers[i].document,
            customers[i].score);
        } else {
            customers[i].score += quilometers / 10;
            fprintf(file, "%s;%s;%i\n",
            customers[i].name,
            customers[i].document,
            customers[i].score);
        }
    }
    fclose(customersFile);
    fclose(file);
}

float calculatePrice(float pricePerDayCategory, float pricePerExtraQuilometer, int quilometers, TRentedCar rentedCar) {
    float price = 0.0;
    
    time_t curSeconds;
    curSeconds = time(NULL);

    long seconds = curSeconds - rentedCar.seconds;
    long days = seconds / 86400;

    price += (float) days * pricePerDayCategory;

    price += (float) (quilometers - rentedCar.car.mileage) * pricePerExtraQuilometer;

    return price;
}