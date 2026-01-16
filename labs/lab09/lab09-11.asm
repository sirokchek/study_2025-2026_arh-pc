%include 'in_out.asm'

SECTION .data
    msg db 'Введите x: ',0
    result db 'f(x)=15x-9=',0

SECTION .bss
    x resb 10
    res resd 1

SECTION .text
global _start

_start:
    ; Ввод x
    mov eax, msg
    call sprint
    
    mov ecx, x
    mov edx, 10
    call sread
    
    mov eax, x
    call atoi          ; eax = x
    
    ; Вызов подпрограммы
    call calc_fx       ; eax = f(x)
    
    ; Вывод результата
    mov [res], eax
    mov eax, result
    call sprint
    mov eax, [res]
    call iprintLF
    
    call quit

; --- Подпрограмма вычисления f(x)=15x-9 ---
calc_fx:
    imul eax, 15       ; eax = 15*x
    sub eax, 9         ; eax = 15x - 9
    ret
