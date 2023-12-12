extrn Current_X_Check:WORD
extrn Current_y_Check:WORD
extrn candrow:byte
extrn Track_color:byte;;changed untill ahmed send in all checks fiels

public RightProc
.model small
.code

RightProc proc far 
MOV CX,Current_Y_Check;FOR CHECK UP TO STOP CHECK
MOV BX,Current_X_Check
mov candrow,0h

ADD BX,10D;START
cmp Bx,319D
jz LABEL4_
INC BX
ADD CX,10D;WIDTH OF CAR

Right_CHECK:
mov candrow,0d
MOV AX,Current_Y_Check;ROW CHANGE 
MOV DX,320D ;ROW *320+COLUMN
MUL DX
ADD AX,BX
MOV DI,AX          ;CHECK
mov al,Track_color;;;changed 
scasb
je c2
JMP LABEL4_
c2:
mov candrow,1d
ADD Current_Y_Check,1
CMP Current_Y_Check,CX
JNZ Right_CHECK
LABEL4_:
RET
 RightProc endp
 end