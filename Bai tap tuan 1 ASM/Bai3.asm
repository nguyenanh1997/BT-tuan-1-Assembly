.model small
.stack 100h
.Data
    nhapChuoi db 'Hay nhap chuoi ban can dao nguoc: $ '
    inChuoiDaoNguoc db 10,13,'Chuoi dao nguoc la: $'
.Code 
Main proc
    mov ax, @data
    mov ds,ax
    mov ah, 09h     ; chuan bi xuat chuoi
    lea dx, nhapChuoi  
    int 21h        ; ngat
        
    mov cx,0    
    mov ah,01h   ; nhap vao 1 ky tu
Nhap:   ; vong lap de nhap chuoi 
    int 21h ; ngat
    cmp al,13 ;neu nguoi dung nhap enter thi ngung
    je  tiep
    mov bl,al
    push bx
    inc cx
    jmp Nhap
 
tiep:        ;in ra thong bao 
    mov ah,09h
    lea dx,inChuoiDaoNguoc
    int 21h

mov ah,02h   ; chuan bi xuat ra tung ky tu
HienThi:      ; lay trong stack ra de hien thi
    pop bx
    mov dl,bl
    int 21h
    loop HienThi
    
mov ah,4ch; 
int 21h  ; 2 cau nay de thoat ra

Main EndP
End Main
    
    