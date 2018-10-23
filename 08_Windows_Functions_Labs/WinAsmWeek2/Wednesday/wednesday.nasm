bits 32

global _sum_array@8, _find_largest

section .text


_sum_array@8:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This method takes two parameters:
;
;	Param 1: A pointer to a buffer of integers (4 bytes/each).
;
;	Param 2: A number indicating the number of elements in the buffer.
;
;	You must:
;	1.) Walk through the buffer, and sum together all of the elements
;	2.) Return the result
;
;	int __stdcall sum_array(int* buffer, int size);
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
push ebp
mov ebp, esp

mov edi, [ebp + 8]				;moving the buffer of ints into edi
mov ecx, [ebp + 12]				;storing the size of the array into ecx
xor eax, eax
.addLoop:
	add eax, [edi]				;adds eax to the value of edi
	add edi, 4					;moves to the next int in the array
	loop .addLoop				;loops through for each value in the array

pop ebp
ret 8							;returns the value stored in eax
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;


_find_largest:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This function takes two
;	parameters:
;
;	Param 1: A pointer to a buffer of integers (4 bytes/each)
;
;	Param 2: A number indicating the number of elements in the
;	buffer.
;
;	Your task is to:
;	1.) Walk through the buffer, locating the largest element
;	2.) Return it as the result.	
;
;	int __cdecl find_largest(unsigned long* buffer, int size)
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
push ebp
mov ebp, esp

mov edi, [ebp + 8]				;pointer to beginning of array of ints
mov ecx, [ebp + 12]				;number of ints in the array
		
xor eax, eax			
.findLoop:
	cmp eax, [edi]				;compares whatever is in eax to the int we are currently looking at
	ja .nextInt					;if eax is > than the int in the array then skip next instruction
	mov eax, [edi]				;if eax <= current value then move that value into eax
	.nextInt:					;move on to next int in the array and loop through all ints
		add edi, 4
		loop .findLoop

pop ebp
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;