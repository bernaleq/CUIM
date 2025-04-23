#include <8051.h>

void delay(unsigned int time) {
    while (time--); 
}

void main() {
    unsigned char massivDigits[10] = {
        0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90
    };
    unsigned char massivSequence[8] = {
        0x92,0x99,0x82,0xB0,0xF8,0xA4,0x80,0xF9
    };

    unsigned char countIndex = 0;   
    unsigned char seqIndex;         
    unsigned char lastCode;         
    unsigned int t;

    P2 = 0xFF;  
    P0 = 0xFF; 

    while (1) {
        if (P0 == 0xFF) {
            P2 = massivDigits[countIndex];
            t = 50;
            while (t--) {
                if (P0 != 0xFF) break;
            }
            if (P0 == 0xFF) {
                countIndex++;
                if (countIndex >= 10) countIndex = 0;
            }
        }
        else {
            seqIndex = 0;
            while (P0 != 0xFF) {
                lastCode = massivSequence[seqIndex];
                P2 = lastCode;
                t = 50;
                while (t--) {
                    if (P0 == 0xFF) break;
                }
                if (P0 == 0xFF) break;
                seqIndex++;
                if (seqIndex >= 8) seqIndex = 0;
            }
            for (countIndex = 0; countIndex < 10; countIndex++) {
                if (massivDigits[countIndex] == lastCode) {
                    break;
                }
            }
        }
    }
}
