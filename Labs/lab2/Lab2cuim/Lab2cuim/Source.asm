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

mov cl, 4;������� ��� �����

L1:
	sub ax, bx; �������� �� X Y
DEC CL;��������� CL �� 1

JNZ L1;���� CL �� ����� 0 �� ������� � ����� L1
;�������� L
xor bx,ax; bx = M = L xor Y
cmp bx, 0; ���������� bx � ����
jg L2;���� M ������ 0 �� ������� � L2
jle L3;���� M ������ ��� ����� �� ������� � L3

L2:
mov cx, bx;�������� � cx bx
and cx, 00f0fh; ���������� cx � 0x0f0f0
jmp L4; ����������� ������� � L4

L3:
mov dx, 3;
mov cx, 0; �������� cx
sub cx, bx; �� R = (cx = 0) �������� bx
jmp L4; ����������� ������� � L4

L4:

cmp cx, 0;���������� cx � 0
jz L5;���� cx ����� 0 �� ��������� � L5
jnz L6;���� �x �� ����� 0 �� ��������� � L6

L5:
mov dx, 5;
call ans_1;�������� ������������ ans_1
jmp L7;


L6:
mov dx, 6;
call ans_2;�������� ������������ ans_2
jmp L7;

L7:
	mov dx, 7;
exit:
Invoke ExitProcess,1
End Start
