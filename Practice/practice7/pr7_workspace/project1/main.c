#include <htc.h>

#define tempCounter 3440

void main()
{
	int urovenSHIMA;
	int counter;
	
	urovenSHIMA = 5;
	P04 = 0; 	// bool pin dlya udobstva

	P1 = 0xFE;
	RCAP2H = 0b00101001;	// Starshaya chast'	 \
	RCAP2L = 0b00101000;	// Mladshaya chast' ->\ R = 0b0010100100101000 = 10536
	T2CON &= 0xFC;
	ET2 = 1;
	EA = 1;
	T2CON |= 0x4;
	while (1) 
	{
		counter = tempCounter/urovenSHIMA;
		if (urovenSHIMA == 2) { counter = 1530; }
		
		while (TF2 == 0) 
		{
			if (P00 != 1)
			{
				if (urovenSHIMA > 2 && !P04) { urovenSHIMA--; P04 = 1; }
			}

			if (P07 != 1)
			{
				if (urovenSHIMA <= 5 && !P04) { urovenSHIMA++; P04 = 1; }
			}
		}

		TF2 = 0;
		P10 = 1;

		while (counter != 0) 
		{
			counter--;
			if (P00 != 1)
			{
				if (urovenSHIMA > 2 && !P04) { urovenSHIMA--; P04 = 1; }
			}

			if (P07 != 1)
			{
				if (urovenSHIMA <= 5 && !P04) { urovenSHIMA++; P04 = 1; }
			} 
		}
		P04 = 0;
		P10 = 0;
		counter = tempCounter - tempCounter*(10 - urovenSHIMA); 
	}
}
