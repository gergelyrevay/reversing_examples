section .data

   test_str db 'How long is this string',0

section .text
   extern puts

   global main

   main:

   ;size
      push 15
   ;byte to set to
      push 41h
   ;pointer to the string
      push test_str
      call mymemset
      add esp, 12

   printres:
      push test_str
      call puts
      add esp, 4
      jmp _exit
   
   ;strlen implementation
   mymemset:
      push ebp
      mov ebp, esp
   ;set eax to null byte
      mov eax, [ebp+12]
      mov edi, [ebp+8]
      mov edx, edi
      mov ecx, [ebp+16]
      repne stosb
      xor eax, eax
      mov esp, ebp
      pop ebp
      ret

   _exit:
      mov   eax, 1
      mov   ebx, 0
      int   80h