#include <stdlib.h>
#include <stdio.h>

int main(){

    unsigned char c;
    FILE * input = stdin;
    FILE * output = stdout;
    while ((c=fgetc(input)) !=EOF){
        if (c != 10){
        fprintf(output , "%d\n" , c);
        }
    }
    return 0;
}