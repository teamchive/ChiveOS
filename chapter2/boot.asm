%include    "pm.inc"
org 7c00h
START:
jmp LABEL_BEGIN
SEG_START_LEN equ $-$$
;====================================
;定义GDT表
[SECTION .gdt]
LABEL_GDT:          DESC 0,0,0
LABEL_DESC_CODE32:  DESC 0,SEG_CODE32_LEN - 1,DA_C + DA_32
LABEL_DESC_VIDEO:   DESC 0x0b8000,0x0ffff,DA_DRW
;====================================================
; 定义gdt表项选择子
gdt_len equ $ - LABEL_GDT
gdt_ptr dw  gdt_len - 1,
        dd  0
;========================================================
;GDT表项选择子
SELE_CODE32 equ LABEL_DESC_CODE32 - LABEL_GDT
SELE_VIDEO  equ LABEL_DESC_VIDEO - LABEL_GDT
;==========================================================

SEG_GDT_LEN equ $-$$

[SECTION .s16]
[BITS   16]
LABEL_BEGIN:
    mov ax, cs
    mov dx, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x100

    ; initialize code_32_descriptor
    INIT_SEG32 LABEL_SEG_CODE32, LABEL_DESC_CODE32

    ; load GDT's base address to gdt_ptr, then lgdt
    xor eax, eax
    mov ax, ds
    shl eax, 4
    add eax, LABEL_GDT
    mov dword [gdt_ptr + 2], eax
    lgdt [gdt_ptr]
    cli
    
.A20_CHECK:
    in al, 0x64
    test al, 2
    jnz .A20_CHECK

    mov al, 0xd1
    out 0x64, al

.A20_GATE:
    in al, 0x64
    test al, 2
    jnz .A20_GATE

    mov al, 0xdf
    out 0x60, al

    ; change to protect mode!
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp dword SELE_CODE32:0

SEG_CODE16_LEN equ $-$$

[SECTION .s32]
[BITS   32]

LABEL_SEG_CODE32:
    mov ax, SELE_VIDEO
    mov gs, ax 
    mov ah, 0x0c

    mov edi, (80*11+79)*2
    mov al, 'C'
    mov [gs:edi], ax
    jmp $
SEG_CODE32_LEN  equ $-$$
PAD SEG_START_LEN
PAD SEG_GDT_LEN
PAD SEG_CODE16_LEN

SIZE equ SEG_START_LEN+SEG_GDT_LEN+SEG_CODE16_LEN+SEG_CODE32_LEN

times      (512 - SIZE - 2) db 0
db   0x55, 0xAA  