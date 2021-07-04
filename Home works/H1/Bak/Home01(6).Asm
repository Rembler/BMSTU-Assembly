; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    13,10,"Press Enter to Exit",0AH,0DH,0
Zapros   DB    "Input string",13,10,0
Vowels   DB    "eyuioaEYUIOA"
AddSpace DB    " ",0
NewLine  DB    13,10,0
Notice_1 DB    "Number of vowels in a line:",13,10,0
Notice_2 DB    13,10,"Number of consonants in each word:",13,10,0

         .DATA
Buffer   DB    100 DUP (0)
Changed  DB    100 DUP (0)
ResStr   DB    16 DUP (' '),0

         .DATA?
inbuf    DB    100 DUP (?)

         .CODE
Start:   
        Invoke StdOut,ADDR Zapros
        Invoke StdIn,ADDR Buffer,LengthOf Buffer
        Invoke StripLF,ADDR Buffer
         
        lea    ESI,Buffer
        lea    EDI,Changed
        cld
        lodsb
        mov    BL,AL
Pre_cycle:
        cmp    AL,0
        je     Pre_cycle_end
        lodsb
        cmp    AL,20h
        jne    Add_to_changed
        cmp    BL,20h
        jne    Add_to_changed
        jmp    Not_add
Add_to_changed:
        stosb
Not_add:
        mov     BL,AL
        jmp Pre_cycle
Pre_cycle_end:            
            
        lea    ESI,Buffer
        mov    EBX,0
        cld
        lodsb
Cycle_1:   
        cmp    AL,0
        je     Cycle_1_end
        lea    EDI,Vowels
        mov    ECX,12
        repne scasb
        jne    Not_vowel
        inc EBX
Not_vowel:
        lodsb
        jmp    Cycle_1
Cycle_1_end:
        Invoke StdOut,ADDR Notice_1
        Invoke dwtoa,EBX,ADDR ResStr
	    Invoke StdOut,ADDR ResStr
	    
	    Invoke StdOut,ADDR Notice_2
        lea    ESI,Changed
        mov    EBX,0
        cld
        lodsb
Cycle_2:
        cmp    AL,0
        je     Cycle_2_end
        cmp    AL,20h
        je     Space
        lea    EDI,Vowels 
        mov    ECX,12 
        repne scasb
        je     Vowel
        inc EBX
Vowel:
        jmp Not_space
Space:
        Invoke dwtoa,EBX,ADDR ResStr
	    Invoke StdOut,ADDR ResStr
	    Invoke StdOut,ADDR AddSpace
        mov EBX,0
Not_space:
        lodsb
        jmp    Cycle_2
Cycle_2_end:
        Invoke dwtoa,EBX,ADDR ResStr
	    Invoke StdOut,ADDR ResStr
	          
        XOR    EAX,EAX
        Invoke StdOut,ADDR MsgExit
        Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
        Invoke ExitProcess,0
        End    Start

