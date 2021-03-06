
; ---------------------------------------------------------------------------

; enum BIOS
BIOSHIntVector:  equ $FFFD08
BIOSVIntVector:  equ $FFFD0E

; ---------------------------------------------------------------------------

; enum Registers
SubCPUInt:       equ $A12000
MemMode:         equ $A12003
CommReg:         equ $A12010
StatusReg:       equ $A12020

; ---------------------------------------------------------------------------

; enum MMDRegs
MMDFlags:        equ $200000
MMDRAMLoc:       equ $200002
MMDRAMSize:      equ $200006
MMDEntryPoint:   equ $200008
MMDLvl4Int:      equ $20000E
MMDLvl6Int:      equ $200010
MMDStart:        equ $200100

; ---------------------------------------------------------------------------

; enum MMDIDs
FileR11A:        equ 1
FileR11B:        equ 2
FileR11C:        equ 3
FileR11D:        equ 4
FileSega:        equ 5
FileLevSel:      equ 6
FileR12A:        equ 7
FileR12B:        equ 8
FileR12C:        equ 9
FileR12D:        equ $A
FileTitle:       equ $B
FileWarp:        equ $C
FileTimeAttack:  equ $D
FileOpening:     equ $24
FileCominSoon:   equ $25

; ---------------------------------------------------------------------------

; enum GlobalGameVars
Act:             equ $FF1210
Lives:           equ $FF1212
Time:            equ $FF1222
TimePeriod:      equ $FF123D
FutureType:      equ $FF127A

; ---------------------------------------------------------------------------

; enum ActIDs
Act1:            equ 0
Act2:            equ 1

; ---------------------------------------------------------------------------

; enum TimeIDs
TimePast:        equ 0
BadFuture:       equ 0
TimePresent:     equ 1
GoodFuture:      equ 1
TimeFuture:      equ 2

; ---------------------------------------------------------------------------

; enum MiscVars
DMNA:            equ 1
VDPCtrl:         equ $C00004
TimeAttackFlag:  equ $FF0580
VBlnkRtnCount:   equ $FF0583
TimeAttackTime:  equ $FF0590
TimeAttackSelection: equ $FF0594
VDPDefaultMode:  equ $FF0596

;
; +-------------------------------------------------------------------------+
; |      This file was generated by The Interactive Disassembler (IDA)      |
; |           Copyright (c) 2018 Hex-Rays, <support@hex-rays.com>           |
; |                      License info: 48-3015-72F4-DD                      |
; |                       Octavian Dima, personal use                       |
; +-------------------------------------------------------------------------+
;
; Input SHA256 : FAB5D5349DF4D2EF7F15C9653F5E5873428638782DF1A77704A7606E9A196A65
; Input MD5    : 24F9E749F7755F9E18983A5F2715738E
; Input CRC32  : 7E469662

; File Name   : C:\Users\theis\Desktop\Projects\Sonic CD 0.02 Disassembly\IPX___.MMD
; Format      : Binary file
; Base Address: 0000h Range: 0000h - 033Ch Loaded length: 033Ch

; Processor       : 68000
; Target assembler: 680x0 Assembler in MRI compatible mode
; This file should be compiled with "as -M"

; ===========================================================================

; Segment type: Pure code
; segment "ROM"
Header:         dc.b   0
                dc.b   0
                dc.l IPX                ; Entry point
                dc.w $3FF
                dc.l IPX                ; Entry point
                dc.l 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.l 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.l 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                dc.l 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
; ---------------------------------------------------------------------------

IPX:                                    ; DATA XREF: ROM:00FEFF02↑o
                                        ; ROM:00FEFF08↑o
                move.l  #VInt,(BIOSHIntVector).w
                bset    #DMNA,(MemMode).l
                moveq   #FileSega,d0
                bsr.w   LoadFile

LoadTitleScreen:                        ; CODE XREF: ROM:00FF005E↓j
                                        ; ROM:00FF00AA↓j ...
                moveq   #FileTitle,d0
                bsr.w   LoadFile
                tst.b   d1
                beq.w   LoadOpening
                tst.w   d0
                beq.w   LoadMainGame
                bra.w   LoadTimeAttack
; ---------------------------------------------------------------------------

LoadLevelSelect:
                moveq   #FileLevSel,d0
                bsr.w   LoadFile
                mulu.w  #6,d0
                move.w  LevSel_Act(pc,d0.w),(Act).l
                move.b  LevSel_TimePeriod(pc,d0.w),(TimePeriod).l
                move.b  LevSel_FutureType(pc,d0.w),(FutureType).l
                move.w  LevSel_Zone(pc,d0.w),d0
                move.b  #0,(TimeAttackFlag).l
                bsr.w   LoadFile
                bra.w   LoadTitleScreen
; ---------------------------------------------------------------------------
LevSel_Zone:    dc.w FileR11A           ; MMD file/zone
LevSel_Act:     dc.w Act1               ; Act
LevSel_TimePeriod:dc.b TimePresent      ; Time period
LevSel_FutureType:dc.b 0                ; Future type
                dc.w FileR11B           ; SPZ1 Past
                dc.w Act1
                dc.b TimePast
                dc.b 0
                dc.w FileR11C           ; SPZ1 Good Future
                dc.w Act1
                dc.b TimeFuture
                dc.b GoodFuture
                dc.w FileR11D           ; SPZ1 Bad Future
                dc.w Act1
                dc.b TimeFuture
                dc.b BadFuture
                dc.w FileR12A           ; SPZ2 Present
                dc.w Act2
                dc.b TimePresent
                dc.b 0
                dc.w FileR12B           ; SPZ2 Past
                dc.w Act2
                dc.b TimePast
                dc.b 0
                dc.w FileR12C           ; SPZ2 Good Future
                dc.w Act2
                dc.b TimeFuture
                dc.b GoodFuture
                dc.w FileR12D           ; SPZ2 Bad Future
                dc.w Act2
                dc.b TimeFuture
                dc.b BadFuture
                dc.w FileWarp           ; Time Warp Sequence
                dc.w 0
                dc.b 0
                dc.b 0
                dc.w FileOpening        ; Opening FMV
                dc.w 0
                dc.b 0
                dc.b 0
                dc.w FileCominSoon      ; Comin' Soon Screen
                dc.w 0
                dc.b 0
                dc.b 0
; ---------------------------------------------------------------------------

LoadOpening:                            ; CODE XREF: ROM:00FF001E↑j
                moveq   #FileOpening,d0
                bsr.w   LoadFile
                bra.w   LoadTitleScreen
; ---------------------------------------------------------------------------

LoadMainGame:                           ; CODE XREF: ROM:00FF0024↑j
                move.b  #TimePresent,(TimePeriod).l
                move.b  #0,(TimeAttackFlag).l
                bsr.w   LoadR11
                tst.b   (Lives).l
                beq.s   LoadCominSoon
                bsr.w   LoadR12

LoadCominSoon:                          ; CODE XREF: ROM:00FF00C8↑j
                                        ; DATA XREF: ROM:00FF009E↑t
                moveq   #FileCominSoon,d0
                bsr.w   LoadFile
                bra.w   LoadTitleScreen

; =============== S U B R O U T I N E =======================================


LoadR11:                                ; CODE XREF: ROM:00FF00BE↑p
                lea     R11Table(pc),a0
                move.w  #Act1,(Act).l
                bra.w   LoadLevel
; End of function LoadR11


; =============== S U B R O U T I N E =======================================


LoadR12:                                ; CODE XREF: ROM:00FF00CA↑p
                lea     R12Table(pc),a0
                move.w  #Act2,(Act).l
                bra.w   *+4
; ---------------------------------------------------------------------------

LoadLevel:                              ; CODE XREF: LoadR11+C↑j
                                        ; LoadR12+C↑j
                move.w  0(a0),d0

LoadTimeWarp:                           ; CODE XREF: LoadR12+3E↓j
                                        ; LoadR12+46↓j ...
                bsr.w   LoadFile
                tst.b   (Lives).l
                beq.s   LoadReturn
                btst    #7,(TimePeriod).l
                beq.s   LoadReturn
                moveq   #FileWarp,d0
                bsr.w   LoadFile
                move.b  (TimePeriod).l,d1
                move.w  2(a0),d0
                andi.b  #$7F,d1
                beq.s   LoadTimeWarp
                move.w  0(a0),d0
                subq.b  #1,d1
                beq.s   LoadTimeWarp
                move.w  6(a0),d0
                tst.b   (FutureType).l
                beq.s   LoadTimeWarp
                move.w  4(a0),d0
                bra.s   LoadTimeWarp
; ---------------------------------------------------------------------------

LoadReturn:                             ; CODE XREF: LoadR12+1E↑j
                                        ; LoadR12+28↑j
                rts
; End of function LoadR12

; ---------------------------------------------------------------------------
R11Table:       dc.w FileR11A           ; DATA XREF: LoadR11↑o
                dc.w FileR11B
                dc.w FileR11C
                dc.w FileR11D
R12Table:       dc.w FileR12A           ; DATA XREF: LoadR12↑o
                dc.w FileR12B
                dc.w FileR12C
                dc.w FileR12D
; ---------------------------------------------------------------------------

LoadTimeAttack:                         ; CODE XREF: ROM:00FF0028↑j
                                        ; ROM:TimeAttack_Index↓j
                moveq   #FileTimeAttack,d0
                bsr.w   LoadFile
                move.w  d0,(TimeAttackSelection).l
                beq.w   LoadTitleScreen
                add.w   d0,d0
                move.w  TimeAttack_Index(pc,d0.w),d0
                move.b  #1,(TimeAttackFlag).l
                bsr.w   LoadFile
                move.l  (Time).l,(TimeAttackTime).l

TimeAttack_Index:
                bra.s   LoadTimeAttack
; ---------------------------------------------------------------------------
TimeAttack_Levels:dc.w FileR11A
                dc.w FileR12A

; =============== S U B R O U T I N E =======================================


LoadFile:                               ; CODE XREF: ROM:00FF0012↑p
                                        ; ROM:00FF0018↑p ...
                move.l  a0,-(sp)
                bsr.w   SPExecute
                move.l  (MMDEntryPoint).l,d0
                beq.s   NoFile
                movea.l d0,a0
                move.l  (MMDRAMLoc).l,d0
                beq.s   Interrupt4
                movea.l d0,a2
                lea     (MMDStart).l,a1
                move.w  (MMDRAMSize).l,d7

CopytoRAM:                              ; CODE XREF: LoadFile+28↓j
                move.l  (a1)+,(a2)+
                dbf     d7,CopytoRAM

Interrupt4:                             ; CODE XREF: LoadFile+16↑j
                move.l  (MMDLvl4Int).l,d0
                beq.s   Interrupt6
                move.l  d0,(BIOSVIntVector).w

Interrupt6:                             ; CODE XREF: LoadFile+32↑j
                move.l  (MMDLvl6Int).l,d0
                beq.s   GetLaunchMode
                move.l  d0,(BIOSHIntVector).w

GetLaunchMode:                          ; CODE XREF: LoadFile+3E↑j
                btst    #6,(MMDFlags).l
                beq.s   Jump
                bset    #1,(MemMode).l

Jump:                                   ; CODE XREF: LoadFile+4C↑j
                jsr     (a0)
                move.b  #0,(VBlnkRtnCount).l
                move.l  #HInt,(BIOSVIntVector).w
                move.l  #VInt,(BIOSHIntVector).w
                move.w  #$8134,(VDPDefaultMode).l
                move.w  #$8134,(VDPCtrl).l
                bset    #1,(MemMode).l

NoFile:                                 ; CODE XREF: LoadFile+C↑j
                movea.l (sp)+,a0
                rts
; End of function LoadFile


; =============== S U B R O U T I N E =======================================


VInt:                                   ; DATA XREF: ROM:IPX↑o
                                        ; LoadFile+68↑o
                bset    #0,(SubCPUInt).l

HInt:                                   ; DATA XREF: LoadFile+60↑o
                rte
; End of function VInt


; =============== S U B R O U T I N E =======================================


SPExecute:                              ; CODE XREF: LoadFile+2↑p
                move.w  d0,(CommReg).l

WaitReturn:                             ; CODE XREF: SPExecute+C↓j
                tst.w   (StatusReg).l
                beq.s   WaitReturn
                move.w  #0,(CommReg).l

WaitClear:                              ; CODE XREF: SPExecute+1C↓j
                tst.w   (StatusReg).l
                bne.s   WaitClear
                rts
; End of function SPExecute

; end of 'ROM'


                END
