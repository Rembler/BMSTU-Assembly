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
A         DWORD  -30
B         DWORD  21
F1       WORD   65535
F2       DWORD  65535
;D        SWORD  25
;F        DWORD  -35
;G        BYTE "Роман Roman",0
;val1     BYTE   255
;chart    WORD   256
;lue3     SWORD  -128
;alu      BYTE   ?
;v5       BYTE   10h
;         BYTE   100101B
;beta     BYTE   23,23h,0ch
;sdk      BYTE   "Hello",0
;min      SWORD  -32767
;ar       DWORD  12345678h
;valar    BYTE   5 DUP (1, 2, 8)

         .DATA?
X        DWORD  ?
inbuf    DB    100 DUP (?)

         .CODE
Start:   ;mov    EAX,A
         ;add    EAX,5
         ;sub    EAX,B
         ;mov    X,EAX
        add    F1,1
        add    F2,1
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

