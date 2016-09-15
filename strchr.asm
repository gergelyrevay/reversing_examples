section .data

   test_str db 'How long is this string',0
   res_str db 'Char is at: %d',10,0
   RES_STR_LEN equ $ - res_str

section .text
   extern puts
   extern printf

   global main

   main:


   ;setup and  call strlen
      push 69 ; character 'i'
      push test_str
      call mystrchr
      add esp, 8

   printres:
      push eax
      push res_str
      call printf
      add esp, 8
      jmp _exit
   
   ;strlen implementation
   mystrchr:
      push ebp
      mov ebp, esp
   ;find length of string
      mov eax, 0h
      mov edi, [ebp+8]
      mov edx, edi
      mov ecx, 0fffffffh
      repne scasb
      sub edi, edx
      dec edi

   ;find char
      mov ecx, edi
      mov ebx, ecx ; save the lenght of the string for comparison
      mov eax, [ebp+12]
      mov edi, edx
      repne scasb
      sub edi, edx
      cmp ebx, edi
      jne found 
      mov edi, 0
   found:
      mov eax, edi
      mov esp, ebp
      pop ebp
      ret
   
   _exit:
      mov   eax, 1
      mov   ebx, 0
      int   80h