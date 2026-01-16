%include 'in_out.asm'

SECTION .data
    msg1 db 'Введите N: ',0h

SECTION .bss
    N resb 10

SECTION .text
global _start
_start:
    ; ----- Вывод сообщения 'Введите N: '
    mov eax, msg1
    call sprint

    ; ----- Ввод 'N'
    mov ecx, N
    mov edx, 10
    call sread

    ; ----- Преобразование 'N' из символа в число
    mov eax, N
    call atoi
    mov [N], eax

    ; ------ Организация цикла
    mov ecx, [N]        ; Счетчик цикла, ecx = N

label:
    mov [N], ecx        ; Сохраняем текущее значение ecx
    mov eax, [N]        ; Загружаем для вывода
    call iprintLF       ; Вывод значения
    loop label          ; ecx = ecx - 1, если не 0 → переход на label

    call quit
