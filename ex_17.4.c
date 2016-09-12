#include<stdio.h>
#include<float.h>


int greet(char* name)
{
	double big_number = DBL_MAX; 
	printf("Hello %s\n", name);
	return(big_number);
}

main()
{
	char* name = "Geri";
    printf("%f\n",greet(name)-1.0);
}
