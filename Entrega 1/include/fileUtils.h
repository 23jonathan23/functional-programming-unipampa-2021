#ifndef __FILE1__
#define __FILE1__

typedef FILE (*file)(int);

FILE *loadFile(char *path, char *openType);

int getTotalRecords(FILE *file);

int readLines(FILE *file, char lines[][1000]);

#endif