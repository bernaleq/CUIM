#include <8051.h>

unsigned char getChar();

void tput (unsigned char ch)
{
	SBUF = ch;
	while(!TI);
	TI = 0;
}

unsigned char getChar()
{
	unsigned char ch;
	while(!RI);
	ch = SBUF;
	tput(ch);
	RI = 0;
	return ch;
}

void main()
{
	char idata *ptr;		// Ukazatel' na oblast' v operativnoy pamyati
	char chRecieved;		// Prinimaemyi simvol
	unsigned char i;		// Dlya for
	unsigned char index;	// Index yacheyki v operativnoy pamyati

	ptr = (char idata*) 0x40;
	
	PCON = 0b10000000;	// Dlya skorosti 375 kHz
	SCON = 0b10011100;	// Nastroyka otpravki \ priyoma
	TMOD = 0b00100000;	// Timer v rejim 2

	TR1 = 1;			// Zapusk timera
	
	tput('\n');
	tput('s');
	tput('t');
	tput('a');
	tput('r');
	tput('t');
	tput(':');
	tput('\n');

	RI = 0;				// Sbros flaga preryvaniya priyoma

	for (i = 0; i < 15; i++)
	{
		*(ptr + index) = getChar();	// Zapis' v pamyat'
		index++;
		
	}
	tput('\n');
	while(1) {}
}