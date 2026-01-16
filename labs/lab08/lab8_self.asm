
%include 'in_out.asm'

SECTION .data
    msg db 'Сумма f(x) = 15x - 9: ',0h

SECTION .text
global _start

_start:
    ; --- Извлечение количества аргументов ---
    pop ecx                 ; ecx = argc
    
    ; --- Пропускаем имя программы ---
    pop edx                 ; edx = argv[0]
    
    ; --- Проверяем, есть ли аргументы ---
    sub ecx, 1              ; ecx = количество реальных аргументов
    cmp ecx, 0
    je no_args              ; если аргументов нет → выход
    
    ; --- Инициализация суммы ---
    mov esi, 0              ; esi = 0 (здесь будет сумма f(x))
    
process_arg:
    ; --- Извлекаем следующий аргумент ---
    pop eax                 ; eax = argv[i] (адрес строки)
    
    ; --- Преобразуем строку в число ---
    call atoi               ; eax = x (число)
    
    ; --- Вычисляем f(x) = 15x - 9 ---
    imul eax, 15            ; eax = 15 * x
    sub eax, 9              ; eax = 15x - 9
    
    ; --- Добавляем к общей сумме ---
    add esi, eax            ; esi = esi + f(x)
    
    ; --- Уменьшаем счётчик и проверяем ---
    dec ecx                 ; уменьшаем количество оставшихся аргументов
    cmp ecx, 0
    jne process_arg         ; если ещё есть аргументы → повторяем
    
    ; --- Вывод результата ---
    mov eax, msg
    call sprint             ; "Сумма f(x) = 15x - 9: "
    
    mov eax, esi            ; переносим сумму в eax для вывода
    call iprintLF           ; выводим число
    
    jmp exit

no_args:
    mov eax, msg
    call sprint             ; "Сумма f(x) = 15x - 9: "
    mov eax, 0
    call iprintLF           ; "0" (сумма пустого множества = 0)

exit:
    call quit
