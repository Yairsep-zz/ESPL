#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{

    unsigned char c;
    FILE *input = stdin;
    FILE *output = stdout;
    if (strcmp(argv[1], "-c") == 0)
    {
        while ((c = fgetc(input)) != EOF)
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
    }
    return 1;
}
