#include <stdio.h>

int main()
{
    int age = 1;
    float num = 3.14;
    int height = 54321;

    char *p = NULL;

    printf("I am %05d years old.\n", age);
    printf("I am %05d inches tall.\n", height);

    //test
    printf("%d\n", num);

    printf("%d, %d\n",age);

    printf("%f\n", age);

    printf("%s", p);

    return 0;
}