section .data

   test_str db 'How long is this string',0
   res_str db 'The length is: '
   RES_STR_LEN equ $ - res_str

section .text
   extern puts

   global _start

   _start:


   ;setup and  call strlen
      push test_str
      call mystrlen
      add esp, 4

   printres:
      push eax
      push res_str
      call puts
      add esp, 4
      call puts
      add esp, 4
      jmp _exit
   
   ;strlen implementation
   mystrlen:
      push ebp
      mov ebp, esp
   ;set eax to null byte
      mov eax, 0h
      mov edi, [ebp-8]
      mov edx, edi
      mov ecx, 0fffffffh
      repne scasb
      sub edi, edx
      mov eax, edi
      mov esp, ebp
      pop ebp
      ret

   _exit:
      mov   eax, 1
      mov   ebx, 0
      int   80h