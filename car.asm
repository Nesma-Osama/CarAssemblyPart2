     ;; ALL DATA RELATED TO BLUE CAR
     extrn UP_CHECK_PRO:far
     extrn DownPRO:far
     extrn RightProc:far
     extrn LeftProc:far
          extrn draw:far

      EXTRN  blue_car_back  :BYTE
      EXTRN  blue_car_front :BYTE
      EXTRN  blue_car_left  :BYTE
      EXTRN  blue_car_right :BYTE
      EXTRN   Blue_velocity  :WORD;;; 0 decrease , 1 normal , 2 increase
      EXTRN   Blue_Current_X :WORD                                                                                                                                                                                            ;; columns
      EXTRN  Blue_Current_Y:WORD
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
     ;; ALL DATA RELATED TO RED CAR
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;
     EXTRN   red_car_back   :BYTE
     EXTRN  red_car_front  :BYTE
     EXTRN red_car_left  :BYTE
     EXTRN red_car_right  :BYTE
     EXTRN  Red_velocity  :WORD
     EXTRN  Red_Current_X  :WORD                                                                                                                                                                                       ; column horizontal
     EXTRN  Red_Current_Y :WORD                                                                                                                                                                                          ; row vertical
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     EXTRN  img_black      :BYTE
     EXTRN Current_X    :WORD
     EXTRN Current_Y    :WORD
     ;;; Data Added by Nesma
     EXTRN Current_X_Check:WORD
     EXTRN Current_y_Check :WORD
     EXTRN  pixelScreen :WORD
     EXTRN  candrow :byte
     ;; Data for Red car
     ;; Data for Blue car
     ;; Data overall
     ;;;;;;;;;;;;;;NesmaPowerUp;;;;;;;;;;;;;;;;;;;;;;;;

extrn enablePowerUpBlue :byte
extrn enablePowerUpRed :byte
extrn powerUpBlue:byte
extrn powerUpRed:byte
extrn obstacleColor:byte
     ;;;;;;;;;;;;;;;;;;;
    EXTRN  Track_color  :BYTE
     PUBLIC CAR
.MODEL SMALL 
.CODE
CAR PROC FAR
                      

     MainLoop:            
     ; key board input
                          mov  ax,0h
                          mov  ah,1
                          int  16h
                          jz   label_
                          mov  ah,0
                          int  16h

     ; Scan codes
     ; check for red "arrows"
                          cmp  ah,48h
                          je   Red_Move_UP
                          cmp  ah,50h
                          je   Red_Move_DOWN
                          cmp  ah,4bh
                          je   Red_Move_LEFT
                          cmp  ah,4dh
                          je   Red_Move_Right
     ;check for blue "wsad"
                          cmp  ah,11h
                          je   temporaryRIGHT
                          cmp  ah,1fh
                          je   temporarydown
                          cmp  ah,1eh
                          je   temporaryleft
                          cmp  ah,20h
                          je   temporary
     label_:              
                          jmp  breakreturn
     Red_Move_UP:         
     ;; Added by Nesma
           MOV AX,Red_Current_X
           MOV Current_X_Check,AX;FOR CHECK ON SCREEN NESMA
           MOV AX,Red_Current_Y
            MOV  Current_y_Check,AX;NESMA
           call UP_CHECK_PRO
           cmp candrow,0d
           jz label2_
           jmp  far ptr CALL_Red_Move_UP
     Red_Move_DOWN: 
           MOV AX,Red_Current_X
           MOV Current_X_Check,AX;FOR CHECK ON SCREEN NESMA
           MOV AX,Red_Current_Y
           MOV  Current_y_Check,AX;NESMA
           call DownPRO;nesma
           cmp candrow,0d;nesma
           jz label2_;nesma
           jmp  far ptr CALL_Red_Move_Down
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;TEMP
            temporary:;nesma to break jump
            jmp Blue_Move_Right
            temporarydown:;nesma to break jump
            jmp Blue_Move_DOWN
            temporaryleft:;nesma to break jump
            jmp Blue_Move_LEFT
            temporaryRIGHT:;nesma to break jump
            jmp Blue_Move_UP
            ;;;nesma break jmp
             label2_:
             jmp breakreturn;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     Red_Move_LEFT:  
           MOV AX,Red_Current_X
           MOV Current_X_Check,AX;FOR CHECK ON SCREEN NESMA
           MOV AX,Red_Current_Y
           MOV  Current_y_Check,AX;NESMA 
           CALL  LeftProc
          cmp candrow,0d;nesma
           jz label2_;nesma
           jmp  far ptr CALL_Red_Move_Left
     Red_Move_Right:  
           MOV AX,Red_Current_X
           MOV Current_X_Check,AX;FOR CHECK ON SCREEN NESMA
           MOV AX,Red_Current_Y
           MOV  Current_y_Check,AX;NESMA
          CALL  RightProc
          cmp candrow,0d;nesma
           jz label2_;nesma
           jmp  far ptr CALL_Red_Move_Right
     Blue_Move_UP:     
           MOV AX,Blue_Current_X
           MOV Current_X_Check,AX;FOR CHECK ON SCREEN NESMA
           MOV AX,Blue_Current_Y
           MOV  Current_y_Check,AX;NESMA
           call UP_CHECK_PRO;NESMA
            cmp candrow,0d;NESMA 
            jz label2_;NESMA
           jmp  far ptr CALL_Blue_Move_UP
     Blue_Move_DOWN:   
           MOV AX,Blue_Current_X
           MOV Current_X_Check,AX;FOR CHECK ON SCREEN NESMA
           MOV AX,Blue_Current_Y
           MOV  Current_y_Check,AX;NESMA   
            call DownPRO;nesma
            cmp candrow,0d;nesma
            jz  label2_;nesma to return to main
           jmp  far ptr CALL_Blue_Move_Down
           ;;;NESMA BREAKE JUMP
           LABEL21_:
           JMP LABEL2_;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     Blue_Move_LEFT: 
           MOV AX,Blue_Current_X
           MOV Current_X_Check,AX;FOR CHECK ON SCREEN NESMA
           MOV AX,Blue_Current_Y
           MOV  Current_y_Check,AX;NESMA  
         CALL  LeftProc
          cmp candrow,0d;nesma
           jz label21_;nesma       
           jmp  far ptr CALL_Blue_Move_Left

           
     Blue_Move_Right:    
           MOV AX,Blue_Current_X
           MOV Current_X_Check,AX;FOR CHECK ON SCREEN NESMA
           MOV AX,Blue_Current_Y
           MOV  Current_y_Check,AX;NESMA 
            CALL  RightProc
          cmp candrow,0d;nesma
           jz label21_;nesma 
           jmp  far ptr CALL_Blue_Move_Right
     ;;;; Red Movement ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;nesma 
     CALL_Red_Move_Down:  
                          call clear_red
     ; then we drwa my shape 
                         mov  bx,Red_Current_X[0]
                          mov  Current_X[0],bx
                          mov  bx,Red_Current_X[2]
                          mov  Current_X[2],bx
                          mov  bx,Red_Current_Y[0]
                          add  bx,Red_velocity
                          mov  Red_Current_Y[0],bx
                          mov  Current_Y[0],bx
                          mov  bx,Red_Current_Y[2]
                          add  bx,Red_velocity
                          mov  Red_Current_Y[2],bx
                          mov  Current_Y[2],bx
                          lea  ax,red_car_back
                          mov  si,ax
                          xor  ax,ax
                          call draw
;;;;;Nesma for obstacle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;obstacle;;untill ahmed send
cmp enablePowerUpRed,3d
jnz l0
mov ax,Red_Current_Y[0];y[0] is the point of the back of car when down
sub ax,1D
mov bx,320d
mul bx
add ax,Red_Current_X[0]
mov di,ax
mov al,obstacleColor
mov cx,10D
rep stosb
mov enablePowerUpRed,0h
    ;;;;;;;;;; ;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
                       l0:   jmp  breakreturn
     CALL_Red_Move_UP:    
     ; at first we remove the current place
                          call clear_red
     ; then we drwa my shape
     ; just copy
                          mov  bx,Red_Current_X[0]
                          mov  Current_X[0],bx
                          mov  bx,Red_Current_X[2]
                          mov  Current_X[2],bx
                          mov  bx,Red_Current_Y[0]
                          sub  bx,Red_velocity
                          mov  Red_Current_Y[0],bx
                          mov  Current_Y[0],bx
                          mov  bx,Red_Current_Y[2]
                          sub  bx,Red_velocity
                          mov  Red_Current_Y[2],bx
                          mov  Current_Y[2],bx
                          lea  ax,red_car_front
                          mov  si,ax
                          xor  ax,ax
                          call draw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;obstacle;;untill ahmed send
cmp enablePowerUpRed,3d
jnz l1
mov ax,Red_Current_Y[2];;row+1 for the point behind me
add ax,1D
mov bx,320d
mul bx
add ax,Red_Current_X[0]
mov di,ax
mov al,obstacleColor
mov cx,10D
rep stosb
mov enablePowerUpRed,0h
    ;;;;;;;;;; ;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 l1: jmp  breakreturn
     CALL_Red_Move_Left:  
     ; clear last place
                          call clear_red
     ; then we drwa my shape
                          mov  bx,Red_Current_X[0]
                          sub  bx,Red_velocity
                          mov  Red_Current_X[0],bx
                          mov  Current_X[0],bx
                          mov  bx,Red_Current_X[2]
                          sub  bx,Red_velocity
                          mov  Red_Current_X[2],bx
                          mov  Current_X[2],bx
                          mov  bx,Red_Current_Y[0]
                          mov  Red_Current_Y[0],bx
                          mov  Current_Y[0],bx
                          mov  bx,Red_Current_Y[2]
                          mov  Red_Current_Y[2],bx
                          mov  Current_Y[2],bx
                          lea  ax,red_car_left
                          mov  si,ax
                          xor  ax,ax
                          call draw
cmp enablePowerUpRed,3d;;power up obst
jnz l3

mov bx,320d;row*320
mov cx,Red_Current_Y[0];for l0op
leftRed:
mov ax,cx;;row  for the point behind me
mul bx;320*
mov dx,Red_Current_X[2];;column is const must +1 to get back the back of the car
add dx,1d
add ax,dx;column
mov di,ax;;
mov al,obstacleColor
stosb
inc cx
cmp cx,Red_Current_Y[2]
jnz leftRed
mov enablePowerUpRed,0h
 l3:     jmp  far ptr breakreturn
                     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     CALL_Red_Move_Right: 
     ; clear last place
                          call clear_red
     ; then we drwa my shape
                          mov  bx,Red_Current_X[0]
                          add  bx,Red_velocity
                          mov  Red_Current_X[0],bx
                          mov  Current_X[0],bx
                          mov  bx,Red_Current_X[2]
                          add  bx,Red_velocity
                          mov  Red_Current_X[2],bx
                          mov  Current_X[2],bx
                          mov  bx,Red_Current_Y[0]
                          mov  Red_Current_Y[0],bx
                          mov  Current_Y[0],bx
                          mov  bx,Red_Current_Y[2]
                          mov  Red_Current_Y[2],bx
                          mov  Current_Y[2],bx
                          lea  ax,red_car_right
                          mov  si,ax
                          xor  ax,ax
                          call draw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;obstacle;;untill ahmed send
cmp enablePowerUpRed,3d;;power up obst
jnz l2

mov bx,320d;row*320
mov cx,Red_Current_Y[0];for l0op
rightRed:
mov ax,cx;;row  for the point behind me
mul bx;320*
mov dx,Red_Current_X[0];;column is const must -1 to get back
sub dx,1d
add ax,dx;column
mov di,ax;;
mov al,obstacleColor
stosb
inc cx
cmp cx,Red_Current_Y[2]
jnz rightRed
mov enablePowerUpRed,0h
    ;;;;;;;;;; ;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


                        l2:  jmp  far ptr breakreturn
     ;;;; Red Movement ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;;;; Blue Movement ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ; ;;;; Blue Movement ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;;;; Blue Movement ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     CALL_Blue_Move_Down: 
                          call clear_blue
     ; then we drwa my shape
                          mov  bx,Blue_Current_X[0]
                          mov  Current_X[0],bx
                          mov  bx,Blue_Current_X[2]
                          mov  Current_X[2],bx
                          mov  bx,Blue_Current_Y[0]
                          add  bx,Blue_velocity
                          mov  Blue_Current_Y[0],bx
                          mov  Current_Y[0],bx
                          mov  bx,Blue_Current_Y[2]
                          add  bx,Blue_velocity
                          mov  Blue_Current_Y[2],bx
                          mov  Current_Y[2],bx
                          lea  ax,blue_car_back
                          mov  si,ax
                          xor  ax,ax
                          call draw
                          ;;;;;Nesma for obstacle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;obstacle;;untill ahmed send
cmp enablePowerUpBlue,3d
jnz l5
mov ax,Blue_Current_Y[0];y[0] is the point of the back of car when down
sub ax,1D
mov bx,320d
mul bx
add ax,Blue_Current_X[0]
mov di,ax
mov al,obstacleColor
mov cx,10D
rep stosb
mov enablePowerUpBlue,0h

    ;;;;;;;;;; ;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
                       l5:   jmp  returnlabel

                          jmp afterreturn

breakreturn:
jmp returnlabel

afterreturn:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     CALL_Blue_Move_UP:   
     ; at first we remove the current place
                          call clear_blue
     ; then we drwa my shape
                          mov  bx,Blue_Current_X[0]
                          mov  Current_X[0],bx
                          mov  bx,Blue_Current_X[2]
                          mov  Current_X[2],bx
                          mov  bx,Blue_Current_Y[0]
                          sub  bx,Blue_velocity
                          mov  Blue_Current_Y[0],bx
                          mov  Current_Y[0],bx
                          mov  bx,Blue_Current_Y[2]
                          sub  bx,Blue_velocity
                          mov  Blue_Current_Y[2],bx
                          mov  Current_Y[2],bx
                          lea  ax,blue_car_front
                          mov  si,ax
                          xor  ax,ax
                          call draw
                          ;;;;;;;;;;;;;;;;;;;;poweruos;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp enablePowerUpBlue,3d
jnz l4
mov ax,Blue_Current_Y[2];;row+1 for the point behind me
add ax,1D
mov bx,320d
mul bx
add ax,Blue_Current_X[0]
mov di,ax
mov al,obstacleColor
mov cx,10D
rep stosb
mov enablePowerUpblue,0h
                       l4:   jmp  returnlabel
                       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     CALL_Blue_Move_Left: 
     ; clear last place
                          call clear_blue
     ; then we drwa my shape
                          mov  bx,Blue_Current_X[0]
                          sub  bx,Blue_velocity
                          mov  Blue_Current_X[0],bx
                          mov  Current_X[0],bx
                          mov  bx,Blue_Current_X[2]
                          sub  bx,Blue_velocity
                          mov  Blue_Current_X[2],bx
                          mov  Current_X[2],bx

                          mov  bx,Blue_Current_Y[0]
                          mov  Blue_Current_Y[0],bx
                          mov  Current_Y[0],bx
                          mov  bx,Blue_Current_Y[2]
                          mov  Blue_Current_Y[2],bx
                          mov  Current_Y[2],bx
                          lea  ax,blue_car_left
                          mov  si,ax
                          xor  ax,ax
                          call draw
                          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp enablePowerUpBlue,3d;;power up obst
jnz l6

mov bx,320d;row*320
mov cx,Blue_Current_Y[0];for l0op
leftBlue:
mov ax,cx;;row  for the point behind me
mul bx;320*
mov dx,Blue_Current_X[2];;column is const must +1 to get back the back of the car
add dx,1d
add ax,dx;column
mov di,ax;;
mov al,obstacleColor
stosb
inc cx
cmp cx,Blue_Current_Y[2]
jnz leftBlue
mov enablePowerUpBlue,0h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


                        l6:  jmp  far ptr returnlabel
     CALL_Blue_Move_Right:
     ; clear last place
                          call clear_blue
     ; then we drwa my shape
                          mov  bx,Blue_Current_X[0]
                          add  bx,Blue_velocity
                          mov  Blue_Current_X[0],bx
                          mov  Current_X[0],bx
                          mov  bx,Blue_Current_X[2]
                          add  bx,Blue_velocity
                          mov  Blue_Current_X[2],bx
                          mov  Current_X[2],bx
                          mov  bx,Blue_Current_Y[0]
                          mov  Blue_Current_Y[0],bx
                          mov  Current_Y[0],bx
                          mov  bx,Blue_Current_Y[2]
                          mov  Blue_Current_Y[2],bx
                          mov  Current_Y[2],bx
                          lea  ax,blue_car_right
                          mov  si,ax
                          xor  ax,ax
                          call draw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;obstacle;;untill ahmed send
cmp enablePowerUpBlue,3d;;power up obst
jnz l7

mov bx,320d;row*320
mov cx,Blue_Current_Y[0];for l0op
rightBlue:
mov ax,cx;;row  for the point behind me
mul bx;320*
mov dx,Blue_Current_X[0];;column is const must -1 to get back
sub dx,1d
add ax,dx;column
mov di,ax;;
mov al,obstacleColor
stosb
inc cx
cmp cx,Blue_Current_Y[2]
jnz rightBlue
mov enablePowerUpBlue,0h
    ;;;;;;;;;; ;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


                         l7: jmp  far ptr returnlabel
                          mov  ah,4ch; end of the program
                          int  21h

CAR ENDP
     ;description
clear_red PROC
                          mov  bx,Red_Current_X[0]
                          mov  Current_X[0],bx
                          mov  bx,Red_Current_X[2]
                          mov  Current_X[2],bx
                          mov  bx,Red_Current_Y[0]
                          mov  Current_Y[0],bx
                          mov  bx,Red_Current_Y[2]
                          mov  Current_Y[2],bx
                          lea  ax,img_black
                          mov  si,ax
                          xor  ax,ax
                          call draw
                          ret
clear_red ENDP

clear_blue PROC
                          mov  bx,Blue_Current_X[0]
                          mov  Current_X[0],bx
                          mov  bx,Blue_Current_X[2]
                          mov  Current_X[2],bx
                          mov  bx,Blue_Current_Y[0]
                          mov  Current_Y[0],bx
                          mov  bx,Blue_Current_Y[2]
                          mov  Current_Y[2],bx
                          lea  ax,img_black
                          mov  si,ax
                          xor  ax,ax
                          call draw
                          ret
clear_blue ENDP
     ;description

 returnlabel:ret
END 