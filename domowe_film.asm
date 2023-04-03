org 0
jmp start
;----przerwanie---
org 0Bh
djnz R2, wlaczenie
mov R2, #1Eh ;sekundy
inc R3
cjne R3, #03h, wlaczenie1; #03Ch=60 sek 
mov R3, #00h 
inc R4
cjne R4, #03h, wlaczenie; #0Fh=15 min
mov R4, #00h
mov TMOD, #0h
clr TR0
setb P2.0
setb P2.1
wlaczenie: reti
wlaczenie1: cpl P2.1
call delay
reti
;----uruchomienie przerwan T0
start: JB P2.0, $;czekanie na wlamanie
mov TMOD, #01h
mov R2, #1Eh
mov R3, #0
mov R4, #0
mov IE, #82h
setb TR0

;----glowna petla programu----
displo: call delay
jnb TR0, start
jmp displo

;----opoznienie-----
delay: mov R6, #01h
dly: mov R7, #0FFh
djnz R7, $
djnz R6, dly
ret
end
