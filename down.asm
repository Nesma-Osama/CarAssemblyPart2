;nesma to separate this function
extrn Current_X_Check:WORD
extrn Current_y_Check:WORD
extrn candrow:byte
extrn Track_color:byte
public DownPRO
.model small
.code
DownPRO proc far 
MOV CX,Current_X_Check;FOR CHECK down TO STOP CHECK
MOV BX,Current_X_Check;START POINT 
ADD CX,10D;WIDTH OF CAR
Down_CHECK:
mov candrow,0d
MOV AX,Current_y_Check;ALWAYS
add AX,10D;width of the car
cmp ax,199d;for the border
jz LABEL3_
add ax,1d
MOV DX,320D ;ROW *320+COLUMN
MUL DX
ADD AX,BX
MOV DI,AX          ;CHECK
mov al,Track_color
scasb
je c1
JMP LABEL3_
c1:
mov candrow,1d
ADD BX,1
CMP BX,CX
JNZ Down_CHECK
LABEL3_:
RET
 DownPRO endp
 end