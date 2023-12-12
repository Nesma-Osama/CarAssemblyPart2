extrn Current_X_Check:WORD
extrn Current_y_Check:WORD
extrn Track_color:byte

extrn candrow:byte
public LeftProc
.model small
.code

LeftProc proc far 
MOV CX,Current_Y_Check;FOR CHECK UP TO STOP CHECK
MOV BX,Current_X_Check
mov candrow,0h
cmp Bx,0d

jz LABEl5_
dec BX;check

ADD CX,10D;WIDTH OF CAR

Left_CHECK:
mov candrow,0d
MOV AX,Current_Y_Check;ROW CHANGE 
MOV DX,320D ;ROW *320+COLUMN
MUL DX
ADD AX,BX
MOV DI,AX          ;CHECK
mov al,Track_color
scasb
je c3
JMP LABEL5_
c3:
mov candrow,1d
add Current_Y_Check,1
CMP Current_Y_Check,CX
JNZ Left_CHECK
LABEL5_:
RET
 LEFTProc endp
 end