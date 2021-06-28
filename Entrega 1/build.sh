#!/bin/bash
### Settings
GCC="gcc -std=c11 -D_XOPEN_SOURCE=700 -Wall -g -Iinclude"
OBJDIR="obj"
BINDIR="bin"
OUTPUT="$BINDIR/bin"
declare -a SOURCE=(
"src/Utils/fileUtils.c"
"src/Utils/loadCars.c"
"src/Utils/loadCustomers.c"
"src/Utils/customerHasScoreToRentThisCar.c"
"src/UseCases/findCarsByScoreCustomer.c"
"src/UseCases/rentCar.c"
"src/UseCases/deliverCar.c"
"src/Presentation/carRental.c"
"src/main.c"
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