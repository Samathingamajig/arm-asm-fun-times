.global _start
.section .text
# .align 4       // Ensure alignment for 64-bit instructions

_start:
    mov x8, #64 // syscall write
    mov x0, #1 // stdout
    ldr x1, =message // write out message buffer
    mov x2, #14 // number of bytes in message
    svc 0x0 // trigger syscall

    mov x8, #93 // syscall exit
    mov x0, #0 // exit with status 0
    svc 0x0 // trigger syscall

.section .data
    message:
    .ascii "Hello, World!\n"
