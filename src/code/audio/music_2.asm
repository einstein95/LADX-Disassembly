; Disassembly of "game.gbc"
; This file was created with mgbdis v1.3 - Game Boy ROM disassembler by Matt Currie.
; https://github.com/mattcurrie/mgbdis

    jp   label_01E_4009

    jp   label_01E_4CFF

PlayMusicTrack_1E::
    jp   PlayMusicTrack_1E_EntryPoint

label_01E_4009:
    ld   hl, wMusicTranspose

.loop_400C
    ld   [hl], $00
    inc  l
    jr   nz, .loop_400C

    ld   a, $80
    ldh  [rNR52], a
    ld   a, $77
    ldh  [rNR50], a
    ld   a, $FF
    ldh  [rNR51], a
    ret

PlayMusicTrack_1E_EntryPoint::
    ld   hl, wMusicTrackToPlay
    ld   a, [hl+]
    and  a
    jr   nz, BeginMusicTrack_1E

    call func_01E_403F

jr_01E_4028:
    call func_01E_4581

DontPlayAudio_1E::
    xor  a
    ld   [wActiveJingle], a
    ld   [wMusicTrackToPlay], a
    ld   [wActiveWaveSfx], a
    ld   [wActiveNoiseSfx], a
    ret

BeginMusicTrack_1E::
    ; [wActiveMusicIndex] = [wMusicTrackToPlay]
    ld   [hl], a
    call BeginMusicTrack_Dispatch_1E
    jr   jr_01E_4028

func_01E_403F::
    ld   de, wD393
    ld   hl, wActiveNoiseSfx
    ld   a, [hl+]
    cp   $01
    jr   z, .jr_4050

    ld   a, [hl]
    cp   $01
    jr   z, jr_01E_405B

    ret

.jr_4050
    ld   a, $01
    ld   [wD379], a
    ld   hl, Data_0E1_4068
    jp   label_01E_4072

jr_01E_405B:
    ld   a, [de]
    dec  a
    ld   [de], a
    ret  nz

    xor  a
    ld   [wD379], a
    ld   hl, Data_0E1_406D
    jr   jr_01E_4072

Data_0E1_4068::
    db $3B
    db $80
    db $07
    db $C0
    db $02

Data_0E1_406D::
    db $00
    db $42
    db $02
    db $C0
    db $04

label_01E_4072:
jr_01E_4072:
    ld   b, $04
    ld   c, $20

.loop_4076
    ld   a, [hl+]
    ldh  [c], a
    inc  c
    dec  b
    jr   nz, .loop_4076

    ld   a, [hl]
    ld   [de], a
    ret


; Music ID numbers are based on values written to wMusicTrackToPlay. They don't
; match up with "constants/sfx.asm" for some reason.
; Is this still the case? The constants are now correctly named.
MusicDataPointerTable_1E::
    dw   MusicFileSelect
    dw   MusicEggMaze
    dw   MusicKanaletCastle
    dw   MusicTailCave
    dw   MusicBottleGrotto
    dw   MusicKeyCavern
    dw   MusicAnglersTunnel
    dw   MusicAfterBoss
    dw   MusicBoss
    dw   MusicTitleCutscene
    dw   MusicObtainInstrument
    dw   MusicIntroWakeUp
    dw   MusicOverworldSwordless
    dw   MusicDreamShrineSleep
    dw   MusicSouthernShrine
    dw   MusicInstrumentFullMoonCello

    dw   Music2dUnderground
    dw   MusicOwl
    dw   MusicFinalBoss
    dw   MusicDreamShrineBed
    dw   MusicHeartContainer
    dw   MusicCave
    dw   MusicObtainPowerup
    dw   MusicInstrumentConchHorn
    dw   MusicInstrumentSeaLilysBell
    dw   MusicInstrumentSurfHarp
    dw   MusicInstrumentWindMarimba
    dw   MusicInstrumentCoralTriangle
    dw   MusicInstrumentOrganOfEveningCalm
    dw   MusicInstrumentThunderDrum
    dw   MusicMarinSing
    dw   MusicManbosMambo

    dw   MusicEggBalladDefault
    dw   MusicEggBalladBell
    dw   MusicEggBalladHarp
    dw   MusicEggBalladMarimba
    dw   MusicEggBalladTriangle
    dw   MusicEggBalladOrgan
    dw   MusicEggBalladAll
    dw   MusicGhostHouse
    dw   MusicActivePowerUp
    dw   MusicLearnBallad
    dw   MusicCatfishsMaw
    dw   MusicOpenAnglersTunnel
    dw   MusicMarinOnBeach
    dw   MusicMarinBeachTalk
    dw   MusicMarinUnused
    dw   MusicMiniboss

    dw   MusicKanaletCastleCopy
    dw   MusicTailCaveCopy
    dw   MusicDreamShrineDream
    dw   MusicEagleBossTransition
    dw   MusicRoosterRevival
    dw   MusicL2Sword
    dw   MusicHenhouse
    dw   MusicFaceShrine
    dw   MusicWindFish
    dw   MusicTurtleRock
    dw   MusicEaglesTower
    dw   MusicEagleBossLoop
    dw   MusicFinalBossIntro
    dw   MusicBossDefeat
    dw   MusicFinalBossDefeat
    dw   MusicFileSelectZelda

func_01E_40FF::
    inc  e
    dec  a
    sla  a
    ld   c, a
    ld   b, $00
    add  hl, bc
    ld   c, [hl]
    inc  hl
    ld   b, [hl]
    ld   l, c
    ld   h, b
    ld   a, h
    ret

func_01E_410E::
    push bc
    ld   c, $30

.loop_4111
    ld   a, [hl+]
    ldh  [c], a
    inc  c
    ld   a, c
    cp   $40
    jr   nz, .loop_4111

    pop  bc
    ret

func_01E_411B::
    xor  a
    ld   [wD379], a
    ld   [wD34F], a
    ld   [wD398], a
    ld   [wD393], a
    ld   [wD3C9], a
    ld   [wD3A3], a
    ld   a, $08
    ldh  [rNR42], a
    ld   a, $80
    ldh  [rNR44], a
    ret

func_01E_4137::
jr_01E_4137:
    ld   a, [wD379]
    cp   $05
    jp   z, label_01E_4D1D

    cp   $0C
    jp   z, label_01E_4D1D

    cp   $1A
    jp   z, label_01E_4D1D

    cp   $24
    jp   z, label_01E_4D1D

    cp   $2A
    jp   z, label_01E_4D1D

    cp   $2E
    jp   z, label_01E_4D1D

    cp   $3F
    jp   z, label_01E_4D1D

    call func_01E_411B
    jp   label_01E_4D1D

BeginMusicTrack_Dispatch_1E::
    ld   b, a
    ld   a, [wActiveMusicTable]
    and  a
    jp   nz, DontPlayAudio_1E

    ld   a, b
    cp   $FF
    jr   z, jr_01E_4137

    cp   $11
    jr   nc, .above10

    jp   DontPlayAudio_1E

.above10
    cp   $21
    jr   nc, .above20

    add  $F0
    jr   .playAudio

.above20
    cp   $31
    jr   nc, .above30

    add  $F0
    jr   .playAudio

.above30
    cp   $41
    jp   c, DontPlayAudio_1E

    cp   $61
    jp   nc, DontPlayAudio_1E

    add  $E0

.playAudio
    dec  hl
    ld   [hl+], a

    ld   [hl-], a
    ld   a, [wD3CA]
    ld   [wPreviousMusicTrack], a
    ld   a, [hl+]
    ld   [wD3CA], a
    ld   b, a
    ld   hl, MusicDataPointerTable_1E
    and  $7F
    call func_01E_40FF
    call func_01E_43C0
    jp   label_01E_4359

; Pattern, repeats after 6 entries.
Data_01E_41AF::
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00
    db   $01, $00, $FF, $FF, $00, $00

label_01E_432F:
    ld   a, [wD3E7]
    and  a
    jp   z, label_01E_473F

    xor  a
    ldh  [rNR30], a
    ld   [wD3E7], a
    push hl
    ld   a, [wD330 + 6]
    ld   l, a
    ld   a, [wD330 + 7]
    ld   h, a
    push bc
    ld   c, $30

.loop_4348
    ld   a, [hl+]
    ldh  [c], a
    inc  c
    ld   a, c
    cp   $40
    jr   nz, .loop_4348

    ld   a, $80
    ldh  [rNR30], a
    pop  bc
    pop  hl
    jp   label_01E_473F

label_01E_4359:
    ld   a, [wActiveMusicIndex]
    ld   hl, Data_01E_41AF

.loop_435F
    dec  a
    jr   z, .jr_436A

    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    inc  hl
    jr   .loop_435F

.jr_436A
    ld   bc, wD355
    ld   a, [hl+]
    ld   [bc], a
    inc  c
    xor  a
    ld   [bc], a
    inc  c
    ld   a, [hl+]
    ld   [bc], a
    inc  c
    xor  a
    ld   [bc], a
    inc  c
    ld   a, [hl+]
    ld   [bc], a
    ldh  [rNR51], a
    inc  c
    ld   a, [hl+]
    ld   [bc], a
    inc  c
    ld   a, [hl+]
    ld   [bc], a
    inc  c
    ld   a, [hl+]
    ld   [bc], a
    ret

func_01E_4387::
    ld   hl, wD355
    ld   a, [hl+]
    cp   $01
    ret  z

    inc  [hl]
    ld   a, [hl+]
    cp   [hl]
    ret  nz

    dec  l
    ld   [hl], $00
    inc  l
    inc  l
    inc  [hl]
    ld   a, [hl+]
    and  $03
    ld   c, l
    ld   b, h
    and  a
    jr   z, .jr_43AB

    inc  c
    cp   $01
    jr   z, .jr_43AB

    inc  c
    cp   $02
    jr   z, .jr_43AB

    inc  c

.jr_43AB
    ld   a, [bc]
    ldh  [rNR51], a
    ret

func_01E_43AF::
    ld   a, [hl+]
    ld   c, a
    ld   a, [hl]
    ld   b, a
    ld   a, [bc]
    ld   [de], a
    inc  e
    inc  bc
    ld   a, [bc]
    ld   [de], a
    ret

func_01E_43BA::
    ld   a, [hl+]
    ld   [de], a
    inc  e
    ld   a, [hl+]
    ld   [de], a
    ret

func_01E_43C0::
    ld   a, [wD379]
    cp   $05
    jr   z, .jr_43E2

    cp   $0C
    jr   z, .jr_43E2

    cp   $1A
    jr   z, .jr_43E2

    cp   $24
    jr   z, .jr_43E2

    cp   $2A
    jr   z, .jr_43E2

    cp   $2E
    jr   z, .jr_43E2

    cp   $3F
    jr   z, .jr_43E2

    call func_01E_411B

.jr_43E2
    call func_01E_4D2A
    ld   de, wMusicTranspose
    ld   b, $00
    ld   a, [hl+]
    ld   [de], a
    inc  e
    call func_01E_43BA
    ld   de, wD310
    call func_01E_43BA
    ld   de, wD320
    call func_01E_43BA
    ld   de, wD330
    call func_01E_43BA
    ld   de, wD340
    call func_01E_43BA
    ld   hl, wD310
    ld   de, wD314
    call func_01E_43AF
    ld   hl, wD320
    ld   de, wD320 + 4
    call func_01E_43AF
    ld   hl, wD330 + 0
    ld   de, wD330 + 4
    call func_01E_43AF
    ld   hl, wD340
    ld   de, wD344
    call func_01E_43AF
    ld   bc, $410
    ld   hl, wD312

.loop_4432
    ld   [hl], $01
    ld   a, c
    add  l
    ld   l, a
    dec  b
    jr   nz, .loop_4432

    xor  a
    ld   [wD31E], a
    ld   [wD320 + $0E], a
    ld   [wD330 + $0E], a
    ret

jr_01E_4445:
    push hl
    ld   a, [wD371]
    and  a
    jr   nz, .jr_4454

    xor  a
    ldh  [rNR30], a
    ld   l, e
    ld   h, d
    call func_01E_410E

.jr_4454
    pop  hl
    jr   jr_01E_4481

label_01E_4457:
    call func_01E_4487
    call func_01E_449C
    ld   e, a
    call func_01E_4487
    call func_01E_449C
    ld   d, a
    call func_01E_4487
    call func_01E_449C
    ld   c, a
    inc  l
    inc  l
    ld   [hl], e
    inc  l
    ld   [hl], d
    inc  l
    ld   [hl], c
    dec  l
    dec  l
    dec  l
    dec  l
    push hl
    ld   hl, wActiveChannelIndex
    ld   a, [hl]
    pop  hl
    cp   $03
    jr   z, jr_01E_4445

jr_01E_4481:
    call func_01E_4487
    jp   label_01E_45A5

func_01E_4487::
    push de
    ld   a, [hl+]
    ld   e, a
    ld   a, [hl-]
    ld   d, a
    inc  de

jr_01E_448D:
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl-], a
    pop  de
    ret

func_01E_4493::
    push de
    ld   a, [hl+]
    ld   e, a
    ld   a, [hl-]
    ld   d, a
    inc  de
    inc  de
    jr   jr_01E_448D

func_01E_449C::
    ld   a, [hl+]
    ld   c, a
    ld   a, [hl-]
    ld   b, a
    ld   a, [bc]
    ld   b, a
    ret

jr_01E_44A3:
    pop  hl
    jr   jr_01E_44D7

label_01E_44A6:
    ld   a, [wActiveChannelIndex]
    cp   $03
    jr   nz, .jr_44BD

    ld   a, [wD330 + $08]
    bit  7, a
    jr   z, .jr_44BD

    ld   a, [hl]
    cp   $06
    jr   nz, .jr_44BD

    ld   a, $40
    ldh  [rNR32], a

.jr_44BD
    push hl
    ld   a, l
    add  $09
    ld   l, a
    ld   a, [hl]
    and  a
    jr   nz, jr_01E_44A3

    ld   a, l
    add  $04
    ld   l, a
    bit  7, [hl]
    jr   nz, jr_01E_44A3

    pop  hl
    call func_01E_4772
    push hl
    call func_01E_47F6
    pop  hl

label_01E_44D7:
jr_01E_44D7:
    dec  l
    dec  l
    jp   label_01E_4752

label_01E_44DC:
    dec  l
    dec  l
    dec  l
    dec  l
    call func_01E_4493

jr_01E_44E3:
    ld   a, l
    add  $04
    ld   e, a
    ld   d, h
    call func_01E_43AF
    cp   $00
    jr   z, jr_01E_450E

    cp   $FF
    jr   z, .jr_44F7

    inc  l
    jp   label_01E_45A3

.jr_44F7
    dec  l
    push hl
    call func_01E_4493
    call func_01E_449C
    ld   e, a
    call func_01E_4487
    call func_01E_449C
    ld   d, a
    pop  hl
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl-], a
    jr   jr_01E_44E3

jr_01E_450E:
    ld   a, [wD3CA]
    cp   $15
    jp   z, ContinueCurrentScreenMusic_1E

    ld   hl, wActiveMusicIndex
    ld   [hl], $00
    call func_01E_4137
    ret

label_01E_451F:
    call func_01E_4487
    call func_01E_449C
    ld   [wMusicSpeedPointer], a
    call func_01E_4487
    call func_01E_449C
    ld   [wMusicSpeedPointer+1], a
    jr   jr_01E_453C

label_01E_4533:
    call func_01E_4487
    call func_01E_449C
    ld   [wMusicTranspose], a

jr_01E_453C:
    call func_01E_4487
    jr   jr_01E_45A5

label_01E_4541:
    call func_01E_4487
    call func_01E_449C
    push hl
    ld   a, l
    add  $0B
    ld   l, a
    ld   c, [hl]
    ld   a, b
    or   c
    ld   [hl], a
    ld   b, h
    ld   c, l
    dec  c
    dec  c
    pop  hl
    ld   a, [hl+]
    ld   e, a
    ld   a, [hl-]
    ld   d, a
    inc  de
    ld   a, e
    ld   [hl+], a
    ld   a, d
    ld   [hl-], a
    ld   a, d
    ld   [bc], a
    dec  c
    ld   a, e
    ld   [bc], a
    jr   jr_01E_45A5

label_01E_4565:
    push hl
    ld   a, l
    add  $0B
    ld   l, a
    ld   a, [hl]
    dec  [hl]
    ld   a, [hl]
    and  $7F
    jr   z, .jr_457E

    ld   b, h
    ld   c, l
    dec  c
    dec  c
    dec  c
    pop  hl
    ld   a, [bc]
    ld   [hl+], a
    inc  c
    ld   a, [bc]
    ld   [hl-], a
    jr   jr_01E_45A5

.jr_457E
    pop  hl
    jr   jr_01E_453C

func_01E_4581::
    ld   hl, wActiveMusicIndex
    ld   a, [hl]
    and  a
    ret  z

    ld   a, [wActiveMusicTable]
    and  a
    jp   nz, DontPlayAudio_1E

    call func_01E_4387

    ld   a, $01
    ld   [wActiveChannelIndex], a
    ld   hl, wD310

label_01E_4599:
    inc  l
    ld   a, [hl+]
    and  a
    jp   z, label_01E_44D7

    dec  [hl]
    jp   nz, label_01E_44A6

label_01E_45A3:
    inc  l
    inc  l

label_01E_45A5:
jr_01E_45A5:
    call func_01E_449C
    cp   $00
    jp   z, label_01E_44DC

    cp   $9D
    jp   z, label_01E_4457

    cp   $9E
    jp   z, label_01E_451F

    cp   $9F
    jp   z, label_01E_4533

    cp   $9B
    jp   z, label_01E_4541

    cp   $9C
    jp   z, label_01E_4565

    cp   $99
    jp   z, label_01E_486E

    cp   $9A
    jp   z, label_01E_4879

    cp   $94
    jp   z, label_01E_48B8

    cp   $97
    jp   z, label_01E_48ED

    cp   $98
    jp   z, label_01E_48FC

    cp   $96
    jp   z, label_01E_4860

    cp   $95
    jp   z, label_01E_486B

    and  $F0
    cp   $A0
    jr   nz, jr_01E_463C

    ld   a, b
    and  $0F
    ld   c, a
    ld   b, $00
    push hl
    ld   de, wMusicSpeedPointer
    ld   a, [de]
    ld   l, a
    inc  e
    ld   a, [de]
    ld   h, a
    add  hl, bc
    ld   a, [hl]
    pop  hl
    push hl
    ld   d, a
    inc  l
    inc  l
    inc  l
    ld   a, [hl]
    and  $F0
    jr   nz, .jr_460E

    ld   a, d
    jr   jr_01E_4633

.jr_460E
    ld   e, a
    ld   a, d
    push af
    srl  a
    sla  e
    jr   c, .jr_461F

    ld   d, a
    srl  a
    sla  e
    jr   c, .jr_461F

    add  d

.jr_461F
    ld   c, a
    and  a
    jr   nz, .jr_4625

    ld   c, $02

.jr_4625
    ld   de, wActiveChannelIndex
    ld   a, [de]
    dec  a
    ld   e, a
    ld   d, $00
    ld   hl, wD307
    add  hl, de
    ld   [hl], c
    pop  af

jr_01E_4633:
    pop  hl
    dec  l
    ld   [hl+], a
    call func_01E_4487
    call func_01E_449C

jr_01E_463C:
    ld   a, [wActiveChannelIndex]
    cp   $04
    jr   z, jr_01E_467B

    push de
    ld   de, wD3B0
    call func_01E_493C
    xor  a
    ld   [de], a
    inc  e
    ld   [de], a
    ld   de, wD3B6
    call func_01E_493C
    inc  e
    xor  a
    ld   [de], a
    ld   a, [wActiveChannelIndex]
    cp   $03
    jr   nz, jr_01E_467A

    ld   de, wD39E
    ld   a, [de]
    and  a
    jr   z, .jr_466C

    ld   a, $01
    ld   [de], a
    xor  a
    ld   [wD39F], a

.jr_466C
    ld   de, wActiveMusicTableIndex
    ld   a, [de]
    and  a
    jr   z, jr_01E_467A

    ld   a, $01
    ld   [de], a
    xor  a
    ld   [wD3DA], a

jr_01E_467A:
    pop  de

jr_01E_467B:
    ld   c, b
    ld   b, $00
    call func_01E_4487
    ld   a, [wActiveChannelIndex]
    cp   $04
    jp   z, label_01E_46BD

    push hl
    ld   a, l
    add  $05
    ld   l, a
    ld   e, l
    ld   d, h
    inc  l
    inc  l
    ld   a, c
    cp   $01
    jr   z, jr_01E_46B8

    ld   [hl], $00
    ld   a, [wMusicTranspose]
    and  a
    jr   z, jr_01E_46AB

    ld   l, a
    ld   h, $00
    bit  7, l
    jr   z, .jr_46A8

    ld   h, $FF

.jr_46A8
    add  hl, bc
    ld   b, h
    ld   c, l

jr_01E_46AB:
    ld   hl, Data_01E_49BF
    add  hl, bc
    ld   a, [hl+]
    ld   [de], a
    inc  e
    ld   a, [hl]
    ld   [de], a
    pop  hl
    jp   label_01E_46EE

jr_01E_46B8:
    ld   [hl], $01
    pop  hl
    jr   jr_01E_46EE

label_01E_46BD:
    push hl
    ld   a, c
    cp   $FF
    jr   z, jr_01E_46DB

    ld   de, wD346
    ld   hl, Data_01E_4A51
    add  hl, bc

.loop
    ld   a, [hl+]
    ld   [de], a
    inc  e
    ld   a, e
    cp   LOW(wD346 + 5)
    jr   nz, .loop

    ld   c, $20
    ld   hl, wD344
    ld   b, $00
    jr   jr_01E_471C

jr_01E_46DB:
    ld   a, [wD34F]
    bit  7, a
    jp   nz, label_01E_474D

    ld   a, $01
    ld   [wActiveNoiseSfx], a
    call func_01E_403F
    jp   label_01E_474D

label_01E_46EE:
jr_01E_46EE:
    push hl
    ld   b, $00
    ld   a, [wActiveChannelIndex]
    cp   $01
    jr   z, jr_01E_4719

    cp   $02
    jr   z, jr_01E_4715

    ld   c, $1A
    ld   a, [wD330 + $0F]
    bit  7, a
    jr   nz, .jr_470A

    xor  a
    ldh  [c], a
    ld   a, $80
    ldh  [c], a

.jr_470A
    inc  c
    inc  l
    inc  l
    inc  l
    inc  l
    ld   a, [hl+]
    ld   e, a
    ld   d, $00
    jr   jr_01E_4723

jr_01E_4715:
    ld   c, $16
    jr   jr_01E_471C

jr_01E_4719:
    ld   c, $10
    inc  c

jr_01E_471C:
    inc  l
    inc  l
    ld   a, [hl+]
    ld   e, a
    inc  l
    ld   a, [hl+]
    ld   d, a

jr_01E_4723:
    push hl
    inc  l
    inc  l
    ld   a, [hl+]
    and  a
    jr   z, .jr_472C

    ld   e, $08

.jr_472C
    inc  l
    inc  l
    ld   [hl], $00
    inc  l
    ld   a, [hl]
    pop  hl
    bit  7, a
    jr   nz, jr_01E_474D

    ld   a, [wActiveChannelIndex]
    cp   $03
    jp   z, label_01E_432F

label_01E_473F:
    ld   a, d
    or   b
    ldh  [c], a
    inc  c
    ld   a, e
    ldh  [c], a
    inc  c
    ld   a, [hl+]
    ldh  [c], a
    inc  c
    ld   a, [hl]
    or   $80
    ldh  [c], a

label_01E_474D:
jr_01E_474D:
    pop  hl
    dec  l
    ld   a, [hl-]
    ld   [hl-], a
    dec  l

label_01E_4752:
    ld   de, wActiveChannelIndex
    ld   a, [de]
    cp   $04
    jr   z, .jr_4763

    inc  a
    ld   [de], a
    ld   a, $10
    add  l
    ld   l, a
    jp   label_01E_4599

.jr_4763
    ld   hl, wD31E
    inc  [hl]
    ld   hl, wD320 + $0E
    inc  [hl]
    ld   hl, wD330 + $0E
    inc  [hl]
    ret

label_01E_4770:
    pop  hl
    ret

func_01E_4772::
    push hl
    ld   a, l
    add  $06
    ld   l, a
    ld   a, [hl]
    and  $0F
    jr   z, jr_01E_4794

    ld   [wD351], a
    ld   a, [wActiveChannelIndex]
    ld   c, $13
    cp   $01
    jr   z, jr_01E_47D6

    ld   c, $18
    cp   $02
    jr   z, jr_01E_47D6

    ld   c, $1D
    cp   $03
    jr   z, jr_01E_47D6

label_01E_4794:
jr_01E_4794:
    ld   a, [wActiveChannelIndex]
    cp   $04
    jp   z, label_01E_4770

    ld   de, wD3B6
    call func_01E_493C
    ld   a, [de]
    and  a
    jp   z, label_01E_47BD

    ld   a, [wActiveChannelIndex]
    ld   c, $13
    cp   $01
    jp   z, label_01E_4905

    ld   c, $18
    cp   $02
    jp   z, label_01E_4905

    ld   c, $1D
    jp   label_01E_4905

label_01E_47BD:
    ld   a, [wActiveChannelIndex]
    cp   $03
    jp   nz, label_01E_4770

    ld   a, [wD39E]
    and  a
    jp   nz, label_01E_4882

    ld   a, [wActiveMusicTableIndex]
    and  a
    jp   nz, label_01E_48C3

    jp   label_01E_4770

jr_01E_47D6:
    inc  l
    ld   a, [hl+]
    ld   e, a
    ld   a, [hl]
    and  $0F
    ld   d, a
    push de
    ld   a, l
    add  $04
    ld   l, a
    ld   b, [hl]
    ld   a, [wD351]
    cp   $01
    jp   z, label_01E_4952

    ld   hl, $FFFF
    pop  de
    add  hl, de
    call func_01E_492B
    jp   label_01E_4794

func_01E_47F6::
    ld   a, [wD31B]
    and  a
    jr   nz, .jr_481D

    ld   a, [wD317]
    and  a
    jr   z, .jr_481D

    and  $0F
    ld   b, a
    ld   hl, wD307
    ld   a, [wD31E]
    cp   [hl]
    jr   nz, .jr_481D

    ld   c, $12
    ld   de, wD31A
    ld   a, [wD31F]
    bit  7, a
    jr   nz, .jr_481D

    call func_01E_4841

.jr_481D
    ld   a, [wD320 + $0B]
    and  a
    ret  nz

    ld   a, [wD320 + $07]
    and  a
    ret  z

    and  $0F
    ld   b, a
    ld   hl, wD308
    ld   a, [wD320 + $0E]
    cp   [hl]
    ret  nz

    ld   a, [wD320 + $0F]
    bit  7, a
    ret  nz

    ld   c, $17
    ld   de, wD320 + $0A
    call func_01E_4841
    ret

func_01E_4841::
    push bc
    dec  b
    ld   c, b
    ld   b, $00
    ld   hl, HardcodedData_1e_4b15
    add  hl, bc
    ld   a, [hl]
    pop  bc
    ldh  [c], a
    inc  c
    inc  c
    ld   a, [de]
    or   $80
    ldh  [c], a
    ret

ContinueCurrentScreenMusic_1E:
    xor  a
    ld   [wActiveMusicTable], a
    ldh  a, [hNextDefaultMusicTrack]
    ld   [wMusicTrackToPlay], a
    jp   PlayMusicTrack_1E_EntryPoint

label_01E_4860:
    ld   a, $01

jr_01E_4862:
    ld   [wD3CD], a
    call func_01E_4487
    jp   label_01E_45A5

label_01E_486B:
    xor  a
    jr   jr_01E_4862

label_01E_486E:
    ld   a, $01

jr_01E_4870:
    ld   [wD39E], a
    call func_01E_4487
    jp   label_01E_45A5

label_01E_4879:
    xor  a
    ld   [wActiveMusicTableIndex], a
    ld   [wD3DA], a
    jr   jr_01E_4870

label_01E_4882:
    cp   $02
    jp   z, label_01E_4770

    ld   bc, wD39F
    call func_01E_48B4
    ld   c, $1C
    ld   b, $40
    cp   $03
    jr   z, jr_01E_48AF

    ld   b, $60
    cp   $05
    jr   z, jr_01E_48AF

    cp   $0A
    jr   z, jr_01E_48AF

    ld   b, $00
    cp   $07
    jr   z, jr_01E_48AF

    cp   $0D
    jp   nz, label_01E_4770

    ld   a, $02
    ld   [wD39E], a

label_01E_48AF:
jr_01E_48AF:
    ld   a, b
    ldh  [c], a
    jp   label_01E_4770

func_01E_48B4::
    ld   a, [bc]
    inc  a
    ld   [bc], a
    ret

label_01E_48B8:
    ld   a, $01
    ld   [wActiveMusicTableIndex], a
    call func_01E_4487
    jp   label_01E_45A5

label_01E_48C3:
    cp   $02
    jp   z, label_01E_4770

    ld   bc, wD3DA
    call func_01E_48B4
    ld   c, $1C
    ld   b, $60
    cp   $03
    jp   z, label_01E_48AF

    ld   b, $40
    cp   $05
    jp   z, label_01E_48AF

    ld   b, $20
    cp   $06
    jp   nz, label_01E_4770

    ld   a, $02
    ld   [wActiveMusicTableIndex], a
    jp   label_01E_48AF

label_01E_48ED:
    ld   de, wD3B6
    call func_01E_493C
    ld   a, $01

jr_01E_48F5:
    ld   [de], a
    call func_01E_4487
    jp   label_01E_45A5

label_01E_48FC:
    ld   de, wD3B6
    call func_01E_493C
    xor  a
    jr   jr_01E_48F5

label_01E_4905:
    inc  e
    ld   a, [de]
    and  a
    jr   nz, jr_01E_491B

    inc  a
    ld   [de], a
    pop  hl
    push hl
    call func_01E_4920

jr_01E_4911:
    ld   hl, hLinkPhysicsModifier
    add  hl, de
    call func_01E_492B
    jp   label_01E_4770

jr_01E_491B:
    call func_01E_4945
    jr   jr_01E_4911

func_01E_4920::
    ld   a, $07
    add  l
    ld   l, a
    ld   a, [hl+]
    ld   e, a
    ld   a, [hl]
    and  $0F
    ld   d, a
    ret

func_01E_492B::
    ld   de, wD3A4
    call func_01E_493C
    ld   a, l
    ldh  [c], a
    ld   [de], a
    inc  c
    inc  e
    ld   a, h
    and  $0F
    ldh  [c], a
    ld   [de], a
    ret

func_01E_493C::
    ld   a, [wActiveChannelIndex]
    dec  a
    sla  a
    add  e
    ld   e, a
    ret

func_01E_4945::
    ld   de, wD3A4
    call func_01E_493C
    ld   a, [de]
    ld   l, a
    inc  e
    ld   a, [de]
    ld   d, a
    ld   e, l
    ret

label_01E_4952:
    pop  de
    ld   de, wD3B0
    call func_01E_493C
    ld   a, [de]
    inc  a
    ld   [de], a
    inc  e
    cp   $19
    jr   z, jr_01E_4992

    cp   $2D
    jr   z, jr_01E_498B

    ld   a, [de]
    and  a
    jp   z, label_01E_4794

jr_01E_496A:
    dec  e
    ld   a, [de]
    sub  $19
    sla  a
    ld   l, a
    ld   h, $00
    ld   de, Data_01E_4997
    add  hl, de
    ld   a, [hl+]
    ld   d, a
    ld   a, [hl]
    ld   e, a
    pop  hl
    push hl
    push de
    call func_01E_4920
    ld   h, d
    ld   l, e
    pop  de
    add  hl, de
    call func_01E_492B
    jp   label_01E_4794

jr_01E_498B:
    dec  e
    ld   a, $19
    ld   [de], a
    inc  e
    jr   jr_01E_496A

jr_01E_4992:
    ld   a, $01
    ld   [de], a
    jr   jr_01E_496A

Data_01E_4997::
    db   $00, $00, $00, $00, $00, $01, $00, $01
    db   $00, $02, $00, $02, $00, $00, $00, $00
    db   $FF, $FF, $FF, $FF, $FF, $FE, $FF, $FE
    db   $00, $00, $00, $01, $00, $02, $00, $01
    db   $00, $00, $FF, $FF, $FF, $FE, $FF, $FF

Data_01E_49BF::
    db   $00, $0F, $2C, $00, $9C, $00, $06, $01
    db   $6B, $01, $C9, $01, $23, $02, $77, $02
    db   $C6, $02, $12, $03, $56, $03, $9B, $03
    db   $DA, $03, $16, $04, $4E, $04, $83, $04
    db   $B5, $04, $E5, $04, $11, $05, $3B, $05
    db   $63, $05, $89, $05, $AC, $05, $CE, $05
    db   $ED, $05, $0A, $06, $27, $06, $42, $06
    db   $5B, $06, $72, $06, $89, $06, $9E, $06
    db   $B2, $06, $C4, $06, $D6, $06, $E7, $06
    db   $F7, $06, $06, $07, $14, $07, $21, $07
    db   $2D, $07, $39, $07, $44, $07, $4F, $07
    db   $59, $07, $62, $07, $6B, $07, $74, $07
    db   $7B, $07, $83, $07, $8A, $07, $90, $07
    db   $97, $07, $9D, $07, $A2, $07, $A7, $07
    db   $AC, $07, $B1, $07, $B6, $07, $BA, $07
    db   $BE, $07, $C1, $07, $C5, $07, $C8, $07
    db   $CB, $07, $CE, $07, $D1, $07, $D4, $07
    db   $D6, $07, $D9, $07, $DB, $07, $DD, $07
    db   $DF, $07

Data_01E_4A51::
    db   $00, $00, $00, $00, $00, $C0, $09, $00
    db   $38, $34, $C0, $19, $00, $38, $33, $C0
    db   $46, $00, $13, $10, $C0, $23, $00, $20
    db   $40, $80, $51, $00, $20, $07, $80, $A1
    db   $00, $00, $18, $80, $F2, $00, $00, $18
    db   $80, $81, $00, $3A, $10, $C0, $80, $00
    db   $00, $10, $C0, $57, $00, $00, $60, $80
    db   $10, $00, $00, $10, $80, $01, $02, $04
    db   $08, $10, $20, $06, $0C, $18, $01, $01
    db   $01, $01, $01, $30


include "data/music/music_tracks_data_1e_1.asm"


label_01E_4CFF:
    xor  a
    ld   [wD379], a

.jr_4D03
    ld   [wD34F], a
    ld   [wD398], a
    ld   [wD393], a
    ld   [wD3C9], a
    ld   [wD3A3], a
    ld   [wD3E2+3], a
    ld   a, $08

.jr_4D17
    ldh  [rNR42], a
    ld   a, $80
    ldh  [rNR44], a

label_01E_4D1D:
    ld   a, $FF
    ldh  [rNR51], a
    ld   a, $03
    ld   [wD355], a
    xor  a
    ld   [wActiveMusicIndex], a

func_01E_4D2A::
    xor  a
    ld   [wD361], a
    ld   [wD371], a
    ld   [wD31F], a
    ld   [wD320 + $0F], a
    ld   [wD330 + $0F], a
    ld   [wD39E], a
    ld   [wD39F], a
    ld   [wActiveMusicTableIndex], a
    ld   [wD3DA], a
    ld   [wD3B6], a
    ld   [wD3B6+1], a
    ld   [wD3B6+2], a
    ld   [wD3B6+3], a
    ld   [wD3B6+4], a
    ld   [wD3B6+5], a
    ld   [wD394], a
    ld   [wD394+1], a
    ld   [wD396], a
    ld   [wD390], a
    ld   [wD390+1], a
    ld   [wD392], a
    ld   [wD3C6], a
    ld   [wD3C7], a
    ld   [wD3C8], a
    ld   [wD3A0], a
    ld   [wD3A1], a
    ld   [wD3A2], a
    ld   [wD3CD], a
    ld   [wD3D6], a
    ld   [wD3D7], a
    ld   [wD3D7+1], a
    ld   [wD3DC], a
    ld   [wD3E7], a
    ld   [wD3E2], a
    ld   [wD3E2+1], a
    ld   [wD3E2+2], a
    ld   a, $08
    ldh  [rNR12], a
    ldh  [rNR22], a
    ld   a, $80
    ldh  [rNR14], a
    ldh  [rNR24], a
    xor  a
    ldh  [rNR10], a
    ldh  [rNR30], a
    ret



