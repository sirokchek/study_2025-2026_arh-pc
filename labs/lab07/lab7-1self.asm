%include 'in_out.asm' ;
SECTION .data
    a dd 99
    b dd 29
    c dd 26
    msg_yes db 'a > b: (a+b)/c = ',0h
    msg_no  db 'a <= b: (c-b)*a = ',0h

SECTION .bss
    result resd 1

SECTION .text
global _start
_start:
    ; Сравниваем a и b
    mov eax, [a]
    cmp eax, [b]
    jg calculate_yes   ; если a > b

    ; --- a <= b ---
    mov eax, [c]
    sub eax, [b]       ; eax = c - b
    imul eax, [a]      ; eax = (c - b) * a
    mov [result], eax

    mov eax, msg_no
    call sprint
    jmp output

calculate_yes:
    ; --- a > b ---
    mov eax, [a]
    add eax, [b]       ; eax = a + b
    cdq                ; расширяем eax в edx:eax для деления
    idiv dword [c]     ; eax = (a+b)/c, edx = остаток
    mov [result], eax

    mov eax, msg_yes
    call sprint

output:
    mov eax, [result]
    call iprintLF
    call quit
