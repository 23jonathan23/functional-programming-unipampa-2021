#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include <time.h>

#include <carRental.h>

#include <car.h>
#include <customer.h>

#include <loadCars.h>
#include <loadCustomers.h>

#include <findCarsByScoreCustomer.h>
#include <rentCar.h>
#include <deliverCar.h>

void execute() {
    int opc;

    do{
            opc = menu();

            switch(opc)
            {
                case 0:
                    exit(0);
                
                case 1:
                    rentCarMenu();
                    break;
                case 2:
                    deliverCarMenu();
                    break;
                
                case 3:
                    findCarsMenu();
                    break;          	 
                
                case 4:
                    reportCarsMenu();
                    break;

                default:
                    printf("Opcao invalida! Tente novamente.\n");  
            } 
        }while(opc != 0);
}

int menu()
{
    int opc;

    	fflush(stdout);
        printf("\n\n#----------------------------Movimenta QBS--------------------------------------#\n");
        printf("#################################################################################\n");
        printf("#                              Escolha a opcao desejada:                        #\n");
        printf("#            1. Alugar um Carro                                                 #\n");
        printf("#            2. Entregar um Carro                                               #\n");
        printf("#            3. Listar Carros Disponiveis                                       #\n");
        printf("#            4. Gerar Relatorio de Carros                                       #\n");
        printf("#            0. Sair                                                            #\n");
        printf("#################################################################################\n");
	    printf(">>");
        scanf("%d", &opc);
        system("cls || clear");
        setbuf(stdin, NULL);

        return opc;
}

void printCarsByCategory(TCar *cars, int size, int category) {
    printf("\nCategoria %i: \n", category);

    for(int i = 0; i < size; i++) {
        if(cars[i].category != category) continue;

        printf("\nPlaca: %s, Marca: %s, Modelo: %s, Ano: %i, KM: %i" , 
            cars[i].plate, cars[i].brand, cars[i].model, cars[i].year, cars[i].mileage);
    }
}

void findCarsMenu() {
    char document[11];
    TCustomer customer;

    do {
        printf("\nPara obter a lista de carros disponiveis, por favor informe o seu documento.\n");
        scanf("%s", document);

        getCustomerByDocument(document, &customer);

        if(strcmp(customer.document, document) != 0)
            printf("\nCliente não encontrado, por favor revise os dados em tente novamente.\n");

    } while(strcmp(customer.document, document) != 0);

    setbuf(stdin, NULL);
    
    int size = getTotalAvailableCars();
    TCar cars[size];

    findCarsByScoreCustomer(cars, customer);

    printf("\nCarros disponiveis para o cliente %s\n", customer.name);

    printCarsByCategory(cars, size, 1);

    printCarsByCategory(cars, size, 2);

    printCarsByCategory(cars, size, 3);
}


void rentCarMenu() {
    char document[11];
    TCustomer customer;

    char plate[10];
    TCar car;

    do {
        printf("\nPara alugar um carro, por favor informe o seu documento:\n");
        scanf("%s", document);

        getCustomerByDocument(document, &customer);

        if(strcmp(customer.document, document) != 0) {
            printf("\nCliente não encontrado, por favor revise os dados em tente novamente.\n");
            continue;
        }

        printf("\nAgora informe a placa do carro que deseja alugar:\n");
        scanf("%s", plate);

        findCarByPlate(&car, customer, plate);

        if(strcmp(car.plate, plate) != 0) {
            printf("\nCarro não encontrado, por favor em caso de duvida utilize a opção de verificar os carros disponiveis no menu.\n");
            continue;
        }

    } while(strcmp(car.plate, plate) != 0);

    rentCar(car, customer);

    printf("\nCarro alugado com sucesso!.\n");

    printf("\nPlaca: %s, Marca: %s, Modelo: %s, Ano: %i, KM: %i" , 
            car.plate, car.brand, car.model, car.year, car.mileage);
    
    time_t dateTimeNow;
    char dateTimeNowFormated[100];

    dateTimeNow = time(NULL);

    strftime( dateTimeNowFormated, sizeof(dateTimeNowFormated), "%d.%m.%Y - %H:%M:%S", localtime( &dateTimeNow ) );

    printf( "\n\nData/Hora da retirada: %s\n", dateTimeNowFormated );
}

void deliverCarMenu() {
    
    TCar car;
    strcpy(car.plate, "BVX0X05");
    strcpy(car.brand, "TOYOTA");
    strcpy(car.model, "COROLA");
    car.year = 2021;
    car.mileage = 90000;
    car.category = 2;

    float value;
    value = returnCar(car, 4.7, 5.8, 200);
}

void reportCarsMenu() {
    
}