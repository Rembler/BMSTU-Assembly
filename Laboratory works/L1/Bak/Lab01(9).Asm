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
A        DWORD  -30
B        DWORD  21
D        BYTE "����� Roman",0

         .DATA?
X        DWORD  ?
inbuf    DB    100 DUP (?)

         .CODE
Start:   mov    EAX,A
         add    EAX,5
         sub    EAX,B
         mov    X,EAX
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

