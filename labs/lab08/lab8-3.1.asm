%include 'in_out.asm'

SECTION .data
    msg db 'Результат: ',0h

SECTION .text
global _start

_start:
    ; --- Извлечение количества аргументов ---
    pop ecx            ; ecx = argc
    
    ; --- Пропускаем имя программы ---
    pop edx            ; edx = argv[0]
    
    ; --- Проверяем, есть ли аргументы ---
    sub ecx, 1         ; ecx = количество реальных аргументов
    cmp ecx, 0
    je no_args         ; если аргументов нет → выход
    
    ; --- Инициализация произведения ---
    mov esi, 1         ; esi = 1 (начальное значение для умножения)
    
next_arg:
    ; --- Извлекаем следующий аргумент ---
    pop eax            ; eax = argv[i]
    
    ; --- Преобразуем строку в число ---
    call atoi          ; eax = число
    
    ; --- УМНОЖАЕМ на произведение ---
    imul esi, eax      ; esi = esi * eax
    
    ; --- Уменьшаем счётчик и проверяем ---
    dec ecx            ; уменьшаем количество оставшихся аргументов
    cmp ecx, 0
    jne next_arg       ; если ещё есть аргументы → повторяем
    
    ; --- Вывод результата ---
    mov eax, msg
    call sprint        ; "Результат: "
    
    mov eax, esi       ; переносим произведение в eax для вывода
    call iprintLF      ; выводим число
    
    jmp exit

no_args:
    mov eax, msg
    call sprint        ; "Результат: "
    mov eax, 1         ; 1 (нейтральный элемент умножения)
    call iprintLF      ; "1"

exit:
    call quit
