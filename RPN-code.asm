org 8000h
flag db 0
scount db 0 
org 100h
mov al, 0 
out 020h, al 
push 0
push 0
jmp display
redo:
mov ax, 0
mov dx, 0 
clc 
start: 
in al, 010h
cmp al, 0
jne line1
in al, 012h
cmp al, 0
jne line2          
in al, 014h 
cmp al, 0
jne line3
in al, 016h
cmp al, 0
jne line4       
in al, 018h
cmp al, 0
jne line5
cmp ah, 0
jne next
jmp start
line1:
add al, 100000b
mov ah, al
jmp start
line2:
add al, 1000000b  
mov ah, al
jmp start
line3:
add al, 1100000b  
mov ah, al
jmp start
line4:
add al, 10000000b  
mov ah, al
jmp start
line5:
add al, 10100000b  
mov ah, al
jmp start 
next:
mov al, ah
mov ah, 0  
cmp al, 100001b
je zero
cmp al, 100010b
je one
cmp al, 100100b
je two
cmp al, 101000b
je three
cmp al, 110000b
je four
cmp al, 1000001b
je five
cmp al, 1000010b
je six
cmp al, 1000100b
je seven
cmp al, 1001000b
je eight
cmp al, 1010000b
je nine 
cmp al, 1100001b
je plus 
cmp al, 1100010b
je minus
cmp al, 1100100b
je times
cmp al, 1101000b
je divide
cmp al, 1110000b
je enter      
cmp al, 10000001b
je root
cmp al, 10000010b
je remainder  
cmp al, 10000100b
je nPr  
cmp al, 10001000b
je nCr  
cmp al, 10010000b
je factorial
cmp al, 10100001b
je twoexp 
cmp al, 10100010b
je exp          
cmp al, 10100100b
je back 
cmp al, 10101000b
je popmem 
cmp al, 10110000b
je clear
zero:
cmp flag , 1 
je  skip0
PUSH 0
inc scount
mov flag,1
skip0:
POP ax 
mov bx, 10
mul bx 
add ax, 0
cmp dx, 0
je of0
stc
of0:
PUSH ax
jmp display
one:
cmp flag , 1  
je  skip1
PUSH 0
inc scount
mov flag,1
skip1:
POP ax 
mov bx, 10
mul bx
add ax,1
cmp dx, 0
je of1
stc
of1:
PUSH ax
jmp display
two:
cmp flag , 1   
je  skip2
PUSH 0
inc scount
mov flag,1
skip2:
POP ax 
mov bx, 10
mul bx 
add ax,2 
cmp dx, 0
je of2
stc
of2:
PUSH ax
jmp display
three:
cmp flag , 1   
je  skip3
PUSH 0
inc scount
mov flag,1
skip3:
POP ax 
mov bx, 10
mul bx 
add ax,3 
cmp dx, 0
je of3
stc
of3:
PUSH ax
jmp display
four:
cmp flag , 1    
je  skip4
PUSH 0
inc scount
mov flag,1
skip4:
POP ax 
mov bx, 10
mul bx
add ax,4   
cmp dx, 0
je of4
stc
of4:
PUSH ax
jmp display
five:
cmp flag , 1   
je  skip5
PUSH 0
inc scount
mov flag,1
skip5:
POP ax 
mov bx, 10
mul bx
add ax,5 
cmp dx, 0
je of5
stc
of5:
PUSH ax
jmp display
six:
cmp flag , 1 
je  skip6
PUSH 0
inc scount
mov flag,1
skip6:
POP ax 
mov bx, 10
mul bx
add ax,6
cmp dx, 0
je of6
stc
of6:
PUSH ax
jmp display
cmp flag , 1    
je  skip7
PUSH 0
inc scount
mov flag,1
skip7:
POP ax 
mov bx, 10
mul bx
add ax,7 
cmp dx, 0
je of7
stc
of7:
PUSH ax
jmp display
eight:
cmp flag , 1  
je  skip8
PUSH 0
inc scount
mov flag,1
skip8:
POP ax 
mov bx, 10
mul bx
add ax,8  
cmp dx, 0
je of8
stc
of8:
PUSH ax
jmp display
nine:
cmp flag , 1    
je  skip9
PUSH 0
inc scount
mov flag,1
skip9:
POP ax 
mov bx, 10
mul bx
add ax,9 
cmp dx, 0
je of9
stc
of9:
PUSH ax 
jmp display
plus:   
cmp scount, 1
je displayn
mov flag,0 
POP ax
POP bx
add ax , bx
PUSH ax
dec scount
jmp display
minus:        
cmp scount, 1
je displayn
mov flag,0  
POP bx
POP ax
sub ax, bx
PUSH ax
dec scount
jmp display
times: 
cmp scount, 1
je displayn
mov flag,0 
POP ax
POP bx 
mov dx,0
mul bx
cmp dx,0
je skiptimes
stc
skiptimes:
PUSH ax 
dec scount
jmp display
divide:
cmp scount, 1
je displayn
mov flag,0 
mov dx, 0
POP bx 
POP ax
div bx
dec scount
cmp dx, 0
jnz approx            
PUSH ax
jmp display
approx: 
mov di, 1
and di, bx
SHR bx,1 
add bx, di
cmp bx,dx     
jbe skipapprox
PUSH ax
jmp display
skipapprox:
add ax,1
PUSH ax
jmp display 
square:   
mov flag,0
POP ax
mul ax
cmp dx,0
je skipsquare
stc
skipsquare:
PUSH ax 
jmp display 
root:    
mov flag,0
pop ax
mov dx, 0
mov bx, ax
mov cx, 01FFh 
froot_loop:
mov si, ax
mov ax, bx
div si
mov dx, 0
add ax, si
mov di, 2
div di
mov dx, 0
loop froot_loop
approxroot:
mov si, ax 
mul ax
mov dx, 0
mov di, bx
sub di, ax
mov ax, si
add ax, 1
mul ax
mov dx, bx
sub ax, dx
mov dx, ax
add si, 1
sub dx, di
mov ax, dx 
cmp dx, 32767
jnc rootdone
sub si, 1
rootdone:
mov ax, si  
push ax
mov flag,0
jmp display
remainder:   
cmp scount, 1
je displayn
mov flag,0
POP bx
POP ax
mov dx, 0
div bx
PUSH dx
dec scount 
mov ax, dx
jmp display 
nPr:      
cmp scount, 1
je displayn
mov flag, 0
dec scount
pop cx
pop ax      
mov dx, 0 
mov bx, ax
mov ax, 1
permloop:
mul bx
dec bx    
cmp dx, 0
jne iterative_overflow
loop permloop
push ax
jmp display  
nCr:   
cmp scount, 1
je displayn 
mov flag, 0 
dec scount
pop cx
mov di, cx
pop ax      
mov dx, 0 
mov bx, ax
mov ax, 1
combloop:
mul bx
dec bx    
cmp dx, 0
jne iterative_overflow
loop combloop  
mov cx, di
combit:  
div cx 
mov dx, 0
loop combit
push ax
jmp display
factorial: 
mov flag,0
pop cx
mov ax, 1
mov dx, 0
factorialit:  
mul cx  
cmp dx, 0
jne iterative_overflow
loop factorialit
push ax
jmp display
twoexp:    
mov flag,0
pop cx
mov ax, 2
dec cx
mov bx, 2
mov dx, 0
twoexploop: 
mul bx
cmp dx, 0
jne iterative_overflow
loop twoexploop
push ax
jmp display
exp:      
cmp scount, 1
je displayn
mov flag,0
dec scount
pop cx
pop ax
dec cx
mov bx, ax
mov dx, 0
exploop: 
mul bx
cmp dx, 0
jne iterative_overflow
loop exploop
push ax
jmp display 
iterative_overflow:
stc
jmp display
back:     
POP ax
mov dx, 0
mov bx, 10
div bx
PUSH ax
jmp display
popmem:   
cmp scount,0
je skippop
POP ax
dec scount
pop ax
push ax
skippop:
mov flag,0
jmp display
clear:   
cmp scount,0
je skipc
POP ax
dec scount
jmp clear
skipc:
mov ax,0
jmp display
enter:   
mov ax, 0
mov flag, 0
jmp display
displayn:
pop ax
push ax
display:
mov dx, 020h
push ax
mov al, 000h
out 030h, al
pop ax 
jnc displayloop   
pop ax
mov ax, 0
push ax
clc
mov al, 0FFh
out 030h, al
mov al, 0   
pop ax
push ax  
displayloop:
mov cx, ax
mov si, dx
mov bx, 10  
mov dx, 0
div bx
mov di, dx 
mov ax, cx
mov dx, si 
s0:
cmp di, 0
jne s1  
mov bl, al
mov al, 0111111b
out dx, al 
mov al, bl
jmp continuedisplay
s1:
cmp di, 1
jne s2 
mov bl, al
mov al, 0000110b
out dx, al 
mov al, bl
jmp continuedisplay
s2:
cmp di, 2
jne s3 
mov bl, al
mov al, 1011011b
out dx, al 
mov al, bl
jmp continuedisplay
s3:
cmp di, 3
jne s4 
mov bl, al
mov al, 1001111b
out dx, al    
mov al, bl
jmp continuedisplay
s4:
cmp di, 4
jne s5
mov bl, al
mov al, 1100110b
out dx, al    
mov al, bl
jmp continuedisplay
s5:
cmp di, 5
jne s6
mov bl, al
mov al, 1101101b
out dx, al     
mov al, bl
jmp continuedisplay
s6:
cmp di, 6
jne s7  
mov bl, al
mov al, 1111101b
out dx, al       
mov al, bl
jmp continuedisplay
s7:
cmp di, 7
jne s8
mov bl, al
mov al, 0000111b
out dx, al 
mov al, bl
jmp continuedisplay
s8:
cmp di, 8
jne s9 
mov bl, al
mov al, 1111111b
out dx, al   
mov al, bl
jmp continuedisplay
s9:
mov bl, al
mov al, 1101111b
out dx, al         
mov al, bl
jmp continuedisplay 
continuedisplay:
cmp dx, 027h 
jns redo
add dx, 2
push dx
mov bx, 0Ah
mov dx, 0
div bx   
pop dx
jmp displayloop 
jmp redo