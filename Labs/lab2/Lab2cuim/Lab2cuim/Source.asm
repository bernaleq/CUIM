.686
.model flat,stdcall
.stack 100h
.data
.code
ExitProcess PROTO STDCALL :DWORD
ans_1:
xor ax, 027e1h;R = 27e1 xor L
ret;

ans_2:
add cx, 067a1h;R + 67A1
sub cx, ax;R+67A1 - L
ret;
Start:

mov ax, 06da9h;init value 06da9h
mov bx, 011fah;init value 011fah

mov cl, 4;счётчик для цикла

L1:
	sub ax, bx; вычитаем из X Y
DEC CL;уменьшаем CL на 1

JNZ L1;если CL не равно 0 то переход к метке L1
;получили L
xor bx,ax; bx = M = L xor Y
cmp bx, 0; сравниваем bx с нулём
jg L2;если M больше 0 то переход к L2
jle L3;если M меньше или равно то переход к L3

L2:
mov cx, bx;помещяем в cx bx
and cx, 00f0fh; конъюнкция cx и 0x0f0f0
jmp L4; безусловный переход к L4

L3:
mov dx, 3;
mov cx, 0; обнуляем cx
sub cx, bx; из R = (cx = 0) вычитаем bx
jmp L4; Безусловный переход к L4

L4:

cmp cx, 0;сравниваем cx с 0
jz L5;если cx равно 0 то переходим в L5
jnz L6;если сx не равно 0 то переходим в L6

L5:
mov dx, 5;
call ans_1;вызываем подпрограмму ans_1
jmp L7;


L6:
mov dx, 6;
call ans_2;вызываем подпрограмму ans_2
jmp L7;

L7:
	mov dx, 7;
exit:
Invoke ExitProcess,1
End Start
