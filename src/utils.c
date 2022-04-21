#include "include/utils.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

char* str_to_hex(const char* instr) {
    unsigned int len = strlen(instr);
    char* hexstr = calloc(1, sizeof(char));

    for (unsigned int i = 0; i < len + 1; i++) {
        char* newstr = calloc(4, sizeof(char));
        sprintf(newstr, "%x", instr[len-i]);
        hexstr = realloc(hexstr, (strlen(hexstr) + strlen(newstr) + 1) * sizeof(char));
        strcat(hexstr, newstr);
        free(newstr);
    }

    return hexstr;
}