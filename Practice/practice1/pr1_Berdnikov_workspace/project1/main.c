#include <8051.h>

void main()
{
	int i;
	char xdata *ptr;
	char test, nabor;

	nabor = 0x33;	// Testovyi nabor
	ptr = (char xdata *) 0xC00;		// Nachal'nyi addres

	for (i=0; i < 1024; i++)
	{
		*ptr = nabor;
		test = *ptr;
		if(test != nabor)
		{
			break;
		}
		ptr++;
	}
}