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
SomeStr  DB    "Some body once",0

         .DATA
Buffer   DB    100 DUP (0)
Changed  DB    100 DUP (0)
ResStr   DB    16 DUP (' '),0

         .DATA?
inbuf    DB    100 DUP (?)

         .CODE
Start:   
	    
	    ;search for consonants in words
	    Invoke StdOut,ADDR Notice_2
        lea    ESI,SomeStr
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
	    
	    ;finishing the work      
        XOR    EAX,EAX
        Invoke StdOut,ADDR MsgExit
        Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
        Invoke ExitProcess,0
        End    Start

