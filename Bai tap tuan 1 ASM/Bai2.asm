.model small
.stack 100
.data
    inputA db 'Nhap so A = $'
    inputB db 'Nhap so B = $'
    outputResult db 'Tong A + B = $' 
    notNumber db ' khong phai chu so $'
    CLRF db 13, 10, '$'
.code
    main proc
    mov ax, @data
    mov ds, ax
               
    mov ah, 9         ; hien thi "Nhap so A = "
    lea dx, inputA
    int 21h
     
    call inputDec     ; goi CTC nhap so thu nhat he so 10
    push ax           ; luu ax da nhap vao stack
    xor ax,ax         ; gan ax bang 0  
    call nextLine     ; xuong dong
     
    mov ah, 9          
    lea dx, inputB    ; hien thi "Nhap so B = "
    int 21h
     
    call inputDec     ;goi ham nhap so thu 2 he so 10
    mov bx, ax
    call nextLine              
     
    pop ax            ; day du lieu tu stack vao ax
    call sum          ; goi ham tinh tong 2 so (trong ax va bx)
    push ax           ; luu day du lieu ax vao stack
                       
    mov ah, 9         
    lea dx, outputResult  ; hien thi KQ
    int 21h
     
    pop ax            ; day du lieu tu stack vao ax
    call outputDec    ; goi CTC hien thi KQ
     
    mov ah, 4ch       ; ket thuc chuong trinh 
    int 21h
     
     
    main endp
     
    sum proc          ; ham tinh tong 2 so
        add ax, bx
        ret
    sum endp 
                                                            
    nextLine proc     ; ham xuong dong
        mov ah, 9
        lea dx, CLRF  ; in ra xuong dong
        int 21h
        ret           ; tra ve ham da goi den nextLine
    nextLine endp
     
    inputDec proc      ;ham Nhap vao 1 so he so 10 va luu ket qua vao Ax
       
        push bx      ; luu gia tri cac thanh ghi
        push cx
        push dx 
        
        batDau:
            mov ah, 2       
            xor bx, bx      ; bx = 0
            xor cx, cx      ; cx = 0
            mov ah, 1
            int 21h
            cmp al, '-'       ; Kiem tra am duong
            je dauTru
            cmp al, '+'
            je dauCong
            jmp tiepTuc
            
            dauTru:
                mov cx, 1
            
            dauCong:
                int 21h
            
            tiepTuc:
                cmp al, '0'
                jnge khongPhaiSo    ; kiem tra xem so vua nhap co phai chu so nam trong pham vi 0->9
                cmp al, '9'
                jnle khongPhaiSo    ;  
                and ax, 000fh       ; doi thanh chu so
                push ax             ; cat vao ngan xep
                mov ax, 10
                
                mul bx              ; ax = tong*10
                mov bx, ax          
                pop ax
                add bx, ax          ; tong = tong*10 + so
                mov ah, 1
                int 21h
                cmp al, 13          ; da enter chua?
                jne tiepTuc         ; nhap tiep
                
                mov ax, bx          ; chuyen KQ ra ax
                or cx, cx           ; kiem tra xem co phai so am khong
                je ra
                neg ax              ; chuyen ax thanh so am
                
            ra:
                pop dx                ; khoi phuc gia tri cac thanh ghi
                pop cx
                pop bx  
                
                ret                 ; ve main
                
            khongPhaiSo:
                mov ax,@data 
                mov ah,9
                lea dx,notnumber
                int 21h
                
                
    inputDec endp  





    outputDec proc
        push bx  ; luu gia tri cac thanh ghi
        push cx
        push dx
        
        cmp ax, 0   ;   neu ax >= 0 ta doi ra day
        jge doiRaDay
        push ax
        mov dl, '-'
        mov ah, 2
        int 21h
        pop ax
        neg ax  ; ax = -ax
        
        doiRaDay:
            xor cx, cx  ; gan cx = 0
            mov bx, 10  ; so chia la 10
            chia:
                xor dx, dx  ; gan dx = 0
                div bx      ; ax = ax / bx; dx = ax % bx
                push dx
                inc cx
                cmp ax, 0   ; kiem tra xem thuong bang khong chua?
                jne chia    ; neu khong bang thi lai chia
                mov ah, 2
            hien:
                pop dx
                or dl, 30h ; doi so ra ma ascii
                int 21h
                loop hien
                
                pop dx     ; khoi phuc gia tri cac thanh ghi
                pop cx
                pop bx
               
        ret
        
    outputDec endp
end main
        
        
        