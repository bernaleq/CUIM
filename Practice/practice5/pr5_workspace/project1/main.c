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
	int i;
	for (i = 0; i < delayTime; i++) { int j; for (j = 0; j < 1400; j++) { /* ..jdem.. */ } }
}

void main()
{
	unsigned char keypad[4][5] = {	{ '7', '8', '9', '+'},
									{ '4', '5', '6', '-'},
									{ '1', '2', '3', '*'},
									{ 'C', '0', '=', '/'}	};

	unsigned char startPosP1;
	unsigned char startPosP3;
	unsigned char testP3;

	unsigned char col;
	unsigned char row;
	
	P2 = 0x0; P0 = 0x0;

	P1 = 0b11110000;
	P3 = 0b11111111;

	startPosP1 = P1;
	startPosP3 = P3;

	setInstruction(0x80);

	while(1) 
	{
		if (P3 != startPosP3) 
		{
			testP3 = P3;

			if 		(P3 == 0b11111110) { col = 0; }
			else if (P3 == 0b11111101) { col = 1; }
			else if (P3 == 0b11111011) { col = 2; }
			else if (P3 == 0b11110111) { col = 3; }
			else if (P3 == 0b11101111) { col = 4; }
			
			P3 = 0b00000000;
			P1 = 0b11111111;

			if 		(P1 == 0b11111110) { row = 0; }
			else if (P1 == 0b11111101) { row = 1; }
			else if (P1 == 0b11111011) { row = 2; }
			else if (P1 == 0b11110111) { row = 3; }
			
			setData(keypad[row][col]);
			delay(40);

			P3 = 0b11111111;
			P1 = 0b11110000;
			while (P3 == testP3) { /* che? */ }
		} 
	}
}
