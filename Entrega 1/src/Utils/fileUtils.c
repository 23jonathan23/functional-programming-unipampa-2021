#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <fileUtils.h>

typedef FILE (*file)(int);

FILE *loadFile(char *path) {
    FILE *file = fopen(path, "r");
    
    if(file == NULL){
    	printf("Erro na abertura do arquivo\n");
    	exit(0);
    }

    return file;
}

int getTotalRecords(FILE *file) {
    int qtdTotal = 0;

    fscanf(file, "%d\n", &qtdTotal);

    return qtdTotal;
}