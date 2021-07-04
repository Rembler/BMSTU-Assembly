#include <iostream>
#include "Header.h"

int main()
{
    printf("Input string:\n");
    char str[255];
    fgets(str, 255, stdin);
    printf("Your string:\n");
    printf("%s", str);
    STR_SAME(str);
}