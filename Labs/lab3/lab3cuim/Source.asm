.686
.model flat,stdcall
.stack 100h
.data
arr dq 100 dup (0.0);������ �������� ��� ������
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
		
		mov ebx, -49;����� ��������� �������� x ��� ���������
		add ebx, ecx;���������� � -49 ������� �������� ��������(0-100)
		fld answer;
		fld operand;
		
		cmp ebx, 0;
		jg L2;to x*x

		cmp ebx, -1;
		jl L3;to 2*sqrt(x-6)

		jmp L4;to x

		L2:
			;x*x
			fadd st(1), st(0);�������� �������� operand � answer
			fmul operand;�������� st(0) �� �������� operand
			fstp arr[ecx*8]; �������� st(0) � ������, ���������� � ������� �����
			fadd step; ���������� �  st(0) 1
			fstp operand; �������� �������� st(0) � operand
			jmp L5;

		L3:
			;2*sqrt(x-6)
			fadd st(1), st(0);�������� �������� operand � answer
			fsub tmp_6;
			fabs;��������� ������, ����� ��������� ��������� ������ (� �� �� ����� ������������� �����)
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
