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
Arr      SDWORD  6 DUP (?)
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
Start:   mov    EBX,0
         mov    ECX,2
input_cycle1:  
         push   ECX
         mov    ECX,3
input_cycle2:  
         push   ECX
         Invoke StdOut,ADDR Zapros
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer
         mov    DWORD PTR Arr[EBX*4],EAX
         pop    ECX
         inc    EBX
         loop   input_cycle2
         pop    ECX
         loop   input_cycle1

         mov    EDI,0
         mov    EBX,0
         mov    ECX,2
work_cycle1:
         push   ECX
         mov    ECX,3
         mov    EAX,0
work_cycle2:  
         cmp    Arr[EBX*4],0
         jnl    no_sum
         add    EAX,Arr[EBX*4]
         no_sum:
         inc    EBX
         loop   work_cycle2
         pop    ECX
         mov    Arr[EDI],EAX
         add    EDI,12
         loop   work_cycle1

         mov    EBX,0   
         mov    ECX,2
output_cycle1:  
         push   ECX
         mov    ECX,3
output_cycle2:  
         push   ECX
         Invoke dwtoa,Arr[EBX*4],ADDR ResStr
	     Invoke StdOut,ADDR ResStr
	     Invoke StdOut,ADDR Space
         pop    ECX
         inc    EBX
         loop   output_cycle2
         Invoke StdOut,ADDR NewLine
         pop    ECX
         loop   output_cycle1
         
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

