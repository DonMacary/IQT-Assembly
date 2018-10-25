bits 64

; LABS
global ex_strlen, ex_memcpy, ex_memset, ex_memcmp, ex_memchr, ex_strchr, ex_strcmp, ex_strcpy, ex_atoi
global ex_strstr, find_largest, walk_list

; BONUS LABS
global ex_isort, ex_qsort


find_largest:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  This function takes two arguments:
;  - Arg1: A pointer to an array of integers
;  - Arg2: The number of integers in the array
;
;  Find and return the largest element in the array.
;  
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

mov rcx, rsi
		
xor rax, rax			
.findLoop:
	cmp ax, [rdi]				;compares whatever is in ax to the int we are currently looking at
	ja .nextInt					;if ax is > than the int in the array then skip next instruction
	mov ax, [rdi]		        ;if ax <= current value then move that value into ax
	.nextInt:					;move on to next int in the array and loop through all ints
		add rdi, 4
		loop .findLoop

pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_strlen:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  size_t strlen(char*);  
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp
xor al, al                  ;holds the current character of the string
xor rcx, rcx                ;counter variable
.loopLen:
    mov al, [rdi]           ;moves the current character into al
    cmp al, 0               ;compare if current char is 0
    je .end                 ;if we find the null character jump to end
    add rcx, 1              ;add one to length counter
    add rdi, 1              ;go to next char
    jmp .loopLen 

.end:
    mov rax, rcx            ;move the count into rax for return
    pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_memcpy:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  void memcpy(void* dst, void* src, int count);
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

mov rcx, rdx                    
rep movsb 

pop rbp         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


ex_memset:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	void memset(void* buf, unsigned char value, size_t length);
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

mov rcx, rdx
mov rax, rsi
rep stosb 

pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_memchr:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	void* memchr(void* haystack, unsigned char needle, size_t length);
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

mov rcx, rdx
mov rax, rsi
repne scasb

cmp rcx, 0              ;check if rcx is 0
je .notfound            ;if it is 0 then we did not find the character in the string

.found:
mov rax, rdi            ;if the value of rcx is >0 then move the current index into rax and return
sub rax, 1              ;we will be one above the matching byte so we need to dec 1
pop rbp
ret 

.notfound:
xor rax, rax
pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_memcmp:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	int memcmp(void*, void*, size_t length);
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

mov rcx, rdx
rep cmpsb               ;compares the two strings  and sets the flag based off of the comparison
ja .greater             ;if str 1 is > str2 then go to greater
jb .lower               ;if str1 < str2 then go to less than
.equal:                 ;if strings are equal
    xor rax, rax        ;makes rax 0 and ends
    jmp .end    

.lower:               ;if str1>str2 make rax > 0
    mov rax, 1
    jmp .end

.greater:                 ;if str1<str2 make rax < 0
    mov rax, -1

.end:
    pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_strchr:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
; DESCRIPTION:
;   The C library function char *strchr(const char *str, int c) 
;   searches for the first occurrence of the character c (an unsigned char)
;   in the string pointed to by the argument str.
; char *strchr(const char *str, int c)
;   str − This is the C string to be scanned.
;   c − This is the character to be searched in str.
; RETURN:
;   This returns a pointer to the first occurrence 
;   of the character c in the string str, or NULL if 
;   the character is not found.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

push rdi
call ex_strlen
pop rdi
mov rcx, rax                  ;puts the length of the string into rcx
mov rax, rsi                  ;puts the search character into rax
repne scasb           

cmp rcx, 0
je .notfound                  ;if rcx is 0 then we did not find the character in the string

.found:
mov rax, rdi                  ;if the value of rcx is >0 then move the current index into rax and return
sub rax, 1                    ;we will be one above the matching byte so we need to dec 1
pop rbp
ret 

.notfound:
xor rax, rax

pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_strcmp:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;  C - int strcmp(const char *str1, const char *str2)
;       str1 − This is the first string to be compared.
;       str2 − This is the second string to be compared.
; RETURN
;   if Return value < 0 then it indicates str1 is less than str2.
;   if Return value > 0 then it indicates str2 is less than str1.
;   if Return value = 0 then it indicates str1 is equal to str2.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

push rdi
call ex_strlen
pop rdi

mov rcx, rax

rep cmpsb               ;compares the two strings and sets the flag based off of the comparison
ja .greater             ;if str 1 is > str2 then go to greater
jb .lower               ;if str1 < str2 then go to less than
.equal:                 ;if strings are equal
    xor rax, rax        ;makes rax 0 and ends
    jmp .end    

.lower:               ;if str1>str2 make rax > 0
    mov rax, 1
    jmp .end

.greater:                 ;if str1<str2 make rax < 0
    mov rax, -1

.end:
    pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

ex_strcpy:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
; Description:
;   The C library function char *strcpy(char *dest, const char *src) 
;   copies the string pointed to, by src to dest.
; Parameters:
;   dest − This is the pointer to the destination array where the content is to be copied.
;   src − This is the string to be copied.
; Returns:
;   This returns a pointer to the destination string dest.
; NOTE: This function does not define how to handle when the
; destination string has info in it already - in the case where the sizes
; are mismatched and the dest has info we had to add a null term at the end to prevent overflow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp


.getLength:
    push rdi
    push rsi
    mov rdi, rsi
    call ex_strlen
    mov rcx, rax
    pop rsi
    pop rdi
.copyStr:
    push rdi
    rep movsb
    xor rax, rax
    stosb               ;add a null terminator at the end in case sizes are whacky
    pop rdi
    mov rax, rdi

pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  |-- |      |--- |    |\     |    |   |   |-------
;  |   |      |    |    | \    |    |   |   |
;  |---- |    |    |    |  \   |    |   |   |_______
;  |     |    |    |    |   \  |    |   |           |
;  |     |    |    |    |    \ |    |   |           |
;  |____ |    |___ |    |     \|    |___|   ________|
;
;
;        |           |------ |   |------ |     |-------
;        |           |       |   |       |     |_______
;        |           |------ |   |-------- |           |
;        |           |       |   |         |           |
;        |_______    |       |   |_________|   ________|
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ex_atoi:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
; DESCRIPTION:
;   The C library function int atoi(const char *str)
;   converts the string argument str to an integer (type int).
; PARAMETERS:
;   str − This is the string representation of an integral number.
; RETURN:
;   This function returns the converted integral number as an 
;   int value. If no valid conversion could be performed, it returns zero.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

xor rax, rax
.getChar:
    movzx rsi, byte [rdi]           ;take a character from thestring
    test rsi, rsi                   ;check if the character is NULL
    je .end                         ;if it is then were done

.testChar:                          ;checks if the character were looking at is an int
    cmp rsi, 32                     ;if we have a white space then were just going to skip...
    je .nextDig

    cmp rsi, 48                     
    jb .notInt                      

    cmp rsi, 57
    ja .notInt

.convertToInt:
    sub rsi, 48                     ;converts the ascii number to a regular int
    imul rax, 10                    ;creates room for the next digit (since were looking at one num at a time)
    add rax, rsi                    ;add the digit to rax

.nextDig:
    inc rdi 
    jmp .getChar

.notInt:
    mov rax, 0

.end:
    pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


ex_strstr:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
; DESCRIPTION:
;   The C library function char *strstr(const char *haystack, const char *needle)
;   function finds the first occurrence of the substring needle in the string haystack. 
;   The terminating '\0' characters are not compared.
; PARAMETERS:
;   haystack − This is the main C string to be scanned.
;   needle − This is the small string to be searched with-in haystack string.
; RETURN:
;   This function returns a pointer to the first occurrence in haystack
;   of any of the entire sequence of characters specified in needle, or a 
;   null pointer if the sequence is not present in haystack.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

.setUp:
    mov rbx, rdi                    ;storing the location of the beginning of rdi
.getLengthNeedle:
    mov rdi, rsi        
    call ex_strlen                  ;get length of needle and store it in rcx
    mov r9, rax                     ;stores needle length into r9 
.getLengthHaystack:
    mov rdi, rbx                    ;move the haystack back into rdi
    call ex_strlen                  ;gets the length of the haystack
    mov rcx, rax                    ;moves the length of the haystack into rcx
.findFirst:                         ;scans haystack for the first character of the needle
    mov rdi, rbx                    ;make sure were at the right spot in the haystack
    movzx rax, byte [rsi]           ;moves the first character of the needle into rax
    repne scasb                     ;scans the haystack for the first character
    jne .notfound                    ;end if we have reached the end of the haystack
    sub rdi, 1                      ;string instructions always go one past so we need to go back one
    mov rbx, rdi                    ;since we have found the first chr of the needle lets preserve this location

.compareNeedle:                     ;Checks to see if the next (needle len) characters of the haystack are = to the needle
    mov rcx, r9                     ;move the length of the needle from r9
    push rsi                        ;preserve the location of the needle
    rep cmpsb                       ;compare needle length times
    je .found                       ;if the two strings are = to this point then yay we found it
    pop rsi                         ;start back at the beginning of the needle
    add rbx, 1                      ;increment past the character we found 
    jmp .getLengthHaystack          ;if they are not equal then go back to looking for the first charcter again

.notfound:
    xor rax, rax
    jmp .end

.found:
    pop rsi                         ;start back at the beginning of the needle
    mov rax, rbx                    ;move the location of the haystack before we found the string (right at the beginning)

.end:
    pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


struc Node
	.Next	resq	1
	.Data	resq	1
endstruc

 walk_list:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;	This function takes 2 parameters:
;	
;	Param 1: A pointer to the beginning of a linked list of nodes (
;   structure definition given above), which is NULL-terminated (e.g., the
;   last Next pointer is NULL).
;
;	Param 2: A needle to search for within the list.
;
;	Walk the list, searching each Node for the needle (in Node.Data), and either:
;	1.) Return the node where you found the value
;	2.) Return NULL if the value cannot be found
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp
xor rbx, rbx
mov rbx, [rdi]

.findloop:
	xor rax, rax
	mov rax, [rbx + Node.Data]
	cmp rsi, rax					; checks if the data in the node is equal to the data given
	je .found						; if so jump to found
	mov rbx, [rbx + Node.Next]		; if there is another node then mov to that one
	cmp rbx, 0
	je .notfound					; if so jump to not found
	jmp .findloop					; start back at top of loop

.found:
;	mov rax, rbx					; if we find the node then move that node into rax -> current test wants the data not the node...
	jmp .end

.notfound:
	mov rax, 0						; if the node isnt in the linked list then make eax 0 and ret

.end:
	pop rbp							; return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ret


ex_isort:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  insertion_sort.c is provided
;  to give an example implementation.
;  PARAMETERS:
;   array - unsorted array
;   size - size of the array
;  Return:
;   pointer to beginning of a sorted array
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
push rbp
mov rbp, rsp

.setup:
    xor rcx, rcx
    mov rcx, 1                  ;rcx is my j
    xor rbx, rbx                ;rbx is my i
    xor rax, rax                ;rax is my key

cmp rdi, 0                      ;check if the array is empty
je .end
cmp rsi, 0                      ;check if the size is 0
je .end
.outterLoop:
    cmp rbx, rsi                ;compares j to size if j>size then were done
    ja .end
    mov rbx, rcx                ;i=j-1
    sub rbx, 1

    mov rax, [rdi + rcx]         ;key = array[j]

    .innerLoop:
        cmp rbx, 0              ;if i <=0 then iterate to next j value
        jb .outterLoop          
        cmp [rdi + rbx], rax    ;if array[i] < key iterate to next j value
        jb .outterLoop  
        mov r10, [rdi+rax]
        xchg r10, [rdi+rax]     ;array[i+1]=array[i]


.end:
    mov rax, rdi
    pop rbp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


ex_qsort:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret
