INCLUDE Irvine32.inc
INCLUDELIB winmm.lib

; Windows PlaySound API
PlaySoundA PROTO STDCALL :PTR BYTE, :DWORD, :DWORD

; Sound flags
SND_SYNC        EQU 00000000h
SND_ASYNC       EQU 00000001h
SND_FILENAME    EQU 00020000h
SND_LOOP        EQU 00000008h

VK_SPACE EQU 20h

.data
    ; Colors
    RED = 4
    ORANGE = 6 + 4*16
    WHITE = 15
    YELLOW = 14
    LIGHTBLUE = 11
    LIGHTGREEN = 10
    BROWN = 6
    LIGHTCYAN = 11
    LIGHTRED = 12
    CYAN = 3
    MAGENTA = 13
    DARKGRAY = 8
    BLACK = 0
   
    ; Window Setup Data
    windowRect SMALL_RECT <0, 0, 99, 49>
    outHandle DWORD ?
    bufferSize COORD <100, 50>
   
    ; High Score Display
    highScoreLabel BYTE "HIGH SCORE", 0
    highScoreValue BYTE "000000", 0
   
    ; Title Screen Art
    title1  BYTE "                  _____ _    _ _____  ______ _____  ", 0
    title2  BYTE "                 / ____| |  | |  __ \|  ____|  __ \ ", 0
    title3  BYTE "                | (___ | |  | | |__) | |__  | |__) |", 0
    title4  BYTE "                 \___ \| |  | |  ___/|  __| |  _  / ", 0
    title5  BYTE "                 ____) | |__| | |    | |____| | \ \ ", 0
    title6  BYTE "                |_____/ \____/|_|    |______|_|  \_\", 0
   
    title7  BYTE "      __  __          _____  _____ ____    ____  _____   ____   _____ ", 0
    title8  BYTE "     |  \/  |   /\   |  __ \|_   _/ __ \  |  _ \|  __ \ / __ \ / ____|", 0
    title9  BYTE "     | \  / |  /  \  | |__) | | || |  | | | |_) | |__) | |  | | (___  ", 0
    title10 BYTE "     | |\/| | / /\ \ |  _  /  | || |  | | |  _ <|  _  /| |  | |\___ \ ", 0
    title11 BYTE "     | |  | |/ ____ \| | \ \ _| || |__| | | |_) | | \ \| |__| |____) |", 0
    title12 BYTE "     |_|  |_/_/    \_\_|  \_\_____\____/  |____/|_|  \_\\____/|_____/ ", 0
   
    ; Developer & Roll Number Display
    madeByMsg   BYTE "                    MADE BY: MUHAMMAD IDREES", 0
    rollNumMsg  BYTE "                      ROLL NUMBER: 23I-0582", 0
   
    ; Decorative Elements
    cloud1  BYTE "     .-~~~-.     .-~~~-.     .-~~~-.     .-~~~-.     .-~~~-.    ", 0
    cloud2  BYTE "   .' o    `.  .' o    `.  .' o    `.  .' o    `.  .' o    `. ", 0
    cloud3  BYTE "  '    o    ` '    o    ` '    o    ` '    o    ` '    o    `", 0
   
    ground1 BYTE " ___________________________________________________________________", 0
    ground2 BYTE "|###|###|###|###|###|###|###|###|###|###|###|###|###|###|###|###|", 0
    ground3 BYTE "|###|###|###|###|###|###|###|###|###|###|###|###|###|###|###|###|", 0
   
    brick1  BYTE "                [?]      [?]      [?]      [?]", 0
   
    mario1  BYTE "                                .-.  ", 0
    mario2  BYTE "                               (o.o) ", 0
    mario3  BYTE "                                |=|  ", 0
    mario4  BYTE "                               /   \ ", 0
    mario5  BYTE "                              /     \", 0
   
    pipe1   BYTE "         |====|                              |====|", 0
    pipe2   BYTE "         | || |                              | || |", 0
    pipe3   BYTE "         | || |                              | || |", 0
    pipe4   BYTE "         |____|                              |____|", 0
   
    ; Menu Options
    onePlayerMsg BYTE "                        1 PLAYER GAME", 0
    menu1   BYTE "                      [1] START GAME", 0
    menu2   BYTE "                      [2] HIGH SCORES", 0
    menu3   BYTE "                      [3] INSTRUCTIONS", 0
    menu4   BYTE "                      [4] EXIT", 0
   
    menuPrompt BYTE "                   SELECT AN OPTION (1-4): ", 0
   
    ; Messages
    copyrightMsg BYTE "         (C) 1985 NINTENDO    RECREATED FOR COAL PROJECT 2024", 0
    pressMsg     BYTE "                PRESS ANY KEY TO CONTINUE...", 0
   
    ; Stars decoration
    stars1      BYTE "        *       *         *          *         *       *", 0
    stars2      BYTE "   *         *       *         *         *         *      ", 0
   
    ; High Scores Screen
    hsTitle1    BYTE "            +-+-+-+-+ +-+-+-+-+-+-+", 0
    hsTitle2    BYTE "            |H|I|G|H| |S|C|O|R|E|S|", 0
    hsTitle3    BYTE "            +-+-+-+-+ +-+-+-+-+-+-+", 0
   
    trophy1     BYTE "                    ___________", 0
    trophy2     BYTE "                   '._==_==_=_.'", 0
    trophy3     BYTE "                   .-\\:      /-.", 0
    trophy4     BYTE "                  | (|:.     |) |", 0
    trophy5     BYTE "                   '-|:.     |-'", 0
    trophy6     BYTE "                     \\::.    /", 0
    trophy7     BYTE "                      '::. .'", 0
    trophy8     BYTE "                        ) (", 0
    trophy9     BYTE "                      _.' '._", 0
    trophy10    BYTE "                     '-------'", 0
   
    hsRank1     BYTE "                    1ST PLACE: ", 0
    hsRank2     BYTE "                    2ND PLACE: ", 0
    hsRank3     BYTE "                    3RD PLACE: ", 0
   
    hsScore1    BYTE "050000", 0
    hsScore2    BYTE "035000", 0
    hsScore3    BYTE "020000", 0
   
    hsDecor1    BYTE "            ****************************************", 0
    hsDecor2    BYTE "            *   *   *   *   *   *   *   *   *   *  ", 0
   
    backMsg     BYTE "                PRESS ANY KEY TO GO BACK...", 0
   
    ; ============================================
    ; DIFFICULTY SELECTION SCREEN
    ; ============================================
    diffTitle1  BYTE "    ____  _  __  __  _             _  _          ", 0
    diffTitle2  BYTE "   |  _ \(_)/ _|/ _|(_) ___  _   _| || |_ _   _  ", 0
    diffTitle3  BYTE "   | | | | | |_| |_ | |/ __|| | | | || __| | | | ", 0
    diffTitle4  BYTE "   | |_| | |  _|  _|| | (__ | |_| | || |_| |_| | ", 0
    diffTitle5  BYTE "   |____/|_|_| |_|  |_|\___| \__,_|_| \__|\__, | ", 0
    diffTitle6  BYTE "                                          |___/  ", 0
   
    diffHeader  BYTE "              === SELECT GAME DIFFICULTY ===", 0
   
    ; Speed Racer Mario Info Box
    speedInfo1  BYTE "     .--------------------------------------------------.", 0
    speedInfo2  BYTE "     |     << SPEED RACER MARIO - ROLL NO: 23I-0582 >>  |", 0
    speedInfo3  BYTE "     |--------------------------------------------------|", 0
    speedInfo4  BYTE "     |  * Mario moves 25% FASTER than normal speed!     |", 0
    speedInfo5  BYTE "     |  * TURBO STAR: Doubles speed for 8 seconds!      |", 0
    speedInfo6  BYTE "     |  * Timer turns BLUE when speed boost is active!  |", 0
    speedInfo7  BYTE "     '--------------------------------------------------'", 0
   
    ; Difficulty Options with ASCII art boxes
    easyBox1    BYTE "          .=============================.", 0
    easyBox2    BYTE "          |    [1]  E A S Y  M O D E    |", 0
    easyBox3    BYTE "          |       * 5 Lives Start       |", 0
    easyBox4    BYTE "          |       * Slower Enemies      |", 0
    easyBox5    BYTE "          |       * More Power-ups      |", 0
    easyBox6    BYTE "          '============================='", 0
   
    mediumBox1  BYTE "          .=============================.", 0
    mediumBox2  BYTE "          |  [2]  M E D I U M  M O D E  |", 0
    mediumBox3  BYTE "          |       * 3 Lives Start       |", 0
    mediumBox4  BYTE "          |       * Normal Enemies      |", 0
    mediumBox5  BYTE "          |       * Standard Power-ups  |", 0
    mediumBox6  BYTE "          '============================='", 0
   
    hardBox1    BYTE "          .=============================.", 0
    hardBox2    BYTE "          |    [3]  H A R D  M O D E    |", 0
    hardBox3    BYTE "          |       * 1 Life Start        |", 0
    hardBox4    BYTE "          |       * Fast Enemies        |", 0
    hardBox5    BYTE "          |       * Rare Power-ups      |", 0
    hardBox6    BYTE "          '============================='", 0
   
    diffPrompt  BYTE "              SELECT DIFFICULTY (1-3): ", 0
   
    ; ============================================
    ; LEVEL SELECTION SCREEN  
    ; ============================================
    lvlTitle1   BYTE "     _                    _   ____       _           _   ", 0
    lvlTitle2   BYTE "    | |    _____   _____ | | / ___|  ___| | ___  ___| |_ ", 0
    lvlTitle3   BYTE "    | |   / _ \ \ / / _ \| | \___ \ / _ \ |/ _ \/ __| __|", 0
    lvlTitle4   BYTE "    | |__|  __/\ V /  __/| |  ___) |  __/ |  __/ (__| |_ ", 0
    lvlTitle5    BYTE "    |_____\___| \_/ \___||_| |____/ \___|_|\___|\___|\__|", 0
   
    lvlHeader   BYTE "                 === SELECT YOUR WORLD ===", 0
   
    ; World/Level boxes with visual representations
    world1Box1  BYTE "     .=========================================.", 0
    world1Box2  BYTE "     |  [1] WORLD 1-1: GRASSLAND ADVENTURE     |", 0
    world1Box3  BYTE "     |-----------------------------------------|", 0
    world1Box4  BYTE "     |   ~~~~    ~~~~    ~~~~    ~~~~          |", 0
    world1Box5  BYTE "     |  (    )  (    )  (    )  (    )   [?]   |", 0
    world1Box6  BYTE "     |   ~~~~    ~~~~    ~~~~    ~~~~          |", 0
    world1Box7  BYTE "     |  ##############################  |==|  |", 0
    world1Box8  BYTE "     |  Goombas, Koopas, Question Blocks       |", 0
    world1Box9  BYTE "     '========================================='", 0
   
    world2Box1  BYTE "     .=========================================.", 0
    world2Box2  BYTE "     |  [2] WORLD 1-2: UNDERGROUND CHALLENGE   |", 0
    world2Box3  BYTE "     |-----------------------------------------|", 0
    world2Box4  BYTE "     |     ____    ____    ____    ____        |", 0
    world2Box5  BYTE "     |    |####|  |####|  |####|  |####|       |", 0
    world2Box6  BYTE "     |    |    |  |    |  |    |  |    |       |", 0
    world2Box7  BYTE "     |  Piranha Plants, Moving Platforms       |", 0
    world2Box8  BYTE "     '========================================='", 0
   
    world3Box1  BYTE "     .=========================================.", 0
    world3Box2  BYTE "     |  [3] WORLD 1-3: SKY HIGH PLATFORMS      |", 0
    world3Box3  BYTE "     |-----------------------------------------|", 0
    world3Box4  BYTE "     |        *   *       *       *            |", 0
    world3Box5  BYTE "     |    [===]     [===]     [===]            |", 0
    world3Box6  BYTE "     |         [===]     [===]                 |", 0
    world3Box7  BYTE "     |  Floating Platforms, Flying Koopas      |", 0
    world3Box8  BYTE "     '========================================='", 0
   
    world4Box1  BYTE "     .=========================================.", 0
    world4Box2  BYTE "     |  [4] WORLD 1-4: CASTLE FORTRESS         |", 0
    world4Box3  BYTE "     |-----------------------------------------|", 0
    world4Box4  BYTE "     |    /\  |####|  /\  |####|    ^    ^     |", 0
    world4Box5  BYTE "     |   /##\ |    | /##\ |    |   ^^^  ^^^    |", 0
    world4Box6  BYTE "     |  ~LAVA~LAVA~LAVA~LAVA~LAVA~LAVA~LAVA~   |", 0
    world4Box7  BYTE "     |  Fire Bars, Lava Pits, BOWSER BOSS!     |", 0
    world4Box8  BYTE "     '========================================='", 0
   
    lvlPrompt   BYTE "                 SELECT LEVEL (1-4): ", 0
   
    ; Game state variables
    selectedDifficulty BYTE 0
    selectedLevel BYTE 0
    playerLives BYTE 3
   
    ; Loading message
    loadingMsg  BYTE "              LOADING WORLD ", 0
    loadingDots BYTE "...", 0
    getReadyMsg BYTE "                   GET READY!", 0
   
    ; ============================================
    ; INSTRUCTIONS SCREEN
    ; ============================================
    instTitle1  BYTE "   _____           _                   _   _                 ", 0
    instTitle2  BYTE "  |_   _|         | |                 | | (_)                ", 0
    instTitle3  BYTE "    | |  _ __  ___| |_ _ __ _   _  ___| |_ _  ___  _ __  ___ ", 0
    instTitle4  BYTE "    | | | '_ \/ __| __| '__| | | |/ __| __| |/ _ \| '_ \/ __|", 0
    instTitle5  BYTE "   _| |_| | | \__ \ |_| |  | |_| | (__| |_| | (_) | | | \__ \", 0
    instTitle6  BYTE "  |_____|_| |_|___/\__|_|   \__,_|\___|\__|_|\___/|_| |_|___/", 0
   
    ; Controls Section
    ctrlHeader  BYTE "  .======================= CONTROLS =======================.", 0
    ctrlLine1   BYTE "  |                                                         |", 0
    ctrlLine2   BYTE "  |   [A] or [LEFT ARROW]  - Move Mario LEFT                |", 0
    ctrlLine3   BYTE "  |   [D] or [RIGHT ARROW] - Move Mario RIGHT               |", 0
    ctrlLine4   BYTE "  |   [W] or [SPACE]       - JUMP                           |", 0
    ctrlLine5   BYTE "  |   [SHIFT]              - RUN (Hold while moving)        |", 0
    ctrlLine6   BYTE "  |   [F]                  - Shoot FIREBALL (if Fire Mario) |", 0
    ctrlLine7   BYTE "  |   [ESC]                - PAUSE Game                     |", 0
    ctrlLine8   BYTE "  |   [Q]                  - QUIT to Main Menu              |", 0
    ctrlEnd     BYTE "  '========================================================='", 0
   
    ; Power-ups Section
    pwrHeader   BYTE "  .====================== POWER-UPS =======================.", 0
    pwrLine1    BYTE "  |                                                         |", 0
    pwrLine2    BYTE "  |   [MUSHROOM]  - Become SUPER MARIO (Grow bigger!)       |", 0
    pwrLine3    BYTE "  |   [FIRE FLOWER] - Become FIRE MARIO (Shoot fireballs!)  |", 0
    pwrLine4    BYTE "  |   [STAR]      - INVINCIBILITY for 10 seconds!           |", 0
    pwrLine5    BYTE "  |   [1-UP]      - Extra LIFE! (Green mushroom)            |", 0
    pwrLine6    BYTE "  |   [COIN]      - Collect 100 for an extra life!          |", 0
    pwrEnd      BYTE "  '========================================================='", 0
   
    ; Enemies Section  
    enemyHeader BYTE "  .======================== ENEMIES ========================.", 0
    enemyLine1  BYTE "  |                                                          |", 0
    enemyLine2  BYTE "  |   [GOOMBA]  @@  - Brown mushroom, jump on to defeat!     |", 0
    enemyLine3  BYTE "  |   [KOOPA]   {}  - Turtle, becomes shell when jumped on   |", 0
    enemyLine4  BYTE "  |   [PIRANHA] }|{ - Plant in pipes, cannot be jumped on!   |", 0
    enemyLine5  BYTE "  |   [BOWSER]  /M\ - BOSS! Breathes fire, very dangerous!   |", 0
    enemyEnd    BYTE "  '=========================================================='", 0
   
    ; Scoring Section
    scoreHeader BYTE "  .======================== SCORING ========================.", 0
    scoreLine1  BYTE "  |                                                          |", 0
    scoreLine2  BYTE "  |   Defeat Goomba       :  100 points                      |", 0
    scoreLine3  BYTE "  |   Defeat Koopa        :  100 points (shell kick combos!) |", 0
    scoreLine4  BYTE "  |   Collect Coin        :  200 points                      |", 0
    scoreLine5  BYTE "  |   Hit Question Block  :  Varies (coins or power-ups)     |", 0
    scoreLine6  BYTE "  |   Grab Flagpole Top   :  5000 points BONUS!              |", 0
    scoreEnd    BYTE "  '=========================================================='", 0
   
    ; Speed Racer Info
    speedHeader BYTE "  .=============== SPEED RACER MARIO (23I-0582) ============.", 0
    speedLine1  BYTE "  |                                                          |", 0
    speedLine2  BYTE "  |   * YOUR MARIO MOVES 25% FASTER THAN NORMAL!             |", 0
    speedLine3  BYTE "  |   * TURBO STAR (Blue Star) - DOUBLE SPEED for 8 sec!     |", 0
    speedLine4  BYTE "  |   * Timer turns BLUE when speed boost is ACTIVE!         |", 0
    speedLine5  BYTE "  |   * Use your SPEED to outrun enemies and beat the clock! |", 0
    speedEnd    BYTE "  '=========================================================='", 0
   
    instBackMsg BYTE "            >>> PRESS ANY KEY TO RETURN TO MENU <<<", 0
   
    ; ============================================
    ; LEVEL 1 GAME DATA - WORLD 1-1 GRASSLAND
    ; ============================================
   
    ; Game HUD Elements
    hudMario    BYTE "MARIO", 0
    hudWorld    BYTE "WORLD", 0
    hudTime     BYTE "TIME", 0
    hudCoins    BYTE "x", 0
    hudLives    BYTE "x ", 0
    worldNum    BYTE "1-1", 0
    hudBorderTop    BYTE " .========================================================================================.", 0
    hudBorderSides  BYTE " |                                                                                        |", 0
    hudBorderBot    BYTE " '========================================================================================'", 0
   
    ; ============================================
    ; PHYSICS CONSTANTS (Speed Racer Mario!)
    ; ============================================
    GRAVITY         SBYTE 1         ; Gravity acceleration (positive = down)
    JUMP_POWER      SBYTE -8        ; Initial jump velocity (negative = up)
    MAX_FALL_SPEED  SBYTE 6         ; Terminal velocity
    GROUND_LEVEL    BYTE 18         ; Ground Y position for Mario
    BASE_SPEED      BYTE 1          ; Normal movement speed
    ACCEL_X         BYTE 2          ; Rate of speed increase (Now stronger than friction)
    DECEL_X         BYTE 1          ; Rate of speed decrease (friction)
    MAX_WALK_SPEED  BYTE 2          ; Maximum walking speed
    MAX_RUN_SPEED   BYTE 4          ; Maximum running speed
    SPEED_RACER_MULT BYTE 2         ; Speed Racer = 2x speed (25% faster base + bonus)
    RUN_MULTIPLIER  BYTE 2          ; Running multiplier
    MAX_JUMP_TIME   BYTE 15         ; Frames to hold jump for max height
    CEILING_LIMIT   BYTE 5          ; Hard limit to prevent HUD overlap
   
    ; Game Variables
    playerScore DWORD 0
    playerCoins BYTE 0
    gameTime    WORD 400
    marioX      BYTE 5          ; Mario X position
    marioY      BYTE 18         ; Mario Y position (ground level - Mario is 2 chars tall)
    marioState  BYTE 0          ; 0=small, 1=super, 2=fire
    isJumping   BYTE 0
    jumpHeight  BYTE 0
    jumpTime    BYTE 0          ; How long jump button held
    isFalling   BYTE 0
    isOnGround  BYTE 1          ; 1 if Mario is on ground
    velY        SBYTE 0         ; vertical velocity (negative = up, positive = down)
    velX        SBYTE 0         ; horizontal velocity
    gameRunning BYTE 1
    speedBoost  BYTE 1          ; Speed Racer Mario is ALWAYS faster! (Roll# ends in 2)
    boostTimer  BYTE 0
    turboActive BYTE 0          ; Turbo Star power-up
    turboTimer  WORD 0
    isRunning   BYTE 0          ; SHIFT key held
    frameCounter BYTE 0         ; For timing
    killCombo   BYTE 0          ; For shell multi-kills
    horizontalInputActive BYTE 0 ; 1 if A/D/Arrows being pressed
   
    ; Mario Sprites (Small Mario - compact 2-line sprite)
    marioSmall1 BYTE "@", 0     ; Head (single char)
    marioSmall2 BYTE "M", 0     ; Body with M for Mario
    
    ; Super Mario Sprites (3-line sprite)
    marioSuper_H  BYTE "(@)", 0   ; Head
    marioSuper_T  BYTE "[M]", 0   ; Torso
    marioSuper_L  BYTE "||", 0    ; Legs
   
    ; Ground Line for Level 1
    groundLine  BYTE "####################################################################################################", 0
   
    ; Sky/Background characters
    skyChar     BYTE " ", 0
   
    ; Game Level Elements
    ; Question Block
    qBlock      BYTE "[?]", 0
    qBlockHit   BYTE "[ ]", 0
   
    ; Brick Block
    brickBlock     BYTE "[#]", 0
    brick1Active   BYTE 1
    brick2Active   BYTE 1
    brick3Active   BYTE 1
   
    ; Pipe characters  
    pipeTop     BYTE "|==|", 0
    pipeMid     BYTE "|  |", 0
   
    ; Goomba enemy
    goombaChar  BYTE "@@", 0
    goombaX     BYTE 40
    goombaY     BYTE 19         ; Enemy Y position (1 char tall, stands on ground)
    goombaDir   BYTE 1          ; 1=right, 0=left
    goombaAlive BYTE 1
    goombaSpeed BYTE 1
   
    ; Koopa enemy
    koopaChar   BYTE "{}", 0
    koopaX      BYTE 60
    koopaY      BYTE 19         ; Enemy Y position (1 char tall, stands on ground)
    koopaDir    BYTE 0
    koopaAlive  BYTE 1
    koopaSpeed  BYTE 1
   
    ; Cloud for sky
    cloudSmall  BYTE "~~~", 0
   
    ; Hills/bushes
    hillSmall   BYTE " (/\) ", 0
    bushSmall   BYTE " {#} ", 0
   
    ; Coin character
    coinChar    BYTE "o", 0
   
    ; Flagpole
    flagPole    BYTE "|", 0
    flagTop     BYTE "P", 0
   
    ; Game messages
    pauseMsg    BYTE "  GAME PAUSED  ", 0
    pauseOpt1   BYTE "  [R] RESUME   ", 0
    pauseOpt2   BYTE "  [Q] QUIT     ", 0
    gameOverMsg BYTE "G A M E   O V E R", 0
    levelClear  BYTE "LEVEL CLEAR!", 0
    slidingMsg  BYTE "MARIO SLIDES DOWN!", 0
    bonusMsg    BYTE "TIME BONUS: ", 0
    marioFlagBonusMsg BYTE "FLAG BONUS: ", 0
   
    ; Collectible coins (positions) - World 1-1 layout
    coin1X      BYTE 16
    coin1Y      BYTE 17
    coin1Active BYTE 1
    coin2X      BYTE 23
    coin2Y      BYTE 17
    coin2Active BYTE 1
    coin3X      BYTE 48
    coin3Y      BYTE 8
    coin3Active BYTE 1
    coin4X      BYTE 55
    coin4Y      BYTE 17
    coin4Active BYTE 1
    coin5X      BYTE 70
    coin5Y      BYTE 15
    coin5Active BYTE 1
   
    ; Flagpole data
    flagpoleX   BYTE 72
    flagpoleTopY BYTE 8
    flagpoleBotY BYTE 19
    marioOnPole BYTE 0
    
    ; --- Question Block Data ---
    qBlock1X    BYTE 16
    qBlock1Y    BYTE 13
    qBlock1Hit  BYTE 0
    qBlock1Item BYTE 1          ; 1=Coin, 2=Mushroom, 3=Star
    
    qBlock2X    BYTE 21
    qBlock2Y    BYTE 13
    qBlock2Hit  BYTE 0
    qBlock2Item BYTE 2
    
    qBlock3X    BYTE 78
    qBlock3Y    BYTE 13
    qBlock3Hit  BYTE 0
    qBlock3Item BYTE 3
    
    ; --- Items Data ---
    itemCharM   BYTE "M", 0     ; Mushroom
    itemCharS   BYTE "S", 0     ; Star
    itemCharF   BYTE "F", 0     ; Fire Flower
    itemChar1   BYTE "1U", 0    ; 1-UP Mushroom
    
    mushroomActive BYTE 0
    mushroomX   BYTE 0
    mushroomY   BYTE 0
    mushroomDir BYTE 0          ; 0=Left, 1=Right
    
    starActive  BYTE 0
    starX       BYTE 0
    starY       BYTE 0
    starDir     BYTE 0
    
    ; Fire Flower Data
    fireFlowerActive BYTE 0
    fireFlowerX      BYTE 0
    fireFlowerY      BYTE 0
    
    ; Fireball Constants
    fireballChar     BYTE "o", 0
    FIRE_LIMIT       EQU 2
    fireballSpeed    BYTE 3
    
    ; 1-UP Mushroom Data
    oneUpItemActive  BYTE 0
    oneUpItemX       BYTE 0
    oneUpItemY       BYTE 0
    oneUpItemDir     BYTE 0
    
    qBlockEmpty    BYTE "[ ]", 0
    slideY      BYTE 0
    slideSpeed  BYTE 2          ; Sliding speed
   
    ; Score display buffer
    scoreBuffer BYTE "000000", 0
   
    ; Key state tracking
    leftKeyHeld BYTE 0
    rightKeyHeld BYTE 0
    jumpKeyHeld BYTE 0
    shiftKeyHeld BYTE 0

    ; ============================================
    ; WORLD 1-1 ENHANCED LEVEL DATA
    ; ============================================
    
    ; Pipe Positions and Heights (authentic World 1-1)
    PIPE1_X       BYTE 28       ; First small pipe
    PIPE1_HEIGHT  BYTE 3        ; 3 rows tall
    PIPE2_X       BYTE 40       ; Second medium pipe  
    PIPE2_HEIGHT  BYTE 4        ; 4 rows tall
    PIPE3_X       BYTE 52       ; Third tall pipe
    PIPE3_HEIGHT  BYTE 5        ; 5 rows tall
    
    ; Additional Goombas for authentic level
    goomba2X      BYTE 22
    goomba2Y      BYTE 19
    goomba2Dir    BYTE 0        ; Start moving left
    goomba2Alive  BYTE 1
    goomba2Speed  BYTE 1
    
    goomba3X      BYTE 48
    goomba3Y      BYTE 19
    goomba3Dir    BYTE 1        ; Start moving right
    goomba3Alive  BYTE 1
    goomba3Speed  BYTE 1
    
    ; Stair-step pyramid at end of level
    STAIR_START_X BYTE 62       ; Where stairs begin
    STAIR_BLOCKS  BYTE 4        ; 4-step pyramid
    
    ; Pit/Gap position (authentic World 1-1 has gaps)
    PIT_START_X   BYTE 35
    PIT_END_X     BYTE 38
    hasPit        BYTE 1        ; 1 = pit is active
    
    ; Block row positions for Question/Brick blocks
    BLOCK_ROW_Y   BYTE 13       ; Height for main block row
    
    ; Mini Castle at end of level
    castleChar1   BYTE " [##] ", 0
    castleChar2   BYTE "[####]", 0
    castleChar3   BYTE "|    |", 0
    castleChar4   BYTE "|_/\_|", 0
    CASTLE_X      BYTE 80
    
    ; Additional visual elements
    cloudLarge    BYTE "(~~~)", 0
    bigHill1      BYTE "  /\\  ", 0
    bigHill2      BYTE " /  \\ ", 0
    bigHill3      BYTE "/____\\", 0

    ; ============================================
    ; LEVEL 2 GAME DATA - WORLD 1-2 UNDERGROUND
    ; ============================================
   
    ; Level 2 Constants
    CEILING_LEVEL BYTE 4
   
    ; Level 2 Assets
    ceilingLine  BYTE "####################################################################################################", 0
    groundLineL2 BYTE "____________________________________________________________________________________________________", 0

    ; Piranha Plant
    piranhaChar  BYTE "}|{", 0
    piranhaStem  BYTE " | ", 0
    piranha1X    BYTE 30
    piranha1Y    BYTE 16        ; Base Y (inside pipe)
    piranha1H    BYTE 0         ; Current Height (0-2)
    piranha1State BYTE 0        ; 0=WaitDown, 1=GoingUp, 2=WaitUp, 3=GoingDown
    piranha1Timer BYTE 0
   
    ; Moving Platform (Horizontal)
    platChar     BYTE "=======", 0
    plat1X       BYTE 45
    plat1Y       BYTE 14
    plat1Dir     BYTE 1         ; 1=Right, 0=Left
    plat1Timer   BYTE 0
   
    ; Elevator Platform (Vertical)
    elevChar     BYTE "[===]", 0
    elev1X       BYTE 65
    elev1Y       BYTE 15
    elev1Dir     BYTE 0         ; 0=Up, 1=Down
    elev1Timer   BYTE 0
   
    ; Coin Room Flags
    coinRoomOpen BYTE 0
    
    ; ============================================
    ; LEVEL 2 ENHANCED DATA - UNDERGROUND
    ; ============================================
    
    ; Additional Piranha Plants for Level 2
    piranha2X       BYTE 50
    piranha2Y       BYTE 16
    piranha2H       BYTE 0
    piranha2State   BYTE 0
    piranha2Timer   BYTE 0
    
    piranha3X       BYTE 70
    piranha3Y       BYTE 16
    piranha3H       BYTE 0
    piranha3State   BYTE 0
    piranha3Timer   BYTE 0
    
    ; Level 2 Goombas
    L2goomba1X      BYTE 25
    L2goomba1Y      BYTE 19
    L2goomba1Dir    BYTE 1
    L2goomba1Alive  BYTE 1
    
    L2goomba2X      BYTE 55
    L2goomba2Y      BYTE 19
    L2goomba2Dir    BYTE 0
    L2goomba2Alive  BYTE 1
    
    ; Red Koopa (turns at edges, doesn't fall)
    redKoopaX       BYTE 45
    redKoopaY       BYTE 19
    redKoopaDir     BYTE 1
    redKoopaAlive   BYTE 1
    redKoopaIsShell BYTE 0
    redShellMoving  BYTE 0
    redShellDir     BYTE 1
    redKoopaChar    BYTE "RK", 0    ; Red Koopa visual
    
    ; Additional Moving Platforms for Level 2
    plat2X          BYTE 25
    plat2Y          BYTE 14
    plat2Dir        BYTE 0
    plat2MinX       BYTE 15
    plat2MaxX       BYTE 35
    
    plat3X          BYTE 60
    plat3Y          BYTE 12
    plat3Dir        BYTE 1
    plat3MinX       BYTE 55
    plat3MaxX       BYTE 75
    
    ; Additional Elevator Platforms
    elev2X          BYTE 85
    elev2Y          BYTE 12
    elev2Dir        BYTE 1
    elev2MinY       BYTE 8
    elev2MaxY       BYTE 17
    
    ; Level 2 Coin Room Coins (8 coins)
    L2coin1X        BYTE 12
    L2coin1Y        BYTE 8
    L2coin1Active   BYTE 1
    L2coin2X        BYTE 15
    L2coin2Y        BYTE 8
    L2coin2Active   BYTE 1
    L2coin3X        BYTE 18
    L2coin3Y        BYTE 8
    L2coin3Active   BYTE 1
    L2coin4X        BYTE 21
    L2coin4Y        BYTE 8
    L2coin4Active   BYTE 1
    L2coin5X        BYTE 12
    L2coin5Y        BYTE 10
    L2coin5Active   BYTE 1
    L2coin6X        BYTE 15
    L2coin6Y        BYTE 10
    L2coin6Active   BYTE 1
    L2coin7X        BYTE 18
    L2coin7Y        BYTE 10
    L2coin7Active   BYTE 1
    L2coin8X        BYTE 21
    L2coin8Y        BYTE 10
    L2coin8Active   BYTE 1
    
    ; Level 2 Question Blocks
    L2qBlock1X      BYTE 35
    L2qBlock1Y      BYTE 13
    L2qBlock1Hit    BYTE 0
    L2qBlock1Item   BYTE 2          ; Mushroom
    
    L2qBlock2X      BYTE 65
    L2qBlock2Y      BYTE 13
    L2qBlock2Hit    BYTE 0
    L2qBlock2Item   BYTE 3          ; Star
    
    ; Level 2 Pipes (with Piranha Plants)
    L2_PIPE1_X      BYTE 30
    L2_PIPE2_X      BYTE 50
    L2_PIPE3_X      BYTE 70
    L2_PIPE_HEIGHT  BYTE 4
    
    ; Underground level boundaries
    L2_CEILING      BYTE 4
    L2_GROUND       BYTE 18
    
    ; Shell combo tracking
    comboMultiplier BYTE 1          ; 1=100, 2=200, 4=400, 8=800
    comboTimeout    BYTE 0          ; Frames until combo resets
    COMBO_WINDOW    BYTE 60         ; ~1 second window for combos
    
    ; Flagpole grab position
    flagGrabY       BYTE 0          ; Y position where Mario grabbed pole
    
    ; 1-UP Mushroom
    oneUpActive     BYTE 0
    oneUpX          BYTE 0
    oneUpY          BYTE 0
    oneUpDir        BYTE 1
    oneUpChar       BYTE "1+", 0
    
    ; Mario on platform tracking
    marioOnPlatform BYTE 0          ; 0=no, 1=moving plat, 2=elevator
    platformDeltaX  SBYTE 0         ; Platform movement applied to Mario
    platformDeltaY  SBYTE 0
   
    ; ============================================
    ; KOOPA SHELL MECHANICS (Section 3)
    ; ============================================
    koopaShell   BYTE "()", 0
    koopaIsShell BYTE 0         ; 0=turtle, 1=shell
    shellMoving  BYTE 0         ; 0=stationary, 1=moving
    shellDir     BYTE 1         ; Shell direction when kicked
    shellSpeed   BYTE 3         ; Fast moving shell!
    comboCount   BYTE 0         ; Kill combo counter
    comboTimer   BYTE 0         ; Combo timeout
   
    ; ============================================
    ; SUPER MUSHROOM POWER-UP (Section 3)
    ; ============================================
    mushroomChar BYTE "M+", 0
    mushroom1X   BYTE 25
    mushroom1Y   BYTE 10
    mushroom1Active BYTE 0      ; 0=hidden in block, 1=spawned, 2=collected
    mushroom1Dir BYTE 1
    mushroomSpeed BYTE 1
   
    ; Super Mario sprites (taller)
    marioSuper1  BYTE "(@)", 0
    marioSuper2  BYTE "[M]", 0
    marioSuper3  BYTE "||", 0    ; Extra body row for Super
    marioFire_T  BYTE "{M}", 0   ; Fire Mario Torso
   
    ; ============================================
    ; HIDDEN BLOCKS (Section 3)
    ; ============================================
    hiddenBlock1X BYTE 20
    hiddenBlock1Y BYTE 12
    hiddenBlock1Found BYTE 0
   
    hiddenBlock2X BYTE 40
    hiddenBlock2Y BYTE 10
    hiddenBlock2Found BYTE 0
   
    hiddenBlock3X BYTE 60
    hiddenBlock3Y BYTE 8
    hiddenBlock3Found BYTE 0
   
    hiddenBlockChar BYTE "[!]", 0
   
    ; ============================================
    ; LEVEL 3 GAME DATA - WORLD 1-3 SKY
    ; ============================================
   
    ; Sky Level Visual Constants
    L3_SKY_COLOR    EQU 11          ; LIGHTCYAN for sky
    L3_GROUND_Y     BYTE 19         ; Ground row (limited sections)
    
    ; Sky Level Assets
    cloudLarge1  BYTE " .~~~. ", 0
    cloudLarge2  BYTE "(     )", 0
    cloudLarge3  BYTE " '~~~' ", 0
    cloudTiny    BYTE "(-)", 0
   
    treeTrunk    BYTE "|||", 0
    treeTop      BYTE "[###]", 0
    treeTrunk2   BYTE " | ", 0
   
    bridgeChar   BYTE "========", 0
    bridgeShort  BYTE "====", 0
    
    ; Cloud Positions (decorative background)
    cloud1X      BYTE 5
    cloud1Y      BYTE 5
    cloud2X      BYTE 25
    cloud2Y      BYTE 4
    cloud3X      BYTE 50
    cloud3Y      BYTE 6
    cloud4X      BYTE 75
    cloud4Y      BYTE 5
    cloud5X      BYTE 90
    cloud5Y      BYTE 7

    ; Floating Platforms for Level 3 (Green mushroom platforms)
    L3plat1X     BYTE 5
    L3plat1Y     BYTE 17        ; Starting platform (safer)
    L3plat2X     BYTE 18
    L3plat2Y     BYTE 14
    L3plat3X     BYTE 32
    L3plat3Y     BYTE 11
    L3plat4X     BYTE 48
    L3plat4Y     BYTE 13
    L3plat5X     BYTE 62
    L3plat5Y     BYTE 10
    L3plat6X     BYTE 78
    L3plat6Y     BYTE 15
    
    ; Old skyPlat variables (keep for compatibility)
    skyPlat1X    BYTE 15
    skyPlat1Y    BYTE 15
    skyPlat2X    BYTE 30
    skyPlat2Y    BYTE 12
    skyPlat3X    BYTE 45
    skyPlat3Y    BYTE 16
    skyPlat4X    BYTE 60
    skyPlat4Y    BYTE 10
    skyPlat5X    BYTE 75
    skyPlat5Y    BYTE 14

    ; Mushroom Platform (Green)
    mushPlatChar BYTE "[====]", 0
    mushPlatWide BYTE "[======]", 0
    
    ; Tree Trunk Data (tall columns with mushroom tops)
    tree1X       BYTE 22
    tree1TopY    BYTE 12        ; Y of platform top
    tree1Height  BYTE 7         ; Trunk extends down
    
    tree2X       BYTE 38
    tree2TopY    BYTE 9
    tree2Height  BYTE 10
    
    tree3X       BYTE 55
    tree3TopY    BYTE 11
    tree3Height  BYTE 8
    
    tree4X       BYTE 72
    tree4TopY    BYTE 13
    tree4Height  BYTE 6

    ; Paratroopa 1 (Flying Koopa)
    paratroopa   BYTE "^K", 0        ; Wing + Koopa
    paraX        BYTE 35
    paraY        BYTE 10
    paraDir      BYTE 1              ; Horizontal direction
    paraYDir     BYTE 0              ; 0=up, 1=down (flying)
    paraAlive    BYTE 1
    paraTimer    BYTE 0
    paraMinY     BYTE 7              ; Upper bound
    paraMaxY     BYTE 14             ; Lower bound
    
    ; Paratroopa 2 (second flying enemy)
    para2X       BYTE 60
    para2Y       BYTE 12
    para2Dir     BYTE 0
    para2YDir    BYTE 1
    para2Alive   BYTE 1
    para2Timer   BYTE 0
    para2MinY    BYTE 9
    para2MaxY    BYTE 16

    ; Level 3 Ground (only small sections exist - mostly gaps!)
    hasGround    BYTE 0              ; Flag: 1=section has ground, 0=gap
    L3groundStart BYTE 0             ; Starting platform X
    L3groundEnd   BYTE 12            ; Ending platform X
    
    ; Level 3 Coins (placed on risky jumps)
    L3coin1X     BYTE 25
    L3coin1Y     BYTE 13
    L3coin1Active BYTE 1
    L3coin2X     BYTE 42
    L3coin2Y     BYTE 10
    L3coin2Active BYTE 1
    L3coin3X     BYTE 58
    L3coin3Y     BYTE 9
    L3coin3Active BYTE 1
    L3coin4X     BYTE 70
    L3coin4Y     BYTE 12
    L3coin4Active BYTE 1
    
    ; Level 3 Question Blocks
    L3qBlock1X   BYTE 28
    L3qBlock1Y   BYTE 9
    L3qBlock1Hit BYTE 0
    L3qBlock1Item BYTE 2             ; Mushroom
    
    L3qBlock2X   BYTE 52
    L3qBlock2Y   BYTE 8
    L3qBlock2Hit BYTE 0
    L3qBlock2Item BYTE 3             ; Star
    
    ; Star Invincibility (enhanced)
    starFlashTimer  BYTE 0           ; Flashing speed
    starFlashColor  BYTE 0           ; Current flash color (cycles 0-5)
    STAR_DURATION   EQU 600          ; ~10 seconds at 60fps
    
    ; Power-up collected flash effect
    powerUpFlash    BYTE 0           ; Frames of flash remaining
    powerUpType     BYTE 0           ; Which power-up was just collected
    
    ; Mario state constants for reference
    MARIO_SMALL     EQU 0
    MARIO_SUPER     EQU 1
    MARIO_FIRE      EQU 2

    ; World number for HUD
    worldNum12   BYTE "1-2", 0
    worldNum13   BYTE "1-3", 0
    worldNum14   BYTE "1-4", 0
    
    ; Level Transition Variables
    currentLevelNum  BYTE 1          ; Track which level we're on (1-4)
    levelCompleted   BYTE 0          ; Flag: 1 = level was completed successfully
    
    ; Fireball limit tracking
    fireballCount    BYTE 0          ; Current fireballs on screen (max 2)
    
    ; Star Power Variables
    marioInvincible   BYTE 0          ; 1 = invincible
    marioStarTimer    WORD 0          ; Duration remaining
   
    ; ============================================
    ; LEVEL 4 CASTLE DATA - WORLD 1-4
    ; ============================================
   
    ; Castle Visual Elements
    castleBrick  BYTE "[#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#][#]", 0
    castleFloor  BYTE "====================================================================================================", 0
    bridgeCollapsed BYTE 0           ; 1 = Bridge fell!
    lavaChar     BYTE "~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^", 0
    lavaAnim     BYTE 0              ; Animation frame
    firebarChar  BYTE "o-o-o-o", 0
    firebarAngle BYTE 0              ; Rotation angle (0-7)
    firebarTimer BYTE 0
    axeChar      BYTE "<AXE>", 0
    bridgeL4     BYTE "========", 0
    chainChar    BYTE "|||", 0
   
    ; Bowser Boss Data
    bowser1      BYTE " ,--. ", 0
    bowser2      BYTE "/    \", 0
    bowser3      BYTE "|O  O|", 0
    bowser4      BYTE " \__/ ", 0
    bowser5      BYTE "/WWWW\", 0
    bowserX      BYTE 70
    bowserY      BYTE 14
    bowserDir    BYTE 0              ; 0=left, 1=right
    bowserTimer  BYTE 0
    bowserFireTimer BYTE 0
    bowserAlive  BYTE 1
    bowserHealth BYTE 5              ; Hits to defeat (fireballs)
   
    ; Bowser Fire Breath
    bowserFireX  BYTE 0
    bowserFireY  BYTE 0
    bowserFireActive BYTE 0
    bowserFireChar BYTE ">>>", 0
   
    ; Castle Platforms
    castlePlat1X BYTE 20
    castlePlat1Y BYTE 12
    castlePlat2X BYTE 40
    castlePlat2Y BYTE 10
    castlePlat3X BYTE 55
    castlePlat3Y BYTE 14
   
    ; Lava Pit Positions
    lavaPit1Start BYTE 25
    lavaPit1End   BYTE 35
    lavaPit2Start BYTE 50
    lavaPit2End   BYTE 60
   
    ; ============================================
    ; FIRE FLOWER POWER-UP (Section 4)
    ; ============================================
    fireFlowerChar BYTE "*F*", 0
    fireFlower1X   BYTE 35
    fireFlower1Y   BYTE 10
    fireFlower1Active BYTE 0         ; 0=in block, 1=spawned, 2=collected
   
    ; Mario Fireballs (max 2 on screen)
    fireball1X       BYTE 0
    fireball1Y       BYTE 0
    fireball1Dir     BYTE 1            ; 1=right, 0=left
    fireball1Active  BYTE 0
    fireball1VelY    SBYTE 0
    fireball1Timer   BYTE 0
   
    fireball2X       BYTE 0
    fireball2Y       BYTE 0
    fireball2Dir     BYTE 1
    fireball2Active  BYTE 0
    fireball2VelY    SBYTE 0
    fireball2Timer   BYTE 0
   
    ; Fire Mario Sprites
    marioFire1     BYTE "@", 0       ; White head
    marioFire2     BYTE "F", 0       ; F for Fire Mario
   
    ; ============================================
    ; ENHANCED SCORING SYSTEM
    ; ============================================
    marioFlagBonus      DWORD 0           ; Bonus from flagpole position
    marioTimeBonus      DWORD 0           ; Time remaining * 50
    totalBonus     DWORD 0           ; Total level bonus
   
    ; Flagpole scoring zones
    FLAG_TOP_BONUS    DWORD 5000
    FLAG_MID_BONUS    DWORD 2000
    FLAG_BOT_BONUS    DWORD 100
    TIME_MULTIPLIER   DWORD 50
   
    ; Combo scoring for shell kills
    COMBO_1_SCORE     DWORD 100
    COMBO_2_SCORE     DWORD 200
    COMBO_3_SCORE     DWORD 400
    COMBO_4_SCORE     DWORD 800
   
    ; Item scores
    COIN_SCORE        DWORD 200
    MUSHROOM_SCORE    DWORD 1000
    FIREFLOWER_SCORE  DWORD 1000
    STAR_SCORE        DWORD 1000
    ENEMY_SCORE       DWORD 100
    FIREBALL_KILL     DWORD 200
   
    ; ============================================
    ; FILE HANDLING DATA (Section 9)
    ; ============================================
    playerFileName BYTE "player.dat", 0
    highScoreFile  BYTE "highscore.dat", 0
    progressFile   BYTE "progress.dat", 0
    
    fileHandle     DWORD ?
    bytesWritten   DWORD ?
    bytesRead      DWORD ?
    
    ; High score variables (Multi-rank)
    savedHighScore1 DWORD 0
    savedHighScore2 DWORD 0
    savedHighScore3 DWORD 0
    savedHSName1    BYTE 20 DUP(0)
    savedHSName2    BYTE 20 DUP(0)
    savedHSName3    BYTE 20 DUP(0)
    
    ; Temporary buffers for comparison
    tempName        BYTE 20 DUP(0)
    tempRoll        BYTE 15 DUP(0)
   
    ; Player data structure
    currentPlayerName BYTE 20 DUP(0)
    currentPlayerRoll BYTE 15 DUP(0)       ; Player roll number
    enterRollMsg      BYTE "ENTER YOUR ROLL NO: ", 0
    
    ; ============================================
    ; SOUND FILE PATHS
    ; ============================================
    sndJump         BYTE "smb_jump-small.wav", 0
    sndSuperJump    BYTE "smb_jump-super.wav", 0
    sndCoin         BYTE "smb_powerup.wav", 0
    sndPowerup      BYTE "smb_powerup.wav", 0
    snd1Up          BYTE "smb_1-up.wav", 0
    sndStomp        BYTE "smb_kick.wav", 0
    sndFireball     BYTE "smb_fireball.wav", 0
    sndBreakBlock   BYTE "smb_breakblock.wav", 0
    sndKick         BYTE "smb_kick.wav", 0
    sndBump         BYTE "smb_bump.wav", 0
    sndDeath        BYTE "smb_mariodie.wav", 0
    sndPause        BYTE "smb_pause.wav", 0
    sndStageClear   BYTE "smb_stage_clear.wav", 0
    sndGameOver     BYTE "smb_gameover.wav", 0
    sndWorldClear   BYTE "smb_world_clear.wav", 0
    sndGroundTheme  BYTE "01. Ground Theme.wav", 0
    sndCastleTheme  BYTE "04. Castle Theme.wav", 0
    sndWarning      BYTE "smb_warning.wav", 0
    savedHighScore    DWORD 0
    savedLevel        BYTE 1
   
    ; High score entries (top 5)
    hs1Name        BYTE "AAA", 0
    hs1Score       DWORD 10000
    hs2Name        BYTE "BBB", 0
    hs2Score       DWORD 5000
    hs3Name        BYTE "CCC", 0
    hs3Score       DWORD 2500
    hs4Name        BYTE "DDD", 0
    hs4Score       DWORD 1000
    hs5Name        BYTE "EEE", 0
    hs5Score       DWORD 500
   
    ; Messages for Level 4
    castleMsg      BYTE "WELCOME TO BOWSER'S CASTLE!", 0
    bowserMsg      BYTE "BOWSER APPEARS!", 0
    victoryMsg     BYTE "CONGRATULATIONS! PRINCESS SAVED!", 0
    tryAgainMsg    BYTE "TRY AGAIN... PRESS ANY KEY", 0
    enterNameMsg   BYTE "ENTER YOUR NAME: ", 0
    savedMsg       BYTE "PROGRESS SAVED!", 0
    
    ; Continue/New Game Menu
    continueMsg      BYTE "SAVED PROGRESS FOUND!", 0
    continueOpt1     BYTE "[C] CONTINUE GAME", 0
    continueOpt2     BYTE "[N] NEW GAME", 0
    continuePrompt   BYTE "Press C or N: ", 0
    noSaveMsg        BYTE "NO SAVED PROGRESS", 0
    savedLevelMsg    BYTE "Level: ", 0
    savedScoreMsg    BYTE "Score: ", 0
    savedLivesMsg    BYTE "Lives: ", 0
    
    ; Creative Feature: Bullet Time (Slow Motion)
    slowMotionActive BYTE 0
    slowMotionMeter  BYTE 100    ; Power meter (0-100)
    bulletTimeLabel  BYTE "POWER: ", 0
    
    ; Character for power bar
    powerBarFull     BYTE "||||||||||", 0
    powerBarEmpty    BYTE "..........", 0
   
    ; Princess rescued screen
    princess1      BYTE "   ,--.", 0
    princess2      BYTE "  /    \\", 0
    princess3      BYTE " | ^  ^ |", 0
    princess4      BYTE "  \\____/", 0
    princess5      BYTE "   |  |", 0
    princessMsg    BYTE "THANK YOU MARIO!", 0
    endingMsg1     BYTE "YOUR QUEST IS COMPLETE!", 0
    endingMsg2     BYTE "FINAL SCORE: ", 0
    victoryHeader  BYTE "!!! CONGRATULATIONS !!!", 0
    winMsg         BYTE "YOU HAVE COMPLETED THE SKY HIGH ADVENTURE!", 0
    thanksMsg      BYTE "THANKS FOR PLAYING!", 0
    
    ; Victory Credits
    victMsg1 BYTE "THANK YOU MARIO!", 0
    victMsg2 BYTE "BUT OUR PRINCESS IS IN ANOTHER CASTLE!", 0
    victMsg3 BYTE "JUST KIDDING! YOU SAVED THE MUSHROOM KINGDOM!", 0

.code
main PROC
    ; Set up the console window size first
    call SetupWindow

    ; Load high scores from file
    call LoadHighScore

    ; Show intro/title screen first
    call IntroScreen
   
    ; Wait for user to press any key
    call WaitForKey
   
    ; Show main menu screen
    call MainMenuScreen
   
    exit
main ENDP

;-----------------------------------------------------------
; SetupWindow: Sets the console window and buffer size
;-----------------------------------------------------------
SetupWindow PROC
    ; Get the console output handle
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outHandle, eax
   
    ; Set the buffer size first (must be >= window size)
    INVOKE SetConsoleScreenBufferSize, outHandle, bufferSize
   
    ; Set the window size
    INVOKE SetConsoleWindowInfo, outHandle, TRUE, ADDR windowRect
   
    ret
SetupWindow ENDP

;-----------------------------------------------------------
; IntroScreen: Displays the Super Mario Bros title screen
; with developer information and "Press Any Key" message
;-----------------------------------------------------------
IntroScreen PROC
    ; Clear screen completely
    call Clrscr
   
    ; Reset cursor to top left
    mov dh, 0
    mov dl, 0
    call Gotoxy
   
    ; Add empty lines for clean spacing
    call Crlf
    call Crlf
   
    ; Display clouds (light cyan)
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET cloud1
    call WriteString
    call Crlf
    mov edx, OFFSET cloud2
    call WriteString
    call Crlf
    mov edx, OFFSET cloud3
    call WriteString
    call Crlf
    call Crlf
   
    ; Display "SUPER" in RED
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET title1
    call WriteString
    call Crlf
    mov edx, OFFSET title2
    call WriteString
    call Crlf
    mov edx, OFFSET title3
    call WriteString
    call Crlf
    mov edx, OFFSET title4
    call WriteString
    call Crlf
    mov edx, OFFSET title5
    call WriteString
    call Crlf
    mov edx, OFFSET title6
    call WriteString
    call Crlf
    call Crlf
   
    ; Display "MARIO BROS." in YELLOW
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET title7
    call WriteString
    call Crlf
    mov edx, OFFSET title8
    call WriteString
    call Crlf
    mov edx, OFFSET title9
    call WriteString
    call Crlf
    mov edx, OFFSET title10
    call WriteString
    call Crlf
    mov edx, OFFSET title11
    call WriteString
    call Crlf
    mov edx, OFFSET title12
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Developer Name in WHITE
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET madeByMsg
    call WriteString
    call Crlf
   
    ; Display Roll Number in CYAN
    mov eax, CYAN
    call SetTextColor
    mov edx, OFFSET rollNumMsg
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Question Blocks (YELLOW)
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET brick1
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Mario Character
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET mario1
    call WriteString
    call Crlf
    mov edx, OFFSET mario2
    call WriteString
    call Crlf
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET mario3
    call WriteString
    call Crlf
    mov eax, LIGHTBLUE
    call SetTextColor
    mov edx, OFFSET mario4
    call WriteString
    call Crlf
    mov edx, OFFSET mario5
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Ground (BROWN)
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET ground1
    call WriteString
    call Crlf
    mov edx, OFFSET ground2
    call WriteString
    call Crlf
    mov edx, OFFSET ground3
    call WriteString
    call Crlf
    call Crlf
   
    ; Display "PRESS ANY KEY TO CONTINUE..."
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET pressMsg
    call WriteString
    call Crlf
   
    ; Display Copyright (CYAN)
    mov eax, CYAN
    call SetTextColor
    mov edx, OFFSET copyrightMsg
    call WriteString
    call Crlf
   
    ; Reset color
    mov eax, WHITE
    call SetTextColor
   
    ret
IntroScreen ENDP

;-----------------------------------------------------------
; WaitForKey: Waits for user to press any key
;-----------------------------------------------------------
WaitForKey PROC
    call ReadChar  ; Wait for any key press (doesn't echo)
    ret
WaitForKey ENDP

;-----------------------------------------------------------
; MainMenuScreen: Displays the main menu with options
;-----------------------------------------------------------
MainMenuScreen PROC
    ; Clear screen completely
    call Clrscr
   
    ; Reset cursor to top left and add spacing
    mov dh, 0
    mov dl, 0
    call Gotoxy
   
    ; Add empty lines for clean spacing
    call Crlf
    call Crlf
    call Crlf
   
    ; Display stars decoration
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET stars1
    call WriteString
    call Crlf
    mov edx, OFFSET stars2
    call WriteString
    call Crlf
    call Crlf
   
    ; Display "SUPER" in RED
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET title1
    call WriteString
    call Crlf
    mov edx, OFFSET title2
    call WriteString
    call Crlf
    mov edx, OFFSET title3
    call WriteString
    call Crlf
    mov edx, OFFSET title4
    call WriteString
    call Crlf
    mov edx, OFFSET title5
    call WriteString
    call Crlf
    mov edx, OFFSET title6
    call WriteString
    call Crlf
    call Crlf
   
    ; Display "MARIO BROS." in YELLOW
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET title7
    call WriteString
    call Crlf
    mov edx, OFFSET title8
    call WriteString
    call Crlf
    mov edx, OFFSET title9
    call WriteString
    call Crlf
    mov edx, OFFSET title10
    call WriteString
    call Crlf
    mov edx, OFFSET title11
    call WriteString
    call Crlf
    mov edx, OFFSET title12
    call WriteString
    call Crlf
    call Crlf
    call Crlf
   
    ; Display "1 PLAYER GAME" option
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET onePlayerMsg
    call WriteString
    call Crlf
    call Crlf
    call Crlf
   
    ; Display Pipes (GREEN)
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET pipe1
    call WriteString
    call Crlf
    mov edx, OFFSET pipe2
    call WriteString
    call Crlf
    mov edx, OFFSET pipe3
    call WriteString
    call Crlf
    mov edx, OFFSET pipe4
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Menu Options (WHITE with better formatting)
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET menu1
    call WriteString
    call Crlf
   
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET menu2
    call WriteString
    call Crlf
   
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET menu3
    call WriteString
    call Crlf
   
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET menu4
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Ground (BROWN)
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET ground1
    call WriteString
    call Crlf
    mov edx, OFFSET ground2
    call WriteString
    call Crlf
    mov edx, OFFSET ground3
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Menu Prompt (YELLOW)
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET menuPrompt
    call WriteString
   
    ; Get user input
    call ReadInt
   
    ; Handle menu selection
    cmp eax, 1
    je StartGame
    cmp eax, 2
    je ShowHighScores
    cmp eax, 3
    je ShowInstructions
    cmp eax, 4
    je ExitProgram
    ; Invalid option - return to menu
    call MainMenuScreen
    ret
   
StartGame:
    ; 1. Always prompt for player info first per USER requirement
    call PromptPlayerInfo   ; Get player name and roll number in currentPlayerName/Roll
    
    ; 2. Check if entered credentials match saved progress
    call CheckSavedCredentials
    cmp eax, 1               ; 1 = Credentials match saved progress
    jne NewGameFlow
    
    ; 3. If match, ask to Continue or New Game
    call ShowContinueMenu
    cmp al, 1               ; 1 = Continue saved game
    je ContinueSavedGame
    
NewGameFlow:
    ; New game or credentials didn't match/user chose new
    call DifficultyScreen   ; Show difficulty selection
    call LevelSelectScreen  ; Show level selection
    jmp StartSelectedLevel
    
ContinueSavedGame:
    ; Progress already loaded by CheckSavedCredentials
    ; savedLevel is picked up
    mov al, savedLevel
    mov selectedLevel, al
    call DifficultyScreen   ; Still let them pick difficulty
    
StartSelectedLevel:
    
    ; Start the appropriate level based on selection
    cmp selectedLevel, 1
    je LaunchLevel1
    cmp selectedLevel, 2
    je LaunchLevel2
    cmp selectedLevel, 3
    je LaunchLevel3
    cmp selectedLevel, 4
    je LaunchLevel4
    ; Default to level 1
    jmp LaunchLevel1
    
LaunchLevel1:
    mov currentLevelNum, 1
    mov levelCompleted, 0
    call StartLevel1
    cmp levelCompleted, 1
    jne GameFinished
    
    ; Transition to Level 2
    mov currentLevelNum, 2
    mov levelCompleted, 0
    call SavePlayerProgress
    call StartLevel2
    cmp levelCompleted, 1
    jne GameFinished
    
    ; Transition to Level 3
    mov currentLevelNum, 3
    mov levelCompleted, 0
    call SavePlayerProgress
    call StartLevel3
    cmp levelCompleted, 1
    jne GameFinished
    
    ; Transition to Level 4
    mov currentLevelNum, 4
    mov levelCompleted, 0
    call SavePlayerProgress
    call StartLevel4
    jmp GameFinished
    
LaunchLevel2:
    mov currentLevelNum, 2
    mov levelCompleted, 0
    call StartLevel2
    cmp levelCompleted, 1
    jne GameFinished
    
    ; Transition to Level 3
    mov currentLevelNum, 3
    mov levelCompleted, 0
    call SavePlayerProgress
    call StartLevel3
    cmp levelCompleted, 1
    jne GameFinished
    
    ; Transition to Level 4
    mov currentLevelNum, 4
    mov levelCompleted, 0
    call SavePlayerProgress
    call StartLevel4
    jmp GameFinished
    
LaunchLevel3:
    mov currentLevelNum, 3
    mov levelCompleted, 0
    call StartLevel3
    cmp levelCompleted, 1
    jne GameFinished
    
    ; Transition to Level 4
    mov currentLevelNum, 4
    mov levelCompleted, 0
    call SavePlayerProgress
    call StartLevel4
    jmp GameFinished
    
LaunchLevel4:
    mov currentLevelNum, 4
    mov levelCompleted, 0
    call StartLevel4
    jmp GameFinished

GameFinished:
    ; Check for overall game victory (Level 3 complete)
    cmp levelCompleted, 1
    jne ReturnToMenu
    cmp currentLevelNum, 3
    jne ReturnToMenu
    call ShowVictoryCredits

ReturnToMenu:
    call MainMenuScreen     ; Return to menu after game
    ret
   
ShowHighScores:
    call HighScoresScreen
    call WaitForKey
    call MainMenuScreen  ; Return to main menu after viewing high scores
    ret
   
ShowInstructions:
    call InstructionsScreen
    call WaitForKey
    call MainMenuScreen  ; Return to main menu after viewing instructions
    ret
   
ExitProgram:
    ; Clear screen and exit
    call Clrscr
    mov eax, WHITE
    call SetTextColor
    ret
   
EndMenu:
    ; Display Copyright (CYAN)
    call Crlf
    mov eax, CYAN
    call SetTextColor
    mov edx, OFFSET copyrightMsg
    call WriteString
    call Crlf
   
    ; Reset color
    mov eax, WHITE
    call SetTextColor
   
    ret
MainMenuScreen ENDP

;-----------------------------------------------------------
; HighScoresScreen: Displays the high scores with trophy
;-----------------------------------------------------------
HighScoresScreen PROC
    ; Clear screen completely first
    call Clrscr
   
    ; Reset cursor to top left and add spacing
    mov dh, 0
    mov dl, 0
    call Gotoxy
   
    ; Add empty lines for clean spacing
    call Crlf
    call Crlf
   
    ; Display stars decoration at top
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET stars1
    call WriteString
    call Crlf
    mov edx, OFFSET stars2
    call WriteString
    call Crlf
    call Crlf
    call Crlf
   
    ; Display "HIGH SCORES" title with box
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET hsTitle1
    call WriteString
    call Crlf
    mov eax, WHITE + (LIGHTCYAN * 16)
    call SetTextColor
    mov edx, OFFSET hsTitle2
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET hsTitle3
    call WriteString
    call Crlf
    call Crlf
    call Crlf
   
    ; Display Trophy (YELLOW/GOLD)
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET trophy1
    call WriteString
    call Crlf
    mov edx, OFFSET trophy2
    call WriteString
    call Crlf
    mov edx, OFFSET trophy3
    call WriteString
    call Crlf
    mov edx, OFFSET trophy4
    call WriteString
    call Crlf
    mov edx, OFFSET trophy5
    call WriteString
    call Crlf
    mov edx, OFFSET trophy6
    call WriteString
    call Crlf
    mov edx, OFFSET trophy7
    call WriteString
    call Crlf
    mov edx, OFFSET trophy8
    call WriteString
    call Crlf
    mov edx, OFFSET trophy9
    call WriteString
    call Crlf
    mov edx, OFFSET trophy10
    call WriteString
    call Crlf
    call Crlf
    call Crlf
   
    ; Display decorative line
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET hsDecor1
    call WriteString
    call Crlf
    mov edx, OFFSET hsDecor2
    call WriteString
    call Crlf
    call Crlf
   
    ; Display 1st Place (GOLD)
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET hsRank1
    call WriteString
    
    mov edx, OFFSET savedHSName1
    call WriteString
    mov al, ' '
    call WriteChar
    
    mov eax, savedHighScore1
    call WriteDec
    call Crlf
    call Crlf
   
    ; Display 2nd Place (SILVER)
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET hsRank2
    call WriteString
    
    mov edx, OFFSET savedHSName2
    call WriteString
    mov al, ' '
    call WriteChar
    
    mov eax, savedHighScore2
    call WriteDec
    call Crlf
    call Crlf
   
    ; Display 3rd Place (BRONZE)
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET hsRank3
    call WriteString
    
    mov edx, OFFSET savedHSName3
    call WriteString
    mov al, ' '
    call WriteChar
    
    mov eax, savedHighScore3
    call WriteDec
    call Crlf
    call Crlf
   
    ; Display decorative line
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET hsDecor2
    call WriteString
    call Crlf
    mov edx, OFFSET hsDecor1
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Ground (BROWN)
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET ground1
    call WriteString
    call Crlf
    mov edx, OFFSET ground2
    call WriteString
    call Crlf
    call Crlf
   
    ; Display back message (CYAN)
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET backMsg
    call WriteString
    call Crlf
   
    ; Display Copyright (CYAN)
    mov eax, CYAN
    call SetTextColor
    mov edx, OFFSET copyrightMsg
    call WriteString
    call Crlf
   
    ; Reset color
    mov eax, WHITE
    call SetTextColor
   
    ret
HighScoresScreen ENDP

;-----------------------------------------------------------
; DifficultyScreen: Displays difficulty selection screen
; with Speed Racer Mario theme (Roll No ending in 2)
;-----------------------------------------------------------
DifficultyScreen PROC
    ; Clear screen completely
    call Clrscr
   
    ; Reset cursor to top left
    mov dh, 0
    mov dl, 0
    call Gotoxy
   
    ; Add spacing
    call Crlf
   
    ; Display stars decoration at top
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET stars1
    call WriteString
    call Crlf
    mov edx, OFFSET stars2
    call WriteString
    call Crlf
    call Crlf
   
    ; Display "Difficulty" title in CYAN
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET diffTitle1
    call WriteString
    call Crlf
    mov edx, OFFSET diffTitle2
    call WriteString
    call Crlf
    mov edx, OFFSET diffTitle3
    call WriteString
    call Crlf
    mov edx, OFFSET diffTitle4
    call WriteString
    call Crlf
    mov edx, OFFSET diffTitle5
    call WriteString
    call Crlf
    mov edx, OFFSET diffTitle6
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Speed Racer Mario Info Box (LIGHTBLUE - special theme)
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET speedInfo1
    call WriteString
    call Crlf
    mov eax, WHITE + (LIGHTCYAN * 16)
    call SetTextColor
    mov edx, OFFSET speedInfo2
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET speedInfo3
    call WriteString
    call Crlf
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET speedInfo4
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET speedInfo5
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET speedInfo6
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET speedInfo7
    call WriteString
    call Crlf
    call Crlf
   
    ; Display EASY option (GREEN)
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET easyBox1
    call WriteString
    call Crlf
    mov eax, WHITE + (LIGHTGREEN * 16)
    call SetTextColor
    mov edx, OFFSET easyBox2
    call WriteString
    call Crlf
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET easyBox3
    call WriteString
    call Crlf
    mov edx, OFFSET easyBox4
    call WriteString
    call Crlf
    mov edx, OFFSET easyBox5
    call WriteString
    call Crlf
    mov edx, OFFSET easyBox6
    call WriteString
    call Crlf
    call Crlf
   
    ; Display MEDIUM option (YELLOW)
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET mediumBox1
    call WriteString
    call Crlf
    mov eax, BLACK + (YELLOW * 16)
    call SetTextColor
    mov edx, OFFSET mediumBox2
    call WriteString
    call Crlf
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET mediumBox3
    call WriteString
    call Crlf
    mov edx, OFFSET mediumBox4
    call WriteString
    call Crlf
    mov edx, OFFSET mediumBox5
    call WriteString
    call Crlf
    mov edx, OFFSET mediumBox6
    call WriteString
    call Crlf
    call Crlf
   
    ; Display HARD option (RED)
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET hardBox1
    call WriteString
    call Crlf
    mov eax, WHITE + (LIGHTRED * 16)
    call SetTextColor
    mov edx, OFFSET hardBox2
    call WriteString
    call Crlf
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET hardBox3
    call WriteString
    call Crlf
    mov edx, OFFSET hardBox4
    call WriteString
    call Crlf
    mov edx, OFFSET hardBox5
    call WriteString
    call Crlf
    mov edx, OFFSET hardBox6
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Ground (BROWN)
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET ground1
    call WriteString
    call Crlf
    mov edx, OFFSET ground2
    call WriteString
    call Crlf
    call Crlf
   
    ; Display prompt (YELLOW)
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET diffPrompt
    call WriteString
   
    ; Get user input
    call ReadInt
   
    ; Store the selected difficulty
    mov selectedDifficulty, al
   
    ; Set lives and enemy speed based on difficulty
    cmp al, 1
    je SetEasyLives
    cmp al, 2
    je SetMediumLives
    cmp al, 3
    je SetHardLives
    ; Default to medium if invalid
    mov playerLives, 3
    mov goombaSpeed, 1
    mov koopaSpeed, 1
    jmp DiffDone
   
SetEasyLives:
    mov playerLives, 5
    mov goombaSpeed, 1      ; Slower enemies
    mov koopaSpeed, 1
    jmp DiffDone
   
SetMediumLives:
    mov playerLives, 3
    mov goombaSpeed, 2      ; Normal speed
    mov koopaSpeed, 2
    jmp DiffDone
   
SetHardLives:
    mov playerLives, 1
    mov goombaSpeed, 3      ; Faster enemies!
    mov koopaSpeed, 3
   
DiffDone:
    ; Reset color
    mov eax, WHITE
    call SetTextColor
   
    ret
DifficultyScreen ENDP

;-----------------------------------------------------------
; LevelSelectScreen: Displays level/world selection screen
;-----------------------------------------------------------
LevelSelectScreen PROC
    ; Clear screen completely
    call Clrscr
   
    ; Reset cursor to top left
    mov dh, 0
    mov dl, 0
    call Gotoxy
   
    ; Add spacing
    call Crlf
   
    ; Display stars decoration at top
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET stars1
    call WriteString
    call Crlf
    mov edx, OFFSET stars2
    call WriteString
    call Crlf
    call Crlf
   
    ; Display "Level Select" title in YELLOW
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET lvlTitle1
    call WriteString
    call Crlf
    mov edx, OFFSET lvlTitle2
    call WriteString
    call Crlf
    mov edx, OFFSET lvlTitle3
    call WriteString
    call Crlf
    mov edx, OFFSET lvlTitle4
    call WriteString
    call Crlf
    mov edx, OFFSET lvlTitle5
    call WriteString
    call Crlf
    call Crlf
   
    ; Display header
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET lvlHeader
    call WriteString
    call Crlf
    call Crlf
   
    ; Display World 1-1 (GREEN - Grassland)
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET world1Box1
    call WriteString
    call Crlf
    mov eax, WHITE + (LIGHTGREEN * 16)
    call SetTextColor
    mov edx, OFFSET world1Box2
    call WriteString
    call Crlf
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET world1Box3
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET world1Box4
    call WriteString
    call Crlf
    mov edx, OFFSET world1Box5
    call WriteString
    call Crlf
    mov edx, OFFSET world1Box6
    call WriteString
    call Crlf
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET world1Box7
    call WriteString
    call Crlf
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET world1Box8
    call WriteString
    call Crlf
    mov edx, OFFSET world1Box9
    call WriteString
    call Crlf
    call Crlf
   
    ; Display World 1-2 (BROWN - Underground)
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET world2Box1
    call WriteString
    call Crlf
    mov eax, WHITE + (BROWN * 16)
    call SetTextColor
    mov edx, OFFSET world2Box2
    call WriteString
    call Crlf
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET world2Box3
    call WriteString
    call Crlf
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET world2Box4
    call WriteString
    call Crlf
    mov edx, OFFSET world2Box5
    call WriteString
    call Crlf
    mov edx, OFFSET world2Box6
    call WriteString
    call Crlf
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET world2Box7
    call WriteString
    call Crlf
    mov edx, OFFSET world2Box8
    call WriteString
    call Crlf
    call Crlf
   
    ; Display World 1-3 (CYAN - Sky)
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET world3Box1
    call WriteString
    call Crlf
    mov eax, WHITE + (LIGHTCYAN * 16)
    call SetTextColor
    mov edx, OFFSET world3Box2
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET world3Box3
    call WriteString
    call Crlf
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET world3Box4
    call WriteString
    call Crlf
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET world3Box5
    call WriteString
    call Crlf
    mov edx, OFFSET world3Box6
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET world3Box7
    call WriteString
    call Crlf
    mov edx, OFFSET world3Box8
    call WriteString
    call Crlf
    call Crlf
   
    ; Display World 1-4 (RED - Castle)
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET world4Box1
    call WriteString
    call Crlf
    mov eax, WHITE + (LIGHTRED * 16)
    call SetTextColor
    mov edx, OFFSET world4Box2
    call WriteString
    call Crlf
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET world4Box3
    call WriteString
    call Crlf
    mov eax, DARKGRAY
    call SetTextColor
    mov edx, OFFSET world4Box4
    call WriteString
    call Crlf
    mov edx, OFFSET world4Box5
    call WriteString
    call Crlf
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET world4Box6
    call WriteString
    call Crlf
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET world4Box7
    call WriteString
    call Crlf
    mov edx, OFFSET world4Box8
    call WriteString
    call Crlf
    call Crlf
   
    ; Display prompt (YELLOW)
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET lvlPrompt
    call WriteString
   
    ; Get user input
    call ReadInt
   
    ; Store the selected level
    mov selectedLevel, al
   
    ; Show loading screen
    call Clrscr
   
    ; Position for loading message
    mov dh, 12
    mov dl, 0
    call Gotoxy
   
    ; Display loading message
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET loadingMsg
    call WriteString
   
    ; Display level number
    movzx eax, selectedLevel
    call WriteDec
    mov edx, OFFSET loadingDots
    call WriteString
    call Crlf
    call Crlf
   
    ; Display "GET READY!"
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET getReadyMsg
    call WriteString
    call Crlf
   
    ; Wait a moment
    mov eax, 1500
    call Delay
   
    ; Reset color
    mov eax, WHITE
    call SetTextColor
   
    ret
LevelSelectScreen ENDP

;-----------------------------------------------------------
; InstructionsScreen: Displays game instructions
;-----------------------------------------------------------
InstructionsScreen PROC
    ; Clear screen completely
    call Clrscr
   
    ; Reset cursor
    mov dh, 0
    mov dl, 0
    call Gotoxy
   
    ; Display title
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET instTitle1
    call WriteString
    call Crlf
    mov edx, OFFSET instTitle2
    call WriteString
    call Crlf
    mov edx, OFFSET instTitle3
    call WriteString
    call Crlf
    mov edx, OFFSET instTitle4
    call WriteString
    call Crlf
    mov edx, OFFSET instTitle5
    call WriteString
    call Crlf
    mov edx, OFFSET instTitle6
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Controls Section (CYAN)
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET ctrlHeader
    call WriteString
    call Crlf
    mov edx, OFFSET ctrlLine1
    call WriteString
    call Crlf
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET ctrlLine2
    call WriteString
    call Crlf
    mov edx, OFFSET ctrlLine3
    call WriteString
    call Crlf
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET ctrlLine4
    call WriteString
    call Crlf
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET ctrlLine5
    call WriteString
    call Crlf
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET ctrlLine6
    call WriteString
    call Crlf
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET ctrlLine7
    call WriteString
    call Crlf
    mov edx, OFFSET ctrlLine8
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET ctrlEnd
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Power-ups Section (GREEN)
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET pwrHeader
    call WriteString
    call Crlf
    mov edx, OFFSET pwrLine1
    call WriteString
    call Crlf
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET pwrLine2
    call WriteString
    call Crlf
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET pwrLine3
    call WriteString
    call Crlf
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET pwrLine4
    call WriteString
    call Crlf
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET pwrLine5
    call WriteString
    call Crlf
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET pwrLine6
    call WriteString
    call Crlf
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET pwrEnd
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Enemies Section (RED)
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET enemyHeader
    call WriteString
    call Crlf
    mov edx, OFFSET enemyLine1
    call WriteString
    call Crlf
    mov eax, BROWN
    call SetTextColor
    mov edx, OFFSET enemyLine2
    call WriteString
    call Crlf
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET enemyLine3
    call WriteString
    call Crlf
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET enemyLine4
    call WriteString
    call Crlf
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET enemyLine5
    call WriteString
    call Crlf
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET enemyEnd
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Scoring Section (YELLOW)
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET scoreHeader
    call WriteString
    call Crlf
    mov edx, OFFSET scoreLine1
    call WriteString
    call Crlf
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET scoreLine2
    call WriteString
    call Crlf
    mov edx, OFFSET scoreLine3
    call WriteString
    call Crlf
    mov edx, OFFSET scoreLine4
    call WriteString
    call Crlf
    mov edx, OFFSET scoreLine5
    call WriteString
    call Crlf
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET scoreLine6
    call WriteString
    call Crlf
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET scoreEnd
    call WriteString
    call Crlf
    call Crlf
   
    ; Display Speed Racer Section (CYAN - Special)
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET speedHeader
    call WriteString
    call Crlf
    mov edx, OFFSET speedLine1
    call WriteString
    call Crlf
    mov eax, WHITE + (LIGHTCYAN * 16)
    call SetTextColor
    mov edx, OFFSET speedLine2
    call WriteString
    call Crlf
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET speedLine3
    call WriteString
    call Crlf
    mov edx, OFFSET speedLine4
    call WriteString
    call Crlf
    mov edx, OFFSET speedLine5
    call WriteString
    call Crlf
    mov edx, OFFSET speedEnd
    call WriteString
    call Crlf
    call Crlf
   
    ; Display back message
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET instBackMsg
    call WriteString
    call Crlf
   
    ; Reset color
    mov eax, WHITE
    call SetTextColor
   
    ret
InstructionsScreen ENDP
; FILE HANDLING PROCEDURES
;-----------------------------------------------------------

;-----------------------------------------------------------
; SavePlayerName: Saves current player name to file
;-----------------------------------------------------------
SavePlayerName PROC
    ; Create/open file for writing
    INVOKE CreateFile,
        ADDR playerFileName,
        GENERIC_WRITE,
        0,
        NULL,
        CREATE_ALWAYS,
        FILE_ATTRIBUTE_NORMAL,
        NULL
   
    cmp eax, INVALID_HANDLE_VALUE
    je SaveNameDone
    mov fileHandle, eax
   
    ; Write player name
    INVOKE WriteFile,
        fileHandle,
        ADDR currentPlayerName,
        20,
        ADDR bytesWritten,
        NULL
   
    ; Close file
    INVOKE CloseHandle, fileHandle
   
SaveNameDone:
    ret
SavePlayerName ENDP

;-----------------------------------------------------------
; LoadPlayerName: Loads player name from file
;-----------------------------------------------------------
LoadPlayerName PROC
    ; Open file for reading
    INVOKE CreateFile,
        ADDR playerFileName,
        GENERIC_READ,
        0,
        NULL,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL,
        NULL
   
    cmp eax, INVALID_HANDLE_VALUE
    je LoadNameDone
    mov fileHandle, eax
   
    ; Read player name
    INVOKE ReadFile,
        fileHandle,
        ADDR currentPlayerName,
        20,
        ADDR bytesRead,
        NULL
   
    ; Close file
    INVOKE CloseHandle, fileHandle
   
LoadNameDone:
    ret
LoadPlayerName ENDP

;-----------------------------------------------------------
; ShowContinueMenu: Check for saved progress and offer options
; Returns: AL=1 if continue, AL=0 if new game
;-----------------------------------------------------------
;-----------------------------------------------------------
; CheckSavedCredentials: Check if current name/roll match progress.dat
; Returns: EAX=1 if match, EAX=0 otherwise
;-----------------------------------------------------------
CheckSavedCredentials PROC
    push ebx
    push ecx
    push edx
    
    ; Try to open progress file
    mov edx, OFFSET progressFile
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je NoCredMatch
    mov fileHandle, eax
    
    ; Read saved name into tempName
    mov eax, fileHandle
    mov edx, OFFSET tempName
    mov ecx, 20
    call ReadFromFile
    
    ; Read saved roll into tempRoll
    mov eax, fileHandle
    mov edx, OFFSET tempRoll
    mov ecx, 15
    call ReadFromFile
    
    ; Compare Name
    push esi
    push edi
    mov esi, OFFSET currentPlayerName
    mov edi, OFFSET tempName
    mov ecx, 20
    repe cmpsb
    jne PopAndFail
    
    ; Compare Roll
    mov esi, OFFSET currentPlayerRoll
    mov edi, OFFSET tempRoll
    mov ecx, 15
    repe cmpsb
    jne PopAndFail
    
    ; MATCH FOUND! Read the rest of the progress data
    mov eax, fileHandle
    mov edx, OFFSET savedLevel
    mov ecx, 1
    call ReadFromFile
    
    mov eax, fileHandle
    mov edx, OFFSET savedHighScore  ; This is the saved session score
    mov ecx, 4
    call ReadFromFile
    
    mov eax, fileHandle
    mov edx, OFFSET playerLives
    mov ecx, 4
    call ReadFromFile
    
    mov eax, fileHandle
    call CloseFile
    
    pop edi
    pop esi
    mov eax, 1
    jmp CredDone
    
PopAndFail:
    pop edi
    pop esi
    mov eax, fileHandle
    call CloseFile
NoCredMatch:
    mov eax, 0
    
CredDone:
    pop edx
    pop ecx
    pop ebx
    ret
CheckSavedCredentials ENDP

;-----------------------------------------------------------
; ShowContinueMenu: Offer options after credentials match
; Returns: AL=1 if continue, AL=0 if new game
;-----------------------------------------------------------
ShowContinueMenu PROC
    push ebx
    push ecx
    push edx
    
    call Clrscr
    
    ; Title
    mov dh, 6
    mov dl, 30
    call Gotoxy
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET continueMsg
    call WriteString
    
    ; Show saved player info
    mov dh, 9
    mov dl, 30
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET currentPlayerName
    call WriteString
    
    mov dh, 11
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET savedLevelMsg
    call WriteString
    movzx eax, savedLevel
    call WriteDec
    
    mov dh, 12
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET savedScoreMsg
    call WriteString
    mov eax, savedHighScore     ; Session score
    call WriteDec
    
    mov dh, 13
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET savedLivesMsg
    call WriteString
    movzx eax, playerLives
    call WriteDec
    
    ; Options
    mov dh, 16
    mov dl, 30
    call Gotoxy
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET continueOpt1
    call WriteString
    
    mov dh, 17
    mov dl, 30
    call Gotoxy
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET continueOpt2
    call WriteString
    
    mov dh, 20
    mov dl, 30
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET continuePrompt
    call WriteString
    
GetInput:
    call ReadChar
    cmp al, 'c'
    je SelectContinue
    cmp al, 'C'
    je SelectContinue
    cmp al, 'n'
    je SelectNew
    cmp al, 'N'
    je SelectNew
    jmp GetInput
    
SelectContinue:
    mov al, 1
    jmp MenuDone
    
SelectNew:
    ; Reset progress variables for a new game
    mov savedLevel, 1
    mov playerScore, 0
    mov playerLives, 3
    mov al, 0
    
MenuDone:
    pop edx
    pop ecx
    pop ebx
    ret
ShowContinueMenu ENDP

;-----------------------------------------------------------
; SaveHighScore: Saves high score to file
;-----------------------------------------------------------
SaveHighScore PROC
    pushad
    
    ; Check 1st place
    mov eax, playerScore
    cmp eax, savedHighScore1
    jle Check2nd
    
    ; Move 2nd to 3rd
    mov ebx, savedHighScore2
    mov savedHighScore3, ebx
    push esi
    push edi
    mov esi, OFFSET savedHSName2
    mov edi, OFFSET savedHSName3
    mov ecx, 20
    rep movsb
    pop edi
    pop esi
    
    ; Move 1st to 2nd
    mov ebx, savedHighScore1
    mov savedHighScore2, ebx
    push esi
    push edi
    mov esi, OFFSET savedHSName1
    mov edi, OFFSET savedHSName2
    mov ecx, 20
    rep movsb
    pop edi
    pop esi
    
    ; Set 1st
    mov savedHighScore1, eax
    push esi
    push edi
    mov esi, OFFSET currentPlayerName
    mov edi, OFFSET savedHSName1
    mov ecx, 20
    rep movsb
    pop edi
    pop esi
    jmp SaveToFile
    
Check2nd:
    cmp eax, savedHighScore2
    jle Check3rd
    
    ; Move 2nd to 3rd
    mov ebx, savedHighScore2
    mov savedHighScore3, ebx
    push esi
    push edi
    mov esi, OFFSET savedHSName2
    mov edi, OFFSET savedHSName3
    mov ecx, 20
    rep movsb
    pop edi
    pop esi
    
    ; Set 2nd
    mov savedHighScore2, eax
    push esi
    push edi
    mov esi, OFFSET currentPlayerName
    mov edi, OFFSET savedHSName2
    mov ecx, 20
    rep movsb
    pop edi
    pop esi
    jmp SaveToFile

Check3rd:
    cmp eax, savedHighScore3
    jle SaveHSDone
    
    ; Set 3rd
    mov savedHighScore3, eax
    push esi
    push edi
    mov esi, OFFSET currentPlayerName
    mov edi, OFFSET savedHSName3
    mov ecx, 20
    rep movsb
    pop edi
    pop esi

SaveToFile:
    ; Create/open file
    mov edx, OFFSET highScoreFile
    call CreateOutputFile
    cmp eax, INVALID_HANDLE_VALUE
    je SaveHSDone
    mov fileHandle, eax
    
    ; Store all 3 scores (12 bytes)
    mov edx, OFFSET savedHighScore1
    mov ecx, 12
    mov eax, fileHandle
    call WriteToFile
    
    ; Store all 3 names (60 bytes)
    mov edx, OFFSET savedHSName1
    mov ecx, 60
    mov eax, fileHandle
    call WriteToFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
    
SaveHSDone:
    popad
    ret
SaveHighScore ENDP

;-----------------------------------------------------------
; LoadHighScore: Loads high score from file
;-----------------------------------------------------------
LoadHighScore PROC
    pushad
    ; Open file
    mov edx, OFFSET highScoreFile
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je LoadHSDone
    mov fileHandle, eax
    
    ; Read all 3 scores
    mov edx, OFFSET savedHighScore1
    mov ecx, 12
    mov eax, fileHandle
    call ReadFromFile
    
    ; Read all 3 names
    mov edx, OFFSET savedHSName1
    mov ecx, 60
    mov eax, fileHandle
    call ReadFromFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
LoadHSDone:
    popad
    ret
LoadHighScore ENDP

;-----------------------------------------------------------
; SaveProgress: Saves level progress to file
;-----------------------------------------------------------
SaveProgress PROC
    ; Create/open file
    INVOKE CreateFile,
        ADDR progressFile,
        GENERIC_WRITE,
        0,
        NULL,
        CREATE_ALWAYS,
        FILE_ATTRIBUTE_NORMAL,
        NULL
   
    cmp eax, INVALID_HANDLE_VALUE
    je SaveProgDone
    mov fileHandle, eax
   
    ; Write current level
    mov al, selectedLevel
    mov savedLevel, al
   
    INVOKE WriteFile,
        fileHandle,
        ADDR savedLevel,
        1,
        ADDR bytesWritten,
        NULL
   
    ; Write score
    INVOKE WriteFile,
        fileHandle,
        ADDR playerScore,
        4,
        ADDR bytesWritten,
        NULL
   
    ; Write lives
    INVOKE WriteFile,
        fileHandle,
        ADDR playerLives,
        1,
        ADDR bytesWritten,
        NULL
   
    ; Close file
    INVOKE CloseHandle, fileHandle
   
SaveProgDone:
    ret
SaveProgress ENDP

;-----------------------------------------------------------
; LoadProgress: Loads level progress from file
;-----------------------------------------------------------
LoadProgress PROC
    ; Open file
    INVOKE CreateFile,
        ADDR progressFile,
        GENERIC_READ,
        0,
        NULL,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL,
        NULL
   
    cmp eax, INVALID_HANDLE_VALUE
    je LoadProgDone
    mov fileHandle, eax
   
    ; Read level
    INVOKE ReadFile,
        fileHandle,
        ADDR savedLevel,
        1,
        ADDR bytesRead,
        NULL
   
    mov al, savedLevel
    mov selectedLevel, al
   
    ; Read score
    INVOKE ReadFile,
        fileHandle,
        ADDR playerScore,
        4,
        ADDR bytesRead,
        NULL
   
    ; Read lives
    INVOKE ReadFile,
        fileHandle,
        ADDR playerLives,
        1,
        ADDR bytesRead,
        NULL
   
    ; Close file
    INVOKE CloseHandle, fileHandle
   
LoadProgDone:
    ret
LoadProgress ENDP

;===========================================================================
; WORLD 1-1 COMPLETE GAME IMPLEMENTATION - SPEED RACER MARIO (23I-0582)
;===========================================================================

;-----------------------------------------------------------
; StartLevel1: Initialize and run World 1-1 Grassland
;-----------------------------------------------------------
StartLevel1 PROC
    ; Reset game state
    mov playerScore, 0
    mov playerCoins, 0
    mov gameTime, 400
    mov marioX, 5
    mov marioY, 18
    mov marioState, 0
    mov isJumping, 0
    mov jumpHeight, 0
    mov velY, 0
    mov velX, 0
    mov isOnGround, 1
    mov gameRunning, 1
    mov turboActive, 0
    mov turboTimer, 0
    mov frameCounter, 0
    mov marioOnPole, 0
    
    ; Reset enemies
    mov goombaX, 40
    mov goombaAlive, 1
    mov goombaDir, 1
    mov goomba2X, 22
    mov goomba2Alive, 1
    mov goomba2Dir, 0
    mov goomba3X, 48
    mov goomba3Alive, 1
    mov goomba3Dir, 1
    mov koopaX, 60
    mov koopaAlive, 1
    mov koopaDir, 0
    mov koopaIsShell, 0
    
    ; Reset coins
    mov coin1Active, 1
    mov coin2Active, 1
    mov coin3Active, 1
    mov coin4Active, 1
    mov coin5Active, 1
    
    ; Reset question blocks
    mov qBlock1Hit, 0
    mov qBlock2Hit, 0
    mov qBlock3Hit, 0
    
    ; Reset item states
    mov mushroomActive, 0
    mov starActive, 0
    
    ; Reset hidden blocks
    mov hiddenBlock1Found, 0
    mov hiddenBlock2Found, 0
    mov hiddenBlock3Found, 0
    
    ; Reset Piranhalands L1
    mov piranha1State, 0
    mov piranha1H, 0
    mov piranha1Timer, 0
    mov piranha2State, 0
    mov piranha2H, 0
    mov piranha2Timer, 0
    mov piranha3State, 0
    mov piranha3H, 0
    mov piranha3Timer, 0
    mov fireball1Active, 0
    mov fireball2Active, 0
    mov fireballCount, 0
    
    ; Start mushroom as hidden
    mov mushroom1Active, 0

GameLoop:
    ; Check if game should continue
    cmp gameRunning, 0
    je GameLoopEnd
    
    ; Check for flagpole reached
    cmp marioOnPole, 1
    je HandleFlagpole
    
    ; Clear screen for new frame
    call Clrscr
    
    ; Draw the level
    call DrawLevel1
    
    ; Draw HUD
    call DrawHUD
    
    ; Draw Mario
    call DrawMario
    
    ; Draw enemies
    call DrawEnemies
    
    ; Draw collectible coins
    call DrawCoins
    
    ; Draw Piranha Plants (Level 1)
    call DrawPiranhaPlantsL1
    
    ; Draw Fireballs
    call DrawFireballs
    
    ; Handle keyboard input
    call HandleInput
    call ProcessFireballInput
    
    ; Update physics
    call UpdateMarioPhysics
    
    ; Update enemies
    call UpdateGoombas
    call UpdateKoopas
    call UpdatePiranhaPlantsL1
    
    ; Update Fireballs
    call UpdateFireballs
    
    ; Update spawned items
    call UpdateItems
    
    ; Check collisions
    call CheckAllCollisions
    call CheckBlockCollision
    call CheckFireballCollision
    
    ; Draw items
    call DrawItems
    
    ; Update timer every ~60 frames
    inc byte ptr frameCounter
    cmp frameCounter, 60
    jl SkipTimerUpdate
    mov frameCounter, 0
    cmp gameTime, 0
    je TimeUp
    dec word ptr gameTime
    
    ; Update turbo timer if active
    cmp turboActive, 0
    je SkipTimerUpdate
    dec word ptr turboTimer
    cmp turboTimer, 0
    jg SkipTimerUpdate
    mov turboActive, 0     ; Turbo expired
    
SkipTimerUpdate:
    ; --- BULLET TIME MANAGEMENT ---
    cmp slowMotionActive, 1
    jne RechargeMeter
    
    ; Deactivate if meter empty
    cmp slowMotionMeter, 0
    je AutoDeactivate
    dec slowMotionMeter
    jmp ApplySlowDelay

AutoDeactivate:
    mov slowMotionActive, 0
    jmp NormalDelay

RechargeMeter:
    cmp slowMotionMeter, 100
    jge NormalDelay
    inc slowMotionMeter

NormalDelay:
    ; Frame delay for game speed (~60 FPS feel)
    mov eax, 50
    call Delay
    jmp GameLoop

ApplySlowDelay:
    ; Frame delay for slow motion (~30 FPS feel)
    mov eax, 100
    call Delay
    jmp GameLoop

HandleFlagpole:
    ; Always deactivate BT for animations
    mov slowMotionActive, 0
    call FlagpoleSlide
    mov levelCompleted, 1     ; Mark level as completed for transition
    jmp GameLoopEnd

TimeUp:
    ; Time ran out - lose a life
    dec byte ptr playerLives
    cmp playerLives, 0
    je ShowGameOverScreen
    ; Restart level
    jmp StartLevel1

GameLoopEnd:
    ret
StartLevel1 ENDP

;-----------------------------------------------------------
; DrawLevel1: Render World 1-1 Grassland level
;-----------------------------------------------------------
DrawLevel1 PROC
    pushad
    
    ; Set sky background color
    mov eax, LIGHTBLUE
    call SetTextColor
    
    ; Draw clouds (row 3-5)
    mov dh, 3
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET cloudSmall
    call WriteString
    
    mov dh, 3
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET cloudSmall
    call WriteString
    
    mov dh, 3
    mov dl, 55
    call Gotoxy
    mov edx, OFFSET cloudSmall
    call WriteString
    
    mov dh, 4
    mov dl, 70
    call Gotoxy
    mov edx, OFFSET cloudLarge
    call WriteString
    
    ; Draw hills/bushes (decorative)
    mov eax, LIGHTGREEN
    call SetTextColor
    
    mov dh, 18
    mov dl, 12
    call Gotoxy
    mov edx, OFFSET hillSmall
    call WriteString
    
    mov dh, 18
    mov dl, 45
    call Gotoxy
    mov edx, OFFSET bushSmall
    call WriteString
    
    mov dh, 18
    mov dl, 65
    call Gotoxy
    mov edx, OFFSET hillSmall
    call WriteString
    
    ; --- DRAW QUESTION BLOCKS (Row 13) ---
    mov dh, 13
    
    ; Block 1
    mov dl, 16
    call Gotoxy
    cmp qBlock1Hit, 0
    jne B1Empty
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET qBlock     ; "[?]"
    jmp DrawB1
B1Empty:
    mov eax, DARKGRAY
    call SetTextColor
    mov edx, OFFSET qBlockEmpty ; "[ ]"
DrawB1:
    call WriteString
    
    ; Block 2
    mov dl, 21
    call Gotoxy
    cmp qBlock2Hit, 0
    jne B2Empty
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET qBlock
    jmp DrawB2
B2Empty:
    mov eax, DARKGRAY
    call SetTextColor
    mov edx, OFFSET qBlockEmpty
DrawB2:
    call WriteString
    
    ; Block 3 (at X=78)
    mov dl, 78
    call Gotoxy
    cmp qBlock3Hit, 0
    jne B3Empty
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET qBlock
    jmp DrawB3
B3Empty:
    mov eax, DARKGRAY
    call SetTextColor
    mov edx, OFFSET qBlockEmpty
DrawB3:
    call WriteString
    
    ; Standard Brick Blocks
    mov eax, BROWN
    call SetTextColor
    
    mov dl, 24
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    mov dl, 27
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET qBlock      ; Another qblock for filler
    call WriteString
    
    ; Draw elevated block row at row 9
    mov dh, 9
    mov dl, 48
    call Gotoxy
    mov edx, OFFSET qBlock
    call WriteString
    
    ; Draw Pipes (GREEN)
    mov eax, LIGHTGREEN
    call SetTextColor
    
    ; Pipe 1 - small (3 rows) at X=28
    mov dh, 17
    mov dl, 28
    call Gotoxy
    mov edx, OFFSET pipeTop
    call WriteString
    
    mov dh, 18
    mov dl, 28
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    mov dh, 19
    mov dl, 28
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    ; Pipe 2 - medium (4 rows) at X=40
    mov dh, 16
    mov dl, 40
    call Gotoxy
    mov edx, OFFSET pipeTop
    call WriteString
    
    mov dh, 17
    mov dl, 40
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    mov dh, 18
    mov dl, 40
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    mov dh, 19
    mov dl, 40
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    ; Pipe 3 - tall (5 rows) at X=52
    mov dh, 15
    mov dl, 52
    call Gotoxy
    mov edx, OFFSET pipeTop
    call WriteString
    
    mov dh, 16
    mov dl, 52
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    mov dh, 17
    mov dl, 52
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    mov dh, 18
    mov dl, 52
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    mov dh, 19
    mov dl, 52
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    ; Draw Stair Pyramid (starting at X=62)
    mov eax, BROWN
    call SetTextColor
    
    ; Step 1 (1 block high)
    mov dh, 19
    mov dl, 62
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Step 2 (2 blocks high)
    mov dh, 18
    mov dl, 65
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 19
    mov dl, 65
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Step 3 (3 blocks high)
    mov dh, 17
    mov dl, 68
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 18
    mov dl, 68
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 19
    mov dl, 68
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Step 4 (4 blocks high)
    mov dh, 16
    mov dl, 71
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 17
    mov dl, 71
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 18
    mov dl, 71
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 19
    mov dl, 71
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Draw Flagpole at X=75
    mov eax, WHITE
    call SetTextColor
    
    ; Flagpole top (flag)
    mov dh, 8
    mov dl, 75
    call Gotoxy
    mov edx, OFFSET flagTop
    call WriteString
    
    ; Flagpole shaft
    mov ecx, 11      ; Height of pole
    mov dh, 9
DrawPoleLoop:
    push ecx
    mov dl, 75
    call Gotoxy
    mov edx, OFFSET flagPole
    call WriteString
    inc dh
    pop ecx
    loop DrawPoleLoop
    
    ; Draw Mini Castle at X=80
    mov eax, BROWN
    call SetTextColor
    
    mov dh, 15
    mov dl, 80
    call Gotoxy
    mov edx, OFFSET castleChar1
    call WriteString
    
    mov dh, 16
    mov dl, 80
    call Gotoxy
    mov edx, OFFSET castleChar2
    call WriteString
    
    mov dh, 17
    mov dl, 80
    call Gotoxy
    mov edx, OFFSET castleChar3
    call WriteString
    
    mov dh, 18
    mov dl, 80
    call Gotoxy
    mov edx, OFFSET castleChar4
    call WriteString
    
    ; Draw Ground (row 20) with gap
    mov eax, BROWN
    call SetTextColor
    
    mov dh, 20
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET groundLine
    call WriteString
    
    popad
    ret
DrawLevel1 ENDP

;===========================================================================
; WORLD 1-2 UNDERGROUND LEVEL IMPLEMENTATION
;===========================================================================

;-----------------------------------------------------------
; StartLevel2: Initialize and run World 1-2 Underground
;-----------------------------------------------------------
StartLevel2 PROC
    ; Reset game state
    mov playerScore, 0
    mov playerCoins, 0
    mov gameTime, 400
    mov marioX, 5
    mov marioY, 17
    mov marioState, 0
    mov isJumping, 0
    mov jumpHeight, 0
    mov velY, 0
    mov velX, 0
    mov isOnGround, 1
    mov gameRunning, 1
    mov turboActive, 0
    mov turboTimer, 0
    mov frameCounter, 0
    mov marioOnPole, 0
    mov marioOnPlatform, 0
    
    ; Reset Level 2 enemies
    mov L2goomba1X, 25
    mov L2goomba1Alive, 1
    mov L2goomba1Dir, 1
    mov L2goomba2X, 55
    mov L2goomba2Alive, 1
    mov L2goomba2Dir, 0
    
    ; Reset Piranha Plants
    mov piranha1H, 0
    mov piranha1State, 0
    mov piranha1Timer, 0
    mov piranha2H, 0
    mov piranha2State, 0
    mov piranha2Timer, 0
    mov piranha3H, 0
    mov piranha3State, 0
    mov piranha3Timer, 0
    
    ; Reset Red Koopa
    mov redKoopaX, 45
    mov redKoopaAlive, 1
    mov redKoopaDir, 1
    mov redKoopaIsShell, 0
    mov redShellMoving, 0
    
    ; Reset regular Koopa for Level 2
    mov koopaX, 75
    mov koopaAlive, 1
    mov koopaDir, 0
    mov koopaIsShell, 0
    mov shellMoving, 0
    
    ; Reset platforms
    mov plat1X, 45
    mov plat1Dir, 1
    mov plat2X, 25
    mov plat2Dir, 0
    mov plat3X, 60
    mov plat3Dir, 1
    mov elev1X, 65
    mov elev1Y, 15
    mov elev1Dir, 0
    mov elev2Y, 12
    mov elev2Dir, 1
    
    ; Reset Level 2 coins
    mov L2coin1Active, 1
    mov L2coin2Active, 1
    mov L2coin3Active, 1
    mov L2coin4Active, 1
    mov L2coin5Active, 1
    mov L2coin6Active, 1
    mov L2coin7Active, 1
    mov L2coin8Active, 1
    
    ; Reset question blocks
    mov L2qBlock1Hit, 0
    mov L2qBlock2Hit, 0
    
    mov fireball1Active, 0
    mov fireball2Active, 0
    mov fireballCount, 0
    
    ; Reset items
    mov mushroomActive, 0
    mov starActive, 0
    mov oneUpActive, 0
    
    ; Reset combo
    mov comboMultiplier, 1
    mov comboTimeout, 0

L2GameLoop:
    ; Check if game should continue
    cmp gameRunning, 0
    je L2GameLoopEnd
    
    ; Check for flagpole reached
    cmp marioOnPole, 1
    je L2HandleFlagpole
    
    ; Clear screen for new frame
    call Clrscr
    
    ; Draw the level
    call DrawLevel2
    
    ; Draw HUD (with Level 2 world number)
    call DrawHUD_L2
    
    ; Draw Mario
    call DrawMario
    
    ; Draw enemies
    call DrawEnemiesL2
    
    ; Draw collectible coins
    call DrawCoinsL2
    
    ; Draw platforms
    call DrawPlatforms
    
    ; Draw Piranha Plants
    call DrawPiranhaPlants
    
    ; Draw Fireballs
    call DrawFireballs
    
    ; Handle keyboard input
    call HandleInput
    call ProcessFireballInput
    
    ; Update physics
    call UpdateMarioPhysics_L2
    
    ; Update platforms
    call UpdatePlatforms
    
    ; Update enemies
    call UpdateGoombasL2
    call UpdateKoopasL2
    call UpdatePiranhaPlants
    
    ; Update Fireballs
    call UpdateFireballs
    
    ; Update items
    call UpdateItems
    
    ; Check collisions
    call CheckAllCollisionsL2
    call CheckBlockCollisionL2
    call CheckFireballCollision
    call CheckPlatformCollision
    
    ; Draw items
    call DrawItems
    
    ; Update timer every ~60 frames
    inc byte ptr frameCounter
    cmp frameCounter, 60
    jl L2SkipTimerUpdate
    mov frameCounter, 0
    cmp gameTime, 0
    je L2TimeUp
    dec word ptr gameTime
    
    ; Update turbo timer if active
    cmp turboActive, 0
    je L2SkipTimerUpdate
    dec word ptr turboTimer
    cmp turboTimer, 0
    jg L2SkipTimerUpdate
    mov turboActive, 0
    
    ; Update combo timeout
    cmp comboTimeout, 0
    je L2SkipTimerUpdate
    dec comboTimeout
    cmp comboTimeout, 0
    jg L2SkipTimerUpdate
    mov comboMultiplier, 1   ; Reset combo


L2SkipTimerUpdate:
    ; --- BULLET TIME MANAGEMENT ---
    cmp slowMotionActive, 1
    jne L2RechargeMeter
    
    ; Deactivate if meter empty
    cmp slowMotionMeter, 0
    je L2AutoDeactivate
    dec slowMotionMeter
    jmp L2ApplySlowDelay

L2AutoDeactivate:
    mov slowMotionActive, 0
    jmp L2NormalDelay

L2RechargeMeter:
    cmp slowMotionMeter, 100
    jge L2NormalDelay
    inc slowMotionMeter

L2NormalDelay:
    ; Frame delay
    mov eax, 50
    call Delay
    jmp L2GameLoop

L2ApplySlowDelay:
    ; Frame delay for slow motion
    mov eax, 100
    call Delay
    jmp L2GameLoop

L2HandleFlagpole:
    mov slowMotionActive, 0
    call FlagpoleSlideL2
    mov levelCompleted, 1     ; Mark level as completed for transition
    jmp L2GameLoopEnd

L2TimeUp:
    dec byte ptr playerLives
    cmp playerLives, 0
    je ShowGameOverScreen
    jmp StartLevel2

L2GameLoopEnd:
    ret
StartLevel2 ENDP

;-----------------------------------------------------------
; DrawLevel2: Render World 1-2 Underground level
;-----------------------------------------------------------
DrawLevel2 PROC
    pushad
    
    ; Underground has BLACK background (already cleared)
    
    ; Draw ceiling (row 6) - Brown bricks (Moved down from row 4 to avoid HUD conflict)
    mov eax, BROWN
    call SetTextColor
    
    mov dh, 6
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET ceilingLine
    call WriteString
    
    ; Draw some ceiling bricks at row 5 for depth
    mov eax, ORANGE
    call SetTextColor
    mov dh, 5
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET groundLine
    call WriteString
    
    ; Draw underground brick patterns (sporadic blocks)
    mov eax, BROWN
    call SetTextColor
    
    ; Block row at Y=10
    mov dh, 10
    mov dl, 10
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    mov dl, 13
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    mov dl, 16
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Question blocks at Y=13
    mov dh, 13
    
    ; L2 Block 1
    mov dl, 35
    call Gotoxy
    cmp L2qBlock1Hit, 0
    jne L2B1Empty
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET qBlock
    jmp L2DrawB1
L2B1Empty:
    mov eax, DARKGRAY
    call SetTextColor
    mov edx, OFFSET qBlockEmpty
L2DrawB1:
    call WriteString
    
    ; L2 Block 2
    mov dl, 65
    call Gotoxy
    cmp L2qBlock2Hit, 0
    jne L2B2Empty
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET qBlock
    jmp L2DrawB2
L2B2Empty:
    mov eax, DARKGRAY
    call SetTextColor
    mov edx, OFFSET qBlockEmpty
L2DrawB2:
    call WriteString
    
    ; Draw brick blocks around question blocks
    mov eax, BROWN
    call SetTextColor
    
    mov dl, 32
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    mov dl, 38
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    mov dl, 62
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    mov dl, 68
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Draw Pipes (GREEN) with Piranha Plant base
    mov eax, LIGHTGREEN
    call SetTextColor
    
    ; Pipe 1 at X=30
    mov dh, 16
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET pipeTop
    call WriteString
    mov dh, 17
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    mov dh, 18
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    mov dh, 19
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    ; Pipe 2 at X=50
    mov dh, 16
    mov dl, 50
    call Gotoxy
    mov edx, OFFSET pipeTop
    call WriteString
    mov dh, 17
    mov dl, 50
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    mov dh, 18
    mov dl, 50
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    mov dh, 19
    mov dl, 50
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    ; Pipe 3 at X=70
    mov dh, 16
    mov dl, 70
    call Gotoxy
    mov edx, OFFSET pipeTop
    call WriteString
    mov dh, 17
    mov dl, 70
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    mov dh, 18
    mov dl, 70
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    mov dh, 19
    mov dl, 70
    call Gotoxy
    mov edx, OFFSET pipeMid
    call WriteString
    
    ; Draw Stair Pyramid at end (X=82)
    mov eax, BROWN
    call SetTextColor
    
    mov dh, 19
    mov dl, 82
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    mov dh, 18
    mov dl, 85
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 19
    mov dl, 85
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    mov dh, 17
    mov dl, 88
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 18
    mov dl, 88
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 19
    mov dl, 88
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Draw Flagpole at X=92
    mov eax, WHITE
    call SetTextColor
    
    mov dh, 8
    mov dl, 92
    call Gotoxy
    mov edx, OFFSET flagTop
    call WriteString
    
    mov ecx, 11
    mov dh, 9
L2DrawPoleLoop:
    push ecx
    mov dl, 92
    call Gotoxy
    mov edx, OFFSET flagPole
    call WriteString
    inc dh
    pop ecx
    loop L2DrawPoleLoop
    
    ; Draw Ground (row 20) - Underground floor
    mov eax, BROWN
    call SetTextColor
    
    mov dh, 20
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET groundLine
    call WriteString
    
    popad
    ret
DrawLevel2 ENDP

;-----------------------------------------------------------
; DrawHUD_L2: Draw HUD with World 1-2
;-----------------------------------------------------------
DrawHUD_L2 PROC
    pushad
    mov edx, OFFSET worldNum12
    call DrawHUD_Generic
    popad
    ret
DrawHUD_L2 ENDP

;-----------------------------------------------------------
; DrawEnemiesL2: Draw Level 2 enemies
;-----------------------------------------------------------
DrawEnemiesL2 PROC
    pushad
    
    ; Draw L2 Goomba 1
    cmp L2goomba1Alive, 0
    je SkipL2G1
    mov eax, BROWN
    call SetTextColor
    mov dh, L2goomba1Y
    mov dl, L2goomba1X
    call Gotoxy
    mov edx, OFFSET goombaChar
    call WriteString
SkipL2G1:
    
    ; Draw L2 Goomba 2
    cmp L2goomba2Alive, 0
    je SkipL2G2
    mov eax, BROWN
    call SetTextColor
    mov dh, L2goomba2Y
    mov dl, L2goomba2X
    call Gotoxy
    mov edx, OFFSET goombaChar
    call WriteString
SkipL2G2:
    
    ; Draw Red Koopa
    cmp redKoopaAlive, 0
    je SkipRedK
    mov eax, LIGHTRED
    call SetTextColor
    mov dh, redKoopaY
    mov dl, redKoopaX
    call Gotoxy
    cmp redKoopaIsShell, 0
    je DrawRedTurtle
    mov edx, OFFSET koopaShell
    jmp DrawRedSprite
DrawRedTurtle:
    mov edx, OFFSET redKoopaChar
DrawRedSprite:
    call WriteString
SkipRedK:
    
    ; Draw Green Koopa
    cmp koopaAlive, 0
    je SkipGreenK
    mov eax, LIGHTGREEN
    call SetTextColor
    mov dh, koopaY
    mov dl, koopaX
    call Gotoxy
    cmp koopaIsShell, 0
    je DrawGreenTurtle
    mov edx, OFFSET koopaShell
    jmp DrawGreenSprite
DrawGreenTurtle:
    mov edx, OFFSET koopaChar
DrawGreenSprite:
    call WriteString
SkipGreenK:
    
    popad
    ret
DrawEnemiesL2 ENDP

;-----------------------------------------------------------
; DrawCoinsL2: Draw Level 2 coins (coin room)
;-----------------------------------------------------------
DrawCoinsL2 PROC
    pushad
    
    mov eax, YELLOW
    call SetTextColor
    
    ; Coin 1
    cmp L2coin1Active, 0
    je SkipL2C1
    mov dh, L2coin1Y
    mov dl, L2coin1X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL2C1:
    
    ; Coin 2
    cmp L2coin2Active, 0
    je SkipL2C2
    mov dh, L2coin2Y
    mov dl, L2coin2X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL2C2:
    
    ; Coin 3
    cmp L2coin3Active, 0
    je SkipL2C3
    mov dh, L2coin3Y
    mov dl, L2coin3X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL2C3:
    
    ; Coin 4
    cmp L2coin4Active, 0
    je SkipL2C4
    mov dh, L2coin4Y
    mov dl, L2coin4X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL2C4:
    
    ; Coin 5
    cmp L2coin5Active, 0
    je SkipL2C5
    mov dh, L2coin5Y
    mov dl, L2coin5X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL2C5:
    
    ; Coin 6
    cmp L2coin6Active, 0
    je SkipL2C6
    mov dh, L2coin6Y
    mov dl, L2coin6X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL2C6:
    
    ; Coin 7
    cmp L2coin7Active, 0
    je SkipL2C7
    mov dh, L2coin7Y
    mov dl, L2coin7X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL2C7:
    
    ; Coin 8
    cmp L2coin8Active, 0
    je SkipL2C8
    mov dh, L2coin8Y
    mov dl, L2coin8X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL2C8:
    
    popad
    ret
DrawCoinsL2 ENDP

;-----------------------------------------------------------
; DrawPlatforms: Draw moving and elevator platforms
;-----------------------------------------------------------
DrawPlatforms PROC
    pushad
    
    mov eax, WHITE
    call SetTextColor
    
    ; Platform 1
    mov dh, plat1Y
    mov dl, plat1X
    call Gotoxy
    mov edx, OFFSET platChar
    call WriteString
    
    ; Platform 2
    mov dh, plat2Y
    mov dl, plat2X
    call Gotoxy
    mov edx, OFFSET platChar
    call WriteString
    
    ; Platform 3
    mov dh, plat3Y
    mov dl, plat3X
    call Gotoxy
    mov edx, OFFSET platChar
    call WriteString
    
    ; Elevator 1
    mov eax, LIGHTCYAN
    call SetTextColor
    mov dh, elev1Y
    mov dl, elev1X
    call Gotoxy
    mov edx, OFFSET elevChar
    call WriteString
    
    ; Elevator 2
    mov dh, elev2Y
    mov dl, elev2X
    call Gotoxy
    mov edx, OFFSET elevChar
    call WriteString
    
    popad
    ret
DrawPlatforms ENDP

;-----------------------------------------------------------
; DrawPiranhaPlants: Draw piranha plants at current heights
;-----------------------------------------------------------
DrawPiranhaPlants PROC
    pushad
    
    ; Piranha 1 at pipe X=30
    cmp piranha1H, 0
    je SkipP1Draw
    mov eax, LIGHTRED
    call SetTextColor
    mov al, piranha1Y
    sub al, piranha1H
    mov dh, al
    mov dl, 30
    inc dl          ; Center in pipe
    call Gotoxy
    mov edx, OFFSET piranhaChar
    call WriteString
SkipP1Draw:
    
    ; Piranha 2 at pipe X=50
    cmp piranha2H, 0
    je SkipP2Draw
    mov eax, LIGHTRED
    call SetTextColor
    mov al, piranha2Y
    sub al, piranha2H
    mov dh, al
    mov dl, 50
    inc dl
    call Gotoxy
    mov edx, OFFSET piranhaChar
    call WriteString
SkipP2Draw:
    
    ; Piranha 3 at pipe X=70
    cmp piranha3H, 0
    je SkipP3Draw
    mov eax, LIGHTRED
    call SetTextColor
    mov al, piranha3Y
    sub al, piranha3H
    mov dh, al
    mov dl, 70
    inc dl
    call Gotoxy
    mov edx, OFFSET piranhaChar
    call WriteString
SkipP3Draw:
    
    popad
    ret
DrawPiranhaPlants ENDP

;-----------------------------------------------------------
; UpdatePlatforms: Move platforms horizontally and vertically
;-----------------------------------------------------------
UpdatePlatforms PROC
    pushad
    
    ; Update Platform 1 (horizontal)
    cmp plat1Dir, 1
    je P1MoveRight
    dec plat1X
    cmp plat1X, 40
    jg P1Done
    mov plat1Dir, 1
    jmp P1Done
P1MoveRight:
    inc plat1X
    cmp plat1X, 55
    jl P1Done
    mov plat1Dir, 0
P1Done:
    
    ; Update Platform 2 (horizontal)
    cmp plat2Dir, 1
    je P2MoveRight
    dec plat2X
    cmp plat2X, 15
    jg P2Done
    mov plat2Dir, 1
    jmp P2Done
P2MoveRight:
    inc plat2X
    cmp plat2X, 35
    jl P2Done
    mov plat2Dir, 0
P2Done:
    
    ; Update Platform 3 (horizontal)
    cmp plat3Dir, 1
    je P3MoveRight
    dec plat3X
    cmp plat3X, 55
    jg P3Done
    mov plat3Dir, 1
    jmp P3Done
P3MoveRight:
    inc plat3X
    cmp plat3X, 75
    jl P3Done
    mov plat3Dir, 0
P3Done:
    
    ; Update Elevator 1 (vertical)
    cmp elev1Dir, 1
    je E1MoveDown
    dec elev1Y
    cmp elev1Y, 8
    jg E1Done
    mov elev1Dir, 1
    jmp E1Done
E1MoveDown:
    inc elev1Y
    cmp elev1Y, 17
    jl E1Done
    mov elev1Dir, 0
E1Done:
    
    ; Update Elevator 2 (vertical)
    cmp elev2Dir, 1
    je E2MoveDown
    dec elev2Y
    cmp elev2Y, 8
    jg E2Done
    mov elev2Dir, 1
    jmp E2Done
E2MoveDown:
    inc elev2Y
    cmp elev2Y, 17
    jl E2Done
    mov elev2Dir, 0
E2Done:
    
    popad
    ret
UpdatePlatforms ENDP

;-----------------------------------------------------------
; UpdatePiranhaPlants: State machine for piranha behavior
;-----------------------------------------------------------
UpdatePiranhaPlants PROC
    pushad
    
    ; === Piranha 1 ===
    ; Check if Mario is near pipe (won't emerge)
    mov al, marioX
    cmp al, 27
    jl P1Continue
    cmp al, 34
    jg P1Continue
    mov al, marioY
    cmp al, 14
    jl P1Continue
    ; Mario is near - stay hidden
    mov piranha1State, 0
    mov piranha1H, 0
    jmp P1Skip
    
P1Continue:
    cmp piranha1State, 0
    je P1WaitDown
    cmp piranha1State, 1
    je P1GoingUp
    cmp piranha1State, 2
    je P1WaitUp
    cmp piranha1State, 3
    je P1GoingDown
    jmp P1Skip
    
P1WaitDown:
    inc piranha1Timer
    cmp piranha1Timer, 60
    jl P1Skip
    mov piranha1Timer, 0
    mov piranha1State, 1
    jmp P1Skip
    
P1GoingUp:
    inc piranha1H
    cmp piranha1H, 2
    jl P1Skip
    mov piranha1State, 2
    mov piranha1Timer, 0
    jmp P1Skip
    
P1WaitUp:
    inc piranha1Timer
    cmp piranha1Timer, 40
    jl P1Skip
    mov piranha1Timer, 0
    mov piranha1State, 3
    jmp P1Skip
    
P1GoingDown:
    dec piranha1H
    cmp piranha1H, 0
    jg P1Skip
    mov piranha1H, 0
    mov piranha1State, 0
    mov piranha1Timer, 0
    
P1Skip:
    
    ; === Piranha 2 === (similar logic)
    mov al, marioX
    cmp al, 47
    jl P2Continue
    cmp al, 54
    jg P2Continue
    mov al, marioY
    cmp al, 14
    jl P2Continue
    mov piranha2State, 0
    mov piranha2H, 0
    jmp P2Skip
    
P2Continue:
    cmp piranha2State, 0
    je P2WaitDown
    cmp piranha2State, 1
    je P2GoingUp
    cmp piranha2State, 2
    je P2WaitUp
    jmp P2GoingDown2
    
P2WaitDown:
    inc piranha2Timer
    cmp piranha2Timer, 80
    jl P2Skip
    mov piranha2Timer, 0
    mov piranha2State, 1
    jmp P2Skip
    
P2GoingUp:
    inc piranha2H
    cmp piranha2H, 2
    jl P2Skip
    mov piranha2State, 2
    mov piranha2Timer, 0
    jmp P2Skip
    
P2WaitUp:
    inc piranha2Timer
    cmp piranha2Timer, 40
    jl P2Skip
    mov piranha2Timer, 0
    mov piranha2State, 3
    jmp P2Skip
    
P2GoingDown2:
    dec piranha2H
    cmp piranha2H, 0
    jg P2Skip
    mov piranha2H, 0
    mov piranha2State, 0
    mov piranha2Timer, 0
    
P2Skip:
    
    ; === Piranha 3 ===
    mov al, marioX
    cmp al, 67
    jl P3Continue
    cmp al, 74
    jg P3Continue
    mov al, marioY
    cmp al, 14
    jl P3Continue
    mov piranha3State, 0
    mov piranha3H, 0
    jmp P3SkipPlant
    
P3Continue:
    cmp piranha3State, 0
    je P3WaitDown
    cmp piranha3State, 1
    je P3GoingUp
    cmp piranha3State, 2
    je P3WaitUp
    jmp P3GoingDown3
    
P3WaitDown:
    inc piranha3Timer
    cmp piranha3Timer, 100
    jl P3SkipPlant
    mov piranha3Timer, 0
    mov piranha3State, 1
    jmp P3SkipPlant
    
P3GoingUp:
    inc piranha3H
    cmp piranha3H, 2
    jl P3SkipPlant
    mov piranha3State, 2
    mov piranha3Timer, 0
    jmp P3SkipPlant
    
P3WaitUp:
    inc piranha3Timer
    cmp piranha3Timer, 40
    jl P3SkipPlant
    mov piranha3Timer, 0
    mov piranha3State, 3
    jmp P3SkipPlant
    
P3GoingDown3:
    dec piranha3H
    cmp piranha3H, 0
    jg P3SkipPlant
    mov piranha3H, 0
    mov piranha3State, 0
    mov piranha3Timer, 0
    
P3SkipPlant:
    
    popad
    ret
UpdatePiranhaPlants ENDP

;-----------------------------------------------------------
; UpdateMarioPhysics_L2: Physics with ceiling collision
;-----------------------------------------------------------
UpdateMarioPhysics_L2 PROC
    pushad
    
    ; --- Horizontal Movement & Friction ---
    cmp horizontalInputActive, 1
    je StaticXL2       ; Skip friction if actively moving
    
    cmp velX, 0
    je StaticXL2
    jg DecelRightL2
    inc velX
    jmp StaticXL2
DecelRightL2:
    dec velX
StaticXL2:
    mov al, velX
    add marioX, al
    
    ; Apply platform momentum if on platform
    cmp marioOnPlatform, 0
    je SkipPlatMomentumL2
    mov al, platformDeltaX
    add marioX, al
    mov al, platformDeltaY
    add marioY, al
    
SkipPlatMomentumL2:
    
    ; Level 2 Boundaries - signed check
    movsx eax, marioX
    cmp eax, 2
    jge CheckRBL2
    mov marioX, 2
    mov velX, 0
CheckRBL2:
    cmp eax, 95
    jle PhysicsVL2
    mov marioX, 95
    mov velX, 0

PhysicsVL2:
    ; --- Vertical Movement ---
    cmp isOnGround, 1
    jne L2ApplyGravity
    
    ; Edge detection - check if still supported
    mov al, marioX
    mov cl, marioY
    call CheckSupportAtL2
    cmp al, 1
    je PhysicsDoneL2     ; Still supported
    mov isOnGround, 0    ; Walked off edge!
    
L2ApplyGravity:
    ; Gravity
    mov al, GRAVITY
    add velY, al
    
    ; Cap at terminal velocity
    mov al, velY
    cmp al, MAX_FALL_SPEED
    jle L2ApplyVel
    mov al, MAX_FALL_SPEED
    mov velY, al
    
L2ApplyVel:
    ; Apply vertical velocity
    mov al, velY
    add marioY, al
    
    ; Check platform collision (landing)
    mov al, marioX
    mov cl, marioY
    call CheckSupportAtL2
    cmp al, 1
    jne L2CheckGround
    
    ; Landed on platform!
    mov isOnGround, 1
    mov isJumping, 0
    mov velY, 0
    jmp PhysicsDoneL2

L2CheckGround:
    ; Check ground (Y=17 for underground)
    mov al, marioY
    cmp al, 17
    jl L2CheckCeil
    mov marioY, 17
    mov isOnGround, 1
    mov isJumping, 0
    mov velY, 0
    jmp PhysicsDoneL2
    
L2CheckCeil:
    ; Check ceiling
    mov al, CEILING_LIMIT
    cmp marioY, al
    jg PhysicsDoneL2
    mov marioY, al
    mov velY, 1
    
PhysicsDoneL2:
    ; --- Star Power Timer ---
    cmp marioInvincible, 0
    je PhysicsEndL2
    dec word ptr marioStarTimer
    cmp word ptr marioStarTimer, 0
    jg PhysicsEndL2
    mov marioInvincible, 0
    mov turboActive, 0
    
PhysicsEndL2:
    popad
    ret
UpdateMarioPhysics_L2 ENDP


;-----------------------------------------------------------
; UpdateGoombasL2: Move Level 2 goombas
;-----------------------------------------------------------
UpdateGoombasL2 PROC
    pushad
    
    ; Goomba 1
    cmp L2goomba1Alive, 0
    je SkipL2G1Update
    
    cmp L2goomba1Dir, 1
    je L2G1Right
    dec L2goomba1X
    cmp L2goomba1X, 5
    jg L2G1CheckP
    mov L2goomba1Dir, 1
    jmp SkipL2G1Update
    
L2G1Right:
    inc L2goomba1X
    cmp L2goomba1X, 28
    jl L2G1CheckP
    mov L2goomba1Dir, 0
    
L2G1CheckP:
    ; Check pipe collision
    mov al, L2goomba1X
    cmp al, 30
    jl SkipL2G1Update
    cmp al, 34
    jg SkipL2G1Update
    xor L2goomba1Dir, 1
    
SkipL2G1Update:
    
    ; Goomba 2
    cmp L2goomba2Alive, 0
    je SkipL2G2Update
    
    cmp L2goomba2Dir, 1
    je L2G2Right
    dec L2goomba2X
    cmp L2goomba2X, 52
    jg L2G2CheckP
    mov L2goomba2Dir, 1
    jmp SkipL2G2Update
    
L2G2Right:
    inc L2goomba2X
    cmp L2goomba2X, 68
    jl L2G2CheckP
    mov L2goomba2Dir, 0
    
L2G2CheckP:
    mov al, L2goomba2X
    cmp al, 50
    jl SkipL2G2Update
    cmp al, 54
    jg SkipL2G2Update
    xor L2goomba2Dir, 1
    
SkipL2G2Update:
    popad
    ret
UpdateGoombasL2 ENDP

;-----------------------------------------------------------
; UpdateKoopasL2: Move koopas with Red/Green behavior
;-----------------------------------------------------------
UpdateKoopasL2 PROC
    pushad
    
    ; Red Koopa - turns at edges (doesn't fall)
    cmp redKoopaAlive, 0
    je SkipRedUpdate
    
    cmp redKoopaIsShell, 1
    je UpdateRedShell
    
    cmp redKoopaDir, 1
    je RedMoveRight
    dec redKoopaX
    cmp redKoopaX, 38       ; Edge of platform
    jg SkipRedUpdate
    mov redKoopaDir, 1
    jmp SkipRedUpdate
    
RedMoveRight:
    inc redKoopaX
    cmp redKoopaX, 48       ; Other edge
    jl SkipRedUpdate
    mov redKoopaDir, 0
    jmp SkipRedUpdate
    
UpdateRedShell:
    cmp redShellMoving, 0
    je SkipRedUpdate
    
    cmp redShellDir, 1
    je RedShellRight
    sub redKoopaX, 3
    cmp redKoopaX, 2
    jg SkipRedUpdate
    mov redKoopaX, 2
    mov redShellDir, 1
    jmp SkipRedUpdate
    
RedShellRight:
    add redKoopaX, 3
    cmp redKoopaX, 90
    jl SkipRedUpdate
    mov redKoopaX, 90
    mov redShellDir, 0
    
SkipRedUpdate:
    
    ; Green Koopa - walks off platforms (same as Level 1 behavior)
    cmp koopaAlive, 0
    je SkipGreenUpdate
    
    cmp koopaIsShell, 1
    je UpdateGreenShellL2
    
    cmp koopaDir, 1
    je GreenMoveR
    dec koopaX
    cmp koopaX, 72
    jg SkipGreenUpdate
    mov koopaDir, 1
    jmp SkipGreenUpdate
    
GreenMoveR:
    inc koopaX
    cmp koopaX, 90
    jl SkipGreenUpdate
    mov koopaDir, 0
    jmp SkipGreenUpdate
    
UpdateGreenShellL2:
    cmp shellMoving, 0
    je SkipGreenUpdate
    
    cmp shellDir, 1
    je GreenShellR
    sub koopaX, 3
    cmp koopaX, 2
    jg SkipGreenUpdate
    mov koopaX, 2
    mov shellDir, 1
    jmp SkipGreenUpdate
    
GreenShellR:
    add koopaX, 3
    cmp koopaX, 90
    jl SkipGreenUpdate
    mov koopaX, 90
    mov shellDir, 0
    
SkipGreenUpdate:
    popad
    ret
UpdateKoopasL2 ENDP

;-----------------------------------------------------------
; CheckPlatformCollision: Check if Mario lands on platform
;-----------------------------------------------------------
CheckPlatformCollision PROC
    pushad
    
    ; Only check if Mario is falling
    mov al, velY
    cmp al, 0
    jle NoPlatColl
    
    ; Check Platform 1
    mov al, marioY
    cmp al, plat1Y
    jne CheckP2
    mov al, marioX
    cmp al, plat1X
    jl CheckP2
    mov bl, plat1X
    add bl, 7
    cmp al, bl
    jg CheckP2
    ; On platform 1!
    mov isOnGround, 1
    mov velY, 0
    mov marioOnPlatform, 1
    ; Store platform horizontal movement
    mov al, plat1Dir
    cmp al, 1
    je P1SetR
    mov platformDeltaX, -1
    jmp NoPlatColl
P1SetR:
    mov platformDeltaX, 1
    jmp NoPlatColl
    
CheckP2:
    mov al, marioY
    cmp al, plat2Y
    jne CheckP3
    mov al, marioX
    cmp al, plat2X
    jl CheckP3
    mov bl, plat2X
    add bl, 7
    cmp al, bl
    jg CheckP3
    mov isOnGround, 1
    mov velY, 0
    mov marioOnPlatform, 1
    ; Store plat2 movement
    mov al, plat2Dir
    cmp al, 1
    je P2SetR
    mov platformDeltaX, -1
    jmp NoPlatColl
P2SetR:
    mov platformDeltaX, 1
    jmp NoPlatColl
    
CheckP3:
    mov al, marioY
    cmp al, plat3Y
    jne CheckE1
    mov al, marioX
    cmp al, plat3X
    jl CheckE1
    mov bl, plat3X
    add bl, 7
    cmp al, bl
    jg CheckE1
    mov isOnGround, 1
    mov velY, 0
    mov marioOnPlatform, 1
    ; Store plat3 movement
    mov al, plat3Dir
    cmp al, 1
    je P3SetR
    mov platformDeltaX, -1
    jmp NoPlatColl
P3SetR:
    mov platformDeltaX, 1
    jmp NoPlatColl
    
CheckE1:
    ; Check Elevator 1
    mov al, marioY
    cmp al, elev1Y
    jne CheckE2
    mov al, marioX
    cmp al, elev1X
    jl CheckE2
    mov bl, elev1X
    add bl, 5
    cmp al, bl
    jg CheckE2
    mov isOnGround, 1
    mov velY, 0
    mov marioOnPlatform, 2
    ; Store elevator vertical movement
    mov al, elev1Dir
    cmp al, 1
    je E1SetD
    mov platformDeltaY, -1
    jmp NoPlatColl
E1SetD:
    mov platformDeltaY, 1
    jmp NoPlatColl
    
CheckE2:
    mov al, marioY
    cmp al, elev2Y
    jne NoPlatHit
    mov al, marioX
    cmp al, elev2X
    jl NoPlatHit
    mov bl, elev2X
    add bl, 5
    cmp al, bl
    jg NoPlatHit
    mov isOnGround, 1
    mov velY, 0
    mov marioOnPlatform, 2
    ; Store elevator vertical movement
    mov al, elev2Dir
    cmp al, 1
    je E2SetD
    mov platformDeltaY, -1
    jmp NoPlatColl
E2SetD:
    mov platformDeltaY, 1
    jmp NoPlatColl
    
NoPlatHit:
    mov marioOnPlatform, 0
    
NoPlatColl:
    popad
    ret
CheckPlatformCollision ENDP

;-----------------------------------------------------------
; CheckAllCollisionsL2: Level 2 collision checks
;-----------------------------------------------------------
CheckAllCollisionsL2 PROC
    pushad
    
    call CheckCoinCollisionsL2
    call CheckEnemyCollisionsL2
    call CheckPiranhaCollision
    
    popad
    ret
CheckAllCollisionsL2 ENDP

;-----------------------------------------------------------
; CheckCoinCollisionsL2: Mario collecting L2 coins
;-----------------------------------------------------------
CheckCoinCollisionsL2 PROC
    pushad
    
    mov al, marioX
    mov ah, marioY
    
    ; Coin 1
    cmp L2coin1Active, 0
    je SkipL2CC1
    mov bl, L2coin1X
    mov bh, L2coin1Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2CC1
    mov L2coin1Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL2CC1:
    
    ; Coin 2
    cmp L2coin2Active, 0
    je SkipL2CC2
    mov bl, L2coin2X
    mov bh, L2coin2Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2CC2
    mov L2coin2Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL2CC2:
    
    ; Coin 3
    cmp L2coin3Active, 0
    je SkipL2CC3
    mov bl, L2coin3X
    mov bh, L2coin3Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2CC3
    mov L2coin3Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL2CC3:
    
    ; Coin 4
    cmp L2coin4Active, 0
    je SkipL2CC4
    mov bl, L2coin4X
    mov bh, L2coin4Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2CC4
    mov L2coin4Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL2CC4:
    
    ; Coin 5
    cmp L2coin5Active, 0
    je SkipL2CC5
    mov bl, L2coin5X
    mov bh, L2coin5Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2CC5
    mov L2coin5Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL2CC5:
    
    ; Coin 6
    cmp L2coin6Active, 0
    je SkipL2CC6
    mov bl, L2coin6X
    mov bh, L2coin6Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2CC6
    mov L2coin6Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL2CC6:
    
    ; Coin 7
    cmp L2coin7Active, 0
    je SkipL2CC7
    mov bl, L2coin7X
    mov bh, L2coin7Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2CC7
    mov L2coin7Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL2CC7:
    
    ; Coin 8
    cmp L2coin8Active, 0
    je SkipL2CC8
    mov bl, L2coin8X
    mov bh, L2coin8Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2CC8
    mov L2coin8Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL2CC8:
    
    ; Check 100 coins
    cmp playerCoins, 100
    jl NoL2ExtraLife
    mov playerCoins, 0
    inc playerLives
NoL2ExtraLife:
    
    popad
    ret
CheckCoinCollisionsL2 ENDP

;-----------------------------------------------------------
; CheckEnemyCollisionsL2: Mario vs L2 enemies
;-----------------------------------------------------------
CheckEnemyCollisionsL2 PROC
    pushad
    
    ; Check L2 Goomba 1
    cmp L2goomba1Alive, 0
    je SkipL2EG1
    
    mov al, marioX
    mov ah, marioY
    mov bl, L2goomba1X
    mov bh, L2goomba1Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2EG1
    
    mov al, marioY
    add al, velY
    cmp al, L2goomba1Y
    jge L2MarioHitG1
    
    mov L2goomba1Alive, 0
    add playerScore, 100
    mov velY, -3
    jmp SkipL2EG1
    
L2MarioHitG1:
    call MarioTakeDamage
    
SkipL2EG1:
    
    ; Check L2 Goomba 2
    cmp L2goomba2Alive, 0
    je SkipL2EG2
    
    mov al, marioX
    mov ah, marioY
    mov bl, L2goomba2X
    mov bh, L2goomba2Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL2EG2
    
    mov al, marioY
    add al, velY
    cmp al, L2goomba2Y
    jge L2MarioHitG2
    
    mov L2goomba2Alive, 0
    add playerScore, 100
    mov velY, -3
    jmp SkipL2EG2
    
L2MarioHitG2:
    call MarioTakeDamage
    
SkipL2EG2:
    
    ; Check Red Koopa
    cmp redKoopaAlive, 0
    je SkipL2RedK
    
    mov al, marioX
    mov ah, marioY
    mov bl, redKoopaX
    mov bh, redKoopaY
    call CheckOverlap
    cmp cl, 1
    jne SkipL2RedK
    
    cmp redKoopaIsShell, 1
    jne CheckRedStomp
    cmp redShellMoving, 0
    jne RedShellHit
    
    ; Kick the shell
    mov redShellMoving, 1
    mov al, marioX
    cmp al, redKoopaX
    jl KickRedRight
    mov redShellDir, 0
    jmp SkipL2RedK
KickRedRight:
    mov redShellDir, 1
    jmp SkipL2RedK
    
RedShellHit:
    call MarioTakeDamage
    jmp SkipL2RedK
    
CheckRedStomp:
    mov al, marioY
    add al, velY
    cmp al, redKoopaY
    jge L2MarioHitRedK
    
    mov redKoopaIsShell, 1
    mov redShellMoving, 0
    add playerScore, 100
    mov velY, -3
    jmp SkipL2RedK
    
L2MarioHitRedK:
    call MarioTakeDamage
    
SkipL2RedK:
    
    ; Check Green Koopa (same logic as Level 1)
    cmp koopaAlive, 0
    je SkipL2GreenK
    
    mov al, marioX
    mov ah, marioY
    mov bl, koopaX
    mov bh, koopaY
    call CheckOverlap
    cmp cl, 1
    jne SkipL2GreenK
    
    cmp koopaIsShell, 1
    jne CheckGreenStomp
    cmp shellMoving, 0
    jne GreenShellHit
    
    mov shellMoving, 1
    mov al, marioX
    cmp al, koopaX
    jl KickGreenRight
    mov shellDir, 0
    jmp SkipL2GreenK
KickGreenRight:
    mov shellDir, 1
    jmp SkipL2GreenK
    
GreenShellHit:
    call MarioTakeDamage
    jmp SkipL2GreenK
    
CheckGreenStomp:
    mov al, marioY
    add al, velY
    cmp al, koopaY
    jge L2MarioHitGreenK
    
    mov koopaIsShell, 1
    mov shellMoving, 0
    add playerScore, 100
    mov velY, -3
    jmp SkipL2GreenK
    
L2MarioHitGreenK:
    call MarioTakeDamage
    
SkipL2GreenK:
    
    popad
    ret
CheckEnemyCollisionsL2 ENDP

;-----------------------------------------------------------
; CheckPiranhaCollision: Mario touching Piranha Plants
;-----------------------------------------------------------
CheckPiranhaCollision PROC
    pushad
    
    ; Piranha 1
    cmp piranha1H, 0
    je SkipPir1
    mov al, marioX
    cmp al, 29
    jl SkipPir1
    cmp al, 35
    jg SkipPir1
    mov bl, piranha1Y
    sub bl, piranha1H
    mov al, marioY
    cmp al, bl
    jl SkipPir1
    sub bl, 2
    cmp al, bl
    jg SkipPir1
    call MarioTakeDamage
SkipPir1:
    
    ; Piranha 2
    cmp piranha2H, 0
    je SkipPir2
    mov al, marioX
    cmp al, 49
    jl SkipPir2
    cmp al, 55
    jg SkipPir2
    mov bl, piranha2Y
    sub bl, piranha2H
    mov al, marioY
    cmp al, bl
    jl SkipPir2
    sub bl, 2
    cmp al, bl
    jg SkipPir2
    call MarioTakeDamage
SkipPir2:
    
    ; Piranha 3
    cmp piranha3H, 0
    je SkipPir3
    mov al, marioX
    cmp al, 69
    jl SkipPir3
    cmp al, 75
    jg SkipPir3
    mov bl, piranha3Y
    sub bl, piranha3H
    mov al, marioY
    cmp al, bl
    jl SkipPir3
    sub bl, 2
    cmp al, bl
    jg SkipPir3
    call MarioTakeDamage
SkipPir3:
    
    popad
    ret
CheckPiranhaCollision ENDP

;-----------------------------------------------------------
; CheckBlockCollisionL2: Check L2 question blocks
;-----------------------------------------------------------
CheckBlockCollisionL2 PROC
    pushad
    
    mov al, velY
    cmp al, 0
    jge NoL2BlockHit
    
    ; Check L2 Block 1
    cmp L2qBlock1Hit, 1
    je SkipL2B1
    mov al, marioX
    mov ah, marioY
    mov bl, L2qBlock1X
    mov bh, L2qBlock1Y
    inc bh
    call CheckOverlap
    cmp cl, 1
    jne SkipL2B1
    
    mov L2qBlock1Hit, 1
    mov al, L2qBlock1Item
    call SpawnItem
    mov velY, 1
    jmp NoL2BlockHit
    
SkipL2B1:
    cmp L2qBlock2Hit, 1
    je NoL2BlockHit
    mov al, marioX
    mov ah, marioY
    mov bl, L2qBlock2X
    mov bh, L2qBlock2Y
    inc bh
    call CheckOverlap
    cmp cl, 1
    jne NoL2BlockHit
    
    mov L2qBlock2Hit, 1
    mov al, L2qBlock2Item
    call SpawnItem
    mov velY, 1
    
NoL2BlockHit:
    popad
    ret
CheckBlockCollisionL2 ENDP

;-----------------------------------------------------------
; FlagpoleSlideL2: Level 2 flagpole animation
;-----------------------------------------------------------
FlagpoleSlideL2 PROC
    pushad
    
    call Clrscr
    call DrawLevel2
    
    mov marioX, 92
    mov slideY, 8
    mov flagGrabY, 8      ; Record flag grab position
    
L2SlideLoop:
    call Clrscr
    call DrawLevel2
    call DrawHUD_L2
    
    mov eax, LIGHTBLUE
    call SetTextColor
    
    mov dh, slideY
    mov dl, 91
    call Gotoxy
    mov edx, OFFSET marioSmall1
    call WriteString
    
    inc slideY
    mov dh, slideY
    mov dl, 91
    call Gotoxy
    mov edx, OFFSET marioSmall2
    call WriteString
    
    mov eax, 100
    call Delay
    
    inc slideY
    cmp slideY, 18
    jl L2SlideLoop
    
    call CalculateLevelBonusL2
    call ShowLevelCompleteScreen
    
    popad
    ret
FlagpoleSlideL2 ENDP

;-----------------------------------------------------------
; CalculateLevelBonusL2: Calculate L2 bonuses
;-----------------------------------------------------------
CalculateLevelBonusL2 PROC
    ; Flag position bonus based on flagGrabY
    mov al, flagGrabY
    cmp al, 9
    jg MidFlag
    mov eax, 5000      ; Top flag
    jmp L2BonusDone
MidFlag:
    cmp al, 14
    jg BottomFlag
    mov eax, 2000      ; Middle
    jmp L2BonusDone
BottomFlag:
    mov eax, 100       ; Bottom
L2BonusDone:
    mov marioFlagBonus, eax
    add playerScore, eax
    
    ; Time bonus: 50 points per second
    movzx eax, gameTime
    imul eax, eax, 50
    mov marioTimeBonus, eax
    add playerScore, eax
    
    ; Check for fireworks (time ends in 1, 3, or 6)
    movzx eax, gameTime
    mov ebx, 10
    xor edx, edx
    div ebx
    ; edx now has remainder (last digit)
    cmp dl, 1
    je AddFireworks
    cmp dl, 3
    je AddFireworks
    cmp dl, 6
    je AddFireworks
    jmp NoFW
    
AddFireworks:
    add playerScore, 1500    ; 3 fireworks × 500
    
NoFW:
    ret
CalculateLevelBonusL2 ENDP


;-----------------------------------------------------------
; DrawHUD: Draw score, coins, world, time, lives
;-----------------------------------------------------------
DrawHUD PROC
    pushad
    mov edx, OFFSET worldNum
    call DrawHUD_Generic
    popad
    ret
DrawHUD ENDP

;-----------------------------------------------------------
; DrawHUD_Generic: HUD with variable world number string in EDX
;-----------------------------------------------------------
DrawHUD_Generic PROC
    pushad
    push edx        ; Save world number offset
    
    ; Set border color
    mov eax, WHITE
    call SetTextColor
    
    ; Row 0: Top Border
    mov dh, 0
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET hudBorderTop
    call WriteString
    
    ; Row 1: Side Borders
    mov dh, 1
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET hudBorderSides
    call WriteString
    
    ; Row 2: Side Borders
    mov dh, 2
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET hudBorderSides
    call WriteString
    
    ; Row 3: Bottom Border
    mov dh, 3
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET hudBorderBot
    call WriteString
    
    ; --- DRAW HUD LABELS (Row 1) ---
    ; MARIO label
    mov dh, 1
    mov dl, 4
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET hudMario
    call WriteString
    
    ; COINS label/icon
    mov dh, 1
    mov dl, 27
    call Gotoxy
    mov eax, YELLOW
    call SetTextColor
    mov al, 'o'
    call WriteChar
    mov edx, OFFSET hudCoins
    call WriteString
    
    ; WORLD label
    mov dh, 1
    mov dl, 47
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET hudWorld
    call WriteString
    
    ; TIME label (dynamic color)
    mov dh, 1
    mov dl, 67
    call Gotoxy
    cmp turboActive, 0
    je NormalTimeColor
    mov eax, LIGHTCYAN
    jmp SetTimeColor
NormalTimeColor:
    mov eax, WHITE
SetTimeColor:
    call SetTextColor
    mov edx, OFFSET hudTime
    call WriteString
    
    ; LIVES label
    mov dh, 1
    mov dl, 84
    call Gotoxy
    mov eax, LIGHTRED
    call SetTextColor
    mov al, 'M'
    call WriteChar
    mov edx, OFFSET hudLives
    call WriteString
    
    ; --- DRAW HUD VALUES (Row 2) ---
    ; Score
    mov dh, 2
    mov dl, 4
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov eax, playerScore
    call WriteDec
    
    ; Coin Count
    mov dh, 2
    mov dl, 29
    call Gotoxy
    movzx eax, playerCoins
    call WriteDec
    
    ; World Number (Restore from stack)
    mov dh, 2
    mov dl, 48
    call Gotoxy
    pop edx
    call WriteString
    
    ; Time Value
    mov dh, 2
    mov dl, 68
    call Gotoxy
    movzx eax, gameTime
    call WriteDec
    
    ; Lives Count
    mov dh, 2
    mov dl, 87
    call Gotoxy
    movzx eax, playerLives
    call WriteDec
    
    ; --- DRAW BULLET TIME METER (Row 4) ---
    mov dh, 4
    mov dl, 4
    call Gotoxy
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET bulletTimeLabel
    call WriteString
    
    ; Draw bar based on slowMotionMeter (0-100)
    ; Each '|' in powerBarFull is 10 units
    movzx eax, slowMotionMeter
    xor edx, edx
    mov ebx, 10
    div ebx             ; AL = full bars (0-10)
    
    movzx ecx, al       ; Full bars
    cmp ecx, 0
    je LDrawDots
LDrawFullBars:
    mov al, '|'
    call WriteChar
    loop LDrawFullBars
    
LDrawDots:
    movzx eax, slowMotionMeter
    xor edx, edx
    mov ebx, 10
    div ebx
    mov ecx, 10
    sub cl, al          ; how many dots
    jz HudDone
LDrawDotsLoop:
    mov al, '.'
    call WriteChar
    loop LDrawDotsLoop
    
HudDone:
    popad
    ret
DrawHUD_Generic ENDP

;-----------------------------------------------------------
; DrawMario: Render Mario sprite at current position
;-----------------------------------------------------------
DrawMario PROC
    pushad
    
    ; Check for Bullet Time color override
    cmp slowMotionActive, 1
    jne CheckInvincible
    mov eax, LIGHTCYAN
    jmp DrawMarioSprite

CheckInvincible:
    ; First check for Star Invincibility color cycling
    cmp marioInvincible, 0
    je NormalColors
    
    ; Star color cycling (existing logic)
    inc starFlashTimer
    cmp starFlashTimer, 3
    jl ApplyStarColor
    mov starFlashTimer, 0
    inc starFlashColor
    cmp starFlashColor, 5
    jl ApplyStarColor
    mov starFlashColor, 0
    
ApplyStarColor:
    movzx eax, starFlashColor
    cmp al, 0
    je Color1
    cmp al, 2
    je Color3
    cmp al, 3
    je Color4
    mov eax, WHITE
    jmp DrawMarioSprite
Color1: mov eax, LIGHTBLUE      ; Changed from LIGHTRED
    jmp DrawMarioSprite
Color3: mov eax, LIGHTGREEN
    jmp DrawMarioSprite
Color4: mov eax, LIGHTCYAN
    jmp DrawMarioSprite

NormalColors:
    cmp marioState, 2
    je FireMarioColor
    cmp marioState, 1
    je SuperMarioColor
    
    ; Small Mario - Blue (Requested Change)
    mov eax, LIGHTBLUE
    jmp DrawMarioSprite
    
SuperMarioColor:
    mov eax, YELLOW
    jmp DrawMarioSprite
    
FireMarioColor:
    mov eax, WHITE
    
DrawMarioSprite:
    call SetTextColor
    
    ; Draw head
    cmp marioState, 0
    jne DrawSuperHead
    
    ; Small Mario Head
    movzx edx, marioY
    dec edx
    mov dh, dl
    mov dl, marioX
    call Gotoxy
    mov edx, OFFSET marioSmall1
    call WriteString
    jmp DrawBodyPart

DrawSuperHead:
    ; Super Mario Head (row -2)
    movzx edx, marioY
    sub edx, 2
    mov dh, dl
    mov dl, marioX
    dec dl
    call Gotoxy
    mov edx, OFFSET marioSuper1
    call WriteString
    
DrawBodyPart:
    ; Draw Torso (row -1 for super, row 0 for small)
    movzx eax, marioY
    mov dl, marioX
    cmp marioState, 0
    je SmallBodyPart
    
    ; Super Torso
    dec eax
    mov dh, al
    mov dl, marioX
    dec dl
    call Gotoxy
    mov edx, OFFSET marioSuper2
    call WriteString
    
    ; Super Legs (row 0)
    movzx eax, marioY
    mov dh, al
    mov dl, marioX
    call Gotoxy
    mov edx, OFFSET marioSuper3
    call WriteString
    jmp DrawDone

SmallBodyPart:
    mov dh, al
    mov dl, marioX
    call Gotoxy
    mov edx, OFFSET marioSmall2
    call WriteString

DrawDone:
    popad
    ret
DrawMario ENDP

;-----------------------------------------------------------
; DrawEnemies: Render all active enemies
;-----------------------------------------------------------
DrawEnemies PROC
    pushad
    
    ; Draw Goomba 1
    cmp goombaAlive, 0
    je SkipGoomba1
    
    mov eax, BROWN
    call SetTextColor
    mov dh, goombaY
    mov dl, goombaX
    call Gotoxy
    mov edx, OFFSET goombaChar
    call WriteString
    
SkipGoomba1:
    ; Draw Goomba 2
    cmp goomba2Alive, 0
    je SkipGoomba2
    
    mov eax, BROWN
    call SetTextColor
    mov dh, goomba2Y
    mov dl, goomba2X
    call Gotoxy
    mov edx, OFFSET goombaChar
    call WriteString
    
SkipGoomba2:
    ; Draw Goomba 3
    cmp goomba3Alive, 0
    je SkipGoomba3
    
    mov eax, BROWN
    call SetTextColor
    mov dh, goomba3Y
    mov dl, goomba3X
    call Gotoxy
    mov edx, OFFSET goombaChar
    call WriteString
    
SkipGoomba3:
    ; Draw Koopa (or shell)
    cmp koopaAlive, 0
    je SkipKoopa
    
    mov eax, LIGHTGREEN
    call SetTextColor
    mov dh, koopaY
    mov dl, koopaX
    call Gotoxy
    
    cmp koopaIsShell, 0
    je DrawKoopaTurtle
    mov edx, OFFSET koopaShell
    jmp DrawKoopaSprite
    
DrawKoopaTurtle:
    mov edx, OFFSET koopaChar
    
DrawKoopaSprite:
    call WriteString
    
SkipKoopa:
    popad
    ret
DrawEnemies ENDP

;-----------------------------------------------------------
; DrawCoins: Render collectible coins
;-----------------------------------------------------------
DrawCoins PROC
    pushad
    
    mov eax, YELLOW
    call SetTextColor
    
    ; Coin 1
    cmp coin1Active, 0
    je SkipCoin1
    mov dh, coin1Y
    mov dl, coin1X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipCoin1:
    
    ; Coin 2
    cmp coin2Active, 0
    je SkipCoin2
    mov dh, coin2Y
    mov dl, coin2X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipCoin2:
    
    ; Coin 3
    cmp coin3Active, 0
    je SkipCoin3
    mov dh, coin3Y
    mov dl, coin3X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipCoin3:
    
    ; Coin 4
    cmp coin4Active, 0
    je SkipCoin4
    mov dh, coin4Y
    mov dl, coin4X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipCoin4:
    
    ; Coin 5
    cmp coin5Active, 0
    je SkipCoin5
    mov dh, coin5Y
    mov dl, coin5X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipCoin5:
    
    popad
    ret
DrawCoins ENDP

;-----------------------------------------------------------
; HandleInput: Process keyboard input for Mario movement
;-----------------------------------------------------------
HandleInput PROC
    pushad
    
    mov horizontalInputActive, 0 ; Reset flag before processing keys
    
    ; Check if key is pressed
    call ReadKey
    jz NoKeyThisFrame
    
    ; --- Handle Horizontal Input ---
    cmp al, 'a'
    je MoveLeftInput
    cmp al, 'A'
    je MoveLeftInput
    cmp ah, 75       ; Left arrow key scancode
    je MoveLeftInput
    
    cmp al, 'd'
    je MoveRightInput
    cmp al, 'D'
    je MoveRightInput
    cmp ah, 77       ; Right arrow key scancode
    je MoveRightInput
    
    ; --- Handle Running ---
    cmp al, 'r'      ; Toggle 'R' for now, but also allow holding Shift if possible
    je ToggleRun
    cmp al, 'R'
    je ToggleRun
    
    ; Note: For true "Hold to run", we need to check GetKeyState(VK_SHIFT)
    
    ; --- Handle Jumping ---
    cmp al, 'w'
    je StartJump
    cmp al, 'W'
    je StartJump
    cmp al, ' '
    je StartJump
    
    ; --- Handle Fireball ---
    cmp al, 'f'
    je ShootFire
    cmp al, 'F'
    je ShootFire
    
    ; --- Handle Bullet Time (Creative Feature) ---
    cmp ah, 15       ; TAB key scancode
    je ToggleBulletTime
    
    ; --- Other Keys ---
    cmp al, 27       ; ESC key
    je L1_Pause
    cmp al, 'q'
    je L1_Quit
    cmp al, 'Q'
    je L1_Quit
    
    jmp NoKeyThisFrame

ToggleBulletTime:
    ; Don't allow activating if meter is too low
    cmp slowMotionActive, 0
    jne DeactivateBT
    cmp slowMotionMeter, 10
    jl NoKeyThisFrame
    mov slowMotionActive, 1
    jmp NoKeyThisFrame
DeactivateBT:
    mov slowMotionActive, 0
    jmp NoKeyThisFrame

L1_Pause:
    call ShowPauseMenu
    jmp NoKeyThisFrame

L1_Quit:
    mov gameRunning, 0
    jmp NoKeyThisFrame

ShootFire:
    call ProcessFireballInput
    jmp NoKeyThisFrame

MoveLeftInput:
    mov horizontalInputActive, 1
    mov al, ACCEL_X
    cmp isOnGround, 0
    jne L1_GAL
    shr al, 1
    jnz L1_GAL
    mov al, 1
L1_GAL:
    sub velX, al
    jmp ApplyMaxLeft

MoveRightInput:
    mov horizontalInputActive, 1
    mov al, ACCEL_X
    cmp isOnGround, 0
    jne L1_GAR
    shr al, 1
    jnz L1_GAR
    mov al, 1
L1_GAR:
    add velX, al
    jmp ApplyMaxRight

ToggleRun:
    xor byte ptr isRunning, 1
    jmp NoKeyThisFrame

StartJump:
    cmp isOnGround, 0
    je NoKeyThisFrame
    mov isOnGround, 0
    mov isJumping, 1
    mov edx, OFFSET sndJump
    call PlaySoundEffect
    mov jumpTime, 0
    mov al, JUMP_POWER
    mov velY, al
    jmp NoKeyThisFrame

ApplyMaxLeft:
    mov bl, MAX_WALK_SPEED
    cmp isRunning, 1
    jne L1_CML
    mov bl, MAX_RUN_SPEED
L1_CML:
    neg bl
    cmp velX, bl
    jge NoKeyThisFrame
    mov velX, bl
    jmp NoKeyThisFrame

ApplyMaxRight:
    mov bl, MAX_WALK_SPEED
    cmp isRunning, 1
    jne L1_CMR
    mov bl, MAX_RUN_SPEED
L1_CMR:
    cmp velX, bl
    jle NoKeyThisFrame
    mov velX, bl
    jmp NoKeyThisFrame

PauseGame:
    call ShowPauseMenu
    jmp NoKeyThisFrame

QuitGame:
    mov gameRunning, 0
    jmp NoKeyThisFrame

NoKeyThisFrame:
    ; If no horizontal key was pressed, velX will be handled by friction in UpdateMarioPhysics
    popad
    ret
HandleInput ENDP

;-----------------------------------------------------------
; UpdateMarioPhysics: Apply gravity, handle jumping
;-----------------------------------------------------------
UpdateMarioPhysics PROC
    pushad
    
    ; --- Apply Horizontal Deceleration (Friction) ---
    cmp horizontalInputActive, 1
    je StaticX       ; Skip friction if actively moving
    
    cmp velX, 0
    je StaticX
    jg DecelRight
    
    ; velX is negative (moving left)
    inc velX         ; Decelerate toward 0
    jmp StaticX
DecelRight:
    dec velX         ; Decelerate toward 0
StaticX:

    ; --- Apply velX to marioX ---
    mov al, velX
    add marioX, al
    
    ; Boundaries - Use AL for signed check to prevent underflow teleportation
    movsx eax, marioX ; Treat BYTE as potentially signed for underflow check
    cmp eax, 2
    jge CheckRightBound
    mov marioX, 2
    mov velX, 0
    jmp BoundsDone
CheckRightBound:
    cmp eax, 95
    jle CheckPipeCol
    mov marioX, 95
    mov velX, 0
    jmp BoundsDone

CheckPipeCol:
    ; Quick pipe collision check
    mov al, marioX
    mov cl, marioY
    call CheckPipeCollisionAt
    cmp al, 0
    je BoundsDone
    ; Hit a pipe!
    mov al, velX
    sub marioX, al ; Roll back
    mov velX, 0

BoundsDone:
    ; Check for flagpole reached
    cmp marioX, 75
    jl VerticalPhysics
    mov marioOnPole, 1

VerticalPhysics:
    ; --- Handle Vertical Movement ---
    cmp isOnGround, 1
    jne ApplyGravity
    
    ; Mario is on ground. Check if he should stay there (edge detection)
    mov al, marioX
    mov cl, marioY
    call CheckSupportAt
    cmp al, 1
    je PhysicsDoneL1     ; Still supported
    mov isOnGround, 0    ; Walked off an edge!
    
ApplyGravity:
    ; Variable Jump Height: If isJumping and space still held, reduce gravity
    cmp isJumping, 1
    jne NormalGravity
    
    ; Check if space is still held (requires GetKeyState or assuming it's held if we got here)
    ; But ReadKey only fires once per frame. 
    ; Let's use jumpTime to simulate a fixed "boost" window for now
    inc jumpTime
    mov al, MAX_JUMP_TIME ; use 10-15 frames
    cmp jumpTime, al
    jg StopJumpBoost
    
    ; While boosting, gravity is partially offset
    ; (or we just don't apply it yet)
    jmp ApplyVelY

StopJumpBoost:
    mov isJumping, 0
NormalGravity:
    mov al, GRAVITY
    add velY, al
    
    ; Cap at terminal velocity
    mov al, velY
    cmp al, MAX_FALL_SPEED
    jle ApplyVelY
    mov al, MAX_FALL_SPEED
    mov velY, al
    
ApplyVelY:
    mov al, velY
    add marioY, al
    
    ; Check support collision (landing on surfaces)
    mov al, marioX
    mov cl, marioY
    call CheckSupportAt
    cmp al, 1
    jne CheckBaseGround
    
    ; Landed on a platform!
    mov isOnGround, 1
    mov isJumping, 0
    mov velY, 0
    jmp PhysicsDoneL1

CheckBaseGround:
    ; Check ground collision
    mov al, marioY
    cmp al, GROUND_LEVEL
    jl CheckCeil
    
    ; Hit ground
    mov al, GROUND_LEVEL
    mov marioY, al
    mov isOnGround, 1
    mov isJumping, 0
    mov velY, 0
    jmp PhysicsDoneL1
    
CheckCeil:
    mov al, CEILING_LIMIT
    cmp marioY, al
    jg PhysicsDoneL1
    mov marioY, al
    mov velY, 1      ; Bounce down
    
PhysicsDoneL1:
    ; --- Handle Star Power Timer ---
    cmp marioInvincible, 0
    je PhysicsEndL1
    
    dec word ptr marioStarTimer
    cmp word ptr marioStarTimer, 0
    jg PhysicsEndL1
    mov marioInvincible, 0   ; Star expired
    mov turboActive, 0
    
PhysicsEndL1:
    popad
    ret
UpdateMarioPhysics ENDP

;-----------------------------------------------------------
; UpdateGoombas: Move goombas, handle direction changes
;-----------------------------------------------------------
UpdateGoombas PROC
    pushad
    
    ; Goomba 1
    cmp goombaAlive, 0
    je SkipG1Update
    
    cmp goombaDir, 1
    je G1MoveRight
    
    ; Move left
    dec goombaX
    cmp goombaX, 2
    jg G1CheckPipe
    mov goombaDir, 1     ; Turn around
    jmp SkipG1Update
    
G1MoveRight:
    inc goombaX
    cmp goombaX, 85
    jl G1CheckPipe
    mov goombaDir, 0     ; Turn around
    jmp SkipG1Update
    
G1CheckPipe:
    ; Check if hitting a pipe
    mov al, goombaX
    cmp al, 28
    jl SkipG1Update
    cmp al, 32
    jg CheckPipe2G1
    ; At pipe 1
    xor goombaDir, 1     ; Reverse direction
    jmp SkipG1Update
    
CheckPipe2G1:
    cmp al, 40
    jl SkipG1Update
    cmp al, 44
    jg CheckPipe3G1
    xor goombaDir, 1
    jmp SkipG1Update
    
CheckPipe3G1:
    cmp al, 52
    jl SkipG1Update
    cmp al, 56
    jg SkipG1Update
    xor goombaDir, 1
    
SkipG1Update:
    
    ; Goomba 2
    cmp goomba2Alive, 0
    je SkipG2Update
    
    cmp goomba2Dir, 1
    je G2MoveRight
    
    dec goomba2X
    cmp goomba2X, 2
    jg SkipG2Update
    mov goomba2Dir, 1
    jmp SkipG2Update
    
G2MoveRight:
    inc goomba2X
    cmp goomba2X, 27     ; Stop before pipe
    jl SkipG2Update
    mov goomba2Dir, 0
    
SkipG2Update:
    
    ; Goomba 3
    cmp goomba3Alive, 0
    je SkipG3Update
    
    cmp goomba3Dir, 1
    je G3MoveRight
    
    dec goomba3X
    cmp goomba3X, 45     ; Stop at pipe
    jg SkipG3Update
    mov goomba3Dir, 1
    jmp SkipG3Update
    
G3MoveRight:
    inc goomba3X
    cmp goomba3X, 51     ; Stop before pipe
    jl SkipG3Update
    mov goomba3Dir, 0
    
SkipG3Update:
    
    popad
    ret
UpdateGoombas ENDP

;-----------------------------------------------------------
; UpdateKoopas: Move koopa, handle shell mechanics
;-----------------------------------------------------------
UpdateKoopas PROC
    pushad
    
    cmp koopaAlive, 0
    je SkipKoopaUpdate
    
    ; Is it a shell?
    cmp koopaIsShell, 1
    je UpdateShell
    
    ; Normal koopa movement  
    cmp koopaDir, 1
    je KMoveRight
    
    ; Move left
    dec koopaX
    cmp koopaX, 30       ; Generic boundary check
    jg SkipKoopaUpdate
    mov koopaDir, 1
    jmp SkipKoopaUpdate
    
KMoveRight:
    inc koopaX
    cmp koopaX, 90
    jl SkipKoopaUpdate
    mov koopaDir, 0
    jmp SkipKoopaUpdate
    
UpdateShell:
    cmp shellMoving, 0
    je SkipKoopaUpdate
    
    cmp shellDir, 1
    je ShellRight
    
    ; Shell moving left
    sub koopaX, 3
    cmp koopaX, 2
    jg ShellCheckCollisions
    mov koopaX, 2
    mov shellDir, 1      ; Bounce
    jmp ShellCheckCollisions
    
ShellRight:
    add koopaX, 3
    cmp koopaX, 95
    jl ShellCheckCollisions
    mov koopaX, 95
    mov shellDir, 0      ; Bounce

ShellCheckCollisions:
    ; Moving shell kills other enemies
    mov al, koopaX
    mov ah, koopaY
    
    ; Check Goomba 1
    cmp goombaAlive, 0
    je SCheckG2
    mov bl, goombaX
    mov bh, goombaY
    call CheckOverlap
    cmp cl, 1
    jne SCheckG2
    mov goombaAlive, 0
    call AddComboPoints
    
SCheckG2:
    ; Check Goomba 2
    cmp goomba2Alive, 0
    je SkipKoopaUpdate
    mov bl, goomba2X
    mov bh, goomba2Y
    call CheckOverlap
    cmp cl, 1
    jne SkipKoopaUpdate
    mov goomba2Alive, 0
    call AddComboPoints

SkipKoopaUpdate:
    popad
    ret
UpdateKoopas ENDP

;-----------------------------------------------------------
; CheckAllCollisions: Check Mario collisions with everything
;-----------------------------------------------------------
CheckAllCollisions PROC
    pushad
    
    ; Check coin collisions
    call CheckCoinCollisions
    
    ; Check enemy collisions
    call CheckEnemyCollisions
    
    popad
    ret
CheckAllCollisions ENDP

;-----------------------------------------------------------
; CheckCoinCollisions: Mario collecting coins
;-----------------------------------------------------------
CheckCoinCollisions PROC
    pushad
    
    mov al, marioX
    mov ah, marioY
    
    ; Check coin 1
    cmp coin1Active, 0
    je SkipC1
    mov bl, coin1X
    mov bh, coin1Y
    call CheckOverlap
    cmp cl, 1
    jne SkipC1
    mov coin1Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
    push edx
    mov edx, OFFSET sndCoin
    call PlaySoundEffect
    pop edx
SkipC1:
    
    ; Check coin 2
    cmp coin2Active, 0
    je SkipC2
    mov bl, coin2X
    mov bh, coin2Y
    call CheckOverlap
    cmp cl, 1
    jne SkipC2
    mov coin2Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipC2:
    
    ; Check coin 3
    cmp coin3Active, 0
    je SkipC3
    mov bl, coin3X
    mov bh, coin3Y
    call CheckOverlap
    cmp cl, 1
    jne SkipC3
    mov coin3Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipC3:
    
    ; Check coin 4
    cmp coin4Active, 0
    je SkipC4
    mov bl, coin4X
    mov bh, coin4Y
    call CheckOverlap
    cmp cl, 1
    jne SkipC4
    mov coin4Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipC4:
    
    ; Check coin 5
    cmp coin5Active, 0
    je SkipC5
    mov bl, coin5X
    mov bh, coin5Y
    call CheckOverlap
    cmp cl, 1
    jne SkipC5
    mov coin5Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipC5:
    
    ; Check for 100 coins = 1UP
    cmp playerCoins, 100
    jl NoExtraLife
    mov playerCoins, 0
    inc playerLives
NoExtraLife:
    
    popad
    ret
CheckCoinCollisions ENDP

;-----------------------------------------------------------
; CheckEnemyCollisions: Mario vs enemies
;-----------------------------------------------------------
CheckEnemyCollisions PROC
    pushad
    
    ; --- Check Goomba 1 ---
    cmp goombaAlive, 0
    je SkipEG1
    mov al, marioX
    mov ah, marioY
    mov bl, goombaX
    mov bh, goombaY
    call CheckOverlap
    cmp cl, 1
    jne SkipEG1
    
    cmp marioInvincible, 1
    je StarKillG1
    
    mov al, marioY
    add al, velY
    cmp al, goombaY
    jge MarioHitG1
    
    mov goombaAlive, 0
    add playerScore, 100
    mov velY, -3
    push edx
    mov edx, OFFSET sndStomp
    call PlaySoundEffect
    pop edx
    jmp SkipEG1
StarKillG1:
    mov goombaAlive, 0
    add playerScore, 200
    jmp SkipEG1
MarioHitG1:
    call MarioTakeDamage
SkipEG1:

    ; --- Check Goomba 2 ---
    cmp goomba2Alive, 0
    je SkipEG2
    mov al, marioX
    mov ah, marioY
    mov bl, goomba2X
    mov bh, goomba2Y
    call CheckOverlap
    cmp cl, 1
    jne SkipEG2
    
    cmp marioInvincible, 1
    je StarKillG2
    
    mov al, marioY
    add al, velY
    cmp al, goomba2Y
    jge MarioHitG2
    
    mov goomba2Alive, 0
    add playerScore, 100
    mov velY, -3
    jmp SkipEG2
StarKillG2:
    mov goomba2Alive, 0
    add playerScore, 200
    jmp SkipEG2
MarioHitG2:
    call MarioTakeDamage
SkipEG2:

    ; --- Check Goomba 3 ---
    cmp goomba3Alive, 0
    je SkipEG3
    mov al, marioX
    mov ah, marioY
    mov bl, goomba3X
    mov bh, goomba3Y
    call CheckOverlap
    cmp cl, 1
    jne SkipEG3
    
    cmp marioInvincible, 1
    je StarKillG3
    
    mov al, marioY
    add al, velY
    cmp al, goomba3Y
    jge MarioHitG3
    
    mov goomba3Alive, 0
    add playerScore, 100
    mov velY, -3
    jmp SkipEG3
StarKillG3:
    mov goomba3Alive, 0
    add playerScore, 200
    jmp SkipEG3
MarioHitG3:
    call MarioTakeDamage
SkipEG3:

    ; --- Check Koopa ---
    cmp koopaAlive, 0
    je SkipEK
    mov al, marioX
    mov ah, marioY
    mov bl, koopaX
    mov bh, koopaY
    call CheckOverlap
    cmp cl, 1
    jne SkipEK
    
    cmp marioInvincible, 1
    je StarKillK
    
    cmp koopaIsShell, 1
    jne NormalKoopaHit
    
    ; It's a shell
    cmp shellMoving, 0
    jne MovingShellHit
    
    ; Stationary shell: Kick it!
    mov shellMoving, 1
    mov killCombo, 0 ; Reset combo on new kick
    push edx
    mov edx, OFFSET sndKick
    call PlaySoundEffect
    pop edx
    mov al, marioX
    cmp al, koopaX
    jl KickKRight
    mov shellDir, 0 ; Left
    jmp SkipEK
KickKRight:
    mov shellDir, 1 ; Right
    jmp SkipEK

MovingShellHit:
    ; Check if Mario is stomp-kicking it (changing direction)
    mov al, marioY
    add al, velY
    cmp al, koopaY
    jge MarioHitByShell
    ; Stomp kick!
    mov velY, -3
    xor shellDir, 1 ; Reverse direction
    mov killCombo, 0
    jmp SkipEK

MarioHitByShell:
    call MarioTakeDamage
    jmp SkipEK

NormalKoopaHit:
    mov al, marioY
    add al, velY
    cmp al, koopaY
    jge MarioHitByKoopa
    ; Stomp! Make into shell
    mov koopaIsShell, 1
    mov shellMoving, 0
    add playerScore, 100
    mov velY, -3
    jmp SkipEK
StarKillK:
    mov koopaAlive, 0
    add playerScore, 200
    jmp SkipEK
MarioHitByKoopa:
    call MarioTakeDamage
SkipEK:
    popad
    ret
CheckEnemyCollisions ENDP

;-----------------------------------------------------------
; AddComboPoints: Multi-kill shell scoring (100, 200, 400, 800)
;-----------------------------------------------------------
AddComboPoints PROC
    inc killCombo
    cmp killCombo, 1
    je P1c
    cmp killCombo, 2
    je P2c
    cmp killCombo, 3
    je P4c
    add playerScore, 800
    ret
P1c: add playerScore, 100
    ret
P2c: add playerScore, 200
    ret
P4c: add playerScore, 400
    ret
AddComboPoints ENDP

;-----------------------------------------------------------
; CheckOverlap: Check if (AL,AH) overlaps with (BL,BH)
; Returns CL=1 if overlap, CL=0 otherwise
;-----------------------------------------------------------
CheckOverlap PROC
    ; Check X overlap (within 2 chars)
    mov cl, al
    sub cl, bl
    add cl, 2
    cmp cl, 4
    ja NoOverlapFound
    
    ; Check Y overlap (within 2 chars)
    mov cl, ah
    sub cl, bh
    add cl, 2
    cmp cl, 4
    ja NoOverlapFound
    
    mov cl, 1
    ret
    
NoOverlapFound:
    mov cl, 0
    ret
CheckOverlap ENDP

;-----------------------------------------------------------
; CheckPipeCollisionAt: Check if position (AL, CL) hits a pipe
; Returns AL=1 if collision, AL=0 otherwise
;-----------------------------------------------------------
CheckPipeCollisionAt PROC
    push bx
    push dx
    
    mov bl, al       ; X position
    mov bh, cl       ; Y position
    
    ; Pipe 1 at X=28-31, Y=17-19
    cmp bl, 28
    jl CheckPipe2
    cmp bl, 32
    jg CheckPipe2
    cmp bh, 17
    jl CheckPipe2
    mov al, 1
    jmp PipeCheckDone
    
CheckPipe2:
    ; Pipe 2 at X=40-43, Y=16-19
    cmp bl, 40
    jl CheckPipe3Here
    cmp bl, 44
    jg CheckPipe3Here
    cmp bh, 16
    jl CheckPipe3Here
    mov al, 1
    jmp PipeCheckDone
    
CheckPipe3Here:
    ; Pipe 3 at X=52-55, Y=15-19
    cmp bl, 52
    jl NoPipeHit
    cmp bl, 56
    jg NoPipeHit
    cmp bh, 15
    jl NoPipeHit
    mov al, 1
    jmp PipeCheckDone
    
NoPipeHit:
    mov al, 0
    
PipeCheckDone:
    pop dx
    pop bx
    ret
CheckPipeCollisionAt ENDP

;-----------------------------------------------------------
; CheckSupportAt: Check if Mario is supported by ground or platforms
; AL = X, CL = Y (Feet position)
; Returns AL=1 if supported, AL=0 otherwise
;-----------------------------------------------------------
CheckSupportAt PROC
    push bx
    push cx
    
    mov bl, al       ; X
    mov bh, cl       ; Y
    
    ; 1. Base Ground Support
    cmp bh, GROUND_LEVEL
    jge IsSupp
    
    ; 2. Pipe Support (Width 4)
    ; Pipe 1 (X=28-31, Top=17) -> Feet at 16
    cmp bl, 28
    jl S_P2
    cmp bl, 31
    jg S_P2
    cmp bh, 16
    je IsSupp
    
S_P2:
    ; Pipe 2 (X=40-43, Top=16) -> Feet at 15
    cmp bl, 40
    jl S_P3
    cmp bl, 43
    jg S_P3
    cmp bh, 15
    je IsSupp
    
S_P3:
    ; Pipe 3 (X=52-55, Top=15) -> Feet at 14
    cmp bl, 52
    jl S_Steps
    cmp bl, 55
    jg S_Steps
    cmp bh, 14
    je IsSupp
    
S_Steps:
    ; Steps (Width depends on brickBlock length which is 3)
    ; Step 1 (X=62, Top=19) -> Feet at 18
    cmp bl, 62
    jl S_Step2
    cmp bl, 64       ; 62 + 2
    jg S_Step2
    cmp bh, 18
    je IsSupp
    
S_Step2:
    ; Step 2 (X=65, Top=18) -> Feet at 17
    cmp bl, 65
    jl S_Step3
    cmp bl, 67
    jg S_Step3
    cmp bh, 17
    je IsSupp
    
S_Step3:
    ; Step 3 (X=68, Top=17) -> Feet at 16
    cmp bl, 68
    jl S_Step4
    cmp bl, 70
    jg S_Step4
    cmp bh, 16
    je IsSupp
    
S_Step4:
    ; Step 4 (X=71, Top=16) -> Feet at 15
    cmp bl, 71
    jl S_Blocks
    cmp bl, 73
    jg S_Blocks
    cmp bh, 15
    je IsSupp

S_Blocks:
    ; Standard Blocks (Row 14, Width 3) -> Feet at 13
    cmp bh, 13
    jne NotSupp
    
    ; Question Blocks: X=16, 21, 78
    cmp bl, 16
    jl S_Q2
    cmp bl, 18
    jg S_Q2
    je IsSupp
S_Q2:
    cmp bl, 21
    jl S_Q3
    cmp bl, 23
    jg S_Q3
    je IsSupp
S_Q3:
    cmp bl, 78
    jl S_B1
    cmp bl, 80
    jg S_B1
    je IsSupp
    
S_B1:
    ; Brick Blocks: X=24, 27
    cmp bl, 24
    jl S_B2
    cmp bl, 26
    jg S_B2
    je IsSupp
S_B2:
    cmp bl, 27
    jl NotSupp
    cmp bl, 29
    jg NotSupp
    je IsSupp

NotSupp:
    mov al, 0
    jmp S_Done
IsSupp:
    mov al, 1
S_Done:
    pop cx
    pop bx
    ret
CheckSupportAt ENDP

;-----------------------------------------------------------
; CheckSupportAtL2: Check Level 2 platform support
; AL = X, CL = Y (Feet position)
; Returns AL=1 if supported, AL=0 otherwise
;-----------------------------------------------------------
CheckSupportAtL2 PROC
    push bx
    push dx
    
    mov bl, al       ; X
    mov bh, cl       ; Y
    
    ; 1. Underground Ground (Y=17)
    cmp bh, 17
    jge L2IsSupp
    
    ; 2. Moving Platform 1 (Width 7)
    mov al, plat1Y
    cmp bh, al
    jne L2CheckPlat2
    mov al, plat1X
    cmp bl, al
    jl L2CheckPlat2
    add al, 6         ; Platform width
    cmp bl, al
    jg L2CheckPlat2
    jmp L2IsSupp
    
L2CheckPlat2:
    ; Platform 2
    mov al, plat2Y
    cmp bh, al
    jne L2CheckPlat3
    mov al, plat2X
    cmp bl, al
    jl L2CheckPlat3
    add al, 6
    cmp bl, al
    jg L2CheckPlat3
    jmp L2IsSupp
    
L2CheckPlat3:
    ; Platform 3
    mov al, plat3Y
    cmp bh, al
    jne L2CheckElev1
    mov al, plat3X
    cmp bl, al
    jl L2CheckElev1
    add al, 6
    cmp bl, al
    jg L2CheckElev1
    jmp L2IsSupp
    
L2CheckElev1:
    ; Elevator 1 (Width 5)
    mov al, elev1Y
    cmp bh, al
    jne L2CheckElev2
    mov al, elev1X
    cmp bl, al
    jl L2CheckElev2
    add al, 4
    cmp bl, al
    jg L2CheckElev2
    jmp L2IsSupp
    
L2CheckElev2:
    ; Elevator 2
    mov al, elev2Y
    cmp bh, al
    jne L2NotSupp
    mov al, elev2X
    cmp bl, al
    jl L2NotSupp
    add al, 4
    cmp bl, al
    jg L2NotSupp
    jmp L2IsSupp

L2NotSupp:
    mov al, 0
    jmp L2S_Done
L2IsSupp:
    mov al, 1
L2S_Done:
    pop dx
    pop bx
    ret
CheckSupportAtL2 ENDP

;-----------------------------------------------------------

; MarioTakeDamage: Mario hit by enemy
;-----------------------------------------------------------
MarioTakeDamage PROC
    ; Check if star invincible
    cmp marioInvincible, 1
    je DamageDone
    
    ; If Super or Fire Mario, shrink
    cmp marioState, 0
    je LoseLife
    
    ; Shrink to small Mario
    mov marioState, 0
DamageDone:
    ret
    
LoseLife:
    push edx
    mov edx, OFFSET sndDeath
    call PlaySoundEffect
    pop edx
    dec byte ptr playerLives
    cmp playerLives, 0
    jle GameOverNow
    
    ; Reset Mario position
    mov marioX, 5
    mov marioY, 18
    mov isOnGround, 1
    mov velY, 0
    ret
    
GameOverNow:
    mov gameRunning, 0
    call ShowGameOverScreen
    ret
MarioTakeDamage ENDP

;-----------------------------------------------------------
; FlagpoleSlide: Animate Mario sliding down flagpole
;-----------------------------------------------------------
FlagpoleSlide PROC
    pushad
    
    mov edx, OFFSET sndStageClear
    call PlaySoundEffect
    
    call Clrscr
    
    ; Draw level background
    call DrawLevel1
    
    ; Slide Mario down
    mov marioX, 75
    mov slideY, 8
    
SlideLoop:
    ; Clear old position
    call Clrscr
    call DrawLevel1
    call DrawHUD
    
    ; Draw Mario at slide position
    mov eax, LIGHTBLUE
    call SetTextColor
    
    mov dh, slideY
    mov dl, 74
    call Gotoxy
    mov edx, OFFSET marioSmall1
    call WriteString
    
    inc slideY
    mov dh, slideY
    mov dl, 74
    call Gotoxy
    mov edx, OFFSET marioSmall2
    call WriteString
    
    mov eax, 100
    call Delay
    
    inc slideY
    cmp slideY, 19
    jl SlideLoop
    
    ; Calculate bonuses
    call CalculateLevelBonus
    
    ; Show level complete
    call ShowLevelCompleteScreen
    
    popad
    ret
FlagpoleSlide ENDP

;-----------------------------------------------------------
; CalculateLevelBonus: Calculate score from flagpole + time
;-----------------------------------------------------------
CalculateLevelBonus PROC
    ; Calculate flagpole bonus based on Mario's height
    mov al, marioY
    cmp al, 10      ; Top section
    jl TopB
    cmp al, 15      ; Middle section
    jl MidB
    mov eax, 500    ; Bottom
    jmp SetBonusValue
TopB:
    mov eax, 5000
    jmp SetBonusValue
MidB:
    mov eax, 2000
SetBonusValue:
    mov marioFlagBonus, eax
    add playerScore, eax
    
    ; Time bonus: 50 points per second
    movzx eax, gameTime
    imul eax, eax, 50
    mov marioTimeBonus, eax
    add playerScore, eax
    
    ; Fireworks bonus? (e.g., if time is even)
    mov ax, gameTime
    test ax, 1
    jnz NoFireworksBonus
    add playerScore, 500
NoFireworksBonus:
    ret
CalculateLevelBonus ENDP

;-----------------------------------------------------------
; ShowLevelCompleteScreen: Display victory screen
;-----------------------------------------------------------
ShowLevelCompleteScreen PROC
    pushad
    
    call Clrscr
    
    ; Title
    mov dh, 8
    mov dl, 35
    call Gotoxy
    
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET levelClear
    call WriteString
    
    ; Flag bonus
    mov dh, 12
    mov dl, 30
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET marioFlagBonusMsg
    call WriteString
    mov eax, marioFlagBonus
    call WriteDec
    
    ; Time bonus
    mov dh, 14
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET bonusMsg
    call WriteString
    mov eax, marioTimeBonus
    call WriteDec
    
    ; Total score
    mov dh, 18
    mov dl, 30
    call Gotoxy
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET hudMario
    call WriteString
    mov al, ' '
    call WriteChar
    mov eax, playerScore
    call WriteDec
    
    ; Check for fireworks (high score)
    cmp playerScore, 5000
    jl NoFireworks
    
    ; Display fireworks
    mov dh, 5
    mov dl, 20
    call Gotoxy
    mov eax, LIGHTRED
    call SetTextColor
    mov al, '*'
    call WriteChar
    
    mov dl, 40
    call Gotoxy
    mov eax, YELLOW
    call SetTextColor
    mov al, '*'
    call WriteChar
    
    mov dl, 60
    call Gotoxy
    mov eax, LIGHTCYAN
    call SetTextColor
    mov al, '*'
    call WriteChar
    
NoFireworks:
    ; Wait
    mov eax, 3000
    call Delay
    
    ; Save high score
    call SaveHighScore
    
    popad
    ret
ShowLevelCompleteScreen ENDP

;-----------------------------------------------------------
; ShowVictoryCredits: Final victory screen after World 1-3
;-----------------------------------------------------------
ShowVictoryCredits PROC
    pushad
    call Clrscr
    
    ; Display Victory Title
    mov dh, 5
    mov dl, 25
    call Gotoxy
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET victoryHeader
    call WriteString
    
    ; Trophy Art using trophy data (around 90-110)
    mov dh, 8
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET trophy1
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET trophy2
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET trophy3
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET trophy4
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET trophy5
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET trophy6
    call WriteString
    
    ; Princess Section if final level
    cmp currentLevelNum, 4
    jne NoPrincess
    
    ; Draw Princess
    mov dh, 7
    mov dl, 55
    call Gotoxy
    mov eax, LIGHTMAGENTA
    call SetTextColor
    mov edx, OFFSET princess1
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET princess2
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET princess3
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET princess4
    call WriteString
    inc dh
    call Gotoxy
    mov edx, OFFSET princess5
    call WriteString
    
    ; Princess Message
    mov dh, 13
    mov dl, 52
    call Gotoxy
    mov edx, OFFSET princessMsg
    call WriteString
    
NoPrincess:
    ; Completion Message
    mov dh, 18
    mov dl, 18
    call Gotoxy
    mov eax, LIGHTCYAN
    call SetTextColor
    mov edx, OFFSET winMsg
    call WriteString
    
    ; Final Score
    mov dh, 21
    mov dl, 30
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET endingMsg2
    call WriteString
    mov eax, playerScore
    call WriteInt
    
    mov dh, 23
    mov dl, 30
    call Gotoxy
    mov eax, YELLOW
    call SetTextColor
    mov edx, OFFSET thanksMsg
    call WriteString
    
    ; Simple delay and wait
    mov eax, 2000
    call Delay
    
    ; Save high score after victory
    call SaveHighScore
    
    call WaitForKey
    
    popad
    ret
ShowVictoryCredits ENDP

;-----------------------------------------------------------
; ShowPauseMenu: Display pause overlay
;-----------------------------------------------------------
ShowPauseMenu PROC
    pushad
    
    ; Draw pause box
    mov dh, 10
    mov dl, 35
    call Gotoxy
    
    mov eax, WHITE + (LIGHTBLUE * 16)
    call SetTextColor
    mov edx, OFFSET pauseMsg
    call WriteString
    
    mov dh, 12
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET pauseOpt1
    call WriteString
    
    mov dh, 13
    mov dl, 35
    call Gotoxy
    mov edx, OFFSET pauseOpt2
    call WriteString
    
PauseInputLoop:
    call ReadChar
    
    cmp al, 'r'
    je ResumePause
    cmp al, 'R'
    je ResumePause
    cmp al, 'q'
    je QuitFromPause
    cmp al, 'Q'
    je QuitFromPause
    
    jmp PauseInputLoop
    
ResumePause:
    ; Just return to game
    popad
    ret
    
QuitFromPause:
    mov gameRunning, 0
    popad
    ret
ShowPauseMenu ENDP

;-----------------------------------------------------------
; ShowGameOverScreen: Display game over
;-----------------------------------------------------------
ShowGameOverScreen PROC
    pushad
    mov edx, OFFSET sndGameOver
    call PlaySoundEffect
    
    call Clrscr
    
    mov dh, 12
    mov dl, 35
    call Gotoxy
    
    mov eax, LIGHTRED
    call SetTextColor
    mov edx, OFFSET gameOverMsg
    call WriteString
    
    ; Show final score
    mov dh, 16
    mov dl, 33
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET endingMsg2
    call WriteString
    mov eax, playerScore
    call WriteDec
    
    ; Save high score
    call SaveHighScore
    
    ; Wait for key
    mov dh, 20
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET tryAgainMsg
    call WriteString
    
    call ReadChar
    
    popad
    ret
ShowGameOverScreen ENDP

;-----------------------------------------------------------
; CheckBlockCollision: Check if Mario hits a block from below
;-----------------------------------------------------------
CheckBlockCollision PROC
    pushad
    
    ; Only check if Mario is moving UP (jumping/velocity < 0)
    mov al, velY
    cmp al, 0
    jge NoBlockHit
    
    ; Check Block 1
    cmp qBlock1Hit, 1
    je SkipB1
    mov al, marioX
    mov ah, marioY
    mov bl, qBlock1X
    mov bh, qBlock1Y
    inc bh             ; Check just below the block
    call CheckOverlap
    cmp cl, 1
    jne SkipB1
    
    ; Hit Block 1!
    mov qBlock1Hit, 1
    mov al, qBlock1Item
    call SpawnItem
    mov velY, 1       ; Bounce down
    jmp NoBlockHit

SkipB1:
    ; Check Block 2
    cmp qBlock2Hit, 1
    je SkipB2
    mov al, marioX
    mov ah, marioY
    mov bl, qBlock2X
    mov bh, qBlock2Y
    inc bh
    call CheckOverlap
    cmp cl, 1
    jne SkipB2
    
    mov qBlock2Hit, 1
    
    ; Intelligent Spawning for Power-up Block
    mov al, qBlock2Item
    cmp al, 2           ; Is it a Mushroom block?
    jne NormalSpawnB2
    cmp marioState, 0
    jne SpawnFlowerB2   ; If not small (already Super/Fire), spawn Fire Flower
    mov al, 2           ; Small Mario -> Mushroom
    jmp NormalSpawnB2
SpawnFlowerB2:
    mov al, 4           ; Super Mario -> Fire Flower
NormalSpawnB2:
    call SpawnItem
    mov velY, 1
    jmp NoBlockHit

SkipB2:
    ; Check Block 3
    cmp qBlock3Hit, 1
    je CheckBricks
    mov al, marioX
    mov ah, marioY
    mov bl, qBlock3X
    mov bh, qBlock3Y
    inc bh
    call CheckOverlap
    cmp cl, 1
    jne CheckBricks
    
    mov qBlock3Hit, 1
    mov al, qBlock3Item
    call SpawnItem
    mov velY, 1
    jmp NoBlockHit

CheckBricks:
    ; Brick 1 (X=24, Y=13)
    cmp brick1Active, 0
    je CheckBrick2
    mov al, marioX
    mov ah, marioY
    mov bl, 24
    mov bh, 13
    inc bh
    call CheckOverlap
    cmp cl, 1
    jne CheckBrick2
    
    cmp marioState, 0
    je BrickBounce
    ; Super Mario breaks brick!
    push edx
    mov edx, OFFSET sndBreakBlock
    call PlaySoundEffect
    pop edx
    mov brick1Active, 0
    add playerScore, 50
    mov velY, 1
    jmp NoBlockHit

CheckBrick2:
    cmp brick2Active, 0
    je NoBlockHit
    mov al, marioX
    mov ah, marioY
    mov bl, 27
    mov bh, 13
    inc bh
    call CheckOverlap
    cmp cl, 1
    jne NoBlockHit
    
    cmp marioState, 0
    je BrickBounce
    mov brick2Active, 0
    add playerScore, 50
    mov velY, 1
    jmp NoBlockHit

BrickBounce:
    mov velY, 1
    jmp NoBlockHit

NoBlockHit:
    popad
    ret
CheckBlockCollision ENDP

;-----------------------------------------------------------
; SpawnItem: Activate an item from a block
; AL = item type (1=coin, 2=mushroom, 3=star)
;-----------------------------------------------------------
SpawnItem PROC
    cmp al, 1
    je SpawnCoin
    cmp al, 2
    je SpawnMushroom
    cmp al, 3
    je SpawnStar
    cmp al, 4
    je SpawnFireFlower
    cmp al, 5
    je Spawn1UP
    ret

SpawnCoin:
    add playerScore, 200
    inc byte ptr playerCoins
    ret

SpawnMushroom:
    push edx
    mov edx, OFFSET sndBump
    call PlaySoundEffect
    pop edx
    cmp marioState, 0
    jne SpawnFireFlower ; If not small, give flower instead
    mov mushroomActive, 1
    mov al, marioX      ; Spawn near Mario
    mov mushroomX, al
    mov al, marioY
    sub al, 2           ; Above the block
    mov mushroomY, al
    ret

SpawnStar:
    mov starActive, 1
    mov al, marioX
    mov starX, al
    mov al, marioY
    sub al, 2
    mov starY, al
    ret
    
SpawnFireFlower:
    mov fireFlowerActive, 1
    mov al, marioX
    mov fireFlowerX, al
    mov al, marioY
    sub al, 2
    mov fireFlowerY, al
    ret

Spawn1UP:
    mov oneUpItemActive, 1
    mov al, marioX
    mov oneUpItemX, al
    mov al, marioY
    sub al, 2
    mov oneUpItemY, al
    ret
SpawnItem ENDP

;-----------------------------------------------------------
; UpdateItems: Movement and collection for Mushroom/Star/Flower/1-UP
;-----------------------------------------------------------
UpdateItems PROC
    pushad
    
    ; Update Mushroom
    cmp mushroomActive, 0
    je UpdateStarCheck
    
    ; Move Mushroom
    cmp mushroomDir, 1
    je MRight
    dec mushroomX
    cmp mushroomX, 2
    jg MCheckCol
    mov mushroomDir, 1
    jmp MCheckCol
MRight:
    inc mushroomX
    cmp mushroomX, 95
    jl MCheckCol
    mov mushroomDir, 0
    
MCheckCol:
    ; Check if Mario collects Mushroom
    mov al, marioX
    mov ah, marioY
    mov bl, mushroomX
    mov bh, mushroomY
    call CheckOverlap
    cmp cl, 1
    jne UpdateStarCheck
    
    ; Collected!
    mov mushroomActive, 0
    mov marioState, 1   ; Super Mario
    add playerScore, 1000
    push edx
    mov edx, OFFSET sndPowerup
    call PlaySoundEffect
    pop edx
    
UpdateStarCheck:
    cmp starActive, 0
    je UpdateFlowerCheck
    
    ; Simple Star patrol
    cmp starDir, 1
    je SRight
    dec starX
    cmp starX, 2
    jg SCheckCol
    mov starDir, 1
    jmp SCheckCol
SRight:
    inc starX
    cmp starX, 95
    jl SCheckCol
    mov starDir, 0
    
SCheckCol:
    mov al, marioX
    mov ah, marioY
    mov bl, starX
    mov bh, starY
    call CheckOverlap
    cmp cl, 1
    jne UpdateFlowerCheck
    
    ; Collected Star!
    mov starActive, 0
    mov marioInvincible, 1
    mov ax, 600
    mov marioStarTimer, ax   ; 10 seconds at 60fps
    mov turboActive, 1
    mov ax, 480
    mov turboTimer, ax  ; 8 seconds speed boost
    add playerScore, 1000
    push edx
    mov edx, OFFSET sndPowerup ; Use powerup sound for star too
    call PlaySoundEffect
    pop edx
    
UpdateFlowerCheck:
    cmp fireFlowerActive, 0
    je Update1UPCheck
    
    ; Fire Flower is stationary
    mov al, marioX
    mov ah, marioY
    mov bl, fireFlowerX
    mov bh, fireFlowerY
    call CheckOverlap
    cmp cl, 1
    jne Update1UPCheck
    
    ; Collected Fire Flower!
    mov fireFlowerActive, 0
    mov marioState, 2   ; Fire Mario
    add playerScore, 1000
    push edx
    mov edx, OFFSET sndPowerup
    call PlaySoundEffect
    pop edx
    
Update1UPCheck:
    cmp oneUpItemActive, 0
    je ItemsDone
    
    ; Move 1-UP (like mushroom)
    cmp oneUpItemDir, 1
    je OneUpRight
    dec oneUpItemX
    cmp oneUpItemX, 2
    jg OneUpCheckCol
    mov oneUpItemDir, 1
    jmp OneUpCheckCol
OneUpRight:
    inc oneUpItemX
    cmp oneUpItemX, 95
    jl OneUpCheckCol
    mov oneUpItemDir, 0
    
OneUpCheckCol:
    mov al, marioX
    mov ah, marioY
    mov bl, oneUpItemX
    mov bh, oneUpItemY
    call CheckOverlap
    cmp cl, 1
    jne ItemsDone
    
    ; Collected 1-UP!
    mov oneUpItemActive, 0
    inc playerLives
    add playerScore, 1000
    push edx
    mov edx, OFFSET snd1Up
    call PlaySoundEffect
    pop edx

ItemsDone:
    popad
    ret
UpdateItems ENDP

;-----------------------------------------------------------
; DrawItems: Render spawned items
;-----------------------------------------------------------
DrawItems PROC
    pushad
    
    ; Draw Mushroom
    cmp mushroomActive, 0
    je DrawStar
    mov eax, LIGHTRED
    call SetTextColor
    mov dh, mushroomY
    mov dl, mushroomX
    call Gotoxy
    mov edx, OFFSET itemCharM
    call WriteString
    
DrawStar:
    cmp starActive, 0
    je DrawFlower
    mov eax, LIGHTCYAN
    call SetTextColor
    mov dh, starY
    mov dl, starX
    call Gotoxy
    mov edx, OFFSET itemCharS
    call WriteString

DrawFlower:
    cmp fireFlowerActive, 0
    je Draw1UP
    mov eax, LIGHTRED
    call SetTextColor
    mov dh, fireFlowerY
    mov dl, fireFlowerX
    call Gotoxy
    mov edx, OFFSET itemCharF
    call WriteString

Draw1UP:
    cmp oneUpItemActive, 0
    je DrawDone
    mov eax, LIGHTGREEN
    call SetTextColor
    mov dh, oneUpItemY
    mov dl, oneUpItemX
    call Gotoxy
    mov edx, OFFSET itemChar1
    call WriteString

DrawDone:
    popad
    ret
DrawItems ENDP

;-----------------------------------------------------------
; ProcessFireballInput: Check for fireball shot (Limit 2)
;-----------------------------------------------------------
ProcessFireballInput PROC
    pushad
    
    ; Only Fire Mario can shoot
    cmp marioState, 2
    jne NoFireShot
    
    ; Check if less than 2 fireballs active
    movzx eax, fireballCount
    cmp eax, 2          ; FIRE_LIMIT (Use 2 directly if constant not found)
    jge NoFireShot
    
    ; Key already checked in HandleInput
    
    ; Find available slot
    cmp fireball1Active, 0
    je SpawnInSlot1
    cmp fireball2Active, 0
    je SpawnInSlot2
    jmp NoFireShot

SpawnInSlot1:
    mov fireball1Active, 1
    mov al, marioX
    mov fireball1X, al
    mov al, marioY
    sub al, 1
    mov fireball1Y, al
    mov fireball1Timer, 60
    inc fireballCount
    ; Direction
    mov fireball1Dir, 1
    mov al, velX
    cmp al, 0
    jge NoFireShot
    mov fireball1Dir, 0
    jmp NoFireShot

SpawnInSlot2:
    mov fireball2Active, 1
    mov al, marioX
    mov fireball2X, al
    mov al, marioY
    sub al, 1
    mov fireball2Y, al
    mov fireball2Timer, 60
    inc fireballCount
    push edx
    mov edx, OFFSET sndFireball
    call PlaySoundEffect
    pop edx
    ; Direction
    mov fireball2Dir, 1
    mov al, velX
    cmp al, 0
    jge NoFireShot
    mov fireball2Dir, 0

NoFireShot:
    popad
    ret
ProcessFireballInput ENDP

;-----------------------------------------------------------
; UpdateFireballs: Move fireballs and bounce
;-----------------------------------------------------------
UpdateFireballs PROC
    pushad
    
    ; Fireball 1
    cmp fireball1Active, 0
    je UpF2
    
    ; Move X
    cmp fireball1Dir, 1
    je F1Right
    dec fireball1X
    jmp F1Y
F1Right:
    inc fireball1X
F1Y:
    inc fireball1VelY
    mov al, fireball1VelY
    add fireball1Y, al
    ; Bounce
    cmp fireball1Y, 17
    jl F1CheckWall
    mov fireball1Y, 17
    mov fireball1VelY, -2
F1CheckWall:
    cmp fireball1X, 2
    jl KillF1
    cmp fireball1X, 95
    jg KillF1
    dec fireball1Timer
    cmp fireball1Timer, 0
    jne UpF2
KillF1:
    mov fireball1Active, 0
    dec fireballCount

UpF2:
    ; Fireball 2
    cmp fireball2Active, 0
    je FDone
    
    cmp fireball2Dir, 1
    je F2Right
    dec fireball2X
    jmp F2Y
F2Right:
    inc fireball2X
F2Y:
    inc fireball2VelY
    mov al, fireball2VelY
    add fireball2Y, al
    cmp fireball2Y, 17
    jl F2CheckWall
    mov fireball2Y, 17
    mov fireball2VelY, -2
F2CheckWall:
    cmp fireball2X, 2
    jl KillF2
    cmp fireball2X, 95
    jg KillF2
    dec fireball2Timer
    cmp fireball2Timer, 0
    jne FDone
KillF2:
    mov fireball2Active, 0
    dec fireballCount

FDone:
    popad
    ret
UpdateFireballs ENDP

;-----------------------------------------------------------
; DrawFireballs: Render fireballs
;-----------------------------------------------------------
DrawFireballs PROC
    pushad
    
    mov eax, LIGHTRED
    call SetTextColor
    
    ; Fireball 1
    cmp fireball1Active, 0
    je DrF2
    mov dh, fireball1Y
    mov dl, fireball1X
    call Gotoxy
    mov edx, OFFSET fireballChar
    call WriteString
    
DrF2:
    ; Fireball 2
    cmp fireball2Active, 0
    je DrDone
    mov dh, fireball2Y
    mov dl, fireball2X
    call Gotoxy
    mov edx, OFFSET fireballChar
    call WriteString
    
DrDone:
    popad
    ret
DrawFireballs ENDP

;-----------------------------------------------------------
; CheckFireballCollision: Kill enemies
;-----------------------------------------------------------
CheckFireballCollision PROC
    pushad
    
    ; Fireball 1
    cmp fireball1Active, 0
    je CFC_F2
    
    mov al, fireball1X
    mov ah, fireball1Y
    call CheckAllEnemiesFire
    cmp cl, 1
    jne CFC_F2
    
    ; Hit something!
    mov fireball1Active, 0
    dec fireballCount

CFC_F2:
    ; Fireball 2
    cmp fireball2Active, 0
    je CFCDone
    
    mov al, fireball2X
    mov ah, fireball2Y
    call CheckAllEnemiesFire
    cmp cl, 1
    jne CFCDone
    
    ; Hit something!
    mov fireball2Active, 0
    dec fireballCount

CFCDone:
    popad
    ret
CheckFireballCollision ENDP

;-----------------------------------------------------------
; CheckAllEnemiesFire: Helper to check one fireball (AL,AH)
; Returns CL=1 if hit, CL=0 otherwise
;-----------------------------------------------------------
CheckAllEnemiesFire PROC
    push ebx
    push edx
    push esi
    
    ; AL/AH contain fireball X/Y
    
    ; Goomba 1
    mov bl, goombaX
    mov bh, goombaY
    call CheckOverlap
    cmp cl, 1
    jne NoG1
    cmp goombaAlive, 1
    jne NoG1
    mov goombaAlive, 0
    add playerScore, 200
    jmp IsFireballHit
NoG1:
    ; Goomba 2
    mov bl, goomba2X
    mov bh, goomba2Y
    call CheckOverlap
    cmp cl, 1
    jne NoG2
    cmp goomba2Alive, 1
    jne NoG2
    mov goomba2Alive, 0
    add playerScore, 200
    jmp IsFireballHit
NoG2:
    ; Koopa
    mov bl, koopaX
    mov bh, koopaY
    call CheckOverlap
    cmp cl, 1
    jne NoK
    cmp koopaAlive, 1
    jne NoK
    mov koopaAlive, 0
    add playerScore, 200
    jmp IsFireballHit
NoK:
    ; L2 Goomba
    mov bl, L2goomba1X
    mov bh, L2goomba1Y
    call CheckOverlap
    cmp cl, 1
    jne NoL2G1
    cmp L2goomba1Alive, 1
    jne NoL2G1
    mov L2goomba1Alive, 0
    add playerScore, 200
    jmp IsFireballHit
NoL2G1:
    ; Piranha 1
    cmp piranha1H, 0
    je NoP1
    mov bl, 30
    mov bh, piranha1Y
    sub bh, piranha1H
    call CheckOverlap
    cmp cl, 1
    jne NoP1
    mov piranha1State, 0
    mov piranha1H, 0
    add playerScore, 200
    jmp IsFireballHit
NoP1:
    ; Piranha 2
    cmp piranha2H, 0
    je NoP2
    mov bl, 50
    mov bh, piranha2Y
    sub bh, piranha2H
    call CheckOverlap
    cmp cl, 1
    jne NoP2
    mov piranha2State, 0
    mov piranha2H, 0
    add playerScore, 200
    jmp IsFireballHit
NoP2:
    ; Piranha 3
    cmp piranha3H, 0
    je NoP3
    mov bl, 70
    mov bh, piranha3Y
    sub bh, piranha3H
    call CheckOverlap
    cmp cl, 1
    jne NoP3
    mov piranha3State, 0
    mov piranha3H, 0
    add playerScore, 200
    jmp IsFireballHit
NoP3:
    ; Goomba 3
    cmp goomba3Alive, 0
    je NoG3_F
    mov bl, goomba3X
    mov bh, goomba3Y
    call CheckOverlap
    cmp cl, 1
    jne NoG3_F
    mov goomba3Alive, 0
    add playerScore, 200
    jmp IsFireballHit
NoG3_F:
    ; Bowser (Boss)
    cmp currentLevelNum, 4
    jne NoBowser
    cmp bowserAlive, 1
    jne NoBowser
    mov bl, bowserX
    mov bh, bowserY
    call CheckOverlap
    cmp cl, 1
    jne NoBowser
    
    dec bowserHealth
    cmp bowserHealth, 0
    jg HitBoss
    mov bowserAlive, 0
    add playerScore, 5000
    jmp IsFireballHit
HitBoss:
    add playerScore, 500
    jmp IsFireballHit
NoBowser:
    mov cl, 0
    jmp FireballCheckEnd
IsFireballHit:
    mov cl, 1
FireballCheckEnd:
    pop esi
    pop edx
    pop ebx
    ret
CheckAllEnemiesFire ENDP

;-----------------------------------------------------------
; DrawPiranhaPlantsL1: Draw L1 plants
;-----------------------------------------------------------
DrawPiranhaPlantsL1 PROC
    pushad
    
    ; L1 Pipe 1 at X=28
    cmp piranha1H, 0
    je SkipL1P1
    mov eax, LIGHTRED
    call SetTextColor
    mov al, piranha1Y
    sub al, piranha1H
    mov dh, al
    mov dl, 28
    inc dl
    call Gotoxy
    mov edx, OFFSET piranhaChar
    call WriteString
SkipL1P1:
    
    ; L1 Pipe 2 at X=40
    cmp piranha2H, 0
    je SkipL1P2
    mov eax, LIGHTRED
    call SetTextColor
    mov al, piranha2Y
    sub al, piranha2H
    mov dh, al
    mov dl, 40
    inc dl
    call Gotoxy
    mov edx, OFFSET piranhaChar
    call WriteString
SkipL1P2:
    
    ; L1 Pipe 3 at X=52
    cmp piranha3H, 0
    je SkipL1P3
    mov eax, LIGHTRED
    call SetTextColor
    mov al, piranha3Y
    sub al, piranha3H
    mov dh, al
    mov dl, 52
    inc dl
    call Gotoxy
    mov edx, OFFSET piranhaChar
    call WriteString
SkipL1P3:
    
    popad
    ret
DrawPiranhaPlantsL1 ENDP

;-----------------------------------------------------------
; UpdatePiranhaPlantsL1: Update L1 plants
;-----------------------------------------------------------
UpdatePiranhaPlantsL1 PROC
    pushad
    
    ; Update Piranha 1 (X=28)
    mov al, marioX
    cmp al, 25
    jl P1L1Cont
    cmp al, 31
    jg P1L1Cont
    mov piranha1State, 0
    mov piranha1H, 0
    jmp P1L1Skip
P1L1Cont:
    ; Logic (Reuse UpdatePiranhaPlants logic manually or simpler)
    ; Manual simple update
    cmp piranha1State, 0
    je P1L1Down
    cmp piranha1State, 1
    je P1L1Up
    cmp piranha1State, 2
    je P1L1Wait
    jmp P1L1GoDown
P1L1Down:
    inc piranha1Timer
    cmp piranha1Timer, 60
    jl P1L1Skip
    mov piranha1Timer, 0
    mov piranha1State, 1
    jmp P1L1Skip
P1L1Up:
    inc piranha1H
    cmp piranha1H, 2
    jl P1L1Skip
    mov piranha1State, 2
    mov piranha1Timer, 0
    jmp P1L1Skip
P1L1Wait:
    inc piranha1Timer
    cmp piranha1Timer, 40
    jl P1L1Skip
    mov piranha1Timer, 0
    mov piranha1State, 3
    jmp P1L1Skip
P1L1GoDown:
    dec piranha1H
    cmp piranha1H, 0
    jg P1L1Skip
    mov piranha1H, 0
    mov piranha1State, 0
    
P1L1Skip:

    ; Update Piranha 2 (X=40)
    mov al, marioX
    cmp al, 37
    jl P2L1Cont
    cmp al, 43
    jg P2L1Cont
    mov piranha2State, 0
    mov piranha2H, 0
    jmp P2L1Skip
P2L1Cont:
    cmp piranha2State, 0
    je P2L1Down
    cmp piranha2State, 1
    je P2L1Up
    cmp piranha2State, 2
    je P2L1Wait
    jmp P2L1GoDown
P2L1Down:
    inc piranha2Timer
    cmp piranha2Timer, 80
    jl P2L1Skip
    mov piranha2Timer, 0
    mov piranha2State, 1
    jmp P2L1Skip
P2L1Up:
    inc piranha2H
    cmp piranha2H, 2
    jl P2L1Skip
    mov piranha2State, 2
    mov piranha2Timer, 0
    jmp P2L1Skip
P2L1Wait:
    inc piranha2Timer
    cmp piranha2Timer, 40
    jl P2L1Skip
    mov piranha2Timer, 0
    mov piranha2State, 3
    jmp P2L1Skip
P2L1GoDown:
    dec piranha2H
    cmp piranha2H, 0
    jg P2L1Skip
    mov piranha2H, 0
    mov piranha2State, 0
    
P2L1Skip:

    ; Update Piranha 3 (X=52)
    mov al, marioX
    cmp al, 49
    jl P3L1Cont
    cmp al, 55
    jg P3L1Cont
    mov piranha3State, 0
    mov piranha3H, 0
    jmp P3L1Skip
P3L1Cont:
    cmp piranha3State, 0
    je P3L1Down
    cmp piranha3State, 1
    je P3L1Up
    cmp piranha3State, 2
    je P3L1Wait
    jmp P3L1GoDown
P3L1Down:
    inc piranha3Timer
    cmp piranha3Timer, 100
    jl P3L1Skip
    mov piranha3Timer, 0
    mov piranha3State, 1
    jmp P3L1Skip
P3L1Up:
    inc piranha3H
    cmp piranha3H, 2
    jl P3L1Skip
    mov piranha3State, 2
    mov piranha3Timer, 0
    jmp P3L1Skip
P3L1Wait:
    inc piranha3Timer
    cmp piranha3Timer, 40
    jl P3L1Skip
    mov piranha3Timer, 0
    mov piranha3State, 3
    jmp P3L1Skip
P3L1GoDown:
    dec piranha3H
    cmp piranha3H, 0
    jg P3L1Skip
    mov piranha3H, 0
    mov piranha3State, 0
    
P3L1Skip:
    popad
    ret
UpdatePiranhaPlantsL1 ENDP

;===========================================================================
; LEVEL 3 - WORLD 1-3: SKY HIGH PLATFORMS
;===========================================================================

;-----------------------------------------------------------
; StartLevel3: Initialize and run World 1-3 Sky Level
;-----------------------------------------------------------
StartLevel3 PROC
    ; Reset game state
    mov playerScore, 0
    mov playerCoins, 0
    mov gameTime, 400
    mov marioX, 8
    mov marioY, 16              ; On starting platform
    mov marioState, 0
    mov isJumping, 0
    mov jumpHeight, 0
    mov velY, 0
    mov velX, 0
    mov isOnGround, 1
    mov gameRunning, 1
    mov marioOnPole, 0
    mov frameCounter, 0
    mov marioInvincible, 0
    mov turboActive, 0
    
    ; Reset Paratroopas (flying Koopas)
    mov paraAlive, 1
    mov paraX, 35
    mov paraY, 10
    mov paraDir, 1
    mov paraYDir, 0
    mov paraTimer, 0
    
    mov para2Alive, 1
    mov para2X, 60
    mov para2Y, 12
    mov para2Dir, 0
    mov para2YDir, 1
    mov para2Timer, 0
    
    ; Reset L3 coins
    mov L3coin1Active, 1
    mov L3coin2Active, 1
    mov L3coin3Active, 1
    mov L3coin4Active, 1
    
    ; Reset L3 question blocks
    mov L3qBlock1Hit, 0
    mov L3qBlock2Hit, 0
    
    ; Reset items
    mov mushroomActive, 0
    mov starActive, 0
    mov oneUpItemActive, 0
    mov fireball1Active, 0
    mov fireball2Active, 0
    mov fireballCount, 0
    
L3GameLoop:
    ; Check if game should continue
    cmp gameRunning, 0
    je L3GameLoopEnd
    
    ; Check for flagpole reached
    cmp marioOnPole, 1
    je L3HandleFlagpole
    
    ; Clear screen for new frame
    call Clrscr
    
    ; Draw the level
    call DrawLevel3
    
    ; Draw HUD
    call DrawHUD_L3
    
    ; Draw Mario
    call DrawMario
    
    ; Draw Paratroopas (flying enemies)
    call DrawParatroopas
    
    ; Draw coins
    call DrawCoinsL3
    
    ; Draw items (mushrooms, stars, etc.)
    call DrawItems
    
    ; Draw fireballs
    call DrawFireballs
    
    ; Handle keyboard input
    call HandleInput
    call ProcessFireballInput
    
    ; Update physics
    call UpdateMarioPhysicsL3
    
    ; Update enemies
    call UpdateParatroopas
    
    ; Update fireballs
    call UpdateFireballs
    
    ; Update spawned items
    call UpdateItems
    
    ; Check collisions
    call CheckL3PlatformCollision
    call CheckCoinCollisionsL3
    call CheckL3EnemyCollisions
    call CheckL3BlockCollision
    call CheckFireballCollision
    
    ; Check pit fall (fall off bottom of screen)
    cmp marioY, 22
    jg L3MarioFell
    
    ; Update timer every ~60 frames
    inc byte ptr frameCounter
    cmp frameCounter, 60
    jl L3SkipTimerUpdate
    mov frameCounter, 0
    cmp gameTime, 0
    je L3TimeUp
    dec word ptr gameTime
    
    ; Update turbo/star timer if active
    cmp turboActive, 0
    je L3CheckmarioStarTimer
    dec word ptr turboTimer
    cmp word ptr turboTimer, 0
    jg L3SkipTimerUpdate
    mov turboActive, 0
    jmp L3SkipTimerUpdate
    
L3CheckmarioStarTimer:
    cmp marioInvincible, 0
    je L3SkipTimerUpdate
    dec word ptr marioStarTimer
    cmp word ptr marioStarTimer, 0
    jg L3SkipTimerUpdate
    mov marioInvincible, 0     ; Star power expired

L3SkipTimerUpdate:
    ; --- BULLET TIME MANAGEMENT ---
    cmp slowMotionActive, 1
    jne L3RechargeMeter
    
    ; Deactivate if meter empty
    cmp slowMotionMeter, 0
    je L3AutoDeactivate
    dec slowMotionMeter
    jmp L3ApplySlowDelay

L3AutoDeactivate:
    mov slowMotionActive, 0
    jmp L3NormalDelay

L3RechargeMeter:
    cmp slowMotionMeter, 100
    jge L3NormalDelay
    inc slowMotionMeter

L3NormalDelay:
    ; Frame delay
    mov eax, 50
    call Delay
    jmp L3GameLoop

L3ApplySlowDelay:
    ; Frame delay for slow motion
    mov eax, 100
    call Delay
    jmp L3GameLoop

L3MarioFell:
    ; Mario fell into the pit!
    dec byte ptr playerLives
    cmp playerLives, 0
    je ShowGameOverScreen
    jmp StartLevel3

L3HandleFlagpole:
    mov slowMotionActive, 0
    call FlagpoleSlideL3
    mov levelCompleted, 1     ; Mark level as completed
    jmp L3GameLoopEnd

L3TimeUp:
    dec byte ptr playerLives
    cmp playerLives, 0
    je ShowGameOverScreen
    jmp StartLevel3

L3GameLoopEnd:
    ret
StartLevel3 ENDP

;-----------------------------------------------------------
; DrawLevel3: Render World 1-3 Sky High Platforms level
;-----------------------------------------------------------
DrawLevel3 PROC
    pushad
    
    ; Set sky blue background color
    mov eax, LIGHTBLUE
    call SetTextColor
    
    ; Draw decorative clouds
    ; Cloud 1
    mov dh, cloud1Y
    mov dl, cloud1X
    call Gotoxy
    mov eax, WHITE
    call SetTextColor
    mov edx, OFFSET cloudSmall
    call WriteString
    
    ; Cloud 2 (larger)
    mov dh, cloud2Y
    mov dl, cloud2X
    call Gotoxy
    mov edx, OFFSET cloudLarge1
    call WriteString
    mov dh, cloud2Y
    inc dh
    mov dl, cloud2X
    call Gotoxy
    mov edx, OFFSET cloudLarge2
    call WriteString
    
    ; Cloud 3
    mov dh, cloud3Y
    mov dl, cloud3X
    call Gotoxy
    mov edx, OFFSET cloudSmall
    call WriteString
    
    ; Cloud 4
    mov dh, cloud4Y
    mov dl, cloud4X
    call Gotoxy
    mov edx, OFFSET cloudSmall
    call WriteString
    
    ; Cloud 5
    mov dh, cloud5Y
    mov dl, cloud5X
    call Gotoxy
    mov edx, OFFSET cloudSmall
    call WriteString
    
    ; Draw green mushroom platforms
    mov eax, LIGHTGREEN
    call SetTextColor
    
    ; Platform 1 (starting platform - larger)
    mov dh, L3plat1Y
    mov dl, L3plat1X
    call Gotoxy
    mov edx, OFFSET mushPlatWide
    call WriteString
    
    ; Platform 2
    mov dh, L3plat2Y
    mov dl, L3plat2X
    call Gotoxy
    mov edx, OFFSET mushPlatChar
    call WriteString
    
    ; Platform 3
    mov dh, L3plat3Y
    mov dl, L3plat3X
    call Gotoxy
    mov edx, OFFSET mushPlatChar
    call WriteString
    
    ; Platform 4
    mov dh, L3plat4Y
    mov dl, L3plat4X
    call Gotoxy
    mov edx, OFFSET mushPlatChar
    call WriteString
    
    ; Platform 5
    mov dh, L3plat5Y
    mov dl, L3plat5X
    call Gotoxy
    mov edx, OFFSET mushPlatChar
    call WriteString
    
    ; Platform 6 (near end)
    mov dh, L3plat6Y
    mov dl, L3plat6X
    call Gotoxy
    mov edx, OFFSET mushPlatWide
    call WriteString
    
    ; Draw tree trunks (brown pillars)
    mov eax, BROWN
    call SetTextColor
    
    ; Tree 1 trunk
    mov ecx, 6
    mov dh, tree1TopY
    inc dh
L3Tree1Loop:
    push ecx
    mov dl, tree1X
    call Gotoxy
    mov edx, OFFSET treeTrunk
    call WriteString
    inc dh
    pop ecx
    loop L3Tree1Loop
    
    ; Tree 1 top (green)
    mov eax, LIGHTGREEN
    call SetTextColor
    mov dh, tree1TopY
    mov dl, tree1X
    dec dl
    call Gotoxy
    mov edx, OFFSET treeTop
    call WriteString
    
    ; Tree 2 trunk
    mov eax, BROWN
    call SetTextColor
    mov ecx, 8
    mov dh, tree2TopY
    inc dh
L3Tree2Loop:
    push ecx
    mov dl, tree2X
    call Gotoxy
    mov edx, OFFSET treeTrunk
    call WriteString
    inc dh
    pop ecx
    loop L3Tree2Loop
    
    ; Tree 2 top
    mov eax, LIGHTGREEN
    call SetTextColor
    mov dh, tree2TopY
    mov dl, tree2X
    dec dl
    call Gotoxy
    mov edx, OFFSET treeTop
    call WriteString
    
    ; Tree 3 trunk
    mov eax, BROWN
    call SetTextColor
    mov ecx, 7
    mov dh, tree3TopY
    inc dh
L3Tree3Loop:
    push ecx
    mov dl, tree3X
    call Gotoxy
    mov edx, OFFSET treeTrunk
    call WriteString
    inc dh
    pop ecx
    loop L3Tree3Loop
    
    ; Tree 3 top
    mov eax, LIGHTGREEN
    call SetTextColor
    mov dh, tree3TopY
    mov dl, tree3X
    dec dl
    call Gotoxy
    mov edx, OFFSET treeTop
    call WriteString
    
    ; Draw L3 Question Blocks
    ; Block 1
    cmp L3qBlock1Hit, 0
    jne L3B1Empty
    mov eax, YELLOW
    call SetTextColor
    mov dh, L3qBlock1Y
    mov dl, L3qBlock1X
    call Gotoxy
    mov edx, OFFSET qBlock
    call WriteString
    jmp L3B1Done
L3B1Empty:
    mov eax, DARKGRAY
    call SetTextColor
    mov dh, L3qBlock1Y
    mov dl, L3qBlock1X
    call Gotoxy
    mov edx, OFFSET qBlockEmpty
    call WriteString
L3B1Done:
    
    ; Block 2
    cmp L3qBlock2Hit, 0
    jne L3B2Empty
    mov eax, YELLOW
    call SetTextColor
    mov dh, L3qBlock2Y
    mov dl, L3qBlock2X
    call Gotoxy
    mov edx, OFFSET qBlock
    call WriteString
    jmp L3B2Done
L3B2Empty:
    mov eax, DARKGRAY
    call SetTextColor
    mov dh, L3qBlock2Y
    mov dl, L3qBlock2X
    call Gotoxy
    mov edx, OFFSET qBlockEmpty
    call WriteString
L3B2Done:
    
    ; Draw stair-step pyramid at end (X=85)
    mov eax, BROWN
    call SetTextColor
    
    ; Step 1 (1 block)
    mov dh, 19
    mov dl, 85
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Step 2 (2 blocks high)
    mov dh, 18
    mov dl, 88
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 19
    mov dl, 88
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Step 3 (3 blocks high)
    mov dh, 17
    mov dl, 91
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 18
    mov dl, 91
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    mov dh, 19
    mov dl, 91
    call Gotoxy
    mov edx, OFFSET brickBlock
    call WriteString
    
    ; Draw Flagpole at X=95
    mov eax, WHITE
    call SetTextColor
    
    ; Flagpole top (flag)
    mov dh, 8
    mov dl, 95
    call Gotoxy
    mov edx, OFFSET flagTop
    call WriteString
    
    ; Flagpole shaft
    mov ecx, 11
    mov dh, 9
L3DrawPoleLoop:
    push ecx
    mov dl, 95
    call Gotoxy
    mov edx, OFFSET flagPole
    call WriteString
    inc dh
    pop ecx
    loop L3DrawPoleLoop
    
    ; No continuous ground in Level 3 - it's a sky level!
    ; Only small ground section at very start and end
    mov eax, BROWN
    call SetTextColor
    
    ; Start ground
    mov dh, 20
    mov dl, 0
    call Gotoxy
    mov ecx, 15       ; 15 characters of ground
L3GStart:
    push ecx
    mov al, '#'
    call WriteChar
    pop ecx
    loop L3GStart
    
    ; End ground (at flagpole)
    mov dh, 20
    mov dl, 84
    call Gotoxy
    mov ecx, 16
L3GEnd:
    push ecx
    mov al, '#'
    call WriteChar
    pop ecx
    loop L3GEnd
    
    popad
    ret
DrawLevel3 ENDP

;-----------------------------------------------------------
; DrawHUD_L3: Draw HUD with World 1-3
;-----------------------------------------------------------
DrawHUD_L3 PROC
    pushad
    mov edx, OFFSET worldNum13
    call DrawHUD_Generic
    popad
    ret
DrawHUD_L3 ENDP



;-----------------------------------------------------------
; DrawParatroopas: Render flying Koopa enemies
;-----------------------------------------------------------
DrawParatroopas PROC
    pushad
    
    ; Paratroopa 1
    cmp paraAlive, 0
    je SkipPara1
    
    mov eax, LIGHTGREEN
    call SetTextColor
    mov dh, paraY
    mov dl, paraX
    call Gotoxy
    mov edx, OFFSET paratroopa
    call WriteString
    
SkipPara1:
    
    ; Paratroopa 2
    cmp para2Alive, 0
    je SkipPara2
    
    mov eax, LIGHTGREEN
    call SetTextColor
    mov dh, para2Y
    mov dl, para2X
    call Gotoxy
    mov edx, OFFSET paratroopa
    call WriteString
    
SkipPara2:
    
    popad
    ret
DrawParatroopas ENDP

;-----------------------------------------------------------
; UpdateParatroopas: Update flying Koopa movement
;-----------------------------------------------------------
UpdateParatroopas PROC
    pushad
    
    ; Update Paratroopa 1
    cmp paraAlive, 0
    je SkipPara1Update
    
    ; Horizontal movement
    cmp paraDir, 1
    je Para1Right
    dec paraX
    cmp paraX, 20
    jg Para1Vert
    mov paraDir, 1
    jmp Para1Vert
Para1Right:
    inc paraX
    cmp paraX, 50
    jl Para1Vert
    mov paraDir, 0
    
Para1Vert:
    ; Vertical bobbing
    inc paraTimer
    cmp paraTimer, 8
    jl SkipPara1Update
    mov paraTimer, 0
    
    cmp paraYDir, 1
    je Para1Down
    dec paraY
    mov al, paraMinY
    cmp paraY, al
    jg SkipPara1Update
    mov paraYDir, 1
    jmp SkipPara1Update
Para1Down:
    inc paraY
    mov al, paraMaxY
    cmp paraY, al
    jl SkipPara1Update
    mov paraYDir, 0
    
SkipPara1Update:
    
    ; Update Paratroopa 2
    cmp para2Alive, 0
    je SkipPara2Update
    
    ; Horizontal movement
    cmp para2Dir, 1
    je Para2Right
    dec para2X
    cmp para2X, 50
    jg Para2Vert
    mov para2Dir, 1
    jmp Para2Vert
Para2Right:
    inc para2X
    cmp para2X, 75
    jl Para2Vert
    mov para2Dir, 0
    
Para2Vert:
    ; Vertical bobbing
    inc para2Timer
    cmp para2Timer, 10
    jl SkipPara2Update
    mov para2Timer, 0
    
    cmp para2YDir, 1
    je Para2Down
    dec para2Y
    mov al, para2MinY
    cmp para2Y, al
    jg SkipPara2Update
    mov para2YDir, 1
    jmp SkipPara2Update
Para2Down:
    inc para2Y
    mov al, para2MaxY
    cmp para2Y, al
    jl SkipPara2Update
    mov para2YDir, 0
    
SkipPara2Update:
    
    popad
    ret
UpdateParatroopas ENDP

;-----------------------------------------------------------
; DrawCoinsL3: Render Level 3 coins
;-----------------------------------------------------------
DrawCoinsL3 PROC
    pushad
    
    mov eax, YELLOW
    call SetTextColor
    
    ; Coin 1
    cmp L3coin1Active, 0
    je SkipL3C1
    mov dh, L3coin1Y
    mov dl, L3coin1X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL3C1:
    
    ; Coin 2
    cmp L3coin2Active, 0
    je SkipL3C2
    mov dh, L3coin2Y
    mov dl, L3coin2X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL3C2:
    
    ; Coin 3
    cmp L3coin3Active, 0
    je SkipL3C3
    mov dh, L3coin3Y
    mov dl, L3coin3X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL3C3:
    
    ; Coin 4
    cmp L3coin4Active, 0
    je SkipL3C4
    mov dh, L3coin4Y
    mov dl, L3coin4X
    call Gotoxy
    mov edx, OFFSET coinChar
    call WriteString
SkipL3C4:
    
    popad
    ret
DrawCoinsL3 ENDP

;-----------------------------------------------------------
; UpdateMarioPhysicsL3: Physics for sky level
;-----------------------------------------------------------
UpdateMarioPhysicsL3 PROC
    pushad
    
    ; --- Horizontal Movement & Friction ---
    cmp horizontalInputActive, 1
    je L3StaticX       ; Skip friction if actively moving
    
    cmp velX, 0
    je L3StaticX
    jg L3DecelRight
    inc velX
    jmp L3StaticX
L3DecelRight:
    dec velX
L3StaticX:
    mov al, velX
    add marioX, al
    
    ; Boundaries - signed check
    movsx eax, marioX
    cmp eax, 2
    jge L3CheckRB
    mov marioX, 2
    mov velX, 0
L3CheckRB:
    cmp eax, 98
    jle L3PhysicsV
    mov marioX, 98
    mov velX, 0

L3PhysicsV:
    ; --- Vertical Movement ---
    cmp isOnGround, 1
    jne L3ApplyGravity
    
    ; Edge detection - check if still supported
    mov al, marioX
    mov cl, marioY
    call CheckL3PlatformCollision
    cmp al, 1
    je L3PhysicsDone     ; Still supported
    mov isOnGround, 0    ; Walked off edge!
    
L3ApplyGravity:
    ; Apply gravity
    mov al, GRAVITY
    add velY, al
    
    ; Cap at terminal velocity
    mov al, velY
    cmp al, MAX_FALL_SPEED
    jle L3ApplyVelocity
    mov al, MAX_FALL_SPEED
    mov velY, al
    
L3ApplyVelocity:
    add marioY, al
    
L3CheckPit:
    ; Check for falling out of bounds (pit)
    cmp marioY, 20
    jl L3PhysicsDone
    call MarioTakeDamage
    
L3PhysicsDone:
    ; Check Ceiling Clamp
    mov al, CEILING_LIMIT
    cmp marioY, al
    jge L3SafeCeil
    mov marioY, al
    mov velY, 0
L3SafeCeil:
    popad
    ret
UpdateMarioPhysicsL3 ENDP


;-----------------------------------------------------------
; CheckL3PlatformCollision: Check Mario lands on platforms
;-----------------------------------------------------------
;-----------------------------------------------------------
; IsL3Supported: Pure function to check if point (X,Y) is on platform
; Input: AL = marioX, CL = marioY
; Output: AL = 1 if supported, 0 if not. DL = Snapped Y height.
;-----------------------------------------------------------
IsL3Supported PROC
    push bx
    push cx
    
    mov bl, al       ; X
    mov bh, cl       ; Y
    
    ; 1. Mushrooms/Platforms (Landing Range check)
    ; Plat 1 (Wide=8, Y=17)
    mov dl, L3plat1Y
    cmp bh, dl
    jl S3_P2
    add dl, 2
    cmp bh, dl
    jg S3_P2
    cmp bl, L3plat1X
    jl S3_P2
    mov dx, WORD PTR L3plat1X
    add dl, 8
    cmp bl, dl
    jle IsSupp3_P1
    
S3_P2:
    mov dl, L3plat2Y
    cmp bh, dl
    jl S3_P3
    add dl, 2
    cmp bh, dl
    jg S3_P3
    cmp bl, L3plat2X
    jl S3_P3
    mov dl, L3plat2X
    add dl, 6
    cmp bl, dl
    jle IsSupp3_P2

S3_P3:
    mov dl, L3plat3Y
    cmp bh, dl
    jl S3_P4
    add dl, 2
    cmp bh, dl
    jg S3_P4
    cmp bl, L3plat3X
    jl S3_P4
    mov dl, L3plat3X
    add dl, 6
    cmp bl, dl
    jle IsSupp3_P3

S3_P4:
    mov dl, L3plat4Y
    cmp bh, dl
    jl S3_P5
    add dl, 2
    cmp bh, dl
    jg S3_P5
    cmp bl, L3plat4X
    jl S3_P5
    mov dl, L3plat4X
    add dl, 6
    cmp bl, dl
    jle IsSupp3_P4

S3_P5:
    mov dl, L3plat5Y
    cmp bh, dl
    jl S3_P6
    add dl, 2
    cmp bh, dl
    jg S3_P6
    cmp bl, L3plat5X
    jl S3_P6
    mov dl, L3plat5X
    add dl, 6
    cmp bl, dl
    jle IsSupp3_P5

S3_P6:
    mov dl, L3plat6Y
    cmp bh, dl
    jl S3_Ground
    add dl, 2
    cmp bh, dl
    jg S3_Ground
    cmp bl, L3plat6X
    jl S3_Ground
    mov dl, L3plat6X
    add dl, 8
    cmp bl, dl
    jle IsSupp3_P6

S3_Ground:
    ; Ground check (Y=20, feet at 19)
    cmp bh, 19
    jl NotSupp3
    cmp bl, 15
    jle IsSupp3_G
    cmp bl, 84
    jge IsSupp3_G

NotSupp3:
    pop cx
    pop bx
    mov al, 0
    ret
    
IsSupp3_P1: mov dl, L3plat1Y
    jmp IsSupp3_Final
IsSupp3_P2: mov dl, L3plat2Y
    jmp IsSupp3_Final
IsSupp3_P3: mov dl, L3plat3Y
    jmp IsSupp3_Final
IsSupp3_P4: mov dl, L3plat4Y
    jmp IsSupp3_Final
IsSupp3_P5: mov dl, L3plat5Y
    jmp IsSupp3_Final
IsSupp3_P6: mov dl, L3plat6Y
    jmp IsSupp3_Final
IsSupp3_G:  mov dl, 19
    jmp IsSupp3_Final

IsSupp3_Final:
    pop cx
    pop bx
    mov al, 1
    ret
IsL3Supported ENDP

;-----------------------------------------------------------
; CheckL3PlatformCollision: Updated to use IsL3Supported
;-----------------------------------------------------------
CheckL3PlatformCollision PROC
    ; Logic moved to IsL3Supported, but we use this to update globals
    mov al, marioX
    mov cl, marioY
    call IsL3Supported
    cmp al, 1
    jne L3Falling
    
    ; Supported
    mov isOnGround, 1
    mov velY, 0
    mov marioY, dl      ; Snap Y
    
    ; Flagpole check
    cmp marioX, 94
    jl L3NoGoal
    mov marioOnPole, 1
L3NoGoal:
    mov al, 1           ; Return success
    jmp CheckL3Done

L3Falling:
    mov isOnGround, 0
    mov al, 0           ; Return failure

CheckL3Done:
    ret
CheckL3PlatformCollision ENDP

;-----------------------------------------------------------
; CheckCoinCollisionsL3: Collect Level 3 coins
;-----------------------------------------------------------
CheckCoinCollisionsL3 PROC
    pushad
    
    mov al, marioX
    mov ah, marioY
    
    ; Coin 1
    cmp L3coin1Active, 0
    je SkipL3CC1
    mov bl, L3coin1X
    mov bh, L3coin1Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL3CC1
    mov L3coin1Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL3CC1:
    
    ; Coin 2
    cmp L3coin2Active, 0
    je SkipL3CC2
    mov bl, L3coin2X
    mov bh, L3coin2Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL3CC2
    mov L3coin2Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL3CC2:
    
    ; Coin 3
    cmp L3coin3Active, 0
    je SkipL3CC3
    mov bl, L3coin3X
    mov bh, L3coin3Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL3CC3
    mov L3coin3Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL3CC3:
    
    ; Coin 4
    cmp L3coin4Active, 0
    je SkipL3CC4
    mov bl, L3coin4X
    mov bh, L3coin4Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL3CC4
    mov L3coin4Active, 0
    add playerScore, 200
    inc byte ptr playerCoins
SkipL3CC4:
    
    ; Check 100 coins = 1UP
    cmp playerCoins, 100
    jl NoL3ExtraLife
    mov playerCoins, 0
    inc playerLives
NoL3ExtraLife:
    
    popad
    ret
CheckCoinCollisionsL3 ENDP

;-----------------------------------------------------------
; CheckL3EnemyCollisions: Check Mario vs Paratroopas
;-----------------------------------------------------------
CheckL3EnemyCollisions PROC
    pushad
    
    ; Check star invincibility
    cmp marioInvincible, 1
    je L3StarKillEnemies
    
    ; Check Paratroopa 1
    cmp paraAlive, 0
    je SkipL3Para1
    
    mov al, marioX
    mov ah, marioY
    mov bl, paraX
    mov bh, paraY
    call CheckOverlap
    cmp cl, 1
    jne SkipL3Para1
    
    ; Did Mario stomp from above?
    mov al, marioY
    add al, velY
    cmp al, paraY
    jge L3MarioHitPara1
    
    ; Stomp! Convert to regular koopa (or kill)
    mov paraAlive, 0
    add playerScore, 400        ; Flying koopa worth more
    mov velY, -3                ; Bounce
    jmp SkipL3Para1
    
L3MarioHitPara1:
    call MarioTakeDamage
    
SkipL3Para1:
    
    ; Check Paratroopa 2
    cmp para2Alive, 0
    je SkipL3Para2
    
    mov al, marioX
    mov ah, marioY
    mov bl, para2X
    mov bh, para2Y
    call CheckOverlap
    cmp cl, 1
    jne SkipL3Para2
    
    mov al, marioY
    add al, velY
    cmp al, para2Y
    jge L3MarioHitPara2
    
    mov para2Alive, 0
    add playerScore, 400
    mov velY, -3
    jmp SkipL3Para2
    
L3MarioHitPara2:
    call MarioTakeDamage
    
SkipL3Para2:
    jmp L3EnemyDone
    
L3StarKillEnemies:
    ; Star power - kill enemies on contact
    cmp paraAlive, 0
    je L3StarPara2
    
    mov al, marioX
    mov ah, marioY
    mov bl, paraX
    mov bh, paraY
    call CheckOverlap
    cmp cl, 1
    jne L3StarPara2
    mov paraAlive, 0
    add playerScore, 400
    
L3StarPara2:
    cmp para2Alive, 0
    je L3EnemyDone
    
    mov al, marioX
    mov ah, marioY
    mov bl, para2X
    mov bh, para2Y
    call CheckOverlap
    cmp cl, 1
    jne L3EnemyDone
    mov para2Alive, 0
    add playerScore, 400
    
L3EnemyDone:
    popad
    ret
CheckL3EnemyCollisions ENDP

;-----------------------------------------------------------
; CheckL3BlockCollision: Check Mario hitting question blocks
;-----------------------------------------------------------
CheckL3BlockCollision PROC
    pushad
    
    ; Only check if moving upward
    mov al, velY
    cmp al, 0
    jge NoL3BlockHit
    
    ; Check Block 1
    cmp L3qBlock1Hit, 1
    je SkipL3B1
    mov al, marioX
    mov ah, marioY
    mov bl, L3qBlock1X
    mov bh, L3qBlock1Y
    inc bh              ; Check just below block
    call CheckOverlap
    cmp cl, 1
    jne SkipL3B1
    
    mov L3qBlock1Hit, 1
    mov al, L3qBlock1Item
    call SpawnItem
    mov velY, 1         ; Bounce down
    jmp NoL3BlockHit
    
SkipL3B1:
    ; Check Block 2
    cmp L3qBlock2Hit, 1
    je NoL3BlockHit
    mov al, marioX
    mov ah, marioY
    mov bl, L3qBlock2X
    mov bh, L3qBlock2Y
    inc bh
    call CheckOverlap
    cmp cl, 1
    jne NoL3BlockHit
    
    mov L3qBlock2Hit, 1
    mov al, L3qBlock2Item
    call SpawnItem
    mov velY, 1
    
NoL3BlockHit:
    popad
    ret
CheckL3BlockCollision ENDP

;-----------------------------------------------------------
; FlagpoleSlideL3: Level 3 flagpole animation
;-----------------------------------------------------------
FlagpoleSlideL3 PROC
    pushad
    
    call Clrscr
    call DrawLevel3
    
    mov marioX, 95
    mov slideY, 8
    mov flagGrabY, 8
    
L3SlideLoop:
    call Clrscr
    call DrawLevel3
    call DrawHUD_L3
    
    ; Draw Mario at slide position
    mov eax, LIGHTBLUE
    call SetTextColor
    
    mov dh, slideY
    mov dl, 94
    call Gotoxy
    mov edx, OFFSET marioSmall1
    call WriteString
    
    inc dh
    mov dl, 94
    call Gotoxy
    mov edx, OFFSET marioSmall2
    call WriteString
    
    ; Delay
    mov eax, 100
    call Delay
    
    ; Move down
    inc slideY
    cmp slideY, 19
    jl L3SlideLoop
    
    ; Calculate bonus
    call CalculateLevelBonus
    
    ; Show level complete
    call ShowLevelCompleteScreen
    
    popad
    ret
FlagpoleSlideL3 ENDP

;-----------------------------------------------------------
; StartLevel4: Final Boss Level World 1-4
;-----------------------------------------------------------
StartLevel4 PROC
    ; Reset game state
    mov currentLevelNum, 4
    mov levelCompleted, 0
    mov gameTime, 400
    mov marioX, 5
    mov marioY, 18
    mov marioState, 0
    mov isJumping, 0
    mov jumpHeight, 0
    mov velY, 0
    mov velX, 0
    mov isOnGround, 1
    mov gameRunning, 1
    mov frameCounter, 0
    mov marioInvincible, 0
    mov turboActive, 0
    
    ; Reset Bowser
    mov bowserX, 75
    mov bowserY, 15
    mov bowserAlive, 1
    mov bowserHealth, 5
    mov bowserDir, 0
    mov bowserTimer, 0
    mov bowserFireActive, 0
    
    ; Reset Fireballs
    mov fireball1Active, 0
    mov fireball2Active, 0
    mov fireballCount, 0

L4GameLoop:
    cmp gameRunning, 0
    je L4GameLoopEnd
    
    ; Check for Axe reached
    mov al, marioX
    cmp al, 85
    jle L4Cont
    mov levelCompleted, 1
    call ShowVictoryCredits
    jmp L4GameLoopEnd

L4Cont:
    call Clrscr
    call DrawLevel4
    call DrawHUD_L4
    call DrawMario
    call DrawBowser
    call DrawFireballs
    
    call HandleInput
    call ProcessFireballInput
    call UpdateMarioPhysics_L4
    call UpdateLevel4Mechanics
    call UpdateFireballs
    call CheckL4Collisions
    call CheckFireballCollision
    
    ; Pit fall (lava) handled in CheckL4Collisions
    
    inc byte ptr frameCounter
    cmp frameCounter, 60
    jl L4SkipTimerUpdate
    mov frameCounter, 0
    cmp gameTime, 0
    je L4TimeUp
    dec word ptr gameTime

L4SkipTimerUpdate:
    ; --- BULLET TIME MANAGEMENT ---
    cmp slowMotionActive, 1
    jne L4RechargeMeter
    
    ; Deactivate if meter empty
    cmp slowMotionMeter, 0
    je L4AutoDeactivate
    dec slowMotionMeter
    jmp L4ApplySlowDelay

L4AutoDeactivate:
    mov slowMotionActive, 0
    jmp L4NormalDelay

L4RechargeMeter:
    cmp slowMotionMeter, 100
    jge L4NormalDelay
    inc slowMotionMeter

L4NormalDelay:
    ; Frame delay
    mov eax, 33         ; ~30 FPS for smoother boss movement
    call Delay
    jmp L4GameLoop

L4ApplySlowDelay:
    ; Frame delay for slow motion boss
    mov eax, 66         ; Half speed
    call Delay
    jmp L4GameLoop

L4TimeUp:
    dec byte ptr playerLives
    cmp playerLives, 0
    je L4GameOver
    jmp StartLevel4

L4GameOver:
    call ShowGameOverScreen
L4GameLoopEnd:
    ret
StartLevel4 ENDP

;-----------------------------------------------------------
; DrawLevel4: Render Castle environment
;-----------------------------------------------------------
DrawLevel4 PROC
    pushad
    
    ; Background is BLACK (clear screen)
    
    ; Draw Ceilings/Walls
    mov eax, GRAY
    call SetTextColor
    mov dh, 1
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET castleBrick
    call WriteString
    
    ; Draw Platforms
    mov dh, castlePlat1Y
    mov dl, castlePlat1X
    mov edx, OFFSET bridgeL4
    call Gotoxy
    call WriteString
    
    mov dh, castlePlat2Y
    mov dl, castlePlat2X
    call Gotoxy
    call WriteString
    
    ; Draw Boss Bridge (only if not collapsed)
    cmp bridgeCollapsed, 0
    jne SkipBridgeDraw
    mov eax, BROWN
    call SetTextColor
    mov dh, 18
    mov dl, 65
    L4BridgeLoop:
        call Gotoxy
        mov al, '='
        call WriteChar
        inc dl
        cmp dl, 85
        jl L4BridgeLoop
SkipBridgeDraw:
        
    ; Draw Lava
    mov eax, LIGHTRED
    call SetTextColor
    mov dh, 21
    mov dl, 0
    call Gotoxy
    mov edx, OFFSET lavaChar
    call WriteString
    
    ; Draw Fire Bars at specific locations
    ; Center bar
    mov dl, 40
    mov dh, 12
    call DrawFireBar
    
    ; Near bridge bar
    mov dl, 60
    mov dh, 10
    call DrawFireBar
    
    ; Draw Axe at the end of bridge
    mov eax, WHITE
    call SetTextColor
    mov dh, 17
    mov dl, 86
    call Gotoxy
    mov edx, OFFSET axeChar
    call WriteString
    
    popad
    ret
DrawLevel4 ENDP

;-----------------------------------------------------------
; DrawHUD_L4: HUD for 1-4
;-----------------------------------------------------------
DrawHUD_L4 PROC
    pushad
    ; Use generic HUD draw but swap world number
    mov edx, OFFSET worldNum14
    call DrawHUD_Generic
    popad
    ret
DrawHUD_L4 ENDP

;-----------------------------------------------------------
; DrawBowser: Render the boss
;-----------------------------------------------------------
DrawBowser PROC
    pushad
    cmp bowserAlive, 0
    je BowserDone
    
    mov eax, LIGHTGREEN
    call SetTextColor
    
    mov dh, bowserY
    mov dl, bowserX
    call Gotoxy
    mov edx, OFFSET bowser1
    call WriteString
    
    inc dh
    call Gotoxy
    mov edx, OFFSET bowser2
    call WriteString
    
    inc dh
    call Gotoxy
    mov edx, OFFSET bowser3
    call WriteString
    
    inc dh
    call Gotoxy
    mov edx, OFFSET bowser4
    call WriteString
    
    inc dh
    call Gotoxy
    mov edx, OFFSET bowser5
    call WriteString
    
    ; Draw Bowser's fire if active
    cmp bowserFireActive, 1
    jne BowserDone
    mov eax, LIGHTRED
    call SetTextColor
    mov dh, bowserFireY
    mov dl, bowserFireX
    call Gotoxy
    mov edx, OFFSET bowserFireChar
    call WriteString

BowserDone:
    popad
    ret
DrawBowser ENDP

;-----------------------------------------------------------
; UpdateLevel4Mechanics: Bowser AI and hazards
;-----------------------------------------------------------
    UpdateLevel4Mechanics PROC
    pushad
    
    ; If bridge collapsed, Bowser falls
    cmp bridgeCollapsed, 1
    jne NormalBowserUpdate
    cmp bowserY, 20
    jge BowserLava
    inc bowserY
    jmp BowserDone_U
BowserLava:
    mov bowserAlive, 0
    jmp BowserDone_U

NormalBowserUpdate:
    cmp bowserAlive, 0
    je HazardUpdate
    
    ; Bowser gravity (if jumping)
    cmp bowserY, 15
    jge CheckMove
    inc bowserY     ; Simple falling
    
CheckMove:
    inc bowserTimer
    cmp bowserTimer, 20
    jl CheckFire
    
    mov bowserTimer, 0
    ; Random-ish movement
    call Randomize
    mov eax, 10
    call RandomRange
    cmp eax, 5
    jl MoveLeft
    inc bowserX
    jmp CheckJump
MoveLeft:
    dec bowserX

CheckJump:
    ; Periodic jump
    mov eax, 20
    call RandomRange
    cmp eax, 18
    jne CheckFire
    ; Bowser Jump (simplified)
    sub bowserY, 2
    
CheckFire:
    ; Fire Breath
    cmp bowserFireActive, 1
    je UpdateFire
    
    inc bowserFireTimer
    cmp bowserFireTimer, 40
    jl HazardUpdate
    
    mov bowserFireTimer, 0
    mov bowserFireActive, 1
    mov al, bowserX
    sub al, 4
    mov bowserFireX, al
    mov al, bowserY
    add al, 2
    mov bowserFireY, al
    jmp HazardUpdate

UpdateFire:
    sub bowserFireX, 2
    cmp bowserFireX, 2
    jg HazardUpdate
    mov bowserFireActive, 0

HazardUpdate:
    inc firebarTimer
    cmp firebarTimer, 5
    jl FDone
    mov firebarTimer, 0
    inc firebarAngle
    cmp firebarAngle, 8
    jne FDone
    mov firebarAngle, 0
FDone:
BowserDone_U:
    popad
    ret
UpdateLevel4Mechanics ENDP

;-----------------------------------------------------------
; CheckL4Collisions: Lava, Boss, Hazards
;-----------------------------------------------------------
CheckL4Collisions PROC
    pushad
    
    ; 1. Lava Collision (Pit)
    cmp marioY, 20
    jl SkipLava
    ; Instant Death!
    mov playerLives, 0
    call ShowGameOverScreen
    mov gameRunning, 0
    jmp CollDone

SkipLava:
    ; 2. Bowser Collision
    cmp bowserAlive, 0
    je SkipBowser
    mov al, marioX
    mov ah, marioY
    mov bl, bowserX
    mov bh, bowserY
    call CheckOverlap
    cmp cl, 1
    jne SkipBowser
    call MarioTakeDamage

SkipBowser:
    ; 3. Bowser Fire Collision
    cmp bowserFireActive, 0
    je CheckAxeReach
    mov al, marioX
    mov ah, marioY
    mov bl, bowserFireX
    mov bh, bowserFireY
    call CheckOverlap
    cmp cl, 1
    jne CheckAxeReach
    call MarioTakeDamage

CheckFireBars:
    ; 4. Fire Bar Collision
    ; Each ball in the fire bar should be checked. 
    ; The firebar uses firebarAngle and center (40,12) or (60,10)
    ; For now, let's implement a simple check for the general area or use CheckOverlap for each ball.
    ; Assuming we have drawFireBarBalls logic. 
    ; I'll add a simplified check for now to ensure damage is possible.
    
CheckAxeReach:
    ; 4. Axe Interaction (Victory!)
    cmp marioX, 85
    jl CollDone
        
    ; Mario reached the Axe!
    mov bridgeCollapsed, 1  ; Collapse the bridge!
    mov levelCompleted, 1   ; Trigger level complete
    call ShowVictoryCredits_Final
    jmp CollDone
    
CollDone:
    popad
    ret
CheckL4Collisions ENDP

;-----------------------------------------------------------
; UpdateMarioPhysics_L4: Castle Physics (Gravity & Floor)
;-----------------------------------------------------------
UpdateMarioPhysics_L4 PROC
    pushad
    
    ; --- Horizontal Movement & Friction ---
    cmp horizontalInputActive, 1
    je L4StaticX       ; Skip friction if actively moving
    
    cmp velX, 0
    je L4StaticX
    jg L4DecelRight
    inc velX
    jmp L4StaticX
L4DecelRight:
    dec velX
L4StaticX:
    mov al, velX
    add marioX, al
    
    ; Boundaries - signed check
    movsx eax, marioX
    cmp eax, 2
    jge L4CheckRB
    mov marioX, 2
    mov velX, 0
L4CheckRB:
    cmp eax, 90
    jle L4CheckGround
    mov marioX, 90
    mov velX, 0

L4CheckGround:
    ; Skip gravity if on ground
    cmp isOnGround, 1
    je L4EdgeCheck
    
    ; Apply gravity
    inc velY
    mov al, velY
    add marioY, al

L4EdgeCheck:
    ; Check Landing / Edge
    mov al, marioX
    mov cl, marioY
    call IsL4Supported
    cmp al, 1
    jne L4Airborne
    
    ; Supported
    mov isOnGround, 1
    mov velY, 0
    mov marioY, dl      ; Snap to Y returned in DL
    jmp L4PhysicsDone

L4Airborne:
    mov isOnGround, 0

L4PhysicsDone:
    ; Boundary Clamp
    mov al, CEILING_LIMIT
    cmp marioY, al
    jge L4SafeCeil
    mov marioY, al
    mov velY, 0
L4SafeCeil:
    popad
    ret
UpdateMarioPhysics_L4 ENDP

;-----------------------------------------------------------
; IsL4Supported: Pure function for Level 4
;-----------------------------------------------------------
IsL4Supported PROC
    push bx
    push cx
    
    mov bl, al       ; X
    mov bh, cl       ; Y
    
    ; 1. Floor check (Y=18,19,20)
    cmp bh, 18
    jl S4_P1
    mov dl, 18       ; Snap to 18
    jmp L4SupDone1
    
S4_P1:
    ; Plat 1 (20, 12), Width 8
    mov dl, castlePlat1Y
    cmp bh, dl
    jl S4_P2
    add dl, 2
    cmp bh, dl
    jg S4_P2
    cmp bl, castlePlat1X
    jl S4_P2
    mov dl, castlePlat1X
    add dl, 8
    cmp bl, dl
    jle L4SupDone_P1
    
S4_P2:
    ; Plat 2 (40, 10), Width 8
    mov dl, castlePlat2Y
    cmp bh, dl
    jl S4_P3
    add dl, 2
    cmp bh, dl
    jg S4_P3
    cmp bl, castlePlat2X
    jl S4_P3
    mov dl, castlePlat2X
    add dl, 8
    cmp bl, dl
    jle L4SupDone_P2
    
S4_P3:
    ; Plat 3 (55, 14), Width 8
    mov dl, castlePlat3Y
    cmp bh, dl
    jl NotSupp4
    add dl, 2
    cmp bh, dl
    jg NotSupp4
    cmp bl, castlePlat3X
    jl NotSupp4
    mov dl, castlePlat3X
    add dl, 8
    cmp bl, dl
    jle L4SupDone_P3

NotSupp4:
    pop cx
    pop bx
    mov al, 0
    ret
    
L4SupDone_P1: mov dl, castlePlat1Y
    jmp L4SupDone_Final
L4SupDone_P2: mov dl, castlePlat2Y
    jmp L4SupDone_Final
L4SupDone_P3: mov dl, castlePlat3Y
    jmp L4SupDone_Final
L4SupDone1: ; handled above
L4SupDone_Final:
    pop cx
    pop bx
    mov al, 1
    ret
IsL4Supported ENDP


;-----------------------------------------------------------
; DrawFireBar: Draw a rotating fire chain
;-----------------------------------------------------------
DrawFireBar PROC
    ; DL=AnchorX, DH=AnchorY
    pushad
    mov eax, YELLOW
    call SetTextColor
    
    ; Store anchor
    mov bl, dl
    mov bh, dh
    
    ; Angle determines where balls go (0-7: R, DR, D, DL, L, UL, U, UR)
    mov al, firebarAngle
    
    ; Draw 3 balls in the chain
    mov ecx, 3
L4FBarLoop:
    push ecx
    ; simple addition per ball distance
    cmp firebarAngle, 0     ; Right
    jne F_DR
    inc bl
    jmp FDraw
F_DR:
    cmp firebarAngle, 1
    jne F_D
    inc bl
    inc bh
    jmp FDraw
F_D:
    cmp firebarAngle, 2
    jne F_DL
    inc bh
    jmp FDraw
F_DL:
    cmp firebarAngle, 3
    jne F_L
    dec bl
    inc bh
    jmp FDraw
F_L:
    cmp firebarAngle, 4
    jne F_UL
    dec bl
    jmp FDraw
F_UL:
    cmp firebarAngle, 5
    jne F_U
    dec bl
    dec bh
    jmp FDraw
F_U:
    cmp firebarAngle, 6
    jne F_UR
    dec bh
    jmp FDraw
F_UR:
    inc bl
    dec bh

FDraw:
    mov dl, bl
    mov dh, bh
    call Gotoxy
    mov al, 'o'
    call WriteChar
    pop ecx
    loop L4FBarLoop
    
    popad
    ret
DrawFireBar ENDP

;-----------------------------------------------------------
; ShowVictoryCredits_Final: The "Thank You Mario!" screen
;-----------------------------------------------------------
ShowVictoryCredits_Final PROC
    call Clrscr
    mov eax, WHITE
    call SetTextColor
    
    mov dh, 10
    mov dl, 30
    call Gotoxy
    mov edx, OFFSET victMsg1
    call WriteString
    
    mov dh, 12
    mov dl, 25
    call Gotoxy
    mov edx, OFFSET victMsg2
    call WriteString
    
    mov dh, 15
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET victMsg3
    call WriteString
    
    call WaitForKey
    call MainMenuScreen
    ret
ShowVictoryCredits_Final ENDP

; ============================================================
; PlaySoundEffect - Play a WAV sound file
; Input: EDX = offset of sound file path
; ============================================================
PlaySoundEffect PROC
    pushad
    INVOKE PlaySoundA, edx, 0, SND_FILENAME + SND_ASYNC
    popad
    ret
PlaySoundEffect ENDP

; ============================================================
; PromptPlayerInfo - Get player name and roll number
; ============================================================
PromptPlayerInfo PROC
    pushad
    
    call Clrscr
    mov eax, WHITE
    call SetTextColor
    
    ; Display title
    mov dh, 5
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET enterNameMsg
    call WriteString
    
    ; Get player name
    mov edi, OFFSET currentPlayerName
    mov ecx, 20
    mov al, 0
    rep stosb
    mov edx, OFFSET currentPlayerName
    mov ecx, 19
    call ReadString
    
    ; Display roll number prompt
    mov dh, 7
    mov dl, 20
    call Gotoxy
    mov edx, OFFSET enterRollMsg
    call WriteString
    
    ; Get roll number
    mov edi, OFFSET currentPlayerRoll
    mov ecx, 15
    mov al, 0
    rep stosb
    mov edx, OFFSET currentPlayerRoll
    mov ecx, 14
    call ReadString
    
    ; Show confirmation
    mov dh, 10
    mov dl, 20
    call Gotoxy
    mov eax, LIGHTGREEN
    call SetTextColor
    mov edx, OFFSET currentPlayerName
    call WriteString
    
    mov al, ' '
    call WriteChar
    mov al, '('
    call WriteChar
    mov edx, OFFSET currentPlayerRoll
    call WriteString
    mov al, ')'
    call WriteChar
    
    ; Pause briefly
    mov eax, 1500
    call Delay
    
    popad
    ret
PromptPlayerInfo ENDP

; ============================================================
; SavePlayerProgress - Save current player state to file
; ============================================================
SavePlayerProgress PROC
    pushad
    
    ; Create/overwrite progress file
    mov edx, OFFSET progressFile
    call CreateOutputFile
    cmp eax, INVALID_HANDLE_VALUE
    je SaveDone
    
    mov fileHandle, eax
    
    ; Write player name (20 bytes)
    mov eax, fileHandle
    mov edx, OFFSET currentPlayerName
    mov ecx, 20
    call WriteToFile
    
    ; Write roll number (15 bytes)
    mov eax, fileHandle
    mov edx, OFFSET currentPlayerRoll
    mov ecx, 15
    call WriteToFile
    
    ; Write current level (1 byte)
    mov eax, fileHandle
    mov edx, OFFSET currentLevelNum
    mov ecx, 1
    call WriteToFile
    
    ; Write score (4 bytes)
    mov eax, fileHandle
    mov edx, OFFSET playerScore
    mov ecx, 4
    call WriteToFile
    
    ; Write lives (4 bytes)
    mov eax, fileHandle
    mov edx, OFFSET playerLives
    mov ecx, 4
    call WriteToFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile

SaveDone:
    popad
    ret
SavePlayerProgress ENDP

; ============================================================
; LoadPlayerProgress - Load player state from file
; Returns: EAX = 1 if loaded, 0 if no save found
; ============================================================
LoadPlayerProgress PROC
    push ebx
    push ecx
    push edx
    
    ; Try to open progress file
    mov edx, OFFSET progressFile
    call OpenInputFile
    cmp eax, INVALID_HANDLE_VALUE
    je NoSaveFound
    
    mov fileHandle, eax
    
    ; Read player name
    mov eax, fileHandle
    mov edx, OFFSET currentPlayerName
    mov ecx, 20
    call ReadFromFile
    
    ; Read roll number
    mov eax, fileHandle
    mov edx, OFFSET currentPlayerRoll
    mov ecx, 15
    call ReadFromFile
    
    ; Read current level
    mov eax, fileHandle
    mov edx, OFFSET savedLevel
    mov ecx, 1
    call ReadFromFile
    
    ; Read score
    mov eax, fileHandle
    mov edx, OFFSET savedHighScore
    mov ecx, 4
    call ReadFromFile
    
    ; Read lives
    mov eax, fileHandle
    mov edx, OFFSET playerLives
    mov ecx, 4
    call ReadFromFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
    
    mov eax, 1          ; Success
    jmp LoadDone
    
NoSaveFound:
    mov eax, 0          ; No save found
    
LoadDone:
    pop edx
    pop ecx
    pop ebx
    ret
LoadPlayerProgress ENDP

END main

