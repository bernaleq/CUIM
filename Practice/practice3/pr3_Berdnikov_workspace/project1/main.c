#include <8051.h>
#include <string.h> // function strlen();

void setInstruction(int instruction) 
{
	P0 = instruction;
	P2 = 0x1; P2 = 0x0;
}

void setData(char data) 
{
	P0 = data;
	P2 = 0x3; P2 = 0x2;
} 

void resetInstructionInput() 
{
	P0 = 0x0;
	P2 = 0x1; P2 = 0x0;
}

void delay(int delayTime)
{
	int i, j;
	for (i = 0; i < delayTime; i++) { for (j = 0; j < 1500; j++) { } }
}

void main()
{
	unsigned int i;
	unsigned int i_end;

	unsigned int j;
	unsigned int j_end;

	unsigned int k;

	unsigned int displayWidth = 20;

	unsigned char str[6] = {160,161,175,161,160};
	unsigned char str2[6] = {162,160,164,169,173};

	P2 = 0x0; P0 = 0x0;

	i_end = strlen((char *) str);
	j_end = strlen((char *) str2);
	
	// Otobrazhenie 2 stroki 
	setInstruction(0xC0);
	for (j = 0; j < j_end; j++)
	{
		setData(str2[j]);
		setData(" ");
	}

	// Otobrazhenie 1 stroki
	k = 0;
	while(1) 
	{
		for (i = 0; i < i_end; i++)
		{
			setInstruction(0x80 + (20 - (k % 20) + i) % 20);
			setData(str[i]);
		}
		delay(30);

		resetInstructionInput();
		
		for (i = 0; i < i_end; i++)
		{
			setInstruction(0x80 + (20 - (k % 20) + i) % 20);
			setData(" ");
		}
		k += 2;
	}
}
