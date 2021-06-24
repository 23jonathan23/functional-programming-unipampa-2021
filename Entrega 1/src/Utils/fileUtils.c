#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include <fileUtils.h>

typedef FILE (*file)(int);

FILE *loadFile(char *path, char *openType) {
    FILE *file = fopen(path, openType);
    
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

int readLines(FILE *file, char lines[][1000]) {
    char currentLine[1000];
    
    int qdtLine = 0;
    while (fgets(currentLine, 1000, file)) {
        if(qdtLine > 0) {
            strcpy(&lines[qdtLine-1][0], currentLine);
        }

        qdtLine++;
    }

    return (qdtLine-1);
}