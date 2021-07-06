#include <stdbool.h>

#include <customerHasScoreToRentThisCar.h>

bool customerHasScoreToRentThisCar(int score, int categoryCar) {
    if(categoryCar == 1) {
        return (score >= 9);
    } else if(categoryCar == 2) {
         return (score >= 5);
    }

    return true;
}