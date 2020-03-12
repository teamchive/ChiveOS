; some macros for GDT, descriptors, selectors and so on.

%macro PAD 1
    %assign %1  %1+4-%1 % 4
%endmacro

%macro DESC 3
    dw %2 & 0ffffh
    dw %1 & 0ffffh
    db (%1 >> 16) & 0ffh
    dw ((%2 >> 8) & 0f00h) | (%3 & 0f0ffh)
    db (%1 >> 24) & 0ffh
%endmacro

;first arg:LABEL_SEG, second arg:LABEL_DESC_SEG32 
%macro INIT_SEG32 2
    xor eax, eax
    mov ax, cs
    shl eax, 4
    add eax, %1
    mov word [%2 + 2], ax
    shr eax, 16
    mov byte [%2 + 4], al
    mov byte [%2 + 7], ah
%endmacro


DA_C    equ    98h
DA_32   equ    4000h
DA_DRW  equ    92h

