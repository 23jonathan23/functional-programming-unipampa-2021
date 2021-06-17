#ifndef __FILE1__
#define __FILE1__

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef FILE (*file)(int);

FILE *loadFile(char *path);

int getTotalRecords(FILE *file);

#endif