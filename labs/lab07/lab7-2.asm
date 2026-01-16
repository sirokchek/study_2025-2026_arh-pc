%include 'in_out.asm'

SECTION .data
    msg1 db 'Введите B: ',0h
    msg2 db 'Наибольшее число: ',0h
    A dd 20
    C dd 50

SECTION .bss
    max resd 1   ; храним число
    B resd 1     ; храним число

SECTION .text
global _start
_start:
    ; Вывод запроса
    mov eax, msg1
    call sprint

    ; Ввод B как строки
    mov ecx, B
    mov edx, 10
    call sread

    ; Преобразование строки B в число
    mov eax, B
    call atoi
    mov [B], eax

    ; Записываем A в max
    mov eax, [A]
    mov [max], eax

    ; Сравниваем A и C
    mov eax, [A]
    cmp eax, [C]
    jg check_B   ; если A > C, идём сравнивать с B
    ; Иначе записываем C в max
    mov eax, [C]
    mov [max], eax

check_B:
    ; Сравниваем max(A,C) с B
    mov eax, [max]
    cmp eax, [B]
    jg fin       ; если max(A,C) > B, идём на вывод
    ; Иначе записываем B в max
    mov eax, [B]
    mov [max], eax

fin:
    ; Вывод результата
    mov eax
    call sprint
    mov eax, [max]
    call iprintLF
    call quit
