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
Start:   mov    EBX,0
         mov    ECX,4
input_cycle1:  
         push   ECX
         mov    ECX,6
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
         
         Invoke StdOut,ADDR NewLine
         Invoke StdOut,ADDR Notice1
         
         mov    EBX,0   
         mov    ECX,4
output_cycle1:  
         push   ECX
         mov    ECX,6
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

         mov    EDI,0
         mov    EBX,0
         mov    ECX,4
work_cycle1:
         push   ECX
         mov    ECX,6
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
         add    EDI,24
         loop   work_cycle1
         
         Invoke StdOut,ADDR NewLine
         Invoke StdOut,ADDR Notice2

         mov    EBX,0   
         mov    ECX,4
result_cycle1:  
         push   ECX
         mov    ECX,6
result_cycle2:  
         push   ECX
         Invoke dwtoa,Arr[EBX*4],ADDR ResStr
	     Invoke StdOut,ADDR ResStr
	     Invoke StdOut,ADDR Space
         pop    ECX
         inc    EBX
         loop   result_cycle2
         Invoke StdOut,ADDR NewLine
         pop    ECX
         loop   result_cycle1
         
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start