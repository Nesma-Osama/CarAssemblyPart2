extrn Current_Y:WORD

 extrn Current_X:WORD

public draw
.model small
.code
draw PROC far
                          mov  bx,0
                          mov  dx,Current_Y
     L1:                  
                          mov  ah,0ch
                          mov  cx,Current_X
     L2:                  
                          inc  cx
                          push cx
                          push dx
                          mov  al,[si]
                          inc  si
                          int  10h
                          pop  dx
                          pop  cx
                          cmp  cx,Current_X[2]
                          je   L3
                          jmp  L2
     L3:                  
                          inc  dx
                          cmp  dx,Current_Y[2]
                          jb   L1


                          
                          ret
draw ENDP
end