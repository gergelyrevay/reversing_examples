// hello_i386.S -- hello world in GNU ASM (GAS). FreeBSD/i386 version.
 
// Some constants
.equiv STDOUT, 1                /* file descriptor for stdout */
.equiv RETVAL, 0                /* argument for exit() */
.equiv SYS_WRITE, 4             /* WRITE syscall ID */
.equiv SYS_EXIT, 1              /* EXIT syscall ID */
//.equiv DUMMY, 0xdeadbeef        /* Used for stack padding */
     
// Data section (read-only)
    .section .rodata
    .align 4
msg:
    .string "hello, world!\n"
    len = . - msg
     
// Code section
    .text
    .align 4
    .global _start
_start:
    // Setup a new stack frame
    push    %ebp
    movl    %esp,%ebp
    sub     $0x14,%esp
 
    // Prepare arguments of write(STDOUT,msg,len);
    movl    $len,%edx
    movl    $msg,%ecx
    movl    $STDOUT,%ebx
 
    // WRITE SYSCALL
  //  pushl   $DUMMY
    movl    $SYS_WRITE,%eax
    int     $0x80
  //  popl    %ebx                /* pop DUMMY from stack */
     
    // Unwind stack frame
  //  add     $0x14,%esp
    pop     %ebp
     
bye:
    // Setup a new stack frame
    push    %ebp
    movl    %esp,%ebp
    sub     $0x8,%esp
 
    // Prepare arguments of exit(RETVAL);
    movl    $RETVAL,(%esp)
 
    // EXIT SYSCALL
  //  pushl   $DUMMY
    movl    $SYS_EXIT,%eax
    movl    $0x0, %ebx
    int     $0x80
  //  popl    %ebx                 /* NOTREACHED: pop DUMMY from stack */
 
    // NOTREACHED: No need to unwind stack frame
    add     $0x8,%esp
    pop     %ebp