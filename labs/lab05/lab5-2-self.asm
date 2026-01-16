%include 'in_out.asm'

SECTION .data
msg: DB 'Введите строку: ',0h

SECTION .bss
buf1: RESB 80

SECTION .text
GLOBAL _start
_start:
    ; вывод приглашения
    mov eax, msg
    call sprintLF

    ; ввод строки
    mov ecx, buf1
    mov edx, 80
    call sread

    ; ВЫВОД ВВЕДЁННОЙ СТРОКИ (новая часть)
    mov eax, buf1
    call sprintLF

    ; выход
    call quit
