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
Err      DB    "Error",0

         .DATA
D        SDWORD  6
Zapros   DB      13,10,'Input Q',13,10,0
Result   DB      'Result='
ResStr   DB      16 DUP (' '),0
NewLine  DB      13,10,0

         .DATA?
inbuf    DB      100 DUP (?)
Buffer   DB      10 DUP (?)
Q        SDWORD  ?
S        SDWORD  ?

         .CODE
Start:   Invoke StdOut,ADDR Zapros
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer
         mov    DWORD PTR Q,EAX
         
         mov    EAX,Q
         cmp    EAX,10
         jnl    second_branch
            cmp    D,5
            jne    no_error
                Invoke  StdOut,ADDR Err
                jmp first_end
            no_error:
                mov    EBX,D
                sub    EBX,5
                mul    EAX
                div    EBX
                add    EAX,D
         first_end:
            jmp    results
         second_branch:
            mov    EAX,D
            sub    EAX,Q
            mov    EBX,5
            mul    EBX
         results:
            cmp    D,5
            je     final
                mov    S,EAX
                XOR    EAX,EAX
                Invoke dwtoa,S,ADDR ResStr
                Invoke StdOut,ADDR Result
                Invoke StdOut,ADDR NewLine
            final:
                Invoke StdOut,ADDR MsgExit
                Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

