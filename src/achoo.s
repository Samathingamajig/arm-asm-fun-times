.global _start
.section .text
.align 4       // Ensure alignment for 64-bit instructions

/**
 * uint64_t strlen (const char *str)
 *
 * Returns the length of null-terminated string `str`
 */
strlen:
    mov x1, #0 // initialize length to 0
strlen_loop_body:
    ldrb w2, [x0, x1] // load next byte
    cbz x2, strlen_end // loop until null byte
    add x1, x1, #1 // add 1 to return value
    b strlen_loop_body
strlen_end:
    mov x0, x1 // return must be in r0
    ret


_start:
    ldur x19, [SP] // load argc
    sub x19, x19, #1 // we don't care about program name
    add x20, SP, #16 // go to argv, skip first entry

    adrp x22, space // get address of `space` safely
    add x22, x22, :lo12:space

argc_loop_body:
    cbz x19, argc_loop_end // exit after last argument

    sub x19, x19, #1
    ldur x21, [x20] // load next char *arg
    add x20, x20, #8

    // get strlen of next arg
    mov x0, x21
    bl strlen

    // prepare write system call of argument
    mov x8, #64 // syscall write
    mov x2, x0 // strlen (arg)
    mov x1, x21 // char *arg
    mov x0, #1 // stdout
    svc 0x0

    // write a space between each argument
    mov x0, #1 // stdout
    mov x1, x22 // space
    mov x2, #1 // length of space
    svc 0x0 // trigger syscall

    b argc_loop_body
argc_loop_end:

    // end with newline character
    mov x8, #64 // syscall write
    mov x0, #1 // stdout
    adrp x1, newline
    add x1, x1, :lo12:newline
    mov x2, #1 // length of newline
    svc 0x0 // trigger syscall

    // exit(0)
    mov x8, #93 // syscall exit
    mov x0, #0 // exit with status 0
    svc 0x0 // trigger syscall

.section .rodata
    space:
    .ascii " "
    newline:
    .ascii "\n"

.section .data
