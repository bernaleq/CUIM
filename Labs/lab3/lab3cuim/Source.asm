.686
.model flat,stdcall
.stack 100h
.data
arr dq 100 dup (0.0);массив значений дл€ ответа
operand dd -49.0;
tmp dd 0.0;
tmp_6 dd 6.0;
tmp_2 dd 2.0;
answer dd 0.0;
step dd 1.0;
.code
ExitProcess PROTO STDCALL :DWORD

Start:

	mov ecx, 0;

	finit;

	L1:
		
		mov ebx, -49;задаЄм начальное значение x ƒл€ сравнени€
		add ebx, ecx;прибавл€ем к -49 текущее значение счЄтчика(0-100)
		fld answer;
		fld operand;
		
		cmp ebx, 0;
		jg L2;to x*x

		cmp ebx, -1;
		jl L3;to 2*sqrt(x-6)

		jmp L4;to x

		L2:
			;x*x
			fadd st(1), st(0);помещаем значение operand в answer
			fmul operand;умножаем st(0) на значение operand
			fstp arr[ecx*8]; помещаем st(0) в массив, выталкива€ с вершины стэка
			fadd step; прибавл€ем к  st(0) 1
			fstp operand; помещаем значение st(0) в operand
			jmp L5;

		L3:
			;2*sqrt(x-6)
			fadd st(1), st(0);помещаем значение operand в answer
			fsub tmp_6;
			fabs;вычисл€ем модуль, чтобы вычислить квдратный корень (а то на входе отрицательное число)
			fsqrt;


			fmul tmp_2;

			fstp arr[ecx*8];

			fadd step;
			fstp operand;

			jmp L5;


		L4:
			;x
			fadd st(1), st(0);
			fstp arr[ecx*8];
			fadd step;
			fstp operand;
			jmp L5;

	L5:

		inc ecx;
		cmp ecx, 100;
		jne L1;

exit:
Invoke ExitProcess,1
End Start
