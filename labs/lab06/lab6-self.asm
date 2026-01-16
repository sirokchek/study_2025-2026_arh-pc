%include 'in_out.asm'

SECTION .data
    msg: DB 'Введите x: ', 0
    res: DB 'Результат: ', 0
SECTION .bss
    x: RESB 80

SECTION .text
    GLOBAL _start
_start:
    
    mov eax, msg
    call sprintLF

    
    mov ecx, x
    mov edx, 80
    call sread

    ; Преобразование строки в число (x)
    mov eax, x
    call atoi         ; теперь eax = x (число)

    ; Вычисление f(x) = (8*x - 6) / 2
    mov ebx, 8
    mul ebx          ; eax = 8*x
    sub eax, 6       ; eax = 8*x - 6
    mov ebx, 2
    div ebx          ; eax = (8*x - 6) / 2 (частное)

    ; Вывод результата
    mov ecx, eax     ; сохраняем результат в ecx
    mov eax, res     ; "Результат: "
    call sprint
    mov eax, ecx     ; восстанавливаем результат
    call iprintLF    ; вывод числа

    ; Завершение программы
    call quit
