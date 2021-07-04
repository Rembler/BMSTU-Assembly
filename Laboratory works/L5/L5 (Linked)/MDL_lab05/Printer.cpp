#include <iostream>
#include <string.h>

extern "C" void __stdcall PRINT(char* str)
{
	int len = strlen(str);
	if (len > 0)
	{
		printf("Words differing by no more than one letter:\n");
		printf("%s", str);
	}
	else
	{
		printf("There is no words differing by more than one letter");
	}
}