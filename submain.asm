extrn username:byte
extrn username1:byte
extrn username2:byte

extrn InitialNumber:byte
extrn InitialNumber1:byte
extrn InitialNumber2:byte
extrn privsecond:byte
extrn Red_Current_X:WORD
extrn Red_Current_Y:WORD
extrn Blue_Current_X:WORD
extrn Blue_Current_Y:WORD
EXTRN Current_x:WORD
EXTRN Current_Y:WORD
EXTRN red_car_front:BYTE
EXTRN Blue_car_front:BYTE
extrn second:byte
extrn draw:far
extrn login:far
extrn choose:far
extrn car:far
extrn design:far
extrn PowerUp:far
public submain
.model small
.code
submain proc far
       ;player1

         mov bx,1d
         call login
         lea si,username[2]
         lea di,username1
         ;;;;;;;;;;;;;;UNTILL AHMED
         MOV CX,15D
        rep movsb

         MOV CX,15D
         lea di,username[2]
         mov al,'$'
        rep stosb 
        
        ;;;;;;;;;;;;;;;;;;;;;;;;
         mov cl,InitialNumber
         mov InitialNumber1,cl


;;;;player2
 mov bx,2d
         call login
         lea si,username[2]
         lea di,username2
         ;;;;UNTILL AHMED
         MOV CX,15D
        REP movsb
        ;;;;;;;;;;;;;;;;;;;
          mov cl,InitialNumber
         mov InitialNumber2,cl
         ;;;;;;;;;;;;;;;;
         mov  ah,0003h
         mov  cx,00h
         mov  dx,184fh
         int  10h
         call choose


         ;;;;;;;;;;;;;;;;;;;;initialize
            ; mov  AX,@data                         ;initializing the data segemnt
                          ;mov  DS,AX
                          mov  ax,0003h
                          int  10h
                          mov  ax,0A000h                        ; to graphics screen
                          mov  es,ax
                          mov  ah,0                             ; 320 * 200
                          mov  al,13h
                          int  10h   
     call design
     mov si,00
      printBlackScreen:
     mov ax,si
     mov bx,320d
     mul bx
     mov di,ax
     mov ax,0000h
     mov cx,320d
     repe stosb
     add si,1d
     cmp si,200d
     jnz printBlackScreen
     
         ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;untill ahmed
mov di,57600d ;180 row
mov cx,320d
mov al,0fh
rep stosb


     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;nesma
mov ah,2ch;;to sheck seconds
int 21h
mov privsecond,dh
;;;;nesma end now all screen is black
     ;; printing the shape first time
     ; Red Drawing the shape
                          mov  bx,Red_Current_X[0]
                          mov  Current_X[0],bx
                          mov  bx,Red_Current_X[2]
                          mov  Current_X[2],bx
                          mov  bx,Red_Current_Y[0]
                          mov  Current_Y[0],bx
                          mov  bx,Red_Current_Y[2]
                          mov  Current_Y[2],bx
                          lea  ax,red_car_front
                          mov  si,ax
                          xor  ax,ax
                          call draw
     ; Blue Drawing the shape
                          mov  bx,Blue_Current_X[0]
                          mov  Current_X[0],bx
                          mov  bx,Blue_Current_X[2]
                          mov  Current_X[2],bx
                          mov  bx,Blue_Current_Y[0]
                          mov  Current_Y[0],bx
                          mov  bx,Blue_Current_Y[2]
                          mov  Current_Y[2],bx
                          lea  ax,blue_car_front
                          mov  si,ax
                          xor  ax,ax
                          call draw
 CALL CAR;first call

 ;;;;untill ahmed;;;;;;;;;;;;;;;;;
 push di
 push si
 push ax
 call PowerUp;;11/12/2023
 pop AX
 pop si
 pop di
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
time:;fir timer
mov ah,2ch;get time
int 21h
cmp dh,privsecond;still in the same second
jz secondcheck;return to game
 dec second
mov privsecond,dh

secondcheck:
CALL CAR
;;;;;;;;;;;
  push di
 push si
 push ax
 call PowerUp;;11/12/2023
 pop AX
 pop si
 pop di
 ;;;;;;;;;;;;;;;;;;;;
cmp second,1;the 2 minute finish
jnz time;still not finish
  mov ah,4ch
  int 21h
 ret
submain endp
end