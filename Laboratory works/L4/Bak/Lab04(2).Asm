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

         .DATA
Arr      SDWORD  24 DUP (?)
Notice1  DB      'Your matrix:',13,10,13,10,0
Notice2  DB      'New matrix:',13,10,13,10,0
Zapros   DB      'Input element',13,10,0
Result   DB      'Result='
ResStr   DB      16 DUP (' '),0
Space    DB      ' ',0
NewLine  DB      13,10,0

         .DATA?
inbuf    DB     100 DUP (?)
Buffer   DB     10 DUP (?)
E        DWORD  ?

         .CODE
Start:   mov ECX, 0
     start_cycle:
        Invoke StdOut, ADDR Notice1
        loop start_cycle


        
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

