bits 32

global _fibonacci@4, _walk_list_map@8


section .text


_fibonacci@4:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This method takes a single parameter:
;	
;	Param 1: The fibonacci number to calculate (e.g., "5" would indicate
;	to calculate and return the 5th fibonacci number).
;
;	int __stdcall fibonacci(int n);	
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
push ebp
mov ebp, esp

xor eax, eax        ;current fib number
mov eax, 1          ;start at 1
xor edx, edx        ;previous fib number
mov edi, [ebp + 8]	;move the number into edi
.fibloop:
    xadd eax, edx       ;last=fib and fib = fib+last
    sub edi, 1
    cmp edi, 1
    ja .fibloop       ;loop through however many times is supplied
                       
pop ebp 
ret 4
;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;


struc Node
	.Next	resd  1
	.Data	resd  1
endstruc


_walk_list_map@8:
;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	This method takes two parameters:
;
;	Param 1: A pointer to the beginning of a linked list of nodes (structure
;	definition above)
;
;	Param 2: A function pointer
;
;	Your task:
;	1.) Walk the list of nodes
;	2.) For each node, call the function pointer provided
;	as parameter 2, giving it as input the Data from the node.
;
;	void __stdcall walk_list_map(Node* n, void(*)(size_t));
;
; BEGIN STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;
push ebp
mov ebp, esp
xor esi, esi
xor edi, edi
mov esi, [ebp + 8]					;head node
mov edi, [ebp + 12]					;function to call

.callLoop:
	xor eax, eax
	mov eax, [esi + Node.Data]		;add the data to eax
	push eax						;push data on to stack
	call edi						;call function with eax as param 1
	pop eax							;pop eax
	mov esi, [esi + Node.Next]		;go to next node
	cmp esi, 0						;check if node is empty
	je .end							;if node is empty end program
	jmp .callLoop					;loop back and call function with next node data

.end:
	pop ebp
	ret 8

;;;;;;;;;;;;;;;;;;;;;;;;;;
; END STUDENT CODE
;;;;;;;;;;;;;;;;;;;;;;;;;;