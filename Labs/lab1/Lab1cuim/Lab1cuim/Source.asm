.686
.model flat, stdcall

.stack 100h

.data
X dw 58; значение дл€ X = 58
Y dw 23; значение дл€ Y = 23
Z dw 11; значение дл€ Z = 11
m dw 0;
.code

ExitProcess PROTO STDCALL :DWORD

Start:
mov ax, X; вносим X в регистр AX
add ax, Y; добавл€ем Y
add ax, Z; добавл€ем Z
mov dx, ax; сохран€ем промежуточный результат в DX
and dx, X; (X+Y+Z)X
rol Y, 4; сдвиг Y на 4 бита влево(YТ)
and ax, Y; (X+Y+Z)YТ
sub dx, ax; вычитаем из (X+Y+Z)X выражение (X+Y+Z)YТ
mov m, dx; сохран€ем результат в m 
exit:
Invoke ExitProcess, 1
End Start
