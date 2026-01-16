%include 'in_out.asm'

SECTION .data
filename db 'name.txt', 0h
msg1 db 'Как Вас зовут? ', 0h
msg2 db 'Меня зовут ', 0h

SECTION .bss
name resb 255

SECTION .text
global _start

_start:
    ; Спрашиваем имя
    mov eax, msg1
    call sprint

    ; Читаем имя
    mov ecx, name
    mov edx, 255
    call sread

    ; Создаём файл
    mov ecx, 0777o
    mov ebx, filename
    mov eax, 8
    int 80h

    ; Сохраняем дескриптор
    mov esi, eax

    ; Пишем "Меня зовут "
    mov eax, msg2
    call slen
    mov edx, eax
    mov ecx, msg2
    mov ebx, esi
    mov eax, 4
    int 80h

    ; Пишем имя
    mov eax, name
    call slen
    mov edx, eax
    mov ecx, name
    mov ebx, esi
    mov eax, 4
    int 80h

    ; Закрываем файл
    mov ebx, esi
    mov eax, 6
    int 80h

    call quit
