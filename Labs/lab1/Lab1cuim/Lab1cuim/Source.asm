.686
.model flat, stdcall

.stack 100h

.data
X dw 58; �������� ��� X = 58
Y dw 23; �������� ��� Y = 23
Z dw 11; �������� ��� Z = 11
m dw 0;
.code

ExitProcess PROTO STDCALL :DWORD

Start:
mov ax, X; ������ X � ������� AX
add ax, Y; ��������� Y
add ax, Z; ��������� Z
mov dx, ax; ��������� ������������� ��������� � DX
and dx, X; (X+Y+Z)X
rol Y, 4; ����� Y �� 4 ���� �����(Y�)
and ax, Y; (X+Y+Z)Y�
sub dx, ax; �������� �� (X+Y+Z)X ��������� (X+Y+Z)Y�
mov m, dx; ��������� ��������� � m 
exit:
Invoke ExitProcess, 1
End Start
