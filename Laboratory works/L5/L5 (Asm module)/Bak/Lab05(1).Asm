; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    "Press Enter to Exit",0AH,0DH,0
Zapros   DB    "Enter String",13,10,0
ResStr   DB    "Results:",13,10,0
NewLine  DB    13,10,0
Connect  DB    " - ",0

         .DATA
Buffer   DB    255 DUP (0)
CurWord  DB    100 DUP (0)
SameWord DB    100 DUP (0)
Result   DB    255 DUP (0)
;Buffer   DB    "somebody once some samebody once told simebody",0

         .DATA?
inbuf    DB    100 DUP (?)

         .CODE
         public _STR_SAME
         externdef ?PRINT:near
_STR_SAME proc
Start:   Invoke StdOut,ADDR Zapros
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         
         Invoke StdOut,ADDR ResStr
         lea    ECX,Result
         lea    ESI,Buffer
         dec    ESI
next_word:
         inc    ESI
         mov    AL,0
         lea    EDI,CurWord
clear_word:
         cmp    BYTE PTR [EDI],0
         je     no_copied_word
            stosb
            jmp     clear_word
no_copied_word:
         lea    EDI,CurWord
copy_word:
         cmp    BYTE PTR [ESI],0
         je     end_of_line
            cmp    BYTE PTR [ESI],20h
            je     end_of_word
                movsb
                jmp    copy_word
end_of_word:
         push   ESI
check_next_word:
         inc    ESI
         cmp    BYTE PTR [ESI],0
         jne      not_the_end
            pop     ESI
            jmp     next_word
not_the_end:
         push   ESI
         mov    EBX,0
         lea    EDI,CurWord
word_cmp:
         cmp    BYTE PTR [EDI],0
         je     kudato
            cmp     BYTE PTR [ESI],0
            je      kudato
                cmp     BYTE PTR [ESI],20h
                je      kudato
                    cmpsb
                    je  no_inc
                        inc     EBX
no_inc:
                    jmp     word_cmp
kudato:
        cmp     BYTE PTR [EDI],0
        jne     not_the_same
            cmp     BYTE PTR [ESI],20h
            je     check_ebx
                cmp     BYTE PTR [ESI],0
                jne     not_the_same
check_ebx:
                cmp     EBX,1
                jg      not_the_same
                     mov     EDI,ECX
                     lea     ESI,CurWord
cur_to_res:
                     cmp     BYTE PTR [ESI],0
                     je      cur_to_res_end
                        movsb
                        jmp     cur_to_res
cur_to_res_end:  
                     mov     AL,20h
                     stosb
                     mov     AL,'-'
                     stosb
                     mov     AL,20h
                     stosb
                     mov     AL,0
                     mov     ECX,EDI
                    ;Invoke StdOut,ADDR CurWord
                    ;Invoke StdOut,ADDR Connect
                    pop     ESI
                    lea     EDI,SameWord
copy_copy_word:
                    cmp     BYTE PTR [ESI],20h
                    je      copy_word_end
                        cmp     BYTE PTR [ESI],0
                        je      copy_word_end
                            movsb
                            jmp     copy_copy_word
copy_word_end:
         mov    AL,0
         cmp    BYTE PTR [EDI],0
         je     no_del
            stosb
            jmp copy_word_end
no_del:
         mov    EDI,ECX
         push   ESI
         lea    ESI,SameWord
same_to_res:
         cmp     BYTE PTR [ESI],0
         je      same_to_res_end
            movsb
            jmp     same_to_res
same_to_res_end:  
         mov    AL,';'
         stosb
         mov    AL,20h
         stosb
         mov    AL,0
         pop    ESI
         mov    ECX,EDI
         ;Invoke StdOut,ADDR SameWord
         ;Invoke StdOut,ADDR NewLine
         jmp    check_next_word          
not_the_same:
         add    ESP,4
reach_the_end:
         cmp    BYTE PTR [ESI],20h
         je     check_next_word
            cmp     BYTE PTR [ESI],0
            je      check_next_word
                inc     ESI
                jmp     reach_the_end
end_of_line:
         
         XOR    EAX,EAX
         Invoke StdOut,ADDR Result
         Invoke StdOut,ADDR NewLine
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start
         ret
         _STR_SAME endp
end