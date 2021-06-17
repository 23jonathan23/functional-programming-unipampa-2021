#!/bin/bash
### Settings
GCC="gcc -std=c11 -D_XOPEN_SOURCE=700 -Wall -g -Iinclude"
OBJDIR="obj"
BINDIR="bin"
OUTPUT="$BINDIR/bin"
declare -a SOURCE=(
"src/Utils/FileUtils.c"
"src/UseCases/findCarsByScoreCustomer.c"
"src/Presentation/UICarRental.c"
"src/Main.c"
)
### Clean build
rm -f $OUTPUT
rm -rf $OBJDIR
mkdir -p $BINDIR
mkdir -p $OBJDIR
### Compile
for S in "${SOURCE[@]}"
do
    FILE=$(basename $S)
    echo "$GCC -o $OBJDIR/$FILE.o -c $S"
    $GCC -o $OBJDIR/$FILE.o -c $S
    OBJ="$OBJ $OBJDIR/$FILE.o"
done
### Link
echo "gcc -o $OUTPUT $OBJ"
gcc -o $OUTPUT $OBJ