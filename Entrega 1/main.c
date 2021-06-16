#include<stdio.h>
#include<stdlib.h>
#include<string.h>

//declaracao da struct
typedef struct carro{
    char placa[10];
    char marca[30];
    char modelo[30];
    int ano;
    int quilometragem;
    int quantidade;
    int categoria;
}CARRO;

//função que faz a leitura do arquivo e retorna erro caso não consiga fazê-lo
FILE *abrirArquivo()
{
    FILE *arq = fopen("input.txt", "r");
    
    if(arq == NULL){
    	printf("Erro na abertura do arquivo\n");
    	exit(0);
    }   
    return arq;
}

//função que pega a primeira linha do arquivo, no caso a quantidade total de carros
typedef FILE (*arquivo)(int);
int totalDeCarros(FILE *arquivo)
{
    int qtdTotal = 0;

    fscanf(arquivo, "%d\n", &qtdTotal);

    return qtdTotal;
}
