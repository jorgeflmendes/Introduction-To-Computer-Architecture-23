; *****************************************************************************************************************************
; * Introduction to Computer Architecture (IST - UL)
; * Description: Project "Beyond Mars"
; *****************************************************************************************************************************

; *****************************************************************************************************************************
; * Constants:
; *****************************************************************************************************************************
    ; Keys used in the game:
    START_GAME_KEY EQU 0CH        ; key value required to start the game
    LAUNCH_LEFT_PROBE_KEY EQU 0H  ; key value used to launch the probe to the left
    LAUNCH_VERTICAL_PROBE_KEY EQU 1H ; key value used to launch the vertical probe
    LAUNCH_RIGHT_PROBE_KEY EQU 2H  ; key value used to launch the probe to the right
    PAUSE_GAME_KEY EQU 0FH          ; key value used to pause the game
    END_GAME_KEY EQU 0EH    ; key value used by the player to end the game
    INVALID_KEY EQU -1        ; value used for an invalid key
    
    ; Peripheral addresses:
    DISPLAYS_ADDRESS EQU 0A000H      ; address of the three 7-segment displays (POUT peripheral 1) that show the ship energy
    KEYBOARD_ROW_ADDRESS EQU 0C000H   ; address of the keyboard row register (POUT peripheral 2)
    KEYBOARD_COLUMN_ADDRESS EQU 0E000H   ; address of the keyboard column register (PIN peripheral)
    
    ; Energy-related constants:
    INITIAL_ENERGY_DECIMAL EQU 100     ; initial ship energy value in decimal
    INITIAL_ENERGY_HEXADECIMAL EQU 100H; initial ship energy value in hexadecimal, visually matching the decimal value
    PASSIVE_ENERGY_DRAIN EQU -3     ; value subtracted from the energy over time
    PROBE_ENERGY_COST EQU -5; value subtracted from the energy for each probe
    MINING_ENERGY_REWARD EQU 25; value added to the ship energy when it mines an asteroid
    
    ; General constants:
    INITIAL_KEYBOARD_ROW EQU 8      ; initial keyboard row used when scanning the keyboard (the 4th row)
    KEYBOARD_COLUMN_MASK EQU 0FH          ; mask used to isolate the 4 least significant bits when reading the keyboard columns
    RANDOM_TWO_BIT_MASK EQU 3H         ; mask used to isolate the 2 least significant bits when generating random numbers
    DEFAULT_DELAY EQU 20000      ; value used by the RUN_DELAY routine
    MAX_PROBE_RANGE_FROM_SHIP EQU -16  ; maximum distance that probes can travel from the ship (i.e. 16 vertical pixels above it)
    MAX_ACTIVE_PROBES EQU 3; maximum number of simultaneous probes
    MAX_ASTEROID_SLOTS EQU 4
    ASTEROID_TRAJECTORY_COUNT EQU 5; number of trajectories/positions possible for the asteroids
    
    ; Screen dimensions:
    SCREEN_HEIGHT EQU 32; screen height
    SCREEN_WIDTH EQU 64; screen width

    ; Base address for Media Center commands:
    MEDIA_CENTER_COMMAND_BASE EQU 6000H

    ; Media Center write commands:
    CMD_CLEAR_SCREEN_PIXELS EQU MEDIA_CENTER_COMMAND_BASE + 00H
    CMD_CLEAR_ALL_SCREEN_PIXELS EQU MEDIA_CENTER_COMMAND_BASE + 02H ; command address used to clear all pixels on every screen
    CMD_SELECT_SCREEN EQU MEDIA_CENTER_COMMAND_BASE + 04H
    CMD_SELECT_ROW EQU MEDIA_CENTER_COMMAND_BASE + 0AH
    CMD_SELECT_COLUMN EQU MEDIA_CENTER_COMMAND_BASE + 0CH
    CMD_WRITE_PIXEL EQU MEDIA_CENTER_COMMAND_BASE + 12H ; command address used to write a pixel
    CMD_CLEAR_WARNING EQU MEDIA_CENTER_COMMAND_BASE + 40H
    CMD_SET_BACKGROUND EQU MEDIA_CENTER_COMMAND_BASE + 42H ; command address used to set the background
    CMD_CLEAR_FOREGROUND_IMAGE EQU MEDIA_CENTER_COMMAND_BASE + 44H ; command address used to clear the foreground image
    CMD_OVERLAY_IMAGE EQU MEDIA_CENTER_COMMAND_BASE + 46H ; command address used to overlay an image on the screen
    CMD_START_PLAYBACK EQU MEDIA_CENTER_COMMAND_BASE + 5AH ; command address used to start media playback
    CMD_START_LOOP_PLAYBACK EQU MEDIA_CENTER_COMMAND_BASE + 5CH ; command address used to start looping media playback
    CMD_PAUSE_ALL_MEDIA EQU MEDIA_CENTER_COMMAND_BASE + 62H ; command address used to pause all media playback
    CMD_RESUME_ALL_MEDIA EQU MEDIA_CENTER_COMMAND_BASE + 64H ; command address used to resume paused media playback
    CMD_STOP_ALL_MEDIA EQU MEDIA_CENTER_COMMAND_BASE + 68H ; command address used to stop all media playback
    CMD_STOP_PLAYBACK EQU MEDIA_CENTER_COMMAND_BASE + 66H ; command address used to stop media playback

    ; Media Center read commands:
    CMD_READ_PIXEL_COLOR EQU MEDIA_CENTER_COMMAND_BASE + 10H; command address used to read the color of the current pixel
    
    ; Background asset identifiers:
    GAME_BACKGROUND_ID EQU 0
    BLACK_BACKGROUND_ID EQU 1
    PAUSE_OVERLAY_ID EQU 2
    
    ; Video and audio asset identifiers:
    MENU_VIDEO_ID EQU 0; main menu video ID
    GAME_START_SOUND_ID EQU 1; sound played at the start of each game
    GAME_MUSIC_ID EQU 2; background music played during gameplay
    PROBE_LAUNCH_SOUND_ID EQU 3; sound played for each probe launch
    ASTEROID_SPAWN_SOUND_ID EQU 4; sound played whenever an asteroid spawns
    ENERGY_GAME_OVER_SOUND_ID EQU 5; sound played when the energy runs out
    ENERGY_GAME_OVER_VIDEO_ID EQU 6; video played when the energy runs out
    PAUSE_SOUND_ID EQU 7; sound played when the game is paused
    MINING_SUCCESS_SOUND_ID EQU 8; sound played when a minable asteroid is mined
    ASTEROID_EXPLOSION_SOUND_ID EQU 9; sound played when an asteroid is hit by a probe and explodes
    SHIP_EXPLOSION_GAME_OVER_SOUND_ID EQU 10; sound played when an asteroid hits the ship
    SHIP_EXPLOSION_GAME_OVER_VIDEO_ID EQU 11; video played when the ship explodes
    USER_ABORT_GAME_OVER_VIDEO_ID EQU 12; video played when the user ends the game with the key
    
    ; Pixel screen identifiers:
    ASTEROID_1_SCREEN EQU 0         ; used for the asteroid number 1
    ASTEROID_2_SCREEN EQU 1         ; used for the asteroid number 2
    ASTEROID_3_SCREEN EQU 2         ; used for the asteroid number 3
    ASTEROID_4_SCREEN EQU 3         ; used for the asteroid number 4
    MAIN_SHIP_SCREEN EQU 4         ; used for the ship
    LEFT_PROBE_SCREEN EQU 5         ; used for the left probe
    VERTICAL_PROBE_SCREEN EQU 6        ; used for the vertical probe
    RIGHT_PROBE_SCREEN EQU 7         ; used for the right probe
    
    ; ARGB colors used by the game visuals:
    COLOR_TRANSPARENT EQU 0              ; transparent color
    COLOR_DARK_GRAY EQU 0F444H          ; dark gray
    COLOR_LIGHT_GRAY EQU 0FAAAH           ; light gray
    COLOR_BLACK EQU 0F000H            ; black
    COLOR_LIGHT_GREEN EQU 0F060H          ; light green
    COLOR_DARK_GREEN EQU 0F040H         ; dark green
    COLOR_LIGHT_BLUE EQU 0F4ACH           ; light blue
    COLOR_LIGHT_BROWN EQU 0F642H        ; light brown
    COLOR_DARK_BROWN EQU 0F210H       ; dark brown
    COLOR_LIGHT_RED EQU 0FF44H        ; light red
    COLOR_BRIGHT_RED EQU 0FF00H        ; bright red
    COLOR_DARK_RED EQU 0F400H       ; dark red
    COLOR_ORANGE EQU 0FE60H           ; orange
    COLOR_YELLOW EQU 0FFF4H           ; yellow

    ; Flags that describe asteroid slot occupancy:
    ASTEROID_SLOT_EMPTY EQU 0; indicates that an asteroid slot is free
    ASTEROID_SLOT_OCCUPIED EQU 1; indicates that an asteroid slot is occupied

    ; Asteroid types and trajectories:
    ASTEROID_TYPE_UNDEFINED EQU -1 ; represents an asteroid whose type has not been defined yet
    ASTEROID_TYPE_MINABLE EQU 0 ; represents a minable asteroid
    ASTEROID_TYPE_NON_MINABLE EQU 1 ; represents a non-minable asteroid
    ASTEROID_PATH_LEFT EQU 0 ; represents an asteroid on the left path
    ASTEROID_PATH_CENTER_DIAGONAL_LEFT EQU 1 ; represents an asteroid on the center-left diagonal path
    ASTEROID_PATH_CENTER_VERTICAL EQU 2 ; represents an asteroid on the center vertical path
    ASTEROID_PATH_CENTER_DIAGONAL_RIGHT EQU 3 ; represents an asteroid on the center-right diagonal path
    ASTEROID_PATH_RIGHT EQU 4 ; represents an asteroid on the right path

    ; Flags that describe probe slot occupancy:
    PROBE_SLOT_EMPTY EQU 0; indicates that a probe slot is free
    PROBE_SLOT_OCCUPIED EQU 1; indicates that a probe slot is occupied

    ; Probe types:
    PROBE_TYPE_LEFT EQU 0 ; represents a probe launched to the left
    PROBE_TYPE_VERTICAL EQU 1 ; represents a vertically launched probe
    PROBE_TYPE_RIGHT EQU 2 ; represents a probe launched to the right
    
    ; Object dimensions:
    SHIP_HEIGHT EQU 5            ; height of the ship
    SHIP_WIDTH EQU 14          ; width of the ship
    SHIP_LIGHTS_HEIGHT EQU 2      ; height of the lights of the ship
    SHIP_LIGHTS_WIDTH EQU 4     ; width of the lights of the ship
    PROBE_HEIGHT EQU 2           ; height of the probe
    PROBE_WIDTH EQU 1          ; width of the probe
    ASTEROID_HEIGHT EQU 5        ; height of the asteroids
    ASTEROID_WIDTH EQU 5       ; width of the asteroids
    
    ; Initial positions of core objects:
    SHIP_INITIAL_ROW EQU 27 ; initial row of the ship
    SHIP_INITIAL_COLUMN EQU 25 ; initial column of the ship
    SHIP_LIGHTS_INITIAL_ROW EQU 30 ; initial row of the ship lights
    SHIP_LIGHTS_INITIAL_COLUMN EQU 30 ; initial column of the ship lights

    ; Initial positions of each probe type:
    LEFT_PROBE_INITIAL_ROW EQU 26 ; initial row of the left probe
    LEFT_PROBE_INITIAL_COLUMN EQU 26 ; initial column of the left probe
    VERTICAL_PROBE_INITIAL_ROW EQU 27 ; initial row of the vertical probe
    VERTICAL_PROBE_INITIAL_COLUMN EQU 32 ; initial column of the vertical probe
    RIGHT_PROBE_INITIAL_ROW EQU 26 ; initial row of the right probe
    RIGHT_PROBE_INITIAL_COLUMN EQU 37 ; initial column of the right probe

    ; Initial asteroid positions:
    LEFT_ASTEROID_INITIAL_ROW EQU 0 ; initial row of the left-path asteroid
    LEFT_ASTEROID_INITIAL_COLUMN EQU 0 ; initial column of the left-path asteroid
    CENTER_LEFT_ASTEROID_INITIAL_ROW EQU 0 ; initial row of the center-left asteroid
    CENTER_LEFT_ASTEROID_INITIAL_COLUMN EQU 29 ; initial column of the center-left asteroid
    CENTER_VERTICAL_ASTEROID_INITIAL_ROW EQU 0 ; initial row of the center asteroid
    CENTER_VERTICAL_ASTEROID_INITIAL_COLUMN EQU 30 ; initial column of the center asteroid
    CENTER_RIGHT_ASTEROID_INITIAL_ROW EQU 0 ; initial row of the center-right asteroid
    CENTER_RIGHT_ASTEROID_INITIAL_COLUMN EQU 31 ; initial column of the center-right asteroid
    RIGHT_ASTEROID_INITIAL_ROW EQU 0 ; initial row of the right-path asteroid
    RIGHT_ASTEROID_INITIAL_COLUMN EQU 59 ; initial column of the right-path asteroid

    ; Game states:
    GAME_STATE_NOT_STARTED EQU 0 ; game state when no game has started
    GAME_STATE_RUNNING EQU 1 ; game state while the game is running
    GAME_STATE_PAUSED EQU 2 ; game state while the game is paused
    GAME_STATE_FINISHED EQU 3 ; game state after the game has finished

    ; Ship light patterns:
    SHIP_LIGHTS_OFF EQU 0; lights disabled
    SHIP_LIGHTS_PATTERN_1 EQU 1; ship light pattern 1
    SHIP_LIGHTS_PATTERN_2 EQU 2; ship light pattern 2
    SHIP_LIGHTS_PATTERN_3 EQU 3; ship light pattern 3
    SHIP_LIGHTS_PATTERN_4 EQU 4; ship light pattern 4

    ; Asteroid collision types:
    COLLISION_WITH_SHIP EQU 1 ; collision with the ship
    COLLISION_WITH_LEFT_PROBE EQU 2 ; collision with the left probe
    COLLISION_WITH_VERTICAL_PROBE EQU 3 ; collision with the vertical probe
    COLLISION_WITH_RIGHT_PROBE EQU 4 ; collision with the right probe

    ; Reasons for ending the game:
    GAME_END_NONE EQU 0; game has not ended
    GAME_END_OUT_OF_ENERGY EQU 1; game ended because the ship ran out of energy
    GAME_END_SHIP_COLLISION EQU 2; game ended because an asteroid hit the ship
    GAME_END_USER_REQUEST EQU 3; game ended because the user requested termination
    
    ; Probe movement vectors:
    LEFT_PROBE_VERTICAL_STEP EQU -1 ; left probe vertical increment
    LEFT_PROBE_HORIZONTAL_STEP EQU -1 ; left probe horizontal increment
    VERTICAL_PROBE_VERTICAL_STEP EQU -1 ; center probe vertical increment
    VERTICAL_PROBE_HORIZONTAL_STEP EQU 0 ; center probe horizontal increment
    RIGHT_PROBE_VERTICAL_STEP EQU -1 ; right probe vertical increment
    RIGHT_PROBE_HORIZONTAL_STEP EQU 1 ; right probe horizontal increment

    ; Asteroid movement vectors:
    LEFT_ASTEROID_VERTICAL_STEP EQU 1 ; left-path asteroid vertical increment
    LEFT_ASTEROID_HORIZONTAL_STEP EQU 1 ; left-path asteroid horizontal increment
    CENTER_LEFT_ASTEROID_VERTICAL_STEP EQU 1 ; center-left asteroid vertical increment
    CENTER_LEFT_ASTEROID_HORIZONTAL_STEP EQU -1 ; center-left asteroid horizontal increment
    CENTER_VERTICAL_ASTEROID_VERTICAL_STEP EQU 1 ; center asteroid vertical increment
    CENTER_VERTICAL_ASTEROID_HORIZONTAL_STEP EQU 0 ; center asteroid horizontal increment
    CENTER_RIGHT_ASTEROID_VERTICAL_STEP EQU 1 ; center-right asteroid vertical increment
    CENTER_RIGHT_ASTEROID_HORIZONTAL_STEP EQU 1 ; center-right asteroid horizontal increment
    RIGHT_ASTEROID_VERTICAL_STEP EQU 1 ; right-path asteroid vertical increment
    RIGHT_ASTEROID_HORIZONTAL_STEP EQU -1 ; right-path asteroid horizontal increment

; *****************************************************************************************************************************
PLACE 1000H

; **************************************** STACKS ****************************************
MAIN_STACK: STACK 100H ; reserved space for the main stack
INITIAL_MAIN_STACK_POINTER: ; initial stack pointer for the main stack

REDUCE_ENERGY_STACK: STACK 100H ; reserved space for the "REDUCE_ENERGY" process stack
INITIAL_REDUCE_ENERGY_STACK_POINTER: ; initial stack pointer for the "REDUCE_ENERGY" process stack

UPDATE_SHIP_LIGHTS_STACK: STACK 100H ; reserved space for the "UPDATE_SHIP_LIGHTS" process stack
INITIAL_UPDATE_SHIP_LIGHTS_STACK_POINTER: ; initial stack pointer for the "UPDATE_SHIP_LIGHTS" process stack

LAUNCH_PROBE_STACK: STACK 400H ; reserved space for the "LAUNCH_PROBE" process stack
INITIAL_LAUNCH_PROBE_STACK_POINTER: ; initial stack pointer for the "LAUNCH_PROBE" process stack

PREPARE_ASTEROID_STACK: STACK 100H ; reserved space for the "PREPARE_ASTEROID" process stack
INITIAL_PREPARE_ASTEROID_STACK_POINTER: ; initial stack pointer for the "PREPARE_ASTEROID" process stack

MOVE_ASTEROID_STACK: STACK 400H ; reserved space for the "MOVE_ASTEROID" process stack
INITIAL_MOVE_ASTEROID_STACK_POINTER: ; initial stack pointer for the "MOVE_ASTEROID" process stack

; ******************************** Interrupt Vector Table *******************************
INTERRUPT_VECTOR_TABLE: WORD INTERRUPT_ROUTINE_0
                  WORD INTERRUPT_ROUTINE_1
                  WORD INTERRUPT_ROUTINE_2
                  WORD INTERRUPT_ROUTINE_3

; **************** Lock Variables Used to Synchronize Processes ****************
LAST_KEY_PRESSED: LOCK 0            ; synchronizes keyboard input and stores the last pressed key (1, 2, ..., F)
ASTEROID_MOTION_EVENT: LOCK 0          ; synchronizes asteroid movement
PROBE_MOTION_EVENT: LOCK 0; synchronizes probe movement
ENERGY_TICK_EVENT: LOCK 0; synchronizes periodic energy drain
SHIP_LIGHTS_EVENT: LOCK 0; synchronizes ship light updates

; ********************************* Global Variables *********************************
; Global variables:
GAME_STATE: WORD GAME_STATE_NOT_STARTED; stores the state of the game
GAME_END_REASON: WORD 0; stores the reason why the current game ended
SHIP_ENERGY: WORD 0; stores the energy of the ship
CURRENT_SHIP_LIGHTS_PATTERN: WORD 0     ; stores the currently active ship light pattern
REQUESTED_PROBE_TYPE: WORD 0; stores the type of probe requested by the player

SELECTED_ASTEROID_SCREEN: WORD -1
SELECTED_ASTEROID_ATTRIBUTE: WORD -1
SELECTED_ASTEROID_POSITION: WORD -1

; ************************ Object Visual Definitions ************************
SHIP_SPRITE:                     ; ship sprite definition
    WORD SHIP_WIDTH            ; sprite width
    WORD SHIP_HEIGHT             ; sprite height
    ; Colors of the pixels of the ship:
    WORD COLOR_BLACK, COLOR_BLACK, COLOR_BLACK, COLOR_TRANSPARENT, COLOR_TRANSPARENT, COLOR_TRANSPARENT, COLOR_TRANSPARENT, COLOR_TRANSPARENT, COLOR_TRANSPARENT, COLOR_TRANSPARENT, COLOR_TRANSPARENT, COLOR_BLACK, COLOR_BLACK, COLOR_BLACK
    WORD COLOR_BLACK, COLOR_DARK_GRAY, COLOR_BLACK, COLOR_TRANSPARENT, COLOR_BLACK, COLOR_BLACK, COLOR_BLACK, COLOR_BLACK, COLOR_BLACK, COLOR_BLACK, COLOR_TRANSPARENT, COLOR_BLACK, COLOR_DARK_GRAY, COLOR_BLACK
    WORD COLOR_BLACK, COLOR_DARK_GRAY, COLOR_BLACK, COLOR_BLACK, COLOR_BLACK, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_BLACK, COLOR_BLACK, COLOR_BLACK, COLOR_DARK_GRAY, COLOR_BLACK
    WORD COLOR_BLACK, COLOR_DARK_GRAY, COLOR_DARK_GRAY, COLOR_BLACK, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_BLACK, COLOR_DARK_GRAY, COLOR_DARK_GRAY, COLOR_BLACK
    WORD COLOR_BLACK, COLOR_DARK_GRAY, COLOR_DARK_GRAY, COLOR_BLACK, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_LIGHT_GRAY, COLOR_BLACK, COLOR_DARK_GRAY, COLOR_DARK_GRAY, COLOR_BLACK

PROBE_SPRITE:               ; probe sprite definition
    WORD PROBE_WIDTH      ; sprite width
    WORD PROBE_HEIGHT       ; sprite height
    ; Values of the colors of the pixels of the probe:
    WORD COLOR_DARK_RED
    
NON_MINABLE_ASTEROID_SPRITE:    ; non-minable asteroid sprite definition
    WORD ASTEROID_WIDTH        ; sprite width
    WORD ASTEROID_HEIGHT         ; sprite height
    ; Values of the colors of the pixels of the asteroid non-minable:
    WORD COLOR_TRANSPARENT, COLOR_DARK_BROWN, COLOR_DARK_BROWN, COLOR_LIGHT_BROWN, COLOR_TRANSPARENT
    WORD COLOR_LIGHT_BROWN, COLOR_LIGHT_BROWN, COLOR_LIGHT_BROWN, COLOR_LIGHT_BROWN, COLOR_DARK_BROWN
    WORD COLOR_LIGHT_BROWN, COLOR_LIGHT_BROWN, COLOR_DARK_BROWN, COLOR_LIGHT_BROWN, COLOR_LIGHT_BROWN
    WORD COLOR_DARK_BROWN, COLOR_LIGHT_BROWN, COLOR_LIGHT_BROWN, COLOR_LIGHT_BROWN, COLOR_LIGHT_BROWN
    WORD COLOR_TRANSPARENT, COLOR_DARK_BROWN, COLOR_LIGHT_BROWN, COLOR_DARK_BROWN, COLOR_TRANSPARENT

ASTEROID_EXPLOSION_SPRITE:
    WORD ASTEROID_WIDTH        ; sprite width
    WORD ASTEROID_HEIGHT         ; sprite height
    ; Values of the colors of the pixels of the asteroid in explosion:
    WORD	COLOR_TRANSPARENT,	COLOR_BRIGHT_RED,	COLOR_ORANGE,	COLOR_BRIGHT_RED,	COLOR_TRANSPARENT
    WORD	COLOR_BRIGHT_RED,	COLOR_BRIGHT_RED,	COLOR_ORANGE,	COLOR_ORANGE,	COLOR_ORANGE
    WORD	COLOR_BRIGHT_RED,	COLOR_ORANGE,	COLOR_ORANGE,	COLOR_ORANGE,	COLOR_BRIGHT_RED
    WORD	COLOR_BRIGHT_RED,	COLOR_BRIGHT_RED,	COLOR_ORANGE,	COLOR_BRIGHT_RED,	COLOR_BRIGHT_RED
    WORD	COLOR_TRANSPARENT,	COLOR_BRIGHT_RED,	COLOR_BRIGHT_RED,	COLOR_BRIGHT_RED,	COLOR_TRANSPARENT

MINABLE_ASTEROID_SPRITE:
    WORD ASTEROID_WIDTH        ; sprite width
    WORD ASTEROID_HEIGHT         ; sprite height
    ; Values of the colors of the pixels of the asteroid minable:
    WORD	COLOR_TRANSPARENT,	COLOR_LIGHT_GREEN,	COLOR_DARK_GRAY,	COLOR_DARK_GRAY,	COLOR_TRANSPARENT
    WORD	COLOR_DARK_GREEN,	COLOR_LIGHT_GREEN,	COLOR_LIGHT_GRAY,	COLOR_DARK_GRAY,	COLOR_DARK_GRAY
    WORD	COLOR_DARK_GREEN,	COLOR_LIGHT_BLUE,	COLOR_LIGHT_GREEN,	COLOR_LIGHT_GRAY,	COLOR_DARK_GRAY
    WORD	COLOR_LIGHT_BLUE,	COLOR_LIGHT_BLUE,	COLOR_DARK_GREEN,	COLOR_LIGHT_GRAY,	COLOR_LIGHT_GRAY
    WORD	COLOR_TRANSPARENT,	COLOR_DARK_GREEN,	COLOR_DARK_GREEN,	COLOR_LIGHT_GREEN,	COLOR_TRANSPARENT

ASTEROID_MINING_STAGE_1_SPRITE:
    WORD ASTEROID_WIDTH        ; sprite width
    WORD ASTEROID_HEIGHT         ; sprite height
    ; Values of the colors of the pixels of the first mining stage of the asteroid minable:
    WORD	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT
    WORD	COLOR_TRANSPARENT,	COLOR_LIGHT_GREEN,	COLOR_LIGHT_GRAY,	COLOR_DARK_GRAY,	COLOR_TRANSPARENT
    WORD	COLOR_TRANSPARENT,	COLOR_LIGHT_BLUE,	COLOR_LIGHT_GREEN,	COLOR_LIGHT_GRAY,	COLOR_TRANSPARENT
    WORD	COLOR_TRANSPARENT,	COLOR_LIGHT_BLUE,	COLOR_DARK_GREEN,	COLOR_LIGHT_GRAY,	COLOR_TRANSPARENT
    WORD	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT

ASTEROID_MINING_STAGE_2_SPRITE:
    WORD ASTEROID_WIDTH        ; sprite width
    WORD ASTEROID_HEIGHT         ; sprite height
    ; Values of the colors of the pixels of the second mining stage of the asteroid minable:
    WORD	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT
    WORD	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT
    WORD	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_LIGHT_GREEN,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT
    WORD	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT
    WORD	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT,	COLOR_TRANSPARENT

SHIP_LIGHTS_PATTERN_1_SPRITE:
    WORD SHIP_LIGHTS_WIDTH            ; sprite width
    WORD SHIP_LIGHTS_HEIGHT              ; sprite height

    WORD	COLOR_LIGHT_GRAY,	COLOR_YELLOW,	COLOR_YELLOW,	COLOR_LIGHT_GRAY
    WORD	COLOR_LIGHT_RED,	COLOR_YELLOW,	COLOR_YELLOW,	COLOR_YELLOW

SHIP_LIGHTS_PATTERN_2_SPRITE:
    WORD SHIP_LIGHTS_WIDTH            ; sprite width
    WORD SHIP_LIGHTS_HEIGHT              ; sprite height

    WORD	COLOR_LIGHT_GRAY,	COLOR_LIGHT_RED,	COLOR_YELLOW,	COLOR_LIGHT_GRAY
    WORD	COLOR_YELLOW,	COLOR_LIGHT_RED,	COLOR_YELLOW,	COLOR_YELLOW

SHIP_LIGHTS_PATTERN_3_SPRITE:
    WORD SHIP_LIGHTS_WIDTH            ; sprite width
    WORD SHIP_LIGHTS_HEIGHT              ; sprite height

    WORD	COLOR_LIGHT_GRAY,	COLOR_YELLOW,	COLOR_LIGHT_RED,	COLOR_LIGHT_GRAY
    WORD	COLOR_YELLOW,	COLOR_YELLOW,	COLOR_LIGHT_RED,	COLOR_YELLOW

SHIP_LIGHTS_PATTERN_4_SPRITE:
    WORD SHIP_LIGHTS_WIDTH            ; sprite width
    WORD SHIP_LIGHTS_HEIGHT              ; sprite height

    WORD	COLOR_LIGHT_GRAY,	COLOR_YELLOW,	COLOR_YELLOW,	COLOR_LIGHT_GRAY
    WORD	COLOR_YELLOW,	COLOR_YELLOW,	COLOR_YELLOW,	COLOR_LIGHT_RED

SHIP_LIGHTS_SPRITE_TABLE:
    WORD SHIP_LIGHTS_PATTERN_1_SPRITE
    WORD SHIP_LIGHTS_PATTERN_2_SPRITE
    WORD SHIP_LIGHTS_PATTERN_3_SPRITE
    WORD SHIP_LIGHTS_PATTERN_4_SPRITE

; ************************ Probe Movement Definitions ************************
LEFT_PROBE_MOVEMENT_VECTOR:
WORD LEFT_PROBE_VERTICAL_STEP ; vertical increment
WORD LEFT_PROBE_HORIZONTAL_STEP ; horizontal increment

VERTICAL_PROBE_MOVEMENT_VECTOR:
WORD VERTICAL_PROBE_VERTICAL_STEP ; vertical increment
WORD VERTICAL_PROBE_HORIZONTAL_STEP ; horizontal increment

RIGHT_PROBE_MOVEMENT_VECTOR:
WORD RIGHT_PROBE_VERTICAL_STEP ; vertical increment
WORD RIGHT_PROBE_HORIZONTAL_STEP ; horizontal increment

; ************************ Probe Configuration Tables ************************
PROBE_SCREEN_TABLE:
    WORD LEFT_PROBE_SCREEN
    WORD VERTICAL_PROBE_SCREEN
    WORD RIGHT_PROBE_SCREEN

PROBE_INITIAL_ROW_TABLE:
    WORD LEFT_PROBE_INITIAL_ROW
    WORD VERTICAL_PROBE_INITIAL_ROW
    WORD RIGHT_PROBE_INITIAL_ROW

PROBE_INITIAL_COLUMN_TABLE:
    WORD LEFT_PROBE_INITIAL_COLUMN
    WORD VERTICAL_PROBE_INITIAL_COLUMN
    WORD RIGHT_PROBE_INITIAL_COLUMN

PROBE_MOVEMENT_VECTOR_TABLE:
    WORD LEFT_PROBE_MOVEMENT_VECTOR
    WORD VERTICAL_PROBE_MOVEMENT_VECTOR
    WORD RIGHT_PROBE_MOVEMENT_VECTOR

PROBE_COLLISION_TYPE_TABLE:
    WORD COLLISION_WITH_LEFT_PROBE
    WORD COLLISION_WITH_VERTICAL_PROBE
    WORD COLLISION_WITH_RIGHT_PROBE

; *********************** Asteroid Movement Definitions ************************
LEFT_ASTEROID_MOVEMENT_VECTOR:
    WORD LEFT_ASTEROID_VERTICAL_STEP ; vertical increment
    WORD LEFT_ASTEROID_HORIZONTAL_STEP ; horizontal increment

CENTER_LEFT_ASTEROID_MOVEMENT_VECTOR:
    WORD CENTER_LEFT_ASTEROID_VERTICAL_STEP ; vertical increment
    WORD CENTER_LEFT_ASTEROID_HORIZONTAL_STEP ; horizontal increment

CENTER_VERTICAL_ASTEROID_MOVEMENT_VECTOR:
    WORD CENTER_VERTICAL_ASTEROID_VERTICAL_STEP ; vertical increment
    WORD CENTER_VERTICAL_ASTEROID_HORIZONTAL_STEP ; horizontal increment

CENTER_RIGHT_ASTEROID_MOVEMENT_VECTOR:
    WORD CENTER_RIGHT_ASTEROID_VERTICAL_STEP ; vertical increment
    WORD CENTER_RIGHT_ASTEROID_HORIZONTAL_STEP ; horizontal increment

RIGHT_ASTEROID_MOVEMENT_VECTOR:
    WORD RIGHT_ASTEROID_VERTICAL_STEP ; vertical increment
    WORD RIGHT_ASTEROID_HORIZONTAL_STEP ; horizontal increment

; ********************** Asteroid Configuration Tables ***********************
ASTEROID_SCREEN_TABLE:
    WORD ASTEROID_1_SCREEN
    WORD ASTEROID_2_SCREEN
    WORD ASTEROID_3_SCREEN
    WORD ASTEROID_4_SCREEN

ASTEROID_SLOT_ATTRIBUTE_TABLE:
    WORD ASTEROID_SLOT_1_ATTRIBUTES
    WORD ASTEROID_SLOT_2_ATTRIBUTES
    WORD ASTEROID_SLOT_3_ATTRIBUTES
    WORD ASTEROID_SLOT_4_ATTRIBUTES

ASTEROID_INITIAL_ROW_TABLE:
    WORD LEFT_ASTEROID_INITIAL_ROW
    WORD CENTER_LEFT_ASTEROID_INITIAL_ROW
    WORD CENTER_VERTICAL_ASTEROID_INITIAL_ROW
    WORD CENTER_RIGHT_ASTEROID_INITIAL_ROW
    WORD RIGHT_ASTEROID_INITIAL_ROW

ASTEROID_INITIAL_COLUMN_TABLE:
    WORD LEFT_ASTEROID_INITIAL_COLUMN
    WORD CENTER_LEFT_ASTEROID_INITIAL_COLUMN
    WORD CENTER_VERTICAL_ASTEROID_INITIAL_COLUMN
    WORD CENTER_RIGHT_ASTEROID_INITIAL_COLUMN
    WORD RIGHT_ASTEROID_INITIAL_COLUMN

ASTEROID_MOVEMENT_VECTOR_TABLE:
    WORD LEFT_ASTEROID_MOVEMENT_VECTOR
    WORD CENTER_LEFT_ASTEROID_MOVEMENT_VECTOR
    WORD CENTER_VERTICAL_ASTEROID_MOVEMENT_VECTOR
    WORD CENTER_RIGHT_ASTEROID_MOVEMENT_VECTOR
    WORD RIGHT_ASTEROID_MOVEMENT_VECTOR

; ********************************** Game Flags ***********************************
ACTIVE_PROBE_FLAGS: ; flags of probes active:
    WORD PROBE_SLOT_EMPTY; for probe left
    WORD PROBE_SLOT_EMPTY; ; for probe vertical/central
    WORD PROBE_SLOT_EMPTY; for probe right

ASTEROID_POSITION_FLAGS:
    WORD ASTEROID_SLOT_EMPTY; for position of the left
    WORD ASTEROID_SLOT_EMPTY
    WORD ASTEROID_SLOT_EMPTY
    WORD ASTEROID_SLOT_EMPTY
    WORD ASTEROID_SLOT_EMPTY; for position of the right

ASTEROID_SLOT_FLAGS:
    WORD ASTEROID_SLOT_EMPTY
    WORD ASTEROID_SLOT_EMPTY
    WORD ASTEROID_SLOT_EMPTY
    WORD ASTEROID_SLOT_EMPTY

; ******************** Spawned Asteroid Attributes ********************
ASTEROID_SLOT_1_ATTRIBUTES: ; attributes of the asteroid of the slot 1
    WORD ASTEROID_TYPE_UNDEFINED
    WORD ASTEROID_TYPE_UNDEFINED; stores the trajectory of asteroid slot 1

ASTEROID_SLOT_2_ATTRIBUTES: ; attributes of the asteroid of the slot 2
    WORD ASTEROID_TYPE_UNDEFINED
    WORD ASTEROID_TYPE_UNDEFINED; stores the trajectory of asteroid slot 2

ASTEROID_SLOT_3_ATTRIBUTES: ; attributes of the asteroid of the slot 3
    WORD ASTEROID_TYPE_UNDEFINED
    WORD ASTEROID_TYPE_UNDEFINED; stores the trajectory of asteroid slot 3

ASTEROID_SLOT_4_ATTRIBUTES: ; attributes of the asteroid of the slot 4
    WORD ASTEROID_TYPE_UNDEFINED
    WORD ASTEROID_TYPE_UNDEFINED; stores the trajectory of asteroid slot 4

; ********************** Game Over Media Tables **********************
GAME_OVER_SOUND_TABLE:
    WORD ENERGY_GAME_OVER_SOUND_ID
    WORD ENERGY_GAME_OVER_SOUND_ID
    WORD SHIP_EXPLOSION_GAME_OVER_SOUND_ID
    WORD 0

GAME_OVER_VIDEO_TABLE:
    WORD ENERGY_GAME_OVER_VIDEO_ID
    WORD ENERGY_GAME_OVER_VIDEO_ID
    WORD SHIP_EXPLOSION_GAME_OVER_VIDEO_ID
    WORD USER_ABORT_GAME_OVER_VIDEO_ID


; *****************************************************************************************************************************
; * Code:
; *****************************************************************************************************************************
PLACE 0

; ***************************************************** MAIN PROCESS ******************************************************
; *********************************************************************************************************
; START_GAME - Main control loop. Initializes hardware state, starts background processes, waits for the
; start key, handles user input during gameplay, and dispatches the appropriate game-over sequence.
; *********************************************************************************************************
START_GAME:
    ; Initial setup.
    MOV SP, INITIAL_MAIN_STACK_POINTER
    MOV BTE, INTERRUPT_VECTOR_TABLE
    MOV R0, GAME_STATE_NOT_STARTED
    MOV [GAME_STATE], R0


    MOV R0, MAIN_SHIP_SCREEN
    MOV [CMD_SELECT_SCREEN], R0
    MOV R0, BLACK_BACKGROUND_ID
    MOV [CMD_SET_BACKGROUND], R0
    MOV R0, MENU_VIDEO_ID
    MOV [CMD_START_LOOP_PLAYBACK], R0

    ; Enable interrupts.
    EI0
    EI1
    EI2
    EI3
    EI
    
    CALL READ_KEYBOARD
    CALL UPDATE_SHIP_LIGHTS
    CALL REDUCE_ENERGY
    CALL PREPARE_ASTEROID


wait_start_key:
    MOV R0, [LAST_KEY_PRESSED]
    MOV R1, START_GAME_KEY
    CMP R0, R1
    JNZ wait_start_key

    

start_game_session:
    MOV [CMD_STOP_ALL_MEDIA], R0
    CALL RUN_DELAY
    MOV R0, GAME_START_SOUND_ID
    MOV [CMD_START_PLAYBACK], R0
    MOV R0, GAME_BACKGROUND_ID
    MOV [CMD_SET_BACKGROUND], R0
    MOV R0, GAME_MUSIC_ID
    MOV [CMD_START_LOOP_PLAYBACK], R0

    CALL DRAW_SHIP

    ; Reset per-game state.
    MOV R0, 0
    MOV [CURRENT_SHIP_LIGHTS_PATTERN], R0

    MOV R0, INITIAL_ENERGY_DECIMAL
    MOV [SHIP_ENERGY], R0
    MOV R0, INITIAL_ENERGY_HEXADECIMAL
    MOV [DISPLAYS_ADDRESS], R0
    
    CALL CLEAR_FLAGS
    MOV R0, GAME_STATE_RUNNING
    MOV [GAME_STATE], R0
    MOV R0, GAME_END_NONE
    MOV [GAME_END_REASON], R0

    MOV R0, -1
    MOV [SELECTED_ASTEROID_SCREEN], R0
    MOV [SELECTED_ASTEROID_ATTRIBUTE], R0
    MOV [SELECTED_ASTEROID_POSITION], R0
    EI


wait_new_key: 
    MOV R0, [LAST_KEY_PRESSED]
    MOV R1, [GAME_STATE]
    CMP R1, GAME_STATE_FINISHED
    JZ terminate_game
    ; Continue handling gameplay input.

handle_pause_key:
    MOV R1, PAUSE_GAME_KEY
    CMP R0, R1
    JNZ handle_end_game_key
    MOV R0, PAUSE_OVERLAY_ID
    MOV [CMD_OVERLAY_IMAGE], R0
pause_game:
    DI
    MOV R0, GAME_STATE_PAUSED
    MOV [GAME_STATE], R0
    MOV [CMD_PAUSE_ALL_MEDIA], R0
    MOV R0, PAUSE_SOUND_ID
    MOV [CMD_START_PLAYBACK], R0
wait_for_pause_end:
    MOV R0, [LAST_KEY_PRESSED]
    CMP R0, R1
    JNZ wait_for_pause_end
exit_pause:    
    MOV R0, GAME_STATE_RUNNING
    MOV [GAME_STATE], R0
    MOV [CMD_RESUME_ALL_MEDIA], R0
    MOV [CMD_CLEAR_FOREGROUND_IMAGE], R0
    EI
    JMP wait_new_key

handle_end_game_key:
    MOV R1, END_GAME_KEY
    CMP R0, R1
    JNZ handle_left_probe_key
prepare_game_termination:
    MOV R0, GAME_STATE_FINISHED
    MOV [GAME_STATE], R0
    MOV R0, GAME_END_USER_REQUEST
    MOV [GAME_END_REASON], R0
    JMP terminate_game

handle_left_probe_key:
    CMP R0, LAUNCH_LEFT_PROBE_KEY
    JNZ handle_vertical_probe_key
    MOV R1, PROBE_TYPE_LEFT
    MOV [REQUESTED_PROBE_TYPE], R1
    CALL LAUNCH_PROBE

handle_vertical_probe_key:
    CMP R0, LAUNCH_VERTICAL_PROBE_KEY
    JNZ handle_right_probe_key
    MOV R1, PROBE_TYPE_VERTICAL
    MOV [REQUESTED_PROBE_TYPE], R1
    CALL LAUNCH_PROBE

handle_right_probe_key:
    CMP R0, LAUNCH_RIGHT_PROBE_KEY
    JNZ wait_new_key
    MOV R1, PROBE_TYPE_RIGHT
    MOV [REQUESTED_PROBE_TYPE], R1
    CALL LAUNCH_PROBE

JMP wait_new_key

terminate_game:
    DI
    MOV [CMD_CLEAR_ALL_SCREEN_PIXELS], R0
    MOV [CMD_STOP_ALL_MEDIA], R0
    MOV R0, [GAME_END_REASON]
    MOV R1, R0
    MOV R2, 2
    MUL R1, R2

    CMP R0, GAME_END_USER_REQUEST
    JZ load_game_over_video

    MOV R2, GAME_OVER_SOUND_TABLE
    ADD R2, R1
    MOV R0, [R2]
    MOV [CMD_START_PLAYBACK], R0

load_game_over_video:
    MOV R2, GAME_OVER_VIDEO_TABLE
    ADD R2, R1
    MOV R0, [R2]
    MOV [CMD_START_LOOP_PLAYBACK], R0
    JMP wait_start_key


; *********************************************************************************************************
; CLEAR_FLAGS - Resets asteroid slot flags, trajectory flags, and probe activity flags to their initial state.
;
; Arguments: none.
;
; Returns: none.
; *********************************************************************************************************
CLEAR_FLAGS:
    MOV R1, ASTEROID_SLOT_FLAGS
    MOV R0, MAX_ASTEROID_SLOTS
    MOV R2, ASTEROID_SLOT_EMPTY
    CALL CLEAR_WORD_ARRAY

    MOV R1, ASTEROID_POSITION_FLAGS
    MOV R0, ASTEROID_TRAJECTORY_COUNT
    CALL CLEAR_WORD_ARRAY

    MOV R1, ACTIVE_PROBE_FLAGS
    MOV R0, 3
    MOV R2, PROBE_SLOT_EMPTY
    CALL CLEAR_WORD_ARRAY

    RET


; *********************************************************************************************************
; DRAW_SHIP - Selects the ship screen and prepares the arguments required by DRAW_OBJECT to render the ship.
;
; Arguments: none.
;
; Returns: none.
; *********************************************************************************************************
DRAW_SHIP:
    MOV R0, MAIN_SHIP_SCREEN
    MOV [CMD_SELECT_SCREEN], R0
    

    MOV R1, SHIP_INITIAL_ROW
    MOV R2, SHIP_INITIAL_COLUMN
    MOV R10, SHIP_INITIAL_COLUMN
    MOV R9, SHIP_WIDTH
    MOV R8, SHIP_SPRITE
    

    CALL DRAW_OBJECT
    
    RET


; *********************************************************************************************************
; CLEAR_WORD_ARRAY - Fills a word array with the same value.
;
; Arguments: R1 - base address of the array;
;            R0 - number of words to clear;
;            R2 - fill value.
;
; Returns: none.
; *********************************************************************************************************
CLEAR_WORD_ARRAY:
clear_word_array_loop:
    MOV [R1], R2
    ADD R1, 2
    SUB R0, 1
    JNZ clear_word_array_loop
    RET
  

; *************************************************** ENERGY DRAIN PROCESS ***************************************************

; *********************************************************************************************************
; REDUCE_ENERGY - Waits for INT 2 ticks and periodically decreases ship energy by PASSIVE_ENERGY_DRAIN
; while the game is running.
; *********************************************************************************************************
PROCESS INITIAL_REDUCE_ENERGY_STACK_POINTER
REDUCE_ENERGY:    
    MOV R0, [GAME_STATE]
    CMP R0, GAME_STATE_RUNNING
    JNZ END_REDUCE_ENERGY
    
    MOV R8, PASSIVE_ENERGY_DRAIN
    CALL CHANGE_ENERGY

END_REDUCE_ENERGY:
    MOV R0, [ENERGY_TICK_EVENT]
    JMP REDUCE_ENERGY


; *************************************************** SHIP LIGHT PROCESS ****************************************************

; *********************************************************************************************************
; UPDATE_SHIP_LIGHTS - Waits for INT 3 ticks and cycles through the four ship light patterns while
; the game is running.
; *********************************************************************************************************
PROCESS INITIAL_UPDATE_SHIP_LIGHTS_STACK_POINTER
UPDATE_SHIP_LIGHTS:  
    MOV R0, [GAME_STATE]
    CMP R0, GAME_STATE_RUNNING
    JNZ END_UPDATE_SHIP_LIGHTS

    MOV R0, MAIN_SHIP_SCREEN
    MOV [CMD_SELECT_SCREEN], R0


    MOV R1, SHIP_LIGHTS_INITIAL_ROW
    MOV R2, SHIP_LIGHTS_INITIAL_COLUMN
    MOV R10, R2
    MOV R9, SHIP_LIGHTS_WIDTH

    MOV R0, [CURRENT_SHIP_LIGHTS_PATTERN]
    ADD R0, 1
    CMP R0, 5
    JNZ select_light_pattern
    MOV R0, SHIP_LIGHTS_PATTERN_1

select_light_pattern:
    MOV [CURRENT_SHIP_LIGHTS_PATTERN], R0
    SUB R0, 1
    MOV R11, 2
    MUL R0, R11
    MOV R8, SHIP_LIGHTS_SPRITE_TABLE
    ADD R8, R0
    MOV R8, [R8]
    CALL DRAW_OBJECT
    
END_UPDATE_SHIP_LIGHTS:
    MOV R0, [SHIP_LIGHTS_EVENT]
    JMP UPDATE_SHIP_LIGHTS


; *************************************************** PROBE PROCESS ***************************************************
; *********************************************************************************************************
; LAUNCH_PROBE - Spawns the probe type requested in REQUESTED_PROBE_TYPE, debits its energy cost, and
; advances it on each probe-motion event until it hits something or leaves the valid range.
; *********************************************************************************************************
PROCESS INITIAL_LAUNCH_PROBE_STACK_POINTER
LAUNCH_PROBE:
    MOV R5, [REQUESTED_PROBE_TYPE]
    MOV R10, 2
    MUL R5, R10
    MOV R7, ACTIVE_PROBE_FLAGS
    ADD R7, R5
    
    MOV R10, [R7]
    CMP R10, PROBE_SLOT_EMPTY
    JNZ END_LAUNCH_PROBE

    MOV R0, PROBE_SLOT_OCCUPIED
    MOV [R7], R0
    MOV R8, PROBE_ENERGY_COST
    CALL CHANGE_ENERGY
    
    MOV R0, PROBE_LAUNCH_SOUND_ID
    MOV [CMD_START_PLAYBACK], R0

    MOV R10, PROBE_SCREEN_TABLE
    ADD R10, R5
    MOV R0, [R10]

    MOV R10, PROBE_INITIAL_ROW_TABLE
    ADD R10, R5
    MOV R1, [R10]

    MOV R10, PROBE_INITIAL_COLUMN_TABLE
    ADD R10, R5
    MOV R2, [R10]

    MOV R10, PROBE_MOVEMENT_VECTOR_TABLE
    ADD R10, R5
    MOV R4, [R10]

prepare_probe_common:    

    MOV R3, [R4]
    ADD R4, 2
    MOV R4, [R4]
    MOV R9, PROBE_WIDTH
    MOV R8, PROBE_SPRITE
    MOV R6, 1

move_probe:
    YIELD
    

    MOV R11, [R7]
    CMP R11, PROBE_SLOT_OCCUPIED
    JNZ deactivate_probe


    MOV R11, [GAME_STATE]
    CMP R11, GAME_STATE_FINISHED
    JZ deactivate_probe
    CMP R11, GAME_STATE_PAUSED
    JZ move_probe

    MOV R10, R2
    CALL CLEAR_AND_DRAW_OBJECT
    
    MOV R11, [PROBE_MOTION_EVENT]
    
    ADD R1, R3
    ADD R2, R4
    ADD R6, R3
    MOV R11, MAX_PROBE_RANGE_FROM_SHIP
    CMP R6, R11
    JZ deactivate_probe
    
    JMP move_probe

deactivate_probe:
    MOV R10, PROBE_SLOT_EMPTY
    MOV [R7], R10
    CALL CLEAR_SELECTED_SCREEN

END_LAUNCH_PROBE:
    RET



; *********************************************************************************************************
; PREPARE_ASTEROID - Waits for a free asteroid slot, assigns random attributes to the new asteroid, selects
; its screen, and starts the movement process.
; *********************************************************************************************************
PROCESS INITIAL_PREPARE_ASTEROID_STACK_POINTER
PREPARE_ASTEROID:
    YIELD
    MOV R10, [GAME_STATE]
    CMP R10, GAME_STATE_RUNNING
    JNZ PREPARE_ASTEROID

prepare_slot_search:
    YIELD
    MOV R0, 1
    MOV R1, ASTEROID_SLOT_FLAGS
    
    ; Search for a free asteroid slot.
find_empty_asteroid_slot:
    MOV R2, [R1]
    CMP R2, ASTEROID_SLOT_EMPTY
    JZ empty_slot_found
    ADD R0, 1
    ADD R1, 2
    CMP R0, 5
    JNZ find_empty_asteroid_slot
    JZ prepare_slot_search

empty_slot_found:
    MOV R2, ASTEROID_SLOT_OCCUPIED
    MOV [R1], R2

    CALL CHOOSE_RANDOM_ASTEROID_ATTRIBUTES

    MOV R2, R0
    SUB R0, 1
    MOV R3, 2
    MUL R0, R3
    MOV R3, ASTEROID_SCREEN_TABLE
    ADD R3, R0
    MOV R0, [R3]

END_PREPARE_ASTEROID:
    MOV [SELECTED_ASTEROID_SCREEN], R0
    MOV [SELECTED_ASTEROID_ATTRIBUTE], R1
    MOV [SELECTED_ASTEROID_POSITION], R2
    CALL MOVE_ASTEROID
    JMP PREPARE_ASTEROID


; *********************************************************************************************************
; CHOOSE_RANDOM_ASTEROID_ATTRIBUTES - Chooses the asteroid type and trajectory for the slot identified by R0.
; The routine also reserves the selected trajectory flag.
;
; Arguments: R0 - asteroid slot index.
;
; Returns: R1 - address of the selected slot attribute structure.
; *********************************************************************************************************
CHOOSE_RANDOM_ASTEROID_ATTRIBUTES:
    PUSH R0
    PUSH R2
    PUSH R3
    PUSH R4

    MOV R10, [KEYBOARD_COLUMN_ADDRESS]
    MOV R2, R0
    SUB R2, 1
    MOV R3, 2
    MUL R2, R3
    MOV R1, ASTEROID_SLOT_ATTRIBUTE_TABLE
    ADD R1, R2
    MOV R1, [R1]

choose_asteroid_type:
    MOV R2, R10
    MOV R3, RANDOM_TWO_BIT_MASK
    AND R2, R3
    CMP R2, 0
    JZ set_minable_asteroid


set_non_minable_asteroid:  
    MOV R2, ASTEROID_TYPE_NON_MINABLE
    MOV [R1], R2
    JMP choose_asteroid_trajectory

set_minable_asteroid:
    MOV R2, ASTEROID_TYPE_MINABLE
    MOV [R1], R2

choose_asteroid_trajectory:
    ADD R1, 2

    SHR R10, 5
    MOV R2, 5
    MOD R10, R2
    
    ; Dispatch based on the selected trajectory.
    CMP R10, ASTEROID_PATH_LEFT
    JZ set_left_path
    CMP R10, ASTEROID_PATH_CENTER_DIAGONAL_LEFT
    JZ set_center_diagonal_left
    CMP R10, ASTEROID_PATH_CENTER_VERTICAL
    JZ set_center_vertical
    CMP R10, ASTEROID_PATH_CENTER_DIAGONAL_RIGHT
    JZ set_center_diagonal_right

    
set_right_path:
    MOV R2, ASTEROID_PATH_RIGHT
    JMP check_clear_path

set_left_path:
    MOV R2, ASTEROID_PATH_LEFT
    JMP check_clear_path

set_center_diagonal_left:
    MOV R2, ASTEROID_PATH_CENTER_DIAGONAL_LEFT
    JMP check_clear_path

set_center_vertical:
    MOV R2, ASTEROID_PATH_CENTER_VERTICAL
    JMP check_clear_path

set_center_diagonal_right:
    MOV R2, ASTEROID_PATH_CENTER_DIAGONAL_RIGHT

check_clear_path:
    MOV [R1], R2
    SUB R1, 2
    
    MOV R4, 2
    MUL R2, R4
    MOV R3, ASTEROID_POSITION_FLAGS
    ADD R3, R2
    MOV R4, [R3]
    MOV R2, ASTEROID_SLOT_OCCUPIED
    CMP R4, R2
    JNZ END_CHOOSE_RANDOM_ASTEROID_ATTRIBUTES

    MOV R10, [KEYBOARD_COLUMN_ADDRESS]
    JMP choose_asteroid_trajectory

END_CHOOSE_RANDOM_ASTEROID_ATTRIBUTES:
    MOV R4, ASTEROID_SLOT_OCCUPIED
    MOV [R3], R4
    POP R4
    POP R3
    POP R2
    POP R0
    RET


; *************************************************** ASTEROID PROCESS ***************************************************
; *********************************************************************************************************
; MOVE_ASTEROID - Spawns the prepared asteroid, moves it on each asteroid-motion event, resolves collisions,
; and releases its slot and trajectory flags when it disappears.
; *********************************************************************************************************
PROCESS INITIAL_MOVE_ASTEROID_STACK_POINTER
MOVE_ASTEROID:
    MOV R10, [GAME_STATE]
    CMP R10, GAME_STATE_PAUSED
    JZ MOVE_ASTEROID

    MOV R0, [SELECTED_ASTEROID_SCREEN]
    MOV R1, [SELECTED_ASTEROID_ATTRIBUTE]
    MOV R6, [SELECTED_ASTEROID_POSITION]

    MOV R2, ASTEROID_SPAWN_SOUND_ID
    MOV [CMD_START_PLAYBACK], R2

prepare_asteroid_by_type:
    MOV R11, [R1]
    CMP R11, ASTEROID_TYPE_NON_MINABLE
    JZ prepare_non_minable_asteroid


prepare_minable_asteroid:
    MOV R8, MINABLE_ASTEROID_SPRITE
    JMP prepare_asteroid_by_trajectory

prepare_non_minable_asteroid:
    MOV R8, NON_MINABLE_ASTEROID_SPRITE

prepare_asteroid_by_trajectory:
    ADD R1, 2
    MOV R11, [R1]
    MOV R7, R11
    MOV R4, 2
    MUL R11, R4

    MOV R4, ASTEROID_INITIAL_ROW_TABLE
    ADD R4, R11
    MOV R1, [R4]

    MOV R4, ASTEROID_INITIAL_COLUMN_TABLE
    ADD R4, R11
    MOV R2, [R4]

    MOV R4, ASTEROID_MOVEMENT_VECTOR_TABLE
    ADD R4, R11
    MOV R4, [R4]

prepare_asteroid_common:    

    MOV R3, [R4]
    ADD R4, 2
    MOV R4, [R4]
    MOV R10, R2
    MOV R9, ASTEROID_WIDTH

move_asteroid:
    YIELD
    

    MOV R11, [GAME_STATE]
    CMP R11, GAME_STATE_FINISHED
    JZ clear_asteroid_existence

    CMP R11, GAME_STATE_PAUSED
    JZ move_asteroid

    CALL CHECK_ASTEROID_COLLISION

    CMP R11, COLLISION_WITH_SHIP
    JZ mark_game_finished
    CMP R11, COLLISION_WITH_LEFT_PROBE
    JZ notify_left_probe_of_explosion
    CMP R11, COLLISION_WITH_VERTICAL_PROBE
    JZ notify_vertical_probe_of_explosion
    CMP R11, COLLISION_WITH_RIGHT_PROBE
    JZ notify_right_probe_of_explosion
    
    CALL CLEAR_AND_DRAW_OBJECT
    
    MOV R11, [ASTEROID_MOTION_EVENT]
    ADD R1, R3
    ADD R2, R4
    MOV R10, R2
    MOV R11, SCREEN_HEIGHT
    CMP R1, R11
    JZ clear_asteroid_existence

    JMP move_asteroid

notify_right_probe_of_explosion:
    MOV R11, PROBE_TYPE_RIGHT
    JMP notify_probes_of_global_explosion

notify_left_probe_of_explosion:
    MOV R11, PROBE_TYPE_LEFT
    JMP notify_probes_of_global_explosion

notify_vertical_probe_of_explosion:
    MOV R11, PROBE_TYPE_VERTICAL
    
notify_probes_of_global_explosion:
    MOV R4, 2
    MUL R11, R4
    MOV R4, ACTIVE_PROBE_FLAGS
    ADD R11, R4
    MOV R4, PROBE_SLOT_EMPTY
    MOV [R11], R4

choose_asteroid_update:
    MOV R4, MINABLE_ASTEROID_SPRITE
    CMP R8, R4
    JZ mine_asteroid

    
explode_asteroid:
    MOV R8, ASTEROID_EXPLOSION_SOUND_ID
    MOV [CMD_START_PLAYBACK], R8

    MOV R8, ASTEROID_EXPLOSION_SPRITE
    CALL CLEAR_AND_DRAW_OBJECT
    CALL RUN_DELAY
    JMP clear_asteroid_existence

mine_asteroid:
    MOV R8, MINING_SUCCESS_SOUND_ID
    MOV [CMD_START_PLAYBACK], R8

    MOV R8, ASTEROID_MINING_STAGE_1_SPRITE
    CALL CLEAR_AND_DRAW_OBJECT
    CALL RUN_DELAY
    MOV R8, ASTEROID_MINING_STAGE_2_SPRITE
    CALL CLEAR_AND_DRAW_OBJECT
    CALL RUN_DELAY
    MOV R8, MINING_ENERGY_REWARD
    CALL CHANGE_ENERGY
    JMP clear_asteroid_existence

mark_game_finished:
    MOV R11, GAME_STATE_FINISHED
    MOV [GAME_STATE], R11
    MOV R11, GAME_END_SHIP_COLLISION
    MOV [GAME_END_REASON], R11

clear_asteroid_existence:
    CALL CLEAR_SELECTED_SCREEN

    MOV R10, 2
    SUB R6, 1
    MUL R6, R10
    MOV R11, ASTEROID_SLOT_FLAGS
    ADD R6, R11
    MOV R10, ASTEROID_SLOT_EMPTY
    MOV [R6], R10

    MOV R6, 2
    MUL R7, R6
    MOV R10, ASTEROID_POSITION_FLAGS
    ADD R7, R10
    MOV R10, ASTEROID_SLOT_EMPTY
    MOV [R7], R10

END_MOVE_ASTEROID:
    RET


; *********************************************************************************************************
; CHECK_ASTEROID_COLLISION - Scans the asteroid area against the ship and probe screens. If a collision is
; found, the routine reports the collision target and clears the impacted probe when necessary.
;
; Arguments: R1 - first row of the asteroid;
;            R2 - first column of the asteroid.
;
; Returns: R7 - screen containing the collided object;
;          R11 - collision type.
; *********************************************************************************************************
CHECK_ASTEROID_COLLISION:
    PUSH R0
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    PUSH R9

    MOV R5, ASTEROID_HEIGHT
    MOV R3, R1

check_asteroid_area:
    MOV R6, ASTEROID_WIDTH
    MOV R4, R2

advance_column:
    MOV R7, 7

switch_screen:
    CMP R7, MAIN_SHIP_SCREEN
    JZ select_collision_screen
    MOV R0, R7
    SUB R0, LEFT_PROBE_SCREEN
    MOV R11, 2
    MUL R0, R11
    MOV R11, ACTIVE_PROBE_FLAGS
    ADD R11, R0
    MOV R0, [R11]
    CMP R0, PROBE_SLOT_OCCUPIED
    JNZ next_collision_screen

select_collision_screen:
    MOV [CMD_SELECT_SCREEN], R7
    MOV [CMD_SELECT_COLUMN], R4
    MOV [CMD_SELECT_ROW], R3

key_checks:
    MOV R8, [CMD_READ_PIXEL_COLOR]
    MOV R9, COLOR_BLACK
    CMP R8, R9
    JZ collided_with_ship
    MOV R9, COLOR_DARK_RED
    CMP R8, R9
    JZ collided_with_a_probe

next_collision_screen:
    SUB R7, 1
    CMP R7, 3
    JNZ switch_screen
    
    ADD R4, 1
    SUB R6, 1
    JNZ advance_column

    ADD R3, 1
    SUB R5, 1
    JNZ check_asteroid_area

MOV R11, 0
JMP END_CHECK_ASTEROID_COLLISION

collided_with_ship:
    MOV R11, COLLISION_WITH_SHIP
    JMP END_CHECK_ASTEROID_COLLISION

collided_with_a_probe:
    MOV R0, R7
    CALL CLEAR_SELECTED_SCREEN
    SUB R0, LEFT_PROBE_SCREEN
    MOV R11, 2
    MUL R0, R11
    MOV R11, PROBE_COLLISION_TYPE_TABLE
    ADD R11, R0
    MOV R11, [R11]

END_CHECK_ASTEROID_COLLISION:
    POP R9
    POP R8
    POP R7
    POP R6
    POP R5
    POP R4
    POP R3
    POP R2
    POP R1
    POP R0
    RET


; *************************************************** READ KEYBOARD PROCESS ***************************************************
; *********************************************************************************************************
; READ_KEYBOARD - Scans the keyboard matrix by cycling through the rows. When a key is detected, the
; routine computes its logical value and stores it in LAST_KEY_PRESSED.
;
; Arguments: none.
;
; Returns: R8 contains the detected column mask while scanning;
;          [LAST_KEY_PRESSED] stores the decoded key value (0, 1, 2, ..., F).
; *********************************************************************************************************
KEYBOARD_STACK: STACK 100H
INITIAL_KEYBOARD_STACK_POINTER:

PROCESS INITIAL_KEYBOARD_STACK_POINTER
READ_KEYBOARD:    
    MOV R3, KEYBOARD_ROW_ADDRESS
    MOV R4, KEYBOARD_COLUMN_ADDRESS
    MOV R6, KEYBOARD_COLUMN_MASK
    MOV R7, INITIAL_KEYBOARD_ROW

wait_for_key:
    YIELD
    MOV R0, [GAME_STATE]
    MOV R1, GAME_STATE_FINISHED
    CMP R0, R1
    JNZ continue_waiting_key
    MOV R2, INVALID_KEY
    MOV [LAST_KEY_PRESSED], R2

continue_waiting_key:
    MOV R1, R7
    CALL READ_MASKED_KEYBOARD_COLUMNS
    CMP R8, 0
    JNZ key_available
    CALL ADVANCE_TEST_ROW
    JMP wait_for_key

key_available:
    CALL CALCULATE_KEY_VALUE
    MOV [LAST_KEY_PRESSED], R2
    
    MOV R1, R7
    CALL READ_MASKED_KEYBOARD_COLUMNS
    CMP R8, 0
    JNZ key_available
    
JMP wait_for_key
    

; *********************************************************************************************************
; READ_MASKED_KEYBOARD_COLUMNS - Writes the selected row mask and reads the masked keyboard column value.
;
; Arguments: R1 - row mask;
;            R3 - keyboard row register address;
;            R4 - keyboard column register address;
;            R6 - keyboard column bit mask.
;
; Returns: R8 - masked column bits.
; *********************************************************************************************************
READ_MASKED_KEYBOARD_COLUMNS:
    MOVB [R3], R1
    MOVB R8, [R4]
    AND R8, R6
    RET
    

; *********************************************************************************************************
; ADVANCE_TEST_ROW - Advances the keyboard scan to the next row.
;
; Arguments: R7 - currently tested row mask.
;
; Returns: R7 - next row mask to test.
; *********************************************************************************************************
ADVANCE_TEST_ROW:
    CMP R7, 0
    JZ reset_R7
    SHR R7, 1
    JMP END_ADVANCE_TEST_ROW
reset_R7: 
    MOV R7, 8
END_ADVANCE_TEST_ROW: RET
    
    
; *********************************************************************************************************
; CALCULATE_KEY_VALUE - Converts the current row/column masks into the logical keypad value using
; the expression L * 4 + C, where L and C are zero-based row and column indexes.
;
; Arguments: R7 - selected row mask (1, 2, 4 or 8);
;            R8 - selected column mask (1, 2, 4 or 8).
;
; Returns: R2 - decoded key value (0, 1, 2, ..., F).
; *********************************************************************************************************
CALCULATE_KEY_VALUE:
    ; Convert the row mask to a zero-based index.
    MOV R1, R7
    CALL CONVERT_VALUES
    
    ; Compute L * 4.
    MOV R2, R0
    MOV R0, 4
    MUL R2, R0

    ; Convert the column mask to a zero-based index.
    MOV R1, R8
    CALL CONVERT_VALUES
    
    ; Add C.
    ADD R2, R0
    
    RET
    
    
; *********************************************************************************************************
; CONVERT_VALUES - Converts a power-of-two keypad mask into a zero-based index:
; 8 -> 3, 4 -> 2, 2 -> 1, 1 -> 0.
;
; Arguments: R1 - mask to convert.
;
; Returns: R0 - converted index.
; *********************************************************************************************************
CONVERT_VALUES:
    MOV R0, 0
conversion_loop:
    ADD R0, 1
    SHR R1, 1
    JNZ conversion_loop
    SUB R0, 1

    RET


; *************************************************** INTERRUPT ROUTINES *****************************************************
; *********************************************************************************************************
; INTERRUPT_ROUTINE_0 - Handles INT 0 and wakes asteroid movement.
; *********************************************************************************************************
INTERRUPT_ROUTINE_0:
    MOV [ASTEROID_MOTION_EVENT], R0
    RFE

; *********************************************************************************************************
; INTERRUPT_ROUTINE_1 - Handles INT 1 and wakes probe movement.
; *********************************************************************************************************
INTERRUPT_ROUTINE_1:
    MOV [PROBE_MOTION_EVENT], R0
    RFE

; *********************************************************************************************************
; INTERRUPT_ROUTINE_2 - Handles INT 2 and wakes periodic energy drain.
; *********************************************************************************************************
INTERRUPT_ROUTINE_2:
    MOV [ENERGY_TICK_EVENT], R0
    RFE

; *********************************************************************************************************
; INTERRUPT_ROUTINE_3 - Handles INT 3 and wakes ship light animation.
; *********************************************************************************************************
INTERRUPT_ROUTINE_3:
    MOV [SHIP_LIGHTS_EVENT], R0
    RFE


; ************************************************ GENERAL HELPER ROUTINES **************************************************

; *********************************************************************************************************
; CHANGE_ENERGY - Applies the delta stored in R8 to SHIP_ENERGY and updates the 7-segment displays.
; If the energy reaches zero or below, the game state is forced to GAME_STATE_FINISHED.
;
; Arguments: R8 - signed energy delta.
;
; Returns: [SHIP_ENERGY] updated; display value refreshed.
; *********************************************************************************************************
CHANGE_ENERGY:
    MOV R11, [SHIP_ENERGY]
    ADD R11, R8
    
    CMP R11, 0
    JLE energy_depleted

    MOV [SHIP_ENERGY], R11
    CALL CONVERT_TO_DISPLAY_HEX
    JMP update_energy_display

energy_depleted:
    MOV R0, GAME_STATE_FINISHED
    MOV [GAME_STATE], R0
    MOV R0, GAME_END_OUT_OF_ENERGY
    MOV [GAME_END_REASON], R0
    MOV R10, 0H

update_energy_display:
    MOV [DISPLAYS_ADDRESS], R10
    RET


; *********************************************************************************************************
; CONVERT_TO_DISPLAY_HEX - Converts the decimal energy value in R11 into the hexadecimal encoding expected
; by the 7-segment display hardware. For example, decimal 100 becomes 100H.
;
; Arguments: R11 - decimal energy value.
;
; Returns: R10 - display-ready hexadecimal encoding.
; *********************************************************************************************************
CONVERT_TO_DISPLAY_HEX:
    MOV R4, 10
    
    MOV R1, R11
    MOD R1, R4

    MOV R2, R11
    DIV R2, R4
    MOD R2, R4

    MOV R3, R11
    MOV R4, 100
    DIV R3, R4


    MOV R10, R1
    
    MOV R4, 10H
    MUL R2, R4
    ADD R10, R2

    MOV R4, 100H
    MUL R3, R4
    ADD R10, R3

    RET


; *********************************************************************************************************
; DRAW_OBJECT - Draws the sprite referenced by R8 on the currently selected pixel screen.
;
; Arguments: R1 - first row of the object;
;            R2 - first column of the object;
;            R8 - address of the sprite definition (width, height, and pixel colors);
;            R9 - sprite width, used to reset the inner loop;
;            R10 - initial column, used to reset the drawing position.
;
; Returns: none.
; *********************************************************************************************************
DRAW_OBJECT:
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R9
    PUSH R10

    MOV R3, R8
    MOV R4, [R3]
    ADD R3, 2
    MOV R5, [R3]
    ADD R3, 2
    
draw_object:

    MOV R6, [R3]
    MOV [CMD_SELECT_ROW], R1
    MOV [CMD_SELECT_COLUMN], R2
    MOV [CMD_WRITE_PIXEL], R6
    

    ADD R3, 2
    ADD R2, 1
    SUB R4, 1
    JNZ draw_object
    

    MOV R4, R9
    ADD R1, 1
    MOV R2, R10
    SUB R5, 1
    JNZ draw_object

    POP R10
    POP R9
    POP R6
    POP R5
    POP R4
    POP R3
    POP R2
    POP R1
    RET
    

; *********************************************************************************************************
; RUN_DELAY - Executes a fixed delay loop to smooth screen and media transitions.
;
; Arguments: none.
;
; Returns: none.
; *********************************************************************************************************
RUN_DELAY:
    PUSH R0
    MOV R0, DEFAULT_DELAY
run_wait_cycle:
    NOP
    NOP
    NOP
    NOP
    NOP
    SUB R0, 1
    JNZ run_wait_cycle
END_RUN_DELAY:    
    POP R0
    RET


; *********************************************************************************************************
; CLEAR_SELECTED_SCREEN - Clears the pixel screen identified by R0.
;
; Arguments: R0 - target screen identifier.
;
; Returns: none.
; *********************************************************************************************************
CLEAR_SELECTED_SCREEN:
    MOV [CMD_SELECT_SCREEN], R0
    MOV [CMD_CLEAR_SCREEN_PIXELS], R0
    RET


; *********************************************************************************************************
; CLEAR_AND_DRAW_OBJECT - Clears the screen in R0 and immediately redraws the object described by the
; current drawing registers.
;
; Arguments: R0 - target screen identifier;
;            R1 - first row of the object;
;            R2 - first column of the object;
;            R8 - address of the sprite definition;
;            R9 - sprite width;
;            R10 - initial column.
;
; Returns: none.
; *********************************************************************************************************
CLEAR_AND_DRAW_OBJECT:
    CALL CLEAR_SELECTED_SCREEN
    CALL DRAW_OBJECT
    RET


