section .data

   src_str db 'How long is this string',0
   dst_str db 'xxxxxxxxxxxxxxxxxxxxxxxxxxx',0

section .text
   extern puts

   global main

   main:

   ;size
      push 15
   ;src
      push src_str
   ;dst
      push dst_str
      call mymemcpy
      add esp, 12

   printres:
      push dst_str
      call puts
      add esp, 4
      jmp _exit
   
   ;strlen implementation
   mymemcpy:
      push ebp
      mov ebp, esp
   ;setup counter
      mov ecx, [ebp+16]
      dec ecx
   ;setup strings in register
      mov ebx, [ebp+12]
      mov edx, [ebp+8]

   loop:

      mov eax, [ebp+12]
      mov edi, [ebp+8]
      repne stosb
      xor eax, eax
      mov esp, ebp
      pop ebp
      ret

   _exit:
      mov   eax, 1
      mov   ebx, 0
      int   80h