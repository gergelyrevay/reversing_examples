section .data

   str1 db 0
   str2 db 'string',0
   res_str db 'Return: %d',10,0
   RES_STR_LEN equ $ - res_str

section .text
   extern puts
   extern printf

   global main

   main:


   ;setup and call strlen
      push str2
      push str1
      call mystrcmp
      add esp, 8

   printres:
      push eax
      push res_str
      call printf
      add esp, 8
      jmp _exit
   
   ;strlen implementation
   mystrcmp:
      push ebp
      mov ebp, esp
   ;set eax to null byte
      mov esi, [ebp+8]
      mov edi, [ebp+12]
   loop:
      xor eax, eax
      xor ebx, ebx
      mov al, byte [esi]
      mov bl, byte [edi]
      cmp al, bl
      ja str1greater ; eax greater
      jb str2greater ; ebx greater
      ;if both are zero then exit, enough to check one, because here they are equal
      test al, bl
      jz equal
      ;if characters equal and not zero then exit
      inc esi
      inc edi
      jmp loop

   str1greater:
      mov eax, 1
      jmp return

   str2greater:
      mov eax, -1
      jmp return

   equal:
      mov eax, 0
   return:
      mov esp, ebp
      pop ebp
      ret


   _exit:
      mov   eax, 1
      mov   ebx, 0
      int   80h