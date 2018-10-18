; Author: ELF
; File: Lab9 (Functions and Fibonnaci)
; IQT - ASM

bits 64

global first_func, second_func, third_func

extern printf
mystr  db "Success!", 0xa, 0x00

first_func:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  The function printf has been
;  externed in (above). Call it,
;  passing mystr (also defined
;  above), as its only argument.
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    xor rax, rax
    mov rdi, mystr
    call printf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

extern strlen

second_func:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Your function will be called
;  with two arguments: a function
;  pointer (the first parameter),
;  and a string (the second). The
;  function pointer takes two
;  arguments: a string, and a length.
;  You will need to call strlen
;  (above), passing in the string,
;  and pass the results to the
;  function pointer (along with the
;  string). Return the string you get
;  back from the function. 
;
;  This lab requires a lot of instructions
;
;  It may be wise to seperate the instructions
;  into logical sections. 
;
;  -Very first thing you need to do is figure out calling convention
;  -You will first need to ensure you preserve values
;  -Then you will need to get the string length of the string provided via argument
;  -After which, you need to pass the string and string length to the 
;   function pointer and then call the function pointer.
;  
;  HINTS: 
;  - Preserve values, you will def need to preserve function pointer for call
;  - Some arguments will need to be preserved/reassigned to different registers
;    in order to be passed/called later. 
;
; 
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    push rbp
    mov rbp, rsp

    push rdi                ; pushed rdi (function pointer) onto stack so we can get its value back later
    mov rdi, rsi            ; moved the string into rdi so we can use it in the next function

    xor rax, rax            ; clear out rax for return value
    call strlen             ; called strlen where the first parameter is rdi (the string we were given)

    mov rsi, rax            ; move the string length returned value into rsi

    pop rcx                 ; takes the function pointer off the stack and stores it into rcx

    call rcx                ; calls the function pointer using the string as rdi the length as rsi
                            
    pop rbp   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret

third_func:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Calculate the Nth fibonacci
;  number (where N is the value
;  passed to your method as the
;  only parameter).
;
;  BEGIN student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    push rbp
    mov rbp, rsp

    xor rax, rax        ;current fib number
    mov rax, 1          ;start at 1
    xor rdx, rdx        ;previous fib number
    .fibloop:
        xadd rax, rdx       ;last=fib and fib = fib+last
        sub rdi, 1
        cmp rdi, 1
        ja .fibloop       ;loop through however many times is supplied
                       
    pop rbp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  END student code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ret


