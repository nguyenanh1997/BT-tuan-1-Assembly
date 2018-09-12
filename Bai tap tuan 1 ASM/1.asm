
include 'EMU8086.INC'
.model small
.stack 100h
.data
  dem  db 16
  tong dw ?    
.code
    main proc
             mov ax,@data
             mov ds,ax 
             print "nhap so thu nhat: "
             xor bx,bx
             call nhapSo
             
             
             printn 
             print "nhap so thu hai: " 
             xor bx,bx
             call nhapSo
             
             mov cx,16
             call hienThi
             
    main endp 
     
     
     
    nhapSo proc   ; ham de nhap vao 1 so
             
            MOV AH,1     ; nhap 1 so vao
            INT 21h
            CMP Al,0DH   ; kiem tra xem da an enter chua
            je tinhTong       ; an roi thi nhay toi ham SUM            
            
            AND AL,0FH   ; chuyen ky tu vua nhap sang ascii
            SHL BX,1     ;dich gia tri hien tai sang trai de luu cho lan sau
            OR  BL,AL    ;luu gia tri tu al vao bl
            
            JMP nhapSo
            
            tinhTong:
                ADD tong,BX
                ret    
    nhapSo endp 
    
    hienThi proc ; hien thi so
         PRINTN
         PRINT "Their Sum:"
         SHOW:               ;in ra tong cua 2 so
               CMP cx,0       ; neu bien dem 16 nay ma = 0  thi exit
               JE EXIT
               
               SHL tong,1
               JC R1       ; nhay toi ham R1 neu flag = 1
               JNC R0      ; nguoc lai
          R1:              ;level for print 1
             MOV DL,'1'
             MOV AH,2
             INT 21h
             SUB cx,1
             JMP SHOW
          R0:               ;level for print 0
             MOV DL,'0'
             MOV AH,2
             INT 21h
             SUB cx,1
             JMP SHOW
         EXIT:           ;terminate programme
            ret 
    
    hienThi endp
end main