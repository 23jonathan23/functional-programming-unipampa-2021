#ifndef __FILE1__
#define __FILE1__

typedef FILE (*file)(int);

FILE *loadFile(char *path, char *openType);

int getTotalRecords(FILE *file);

#endif