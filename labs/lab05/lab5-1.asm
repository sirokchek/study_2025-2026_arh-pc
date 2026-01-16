0;10;8MSECTION .data
msg db 'Введите строку:',10
msgLen equ $-msg
SECTION .bss
buf1 resb 80
SECTION .text
global _start
_start:
    mov eax,4
    mov ebx,1
    mov ecx,msg
    mov edx,msgLen
    int 0x80
    mov eax,3
    mov ebx,0
    mov ecx,buf1
    mov edx,80
    int 0x80
    mov eax,1
    mov ebx,0
    int 0x80
