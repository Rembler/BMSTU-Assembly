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
Err      DB    "Error",0

         .DATA
Zapros_Q DB      'Input Q',13,10,0
Zapros_D DB      'Input D',13,10,0
Result   DB      'Result='
ResStr   DB      16 DUP (' '),0
NewLine  DB      13,10,0

         .DATA?
inbuf    DB      100 DUP (?)
Buffer   DB      10 DUP (?)
D        SDWORD  ?
Q        SDWORD  ?
S        SDWORD  ?

         .CODE
Start:   Invoke StdOut,ADDR Zapros_Q
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer
         mov    DWORD PTR Q,EAX
         
         Invoke StdOut,ADDR Zapros_D
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer
         mov    DWORD PTR D,EAX
         
         cmp    Q,10
         jnl    second_branch
         cmp    D,5
         je     error
         mov    EAX,Q
         mov    EBX,D
         sub    EBX,5
         mul    EAX
         div    EBX
         add    EAX,D
         mov    S,EAX
         Invoke dwtoa,S,ADDR ResStr
         jmp    end_first_branch		
	     error:
	     Invoke StdOut,ADDR Err
	     end_first_branch:
	     jmp    result
	     second_branch:
	     mov    EAX,D
	     sub    EAX,Q
	     mov    EBX,5
	     mul    EBX
	     mov    S,EAX
	     Invoke dwtoa,S,ADDR ResStr
	     result:
	     Invoke StdOut,ADDR Result
	     XOR    EAX,EAX
	     Invoke StdOut,ADDR MsgExit
	     Invoke StdIn,ADDR inbuf,LengthOf inbuf
         Invoke ExitProcess,0
         End    Start

