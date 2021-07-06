#ifndef __FILE1__
#define __FILE1__

typedef FILE (*file)(int);

/* Função que faz a abertura dos arquivos de persistencia usados para armazernar os dados do sistema*/
FILE *loadFile(char *path, char *openType);

int getTotalRecords(FILE *file);

/* Função genérica que mapeia as linhas de um arquivo para uma matriz de destino*/
int readLines(FILE *file, char lines[][1000]);

#endif