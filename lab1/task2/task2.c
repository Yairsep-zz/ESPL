#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void decimal_representation(unsigned char c, FILE *output);
void binary_representation(unsigned char c, int *arr, FILE *output);
void upper_to_Lower(unsigned char c, FILE *output);

int main(int argc, char **argv)
{
    char c;
    int i;
    FILE *input = stdin;
    FILE *output = stdout;
    int flag = 0;
    for (i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "-b") == 0)
        {
            flag = 1;
        }
        else if (strcmp(argv[i], "-c") == 0)
        {
            flag = 2;
        }
        else if (strcmp(argv[i], "-o") == 0)
        {
            output = fopen(argv[++i], "w");
        }
        else if (strcmp(argv[i], "-i") == 0)
        {
            input = fopen(argv[++i], "r");
        }
    }

    while ((c = fgetc(input)) != EOF)
    {
        if (c == '\n'){
            fputc(c , output);
        }
        else if (flag == 0)
        {
            decimal_representation(c, output);
        }
        else if (flag == 1)
        {
            int arr[8];
            binary_representation(c, arr, output);
        }
        else if (flag == 2)
        {
            upper_to_Lower(c, output);
        }
    }
    fclose(input);
    fclose(output);
    return 0;
}

void decimal_representation(unsigned char c, FILE *output)
{
    if (c != 10)
    {
        fprintf(output, "%d ", c);
    }
}

void binary_representation(unsigned char c, int *y, FILE *output)
{
    int i;
    if (c != 10)
    {
        for (i = 0; i < 8; i++)
        {
            y[7 - i] = (c >> i) & 1;
        }
        for (i = 0; i < 8; i++)
        {
            fprintf(output, "%d", y[i]);
        }
    }
    fprintf(output, " ");
}

void upper_to_Lower(unsigned char c, FILE *output)
{
    if (65 <= c && c <= 90)
    {
        c += 32;
        fprintf(output, "%c", c);
    }
    else
    {
        fprintf(output, "%c", c);
    }
}