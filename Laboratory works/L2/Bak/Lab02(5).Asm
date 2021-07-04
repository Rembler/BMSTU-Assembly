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

         .DATA
A        SDWORD  5
B        SDWORD  2
D        SDWORD  1
Zapros   DB      13,10,'Input Y',13,10,0
Result   DB      'Result='
ResStr   DB      16 DUP (' '),0
NewLine  DB      13,10,0

         .DATA?
inbuf    DB    100 DUP (?)
S        SDWORD  ?
Y        SDWORD  ?
Buffer   DB      10 DUP (?)
;inbuf    DB      100 DUP (?)

         .CODE
Start:   Invoke StdOut,ADDR Zapros
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer
         mov    DWORD PTR Y,EAX
         
         mov    EAX,B
         imul   EAX
         mov    EBX,EAX
         mov    EAX,A
         sub    EAX,EBX
         mov    EBX,Y
         sub    EBX,A
         idiv   EBX
         mov    EBX,EAX
         mov    EAX,A
         imul   EAX
         add    EBX,EAX
         sub    EBX,D
         mov    S,EBX       
         XOR    EAX,EAX
         
         Invoke dwtoa,S,ADDR ResStr
         Invoke StdOut,ADDR Result
         Invoke StdOut,ADDR NewLine
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

