
;-----------------------------------------------------------
; DrawMario_Blue: Draws Mario with BLUE shirt/overalls
;-----------------------------------------------------------
DrawMario_Blue PROC
    pushad
    
    ; Determine position
    mov dh, marioY
    mov dl, marioX
    
    ; Check Invincibility (Star)
    cmp marioInvincible, 1
    je BlueStarColor
    
    ; Normal Color Scheme
    
    ; Check Size (Small or Super)
    cmp marioState, 0
    jne DrawSuperBlue
    
    ; --- Draw Small Mario (Blue Body) ---
    mov eax, LIGHTRED   ; Red Hat
    call SetTextColor
    call Gotoxy
    mov edx, OFFSET marioSmall1
    call WriteString
    
    ; Body (BLUE)
    inc dh
    call Gotoxy
    mov eax, LIGHTBLUE  ; BLUE Shirt
    call SetTextColor
    mov edx, OFFSET marioSmall2
    call WriteString
    
    jmp BlueDrawDone
    
DrawSuperBlue:
    ; --- Draw Super Mario (Blue Body) ---
    ; Head
    cmp marioState, 2 ; Fire
    je BlueFireHead
    mov eax, LIGHTRED
    jmp SetBlueHead
BlueFireHead:
    mov eax, WHITE      ; White Hat for Fire
SetBlueHead:
    call SetTextColor
    call Gotoxy
    mov edx, OFFSET marioSuper_H
    call WriteString
    
    ; Torso (BLUE)
    inc dh
    call Gotoxy
    mov eax, LIGHTBLUE
    call SetTextColor
    mov edx, OFFSET marioSuper_T
    call WriteString
    
    ; Legs (BLUE)
    inc dh
    call Gotoxy
    mov edx, OFFSET marioSuper_L
    call WriteString
    
    jmp BlueDrawDone
    
BlueStarColor:
    ; Flashing logic
    movzx eax, frameCounter
    and eax, 0111b      ; Cycle colors
    add eax, 9          ; Bright colors
    call SetTextColor
    
    cmp marioState, 0
    jne StarSuper
    
    call Gotoxy
    mov edx, OFFSET marioSmall1
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET marioSmall2
    call WriteString
    jmp BlueDrawDone
    
StarSuper:
    call Gotoxy
    mov edx, OFFSET marioSuper_H
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET marioSuper_T
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET marioSuper_L
    call WriteString

BlueDrawDone:
    popad
    ret
DrawMario_Blue ENDP

;-----------------------------------------------------------
; DrawHUD_New: Enhanced HUD Layout
; Top-Left: SCORE, Center: COINS, Right: WORLD/TIME
;-----------------------------------------------------------
DrawHUD_New PROC
    pushad
    
    ; Top Border
    mov eax, WHITE
    call SetTextColor
    mov dh, 0
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET hudBorderTop
    call WriteString
    
    ; Side Borders
    mov dh, 1
    call Gotoxy
    mov edx, OFFSET hudBorderSides
    call WriteString
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET hudBorderSides
    call WriteString
    
    ; --- MARIO & SCORE (Left) ---
    mov dh, 1
    mov dl, 3
    call Gotoxy
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET hudMario
    call WriteString
    
    mov dh, 2
    mov dl, 3
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov eax, playerScore
    call WriteDec
    
    ; --- COINS (Center) ---
    mov dh, 1
    mov dl, 40
    call Gotoxy
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET coinChar
    call WriteString
    mov al, 'x'
    call WriteChar
    movzx eax, playerCoins
    call WriteDec
    
    ; --- WORLD (Right) ---
    mov dh, 1
    mov dl, 60
    call Gotoxy
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET hudWorld
    call WriteString
    
    mov dh, 2
    mov dl, 60
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    ; Check currentLevelNum
    cmp currentLevelNum, 1
    je PrintW1
    cmp currentLevelNum, 2
    je PrintW2
    cmp currentLevelNum, 3
    je PrintW3
    cmp currentLevelNum, 4
    je PrintW4
    jmp PrintTime
    
PrintW1:
    mov edx, OFFSET worldNum
    call WriteString
    jmp PrintTime
PrintW2:
    mov al, '1'
    call WriteChar
    mov al, '-'
    call WriteChar
    mov al, '2'
    call WriteChar
    jmp PrintTime
PrintW3:
    mov al, '1'
    call WriteChar
    mov al, '-'
    call WriteChar
    mov al, '3'
    call WriteChar
    jmp PrintTime
PrintW4:
    mov al, '1'
    call WriteChar
    mov al, '-'
    call WriteChar
    mov al, '4'
    call WriteChar
    
    ; --- TIME (Far Right) ---
PrintTime:
    mov dh, 1
    mov dl, 75
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET hudTime
    call WriteString
    
    mov dh, 2
    mov dl, 75
    call Gotoxy
    ; Time Color Logic
    cmp turboActive, 0
    je NormalTime
    mov eax, LIGHTCYAN
    call SetTextColor
NormalTime:
    movzx eax, gameTime
    call WriteDec
    
    popad
    ret
DrawHUD_New ENDP


