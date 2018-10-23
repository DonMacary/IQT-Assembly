;Author - ELF
;Project - Tuesday Windows ASM

bits 32

global _copy_string, _get_cpu_string@4, _set_flags

section .text


_copy_string:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This method takes 2 params:
;
;	Param 1: An empty buffer
;
;	Param 2: A NULL-terminated string
;
;	Given these two inputs, 
;	1.) Find the length of the string provided in
;	param 2
;	2.) Copy the string from param 2, to the empty buffer
;	provided in param 1.
;
;	void __cdecl copy_string(char* dest, char* src);
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
push ebp
mov ebp, esp

mov edi, [ebp + 12]	;Null term string

.findLength:
	xor eax, eax
	xor ecx, ecx
	mov ecx, 65535
	repne scasb 
	mov eax, 65534
	sub eax, ecx
	mov ecx, eax

.copyString:
	xor eax, eax
	mov edi, [ebp +8]		;puts the destination buffer into edi
	mov esi, [ebp +12]		;puts the null term string into esi
	repne movsb				;copy esi into edi

pop ebp
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;

_get_cpu_string@4:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This function takes 1 param:
;
;	Param 1: A zero'd character buffer, containing
;	13 elements.
;
;	The following steps must be performed:
;	1.) Call CPUID and get the vendor string
;	2.) Copy from ASCII bytes returned into the buffer
;	provided.
;	
;	void __stdcall get_cpu_string(char* buf);
;
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
push ebp
mov ebp, esp

mov edi, [ebp + 8]					;put the buffer into edi
xor eax, eax						;clear out eax

cpuid								;call cpuid and get vendor string into ebx, edx and ecx
mov [edi], ebx						;copies the vendor string into edi
mov [edi+4], edx
mov [edi+8], ecx

pop ebp
ret 4
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;

