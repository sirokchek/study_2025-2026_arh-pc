%include 'in_out.asm'

SECTION .data
    ; Первый набор
    x1 dd 3
    a1 dd 7
    ; Второй набор
    x2 dd 6
    a2 dd 4
    
    msg1 db 'Для (x1=3, a1=7): f(x) = ',0h
    msg2 db 'Для (x2=6, a2=4): f(x) = ',0h

SECTION .bss
    res1 resd 1
    res2 resd 1

SECTION .text
global _start
_start:
    ; --- Первый набор (3,7) ---
    mov eax, [x1]
    cmp eax, 5
    jge else1           ; если x1 >= 5
    
    ; x1 < 5
    imul eax, [a1]      ; eax = a1 * x1
    jmp save1
    
else1:
    ; x1 >= 5
    sub eax, 5          ; eax = x1 - 5
    
save1:
    mov [res1], eax
    
    ; Вывод первого результата
    mov eax, msg1
    call sprint
    mov eax, [res1]
    call iprintLF
    
    ; --- Второй набор (6,4) ---
    mov eax, [x2]
    cmp eax, 5
    jge else2           ; если x2 >= 5
    
    ; x2 < 5
    imul eax, [a2]      ; eax = a2 * x2
    jmp save2
    
else2:
    ; x2 >= 5
    sub eax, 5          ; eax = x2 - 5
    
save2:
    mov [res2], eax
    
    ; Вывод второго результата
    mov eax, msg2
    call sprint
    mov eax, [res2]
    call iprintLF
    
    call quit
