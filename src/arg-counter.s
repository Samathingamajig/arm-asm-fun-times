.global _start
.section .text
// .align 4       // Ensure alignment for 64-bit instructions

_start:
    mov x8, #93 // syscall exit
    ldur x0, [SP] // load argc as exit code
    svc 0x0 // trigger syscall

.section .data
