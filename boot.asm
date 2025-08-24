[org 0x7C00]
[BITS 16]

start:
    ; save boot drive
    mov [BOOT_DRIVE], dl    

    ; ES:BX -> 0x1000:0000 = 0x10000
    mov ax, 0x1000
    mov es, ax
    mov bx, 0x0000

    ; read 10 sectors starting from LBA sector 2
    mov ah, 0x02       ; read sectors
    mov al, 10         ; num sectors
    mov ch, 0          ; cylinder
    mov cl, 2          ; sector (1 = bootloader, 2 = kernel start)
    mov dh, 0          ; head
    mov dl, [BOOT_DRIVE]
    int 0x13

    jc disk_error      ; jump if error (carry flag set)

    ; jump to kernel loaded at 0x10000
    jmp 0x1000:0000

disk_error:
    ; simple hang on error
    cli
    hlt

BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xAA55
