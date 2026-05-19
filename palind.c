#include<stdio.h>
#include<string.h>
int main()
{
	char name[100],rev[100];
	scanf("%s",name);
	strcpy(rev,name);
	strrev(rev);
	if(strcpy (name,rev)==0)
	{
		printf("Palindrome");
	}
	else
	{
		printf("Not Palindrome");
	}
}
