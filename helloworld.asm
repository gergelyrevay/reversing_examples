// hello_amd64.S -- hello world in GNU ASM (GAS).
 
// Some constants
.equiv STDOUT, 1                /* file descriptor for stdout */
.equiv RETVAL, 0                /* argument for exit() */
.equiv SYS_WRITE, 1             /* WRITE syscall ID */
.equiv SYS_EXIT, 60              /* EXIT syscall ID */
     
// Data section (read-only)
    .section    .rodata
msg:
    .string "hello, world!\n"
    len = . - msg
     
// Code section
    .text
    .global    _start
_start:
 
    /*
     * According to http://www.x86-64.org/documentation/abi.pdf
     * page 124 (A.2.1), the arguments for a LINUX syscall are
     * passed in the following regs:
     *   %rdi, %rsi, %rdx, %r10, %r8 and %r9
     * One has to issue a syscall instruction,
     * which destroys %rcx.
     * %rax contains the number of the syscall.
     * Returing from syscall, register %rax contains the result.
     *
     * Note that FreeBSD/amd64 seems to follow the LINUX convention,
     * unlike FreeBSD/i386 which uses the stack for its arguments.
     */
 
    // Call write(STDOUT,msg,len);
    movl    $len,%edx
    movq    $msg,%rsi
    movl    $STDOUT,%edi
     
    movq    $SYS_WRITE,%rax
    movq    %rcx,%r10         /* syscall destroys %rcx! */
    syscall
     
bye:
    // Call exit(0);
    movl    $RETVAL,%edi
 
    movq    $SYS_EXIT,%rax
    movq    %rcx,%r10         /* syscall destroys %rcx! */
    syscalln