; Disassembly of "game.gbc"
; This file was created with mgbdis v1.3 - Game Boy ROM disassembler by Matt Currie.
; https://github.com/mattcurrie/mgbdis


; Debug handlers?
    jp   label_01B_4009gb

    jp   label_01B_4E2Cgb

PlayMusicTrack_1B::
    jp   PlayMusicTrack_1B_EntryPointgb

label_01B_4009:
    ld   hl, wMusicTransposegb

.loop_400C
    ld   [hl], $00gb
    inc  lgb
    jr   nz, .loop_400Cgb

    ld   a, $80gb
    ldh  [rNR52], agb
    ld   a, $77gb
    ldh  [rNR50], agb
    ld   a, $FFgb
    ldh  [rNR51], agb
    retgb

PlayMusicTrack_1B_EntryPoint::
    ld   hl, wMusicTrackToPlaygb
    ld   a, [hl+]gb
    and  agb
    jr   nz, BeginMusicTrack_1Bgb

    call func_01B_4037gb

jr_01B_4028:
    call UpdateAllMusicChannels_1Bgb
    retgb

DontPlayAudio_1B:
    xor  agb
    ld   [wActiveMusicTable], agb
    retgb

; Input:
;  hl   Points to data after "wMusicTrackToPlay"
BeginMusicTrack_1B::
    ; [wActiveMusicIndex] = [wMusicTrackToPlay]
    ld   [hl], agb
    call BeginMusicTrack_Dispatch_1Bgb
    jr   jr_01B_4028gb

func_01B_4037::
    ld   de, wD393gb
    ld   hl, wActiveNoiseSfxgb
    ld   a, [hl+]gb
    cp   $01gb
    jr   z, .jr_4048gb

    ld   a, [hl]gb
    cp   $01gb
    jr   z, jr_01B_4053gb

    retgb

.jr_4048
    ld   a, $01gb
    ld   [wD379], agb
    ld   hl, Data_01B_4060gb
    jp   label_01B_406Agb

jr_01B_4053:
    ld   a, [de]gb
    dec  agb
    ld   [de], agb
    ret  nzgb

    xor  agb
    ld   [wD379], agb
    ld   hl, Data_01B_4065gb
    jr   jr_01B_406Agb

Data_01B_4060::
    db   $3B, $80, $07, $C0, $02gb

Data_01B_4065::
    db   $00, $42, $02, $C0, $04

label_01B_406A:
jr_01B_406A:
    ld   b, $04gb
    ld   c, $20gb

.loop_406E
    ld   a, [hl+]gb
    ldh  [c], agb
    inc  cgb
    dec  bgb
    jr   nz, .loop_406Egb

    ld   a, [hl]gb
    ld   [de], agb
    retgb


; Music ID numbers are based on values written to wMusicTrackToPlay. They don't
; match up with "constants/sfx.asm" for some reason.
; Is this still the case? The constants are now correctly named.
MusicDataPointerTable_1B::
    dw   MusicTitleScreen
    dw   MusicMinigame
    dw   MusicGameOver
    dw   MusicMabeVillage
    dw   MusicOverworld
    dw   MusicTalTalRange
    dw   MusicShop
    dw   MusicRaftRideRapids
    dw   MusicMysteriousForest
    dw   MusicInsideBuilding
    dw   MusicAnimalVillage
    dw   MusicFairyFountain
    dw   MusicTitleScreenNoIntro
    dw   MusicBowwowKidnapped
    dw   MusicObtainSword
    dw   MusicObtainItem

    dw   MusicOverworldIntro
    dw   MusicMrWriteHouse
    dw   MusicUlrira
    dw   MusicTarinBees
    dw   MusicMamuFrogSong
    dw   MusicMonkeysBuildingBridge
    dw   MusicChristineHouse
    dw   MusicTotakaUnused
    dw   MusicTurtleRockEntranceBoss
    dw   MusicFishermanUnderBridge
    dw   MusicObtainItemUnused
    dw   MusicFileSelectTotaka
    dw   MusicEnding
    dw   MusicMoblinHideout
    dw   MusicIslandDisappear
    dw   MusicRichardHouse

; Input:
;   a:   Table index (starting at 1, not 0)
;   hl:  Table of 16-bit values
; Output:
;   bc:  16-bit value read (little-endian)
;   hl:  Same as bc
;   a:   Value of b/h
;   e:   Incremented by 1
GetMusicDataPtr_1B::
    inc  egb
    dec  agb
    sla  agb
    ld   c, agb
    ld   b, $00gb
    add  hl, bcgb
    ld   c, [hl]gb
    inc  hlgb
    ld   b, [hl]gb
    ld   l, cgb
    ld   h, bgb
    ld   a, hgb
    retgb

; Input:
;   hl:  Waveform (16 bytes to write to $FF30)
SetWaveform_1B::
    push bcgb
    ld   c, $30 ; $FF30, Wave pattern RAMgb

.loop
    ld   a, [hl+]gb
    ldh  [c], agb
    inc  cgb
    ld   a, cgb
    cp   $40gb
    jr   nz, .loopgb

    pop  bcgb
    retgb

StopNoiseChannel_1B::
    xor  agb
    ld   [wD379], agb
    ld   [wD34F], agb
    ld   [wD398], agb
    ld   [wD393], agb
    ld   [wD3C9], agb
    ld   [wD3A3], agb
    ld   a, $08gb
    ldh  [rNR42], agb
    ld   a, $80gb
    ldh  [rNR44], agb
    retgb

; Called when music ends?
func_01B_410F::
jr_01B_410F:
    ld   a, [wD379]gb
    cp   $0Cgb
    jp   z, label_01B_4E4Agb

    cp   $05gb
    jp   z, label_01B_4E4Agb

    cp   $1Agb
    jp   z, label_01B_4E4Agb

    cp   $24gb
    jp   z, label_01B_4E4Agb

    cp   $2Agb
    jp   z, label_01B_4E4Agb

    cp   $2Egb
    jp   z, label_01B_4E4Agb

    cp   $3Fgb
    jp   z, label_01B_4E4Agb

    call StopNoiseChannel_1Bgb
    jp   label_01B_4E4Agb

BeginMusicTrack_Dispatch_1B::
    cp   $FFgb
    jr   z, jr_01B_410Fgb

    ld   a, [wD3CA]gb
    ld   [wPreviousMusicTrack], agb

    ; [wD3CA] = [wActiveMusicIndex]
    ld   a, [hl]gb
    ld   [wD3CA], agb

    cp   $11gb
    jr   nc, .above10gb

    jr   .playAudiogb

.above10
    cp   $21gb
    jr   nc, .above20gb

    jp   DontPlayAudio_1Bgb

.above20
    cp   $31gb
    jr   nc, .above30gb

    jp   DontPlayAudio_1Bgb

.above30
    cp   $41gb
    jp   nc, .DontPlayAudio_1Bgb

    add  $E0gb

.playAudio
    dec  hlgb
    ld   [hl+], a ; [wMusicTrackToPlay]gb

    ld   b, agb
    ld   a, $01gb
    ld   [wActiveMusicTable], agb
    ld   a, bgb
    ld   [hl], a ; [wActiveMusicIndex]gb
    ld   b, agb
    ld   hl, MusicDataPointerTable_1Bgb
    and  $7Fgb
    call GetMusicDataPtr_1Bgb
    call LoadMusicData_1Bgb
    jp   label_01B_42D5gb

Data_1B_418B::
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

label_01B_42AB:
    ld   a, [wD3E7]gb
    and  agb
    jp   z, WriteChannelRegistersgb

    xor  agb
    ldh  [rNR30], agb
    ld   [wD3E7], agb
    push hlgb
    ld   a, [wD330 + 6]gb
    ld   l, agb
    ld   a, [wD330 + 7]gb
    ld   h, agb
    push bcgb
    ld   c, $30gb

.loop_42C4
    ld   a, [hl+]gb
    ldh  [c], agb
    inc  cgb
    ld   a, cgb
    cp   $40gb
    jr   nz, .loop_42C4gb

    ld   a, $80gb
    ldh  [rNR30], agb
    pop  bcgb
    pop  hlgb
    jp   WriteChannelRegistersgb

label_01B_42D5:
    ld   a, [wActiveMusicIndex]gb
    ld   hl, Data_1B_418Bgb

.loop_42DB
    dec  agb
    jr   z, .jr_42E6gb

    inc  hlgb
    inc  hlgb
    inc  hlgb
    inc  hlgb
    inc  hlgb
    inc  hlgb
    jr   .loop_42DBgb

.jr_42E6
    ld   bc, wD355gb
    ld   a, [hl+]gb
    ld   [bc], agb
    inc  cgb
    xor  agb
    ld   [bc], agb
    inc  cgb
    ld   a, [hl+]gb
    ld   [bc], agb
    inc  cgb
    xor  agb
    ld   [bc], agb
    inc  cgb
    ld   a, [hl+]gb
    ld   [bc], agb
    ldh  [rNR51], agb
    inc  cgb
    ld   a, [hl+]gb
    ld   [bc], agb
    inc  cgb
    ld   a, [hl+]gb
    ld   [bc], agb
    inc  cgb
    ld   a, [hl+]gb
    ld   [bc], agb
    retgb

func_01B_4303::
    ld   hl, wD355gb
    ld   a, [hl+]gb
    cp   $01gb
    ret  zgb

    inc  [hl]gb
    ld   a, [hl+]gb
    cp   [hl]gb
    ret  nzgb

    dec  lgb
    ld   [hl], $00gb
    inc  lgb
    inc  lgb
    inc  [hl]gb
    ld   a, [hl+]gb
    and  $03gb
    ld   c, lgb
    ld   b, hgb
    and  agb
    jr   z, .jr_4327gb

    inc  cgb
    cp   $01gb
    jr   z, .jr_4327gb

    inc  cgb
    cp   $02gb
    jr   z, .jr_4327gb

    inc  cgb

.jr_4327
    ld   a, [bc]gb
    ldh  [rNR51], agb
    retgb

; Input:
;   de:  D3x4 (Pointer to sound definition data; will be written to)
;   hl:  D3x0 (Pointer to sound channel data)
; Output:
;   a:   High byte of pointer written
LoadSoundDefinitionData::
    ld   a, [hl+]gb
    ld   c, agb
    ld   a, [hl]gb
    ld   b, agb
    ld   a, [bc]gb
    ld   [de], agb
    inc  egb
    inc  bcgb
    ld   a, [bc]gb
    ld   [de], agb
    retgb

; Inputs:
;   de:  Destination
;   hl:  Source
Copy2Bytes_1B::
    ld   a, [hl+]gb
    ld   [de], agb
    inc  egb
    ld   a, [hl+]gb
    ld   [de], agb
    retgb

; Input:
;   hl:  Pointer to start of music data
LoadMusicData_1B::
    ld   a, [wD379]gb
    cp   $05gb
    jr   z, .jr_435Egb

    cp   $0Cgb
    jr   z, .jr_435Egb

    cp   $1Agb
    jr   z, .jr_435Egb

    cp   $24gb
    jr   z, .jr_435Egb

    cp   $2Agb
    jr   z, .jr_435Egb

    cp   $2Egb
    jr   z, .jr_435Egb

    cp   $3Fgb
    jr   z, .jr_435Egb

    call StopNoiseChannel_1Bgb

.jr_435E
    call StopSquareAndWaveChannels_1Bgb
    ld   de, wMusicTransposegb
    ld   b, $00gb
    ld   a, [hl+]gb
    ld   [de], agb
    inc  egb
    call Copy2Bytes_1Bgb
    ld   de, wD310gb
    call Copy2Bytes_1Bgb
    ld   de, wD320gb
    call Copy2Bytes_1Bgb
    ld   de, wD330gb
    call Copy2Bytes_1Bgb
    ld   de, wD340gb
    call Copy2Bytes_1Bgb
    ld   hl, wD310gb
    ld   de, wD314gb
    call LoadSoundDefinitionDatagb
    ld   hl, wD320gb
    ld   de, wD320 + 4gb
    call LoadSoundDefinitionDatagb
    ld   hl, wD330gb
    ld   de, wD330 + 4gb
    call LoadSoundDefinitionDatagb
    ld   hl, wD340gb
    ld   de, wD344gb
    call LoadSoundDefinitionDatagb

    ; [D3x2] = 1 for all channels
    ld   bc, $0410gb
    ld   hl, wD312gb
.loop
    ld   [hl], $01gb
    ld   a, cgb
    add  lgb
    ld   l, agb
    dec  bgb
    jr   nz, .loopgb

    xor  agb
    ld   [wD31E], agb
    ld   [wD320 + $0E], agb
    ld   [wD330 + $0E], agb
    retgb

; Input:
;  de:  Pointer to waveform data
soundOpcode9DChannel3Handler_1B::
    push hlgb
    ld   a, egb
    ld   [wD330 + 6], agb
    ld   a, dgb
    ld   [wD330 + 7], agb
    ld   a, [wD371]gb
    and  agb
    jr   nz, .nextOpcodegb

    xor  agb
    ldh  [rNR30], agb
    ld   l, egb
    ld   h, dgb
    call SetWaveform_1Bgb

.nextOpcode
    pop  hlgb
    jr   soundOpcode9D.nextOpcodegb

soundOpcode9D::
    call IncChannelDefinitionPointergb
    call ReadSoundPointerBytegb
    ld   e, agb
    call IncChannelDefinitionPointergb
    call ReadSoundPointerBytegb
    ld   d, agb
    call IncChannelDefinitionPointergb
    call ReadSoundPointerBytegb
    ld   c, agb
    inc  lgb
    inc  lgb
    ld   [hl], e ; D3x6gb
    inc  lgb
    ld   [hl], d ; D3x7gb
    inc  lgb
    ld   [hl], c ; D3x8gb
    dec  lgb
    dec  lgb
    dec  lgb
    dec  lgb
    push hlgb
    ld   hl, wActiveChannelIndexgb
    ld   a, [hl]gb
    pop  hlgb
    cp   $03gb
    jr   z, soundOpcode9DChannel3Handler_1Bgb

.nextOpcode
    call IncChannelDefinitionPointergb
    jp   ParseSoundOpcodegb

; Input:
;   hl:  Pointer to data to increment
IncChannelDefinitionPointer::
    push degb
    ld   a, [hl+]gb
    ld   e, agb
    ld   a, [hl-]gb
    ld   d, agb
    inc  degb

saveSoundPointer:
    ld   a, egb
    ld   [hl+], agb
    ld   a, dgb
    ld   [hl-], agb
    pop  degb
    retgb

IncrementPointerBy2::
    push degb
    ld   a, [hl+]gb
    ld   e, agb
    ld   a, [hl-]gb
    ld   d, agb
    inc  degb
    inc  degb
    jr   saveSoundPointergb

; Input:
;   hl:  Pointer to data
; Output:
;   a:   Byte read
;   b:   Same as a
ReadSoundPointerByte::
    ld   a, [hl+]gb
    ld   c, agb
    ld   a, [hl-]gb
    ld   b, agb
    ld   a, [bc]gb
    ld   b, agb
    retgb

jr_01B_4427:
    pop  hlgb
    jr   UpdateNextMusicChannelAfterHlDecrementgb

label_01B_442A:
    ld   a, [wActiveChannelIndex]gb
    cp   $03gb
    jr   nz, .channel3Donegb

    ld   a, [wD330 + 8]gb
    bit  7, agb
    jr   z, .channel3Donegb

    ld   a, [hl]gb
    cp   $06gb
    jr   nz, .channel3Donegb

    ld   a, $40gb
    ldh  [rNR32], agb
.channel3Done

    push hlgb
    ld   a, lgb
    add  $09gb
    ld   l, agb
    ld   a, [hl] ; D3xBgb
    and  agb
    jr   nz, jr_01B_4427gb

    ld   a, lgb
    add  $04gb
    ld   l, agb
    bit  7, [hl] ; D3xFgb
    jr   nz, jr_01B_4427gb

    pop  hlgb
    call func_01B_46FEgb
    push hlgb
    call func_01B_4787gb
    pop  hlgb

UpdateNextMusicChannelAfterHlDecrement:
    dec  lgb
    dec  lgb
    jp   UpdateNextMusicChannel_1Bgb

soundOpcode00:
    dec  lgb
    dec  lgb
    dec  lgb
    dec  lgb
    call IncrementPointerBy2gb

.readNext
    ld   a, lgb
    add  $04gb
    ld   e, agb
    ld   d, hgb
    call LoadSoundDefinitionDatagb
    cp   $00gb
    jr   z, .val00gb

    cp   $FFgb
    jr   z, .valFFgb

    inc  l ; hl = [D3x2]gb
    jp   ParseSoundOpcodeAfterHlIncrementgb

; Music loops?
.valFF
    dec  l ; hl = D3x0gb
    push hlgb
    call IncrementPointerBy2gb
    call ReadSoundPointerBytegb
    ld   e, agb
    call IncChannelDefinitionPointergb
    call ReadSoundPointerBytegb
    ld   d, agb
    pop  hlgb
    ld   a, egb
    ld   [hl+], a ; D3x0gb
    ld   a, dgb
    ld   [hl-], agb
    jr   .readNextgb

; Item acquired fanfare ends
.val00
    ld   a, [wD3CA]gb
    cp   MUSIC_OBTAIN_SWORDgb
    jp   z, ContinueCurrentScreenMusic_1Bgb

    cp   MUSIC_OBTAIN_ITEMgb
    jp   z, ContinueCurrentScreenMusic_1Bgb

    cp   MUSIC_HEART_CONTAINERgb
    jp   z, ContinueCurrentScreenMusic_1Bgb

    ld   hl, wActiveMusicIndexgb
    ld   [hl], $00gb
    call func_01B_410Fgb
    retgb

soundOpcode9E:
    call IncChannelDefinitionPointergb
    call ReadSoundPointerBytegb
    ld   [wMusicSpeedPointer], agb
    call IncChannelDefinitionPointergb
    call ReadSoundPointerBytegb
    ld   [wMusicSpeedPointer+1], agb
    jr   IncChannelDefinitonPointerAndParseNextgb

soundOpcode9F:
    call IncChannelDefinitionPointergb
    call ReadSoundPointerBytegb
    ld   [wMusicTranspose], agb

IncChannelDefinitonPointerAndParseNext:
    call IncChannelDefinitionPointergb
    jr   ParseSoundOpcodegb

soundOpcode9B:
    call IncChannelDefinitionPointergb
    call ReadSoundPointerBytegb
    push hlgb
    ld   a, lgb
    add  $0Bgb
    ld   l, agb
    ld   c, [hl] ; D3xFgb
    ld   a, bgb
    or   cgb
    ld   [hl], a ; D3xFgb

    ld   b, hgb
    ld   c, lgb
    dec  cgb
    dec  cgb
    pop  hlgb
    ld   a, [hl+] ; D3x4gb
    ld   e, agb
    ld   a, [hl-]gb
    ld   d, agb
    inc  degb

    ld   a, egb
    ld   [hl+], a ; D3x4gb
    ld   a, dgb
    ld   [hl-], agb
    ld   a, dgb
    ld   [bc], a ; D3xDgb
    dec  cgb
    ld   a, egb
    ld   [bc], a ; D3xCgb
    jr   ParseSoundOpcodegb

soundOpcode9C:
    push hlgb
    ld   a, lgb
    add  $0Bgb
    ld   l, agb
    ld   a, [hl] ; D3xFgb
    dec  [hl]gb
    ld   a, [hl]gb
    and  $7Fgb
    jr   z, .doneLoopinggb

    ld   b, hgb
    ld   c, lgb
    dec  cgb
    dec  cgb
    dec  cgb
    pop  hlgb
    ld   a, [bc]  ; D3xCgb
    ld   [hl+], a ; D3x4gb
    inc  cgb
    ld   a, [bc]gb
    ld   [hl-], agb
    jr   ParseSoundOpcodegb

.doneLooping
    pop  hlgb
    jr   IncChannelDefinitonPointerAndParseNextgb

UpdateAllMusicChannels_1B::
    ld   hl, wActiveMusicIndexgb
    ld   a, [hl]gb
    and  agb
    ret  zgb

    ld   a, [wActiveMusicTable]gb
    and  agb
    ret  zgb

    call func_01B_4303gb
    ld   a, $01gb
    ld   [wActiveChannelIndex], agb
    ld   hl, wD310gb

; This will loop through all music channels and update them.
; Input:
;   hl:  D3x0 (x = channel index)
UpdateMusicChannel_1B::
    inc  lgb
    ld   a, [hl+] ; Dx11gb
    and  agb
    jp   z, UpdateNextMusicChannelAfterHlDecrement ;; 1B:4528 $CA $5B $44

    dec  [hl] ; Dx12gb
    jp   nz, label_01B_442Agb

ParseSoundOpcodeAfterHlIncrement:
    inc  lgb
    inc  lgb

; Parse an "opcode" from sound channel definition data?
; Input:
;   hl: D3x4
ParseSoundOpcode:
    call ReadSoundPointerBytegb
    cp   $00gb
    jp   z, soundOpcode00gb

    cp   $9Dgb
    jp   z, soundOpcode9Dgb

    cp   $9Egb
    jp   z, soundOpcode9Egb

    cp   $9Fgb
    jp   z, soundOpcode9Fgb

    cp   $9Bgb
    jp   z, soundOpcode9Bgb

    cp   $9Cgb
    jp   z, soundOpcode9Cgb

    cp   $99gb
    jp   z, soundOpcode99gb

    cp   $9Agb
    jp   z, soundOpcode9Agb

    cp   $94gb
    jp   z, soundOpcode94gb

    cp   $97gb
    jp   z, soundOpcode97gb

    cp   $98gb
    jp   z, soundOpcode98gb

    cp   $96gb
    jp   z, soundOpcode96gb

    cp   $95gb
    jp   z, soundOpcode95gb

    and  $F0gb
    cp   $A0gb
    jr   nz, HandleNotegb

    ; Command $A0-$AF
    ld   a, bgb
    and  $0Fgb
    ld   c, agb
    ld   b, $00gb
    push hlgb
    ld   de, wMusicSpeedPointergb
    ld   a, [de]gb
    ld   l, agb
    inc  egb
    ld   a, [de]gb
    ld   h, agb
    add  hl, bcgb
    ld   a, [hl]gb
    pop  hlgb
    push hlgb
    ld   d, agb
    inc  lgb
    inc  lgb
    inc  lgb
    ld   a, [hl] ; D3x7gb
    and  $F0gb
    jr   nz, .jr_01B_459Agb

    ld   a, dgb
    jr   .jr_01B_45BFgb

.jr_01B_459A
    ld   e, agb
    ld   a, dgb
    push afgb
    srl  agb
    sla  egb
    jr   c, .jr_01B_45ABgb

    ld   d, agb
    srl  agb
    sla  egb
    jr   c, .jr_01B_45ABgb

    add  dgb

.jr_01B_45AB
    ld   c, agb
    and  agb
    jr   nz, .jr_01B_45B1gb

    ld   c, $02gb

.jr_01B_45B1
    ld   de, wActiveChannelIndexgb
    ld   a, [de]gb
    dec  agb
    ld   e, agb
    ld   d, $00gb
    ld   hl, wD307gb
    add  hl, degb
    ld   [hl], cgb
    pop  afgb

.jr_01B_45BF
    pop  hlgb
    dec  lgb
    ld   [hl+], a ; [D3x3]gb
    call IncChannelDefinitionPointergb
    call ReadSoundPointerBytegb

; Input:
;   a:   Note
;   de:  ?
;   hl:  D3x0
HandleNote::
    ld   a, [wActiveChannelIndex]gb
    cp   $04gb
    jr   z, .skippedForChannel4gb

    push degb
    ld   de, wD3B0gb
    call IndexChannelArraygb
    xor  agb
    ld   [de], agb
    inc  egb
    ld   [de], agb
    ld   de, wD3B6gb
    call IndexChannelArraygb
    inc  egb
    xor  agb
    ld   [de], agb
    ld   a, [wActiveChannelIndex]gb
    cp   $03gb
    jr   nz, .doneChannel3Handlergb

    ; Channel 3
    ld   de, wD39Egb
    ld   a, [de]gb
    and  agb
    jr   z, .jr_01B_45F8gb

    ld   a, $01gb
    ld   [de], agb
    xor  agb
    ld   [wD39F], agb

.jr_01B_45F8
    ld   de, wActiveMusicTableIndexgb
    ld   a, [de]gb
    and  agb
    jr   z, .doneChannel3Handlergb

    ld   a, $01gb
    ld   [de], agb
    xor  agb
    ld   [wD3DA], agb

.doneChannel3Handler
    pop  degb

.skippedForChannel4
    ld   c, bgb
    ld   b, $00gb
    call IncChannelDefinitionPointergb

    ld   a, [wActiveChannelIndex]gb
    cp   $04gb
    jp   z, .handleChannel4Notegb

    ; Channel 1-3 only

    push hlgb
    ld   a, lgb
    add  $05gb
    ld   l, agb
    ld   e, lgb
    ld   d, hgb
    inc  lgb
    inc  lgb
    ld   a, cgb
    cp   $01gb
    jr   z, .jr_01B_4644gb

    ld   [hl], $00 ; D3xBgb
    ld   a, [wMusicTranspose]gb
    and  agb
    jr   z, .jr_01B_4637gb

    ld   l, agb
    ld   h, $00gb
    bit  7, lgb
    jr   z, .jr_01B_4634gb

    ld   h, $FFgb

.jr_01B_4634
    add  hl, bcgb
    ld   b, hgb
    ld   c, lgb

.jr_01B_4637
    ld   hl, SquareAndWaveFrequencyTablegb
    add  hl, bcgb
    ld   a, [hl+]gb
    ld   [de], a ; D3x9gb
    inc  egb
    ld   a, [hl]gb
    ld   [de], a ; D3xAgb
    pop  hlgb
    jp   .label_01B_467Agb

.jr_01B_4644
    ld   [hl], $01 ; D3xBgb
    pop  hlgb
    jr   .label_01B_467Agb

    ; Channel 4 only
.handleChannel4Note
    push hlgb
    ld   a, cgb
    cp   $FFgb
    jr   z, .noiseNoteFFgb

    ld   de, wD346gb
    ld   hl, NoiseFrequencyTablegb
    add  hl, bcgb

.jr_01B_4656
    ld   a, [hl+]gb
    ld   [de], agb
    inc  egb
    ld   a, egb
    cp   $4Bgb
    jr   nz, .jr_01B_4656gb

    ld   c, rNR41 & $ffgb
    ld   hl, wD344gb
    ld   b, $00gb
    jr   .jr_01B_46A8gb

.noiseNoteFF
    ld   a, [wD34F]gb
    bit  7, agb
    jp   nz, label_01B_46D9gb

    ld   a, $01gb
    ld   [wActiveNoiseSfx], agb
    call func_01B_4037gb
    jp   label_01B_46D9gb

    ; Channels 1-3 only
.label_01B_467A:
    push hlgb
    ld   b, $00gb
    ld   a, [wActiveChannelIndex]gb
    cp   $01gb
    jr   z, .channel1gb

    cp   $02gb
    jr   z, .channel2gb

    ; Channel 3
    ld   c, rNR30 & $ffgb
    ld   a, [wD330 + $0F]gb
    bit  7, agb
    jr   nz, .jr_01B_4696gb

    xor  agb
    ldh  [c], agb
    ld   a, $80gb
    ldh  [c], agb

.jr_01B_4696
    inc  cgb
    inc  lgb
    inc  lgb
    inc  lgb
    inc  lgb
    ld   a, [hl+]gb
    ld   e, agb
    ld   d, $00gb
    jr   .jr_01B_46AFgb

.channel2:
    ld   c, rNR21 & $ffgb
    jr   .jr_01B_46A8gb

.channel1:
    ld   c, rNR10 & $ffgb
    inc  c ; rNR11gb

.jr_01B_46A8
    inc  lgb
    inc  lgb
    ld   a, [hl+] ; D3x6gb
    ld   e, agb
    inc  lgb
    ld   a, [hl+] ; D3x8gb
    ld   d, agb

.jr_01B_46AF
    push hlgb
    inc  lgb
    inc  lgb
    ld   a, [hl+] ; D3xBgb
    and  agb
    jr   z, .jr_01B_46B8gb

    ld   e, $08gb

.jr_01B_46B8
    inc  lgb
    inc  lgb
    ld   [hl], $00 ; D3xEgb
    inc  lgb
    ld   a, [hl] ; D3xFgb
    pop  hlgb
    bit  7, agb
    jr   nz, label_01B_46D9gb

    ld   a, [wActiveChannelIndex]gb
    cp   $03gb
    jp   z, label_01B_42ABgb

; Input:
;   c:   rNRx1 (set based on which channel it is)
;   b:   Value for NRx1 (or'd with d)
;   d:   Value for NRx1 (or'd with b)
;   e:   Value for NRx2 (volume/envelope)
;   hl:  Pointer to frequency values for NRx3 & NRx4 (forces start with bit 7 on NRx4)
WriteChannelRegisters::
    ld   a, dgb
    or   bgb
    ldh  [c], a ; rNRx1gb
    inc  cgb
    ld   a, egb
    ldh  [c], a ; rNRx2gb
    inc  cgb
    ld   a, [hl+]gb
    ldh  [c], a ; rNRx3gb
    inc  cgb
    ld   a, [hl]gb
    or   $80gb
    ldh  [c], a ; rNRx4gb

label_01B_46D9:
    pop  hlgb
    dec  lgb
    ld   a, [hl-] ; D3x3gb
    ld   [hl-], a ; D3x2gb
    dec  lgb

UpdateNextMusicChannel_1B::
    ld   de, wActiveChannelIndexgb
    ld   a, [de]gb
    cp   $04gb
    jr   z, .lastChannelgb

    ; Update next channel
    inc  agb
    ld   [de], a ; [wActiveChannelIndex]++
    ld   a, $10gb
    add  lgb
    ld   l, a ; hl = D3x0 (next channel)gb
    jp   UpdateMusicChannel_1Bgb

.lastChannel
    ; This was the last channel. Done updating sound for now.
    ld   hl, wD31Egb
    inc  [hl]gb
    ld   hl, wD320 + $0Egb
    inc  [hl]gb
    ld   hl, wD330 + $0Egb
    inc  [hl]gb
    retgb

label_01B_46FC:
    pop  hlgb
    retgb

func_01B_46FE::
    push hlgb
    ld   a, lgb
    add  $06gb
    ld   l, agb
    ld   a, [hl]gb
    and  $0Fgb
    jr   z, jr_01B_4720gb

    ld   [wD351], agb
    ld   a, [wActiveChannelIndex]gb
    ld   c, $13gb
    cp   $01gb
    jr   z, jr_01B_4762gb

    ld   c, $18gb
    cp   $02gb
    jr   z, jr_01B_4762gb

    ld   c, $1Dgb
    cp   $03gb
    jr   z, jr_01B_4762gb

label_01B_4720:
jr_01B_4720:
    ld   a, [wActiveChannelIndex]gb
    cp   $04gb
    jp   z, label_01B_46FCgb

    ld   de, wD3B6gb
    call IndexChannelArraygb
    ld   a, [de]gb
    and  agb
    jp   z, label_01B_4749gb

    ld   a, [wActiveChannelIndex]gb
    ld   c, $13gb
    cp   $01gb
    jp   z, label_01B_485Egb

    ld   c, $18gb
    cp   $02gb
    jp   z, label_01B_485Egb

    ld   c, $1Dgb
    jp   label_01B_485Egb

label_01B_4749:
    ld   a, [wActiveChannelIndex]gb
    cp   $03gb
    jp   nz, label_01B_46FCgb

    ld   a, [wD39E]gb
    and  agb
    jp   nz, label_01B_4810gb

    ld   a, [wActiveMusicTableIndex]gb
    and  agb
    jp   nz, label_01B_4998gb

    jp   label_01B_46FCgb

jr_01B_4762:
    inc  lgb
    ld   a, [hl+]gb
    ld   e, agb
    ld   a, [hl]gb
    and  $0Fgb
    ld   d, agb
    push degb
    ld   a, lgb
    add  $04gb
    ld   l, agb
    ld   b, [hl]gb
    ld   a, [wD351]gb
    cp   $01gb
    jp   z, label_01B_48ABgb

    cp   $05gb
    jp   z, label_01B_4918gb

    ld   hl, $FFFFgb
    pop  degb
    add  hl, degb
    call func_01B_4884gb
    jp   label_01B_4720gb

func_01B_4787::
    ld   a, [wD31B]gb
    and  agb
    jr   nz, .jr_47AEgb

    ld   a, [wD317]gb
    and  agb
    jr   z, .jr_47AEgb

    and  $0Fgb
    ld   b, agb
    ld   hl, wD307gb
    ld   a, [wD31E]gb
    cp   [hl]gb
    jr   nz, .jr_47AEgb

    ld   c, $12gb
    ld   de, wD31Agb
    ld   a, [wD31F]gb
    bit  7, agb
    jr   nz, .jr_47AEgb

    call func_01B_47D2gb

.jr_47AE
    ld   a, [wD320 + $0B]gb
    and  agb
    ret  nzgb

    ld   a, [wD320 + $07]gb
    and  agb
    ret  zgb

    and  $0Fgb
    ld   b, agb
    ld   hl, wD308gb
    ld   a, [wD320 + $0E]gb
    cp   [hl]gb
    ret  nzgb

    ld   a, [wD320 + $0F]gb
    bit  7, agb
    ret  nzgb

    ld   c, $17gb
    ld   de, wD320 + $0Agb
    call func_01B_47D2gb
    retgb

func_01B_47D2::
    push bcgb
    dec  bgb
    ld   c, bgb
    ld   b, $00gb
    ld   hl, HardcodedData_1b_4b13gb
    add  hl, bcgb
    ld   a, [hl]gb
    pop  bcgb
    ldh  [c], a ; NRx2gb
    inc  cgb
    inc  cgb
    ld   a, [de]gb
    or   $80gb
    ldh  [c], agb
    retgb

; Continues playing the music after a fanfare has played when you find your sword/weapon/heart container.
; Above is wrong, seems to set all tracks to MUSIC_NONE?
ContinueCurrentScreenMusic_1B:
    xor  agb
    ld   [wActiveMusicTable], agb
    ldh  a, [hNextDefaultMusicTrack]gb
    ld   [wMusicTrackToPlay], agb
    jp   PlayMusicTrack_1B_EntryPointgb

soundOpcode96:
    ld   a, $01gb

.setD3CDAndParseNext:
    ld   [wD3CD], agb
    call IncChannelDefinitionPointergb
    jp   ParseSoundOpcodegb

soundOpcode95:
    xor  agb
    jr   soundOpcode96.setD3CDAndParseNextgb

soundOpcode99:
    ld   a, $01gb

.setD39EAndParseNext
    ld   [wD39E], agb
    call IncChannelDefinitionPointergb
    jp   ParseSoundOpcodegb

soundOpcode9A:
    xor  agb
    ld   [wD39E], agb
    jr   soundOpcode99.setD39EAndParseNextgb

label_01B_4810:
    cp   $02gb
    jp   z, label_01B_46FCgb

    ld   bc, wD39Fgb
    call func_01B_4842gb
    ld   c, $1Cgb
    ld   b, $40gb
    cp   $03gb
    jr   z, jr_01B_483Dgb

    ld   b, $60gb
    cp   $05gb
    jr   z, jr_01B_483Dgb

    cp   $0Agb
    jr   z, jr_01B_483Dgb

    ld   b, $00gb
    cp   $07gb
    jr   z, jr_01B_483Dgb

    cp   $0Dgb
    jp   nz, label_01B_46FCgb

    ld   a, $02gb
    ld   [wD39E], agb

label_01B_483D:
jr_01B_483D:
    ld   a, bgb
    ldh  [c], agb
    jp   label_01B_46FCgb

func_01B_4842::
    ld   a, [bc]gb
    inc  agb
    ld   [bc], agb
    retgb

soundOpcode97:
    ld   de, wD3B6gb
    call IndexChannelArraygb
    ld   a, $01gb

.setDeAndParseNext:
    ld   [de], agb
    call IncChannelDefinitionPointergb
    jp   ParseSoundOpcodegb

soundOpcode98:
    ld   de, wD3B6gb
    call IndexChannelArraygb
    xor  agb
    jr   soundOpcode97.setDeAndParseNextgb

label_01B_485E:
    inc  egb
    ld   a, [de]gb
    and  agb
    jr   nz, jr_01B_4874gb

    inc  agb
    ld   [de], agb
    pop  hlgb
    push hlgb
    call func_01B_4879gb

jr_01B_486A:
    ld   hl, hLinkPhysicsModifiergb
    add  hl, degb
    call func_01B_4884gb
    jp   label_01B_46FCgb

jr_01B_4874:
    call func_01B_489Egb
    jr   jr_01B_486Agb

func_01B_4879::
    ld   a, $07gb
    add  lgb
    ld   l, agb
    ld   a, [hl+]gb
    ld   e, agb
    ld   a, [hl]gb
    and  $0Fgb
    ld   d, agb
    retgb

func_01B_4884::
    ld   de, wD3A4gb
    call IndexChannelArraygb
    ld   a, lgb
    ldh  [c], agb
    ld   [de], agb
    inc  cgb
    inc  egb
    ld   a, hgb
    and  $0Fgb
    ldh  [c], agb
    ld   [de], agb
    retgb

; Input:
;   de:  Points to an array of words (2 bytes) with an entry for each channel
; Output:
;   de:  Pointer to array entry for active channel
IndexChannelArray::
    ld   a, [wActiveChannelIndex]gb
    dec  agb
    sla  agb
    add  egb
    ld   e, agb
    retgb

func_01B_489E::
    ld   de, wD3A4gb
    call IndexChannelArraygb
    ld   a, [de]gb
    ld   l, agb
    inc  egb
    ld   a, [de]gb
    ld   d, agb
    ld   e, lgb
    retgb

label_01B_48AB:
    pop  degb
    ld   de, wD3B0gb
    call IndexChannelArraygb
    ld   a, [de]gb
    inc  agb
    ld   [de], agb
    inc  egb
    cp   $19gb
    jr   z, jr_01B_48EBgb

    cp   $2Dgb
    jr   z, jr_01B_48E4gb

    ld   a, [de]gb
    and  agb
    jp   z, label_01B_4720gb

jr_01B_48C3:
    dec  egb
    ld   a, [de]gb
    sub  $19gb
    sla  agb
    ld   l, agb
    ld   h, $00gb
    ld   de, Data_01B_48F0gb
    add  hl, degb
    ld   a, [hl+]gb
    ld   d, agb
    ld   a, [hl]gb
    ld   e, agb
    pop  hlgb
    push hlgb
    push degb
    call func_01B_4879gb
    ld   h, dgb
    ld   l, egb
    pop  degb
    add  hl, degb
    call func_01B_4884gb
    jp   label_01B_4720gb

jr_01B_48E4:
    dec  egb
    ld   a, $19gb
    ld   [de], agb
    inc  egb
    jr   jr_01B_48C3gb

jr_01B_48EB:
    ld   a, $01gb
    ld   [de], agb
    jr   jr_01B_48C3gb

Data_01B_48F0::
    db   $00, $00, $00, $00, $00, $01, $00, $01gb
    db   $00, $02, $00, $02, $00, $00, $00, $00gb
    db   $FF, $FF, $FF, $FF, $FF, $FE, $FF, $FEgb
    db   $00, $00, $00, $01, $00, $02, $00, $01gb
    db   $00, $00, $FF, $FF, $FF, $FE, $FF, $FFgb

label_01B_4918:
    pop  degb
    ld   de, wD3D0gb
    call IndexChannelArraygb
    ld   a, [de]gb
    inc  agb
    ld   [de], agb
    inc  egb
    cp   $21gb
    jr   z, jr_01B_4946gb

jr_01B_4927:
    dec  egb
    ld   a, [de]gb
    sla  agb
    ld   l, agb
    ld   h, $00gb
    ld   de, Data_01B_494Dgb
    add  hl, degb
    ld   a, [hl+]gb
    ld   d, agb
    ld   a, [hl]gb
    ld   e, agb
    pop  hlgb
    push hlgb
    push degb
    call func_01B_4879gb
    ld   h, dgb
    ld   l, egb
    pop  degb
    add  hl, degb
    call func_01B_4884gb
    jp   label_01B_4720gb

jr_01B_4946:
    dec  egb
    ld   a, $01gb
    ld   [de], agb
    inc  egb
    jr   jr_01B_4927gb

Data_01B_494D::
    db   $00, $08, $00, $00, $FF, $F8, $00, $00gb
    db   $00, $0A, $00, $02, $FF, $FA, $00, $02gb
    db   $00, $0C, $00, $04, $FF, $FC, $00, $04gb
    db   $00, $0A, $00, $02, $FF, $FA, $00, $02gb
    db   $00, $08, $00, $00, $FF, $F8, $00, $00gb
    db   $00, $06, $FF, $FE, $FF, $F6, $FF, $FEgb
    db   $00, $04, $FF, $FC, $FF, $F4, $FF, $FCgb
    db   $00, $06, $FF, $FE, $FF, $F6, $FF, $FEgb

soundOpcode94:
    ld   a, $01gb
    ld   [wActiveMusicTableIndex], agb
    call IncChannelDefinitionPointergb
    jp   ParseSoundOpcodegb

label_01B_4998:
    cp   $02gb
    jp   z, label_01B_46FCgb

    ld   bc, wD3DAgb
    call func_01B_4842gb
    ld   c, $1Cgb
    ld   b, $60gb
    cp   $03gb
    jp   z, label_01B_483Dgb

    ld   b, $40gb
    cp   $05gb
    jp   z, label_01B_483Dgb

    ld   b, $20gb
    cp   $06gb
    jp   nz, label_01B_46FCgb

    ld   a, $02gb
    ld   [wActiveMusicTableIndex], agb
    jp   label_01B_483Dgb


SquareAndWaveFrequencyTable::
    dw   $0F00, $002C, $009C, $0106
    dw   $016B, $01C9, $0223, $0277
    dw   $02C6, $0312, $0356, $039B
    dw   $03DA, $0416, $044E, $0483
    dw   $04B5, $04E5, $0511, $053B
    dw   $0563, $0589, $05AC, $05CE
    dw   $05ED, $060A, $0627, $0642
    dw   $065B, $0672, $0689, $069E
    dw   $06B2, $06C4, $06D6, $06E7
    dw   $06F7, $0706, $0714, $0721
    dw   $072D, $0739, $0744, $074F
    dw   $0759, $0762, $076B, $0774
    dw   $077B, $0783, $078A, $0790
    dw   $0797, $079D, $07A2, $07A7
    dw   $07AC, $07B1, $07B6, $07BA
    dw   $07BE, $07C1, $07C5, $07C8
    dw   $07CB, $07CE, $07D1, $07D4
    dw   $07D6, $07D9, $07DB, $07DD
    dw   $07DF

NoiseFrequencyTable::
    db   $00
    db   $00, $00, $00, $00, $C0
    db   $09, $00, $38, $34, $C0
    db   $19, $00, $38, $33, $C0
    db   $46, $00, $13, $10, $C0
    db   $23, $00, $20, $40, $80
    db   $51, $00, $20, $07, $80
    db   $A1, $00, $00, $18, $80
    db   $F2, $00, $00, $18, $80
    db   $81, $00, $3A, $10, $C0
    db   $80, $00, $00, $10, $C0
    db   $57, $00, $00, $60, $80
    db   $01, $02, $04, $08, $10
    db   $20, $06, $0C, $18, $01
    db   $01, $01, $01, $01, $30
    db   $01, $03, $06, $0C, $18
    db   $30, $09, $12, $24, $02
    db   $04, $08, $01, $01, $48


include "data/music/music_tracks_data_1b_1.asm"


label_01B_4E2C:
    xor  agb
    ld   [wD379], agb
    ld   [wD34F], agb
    ld   [wD398], agb
    ld   [wD393], agb
    ld   [wD3C9], agb
    ld   [wD3A3], agb
    ld   [wD3E2+3], agb
    ld   a, $08gb
    ldh  [rNR42], agb
    ld   a, $80gb
    ldh  [rNR44], agb

label_01B_4E4A:
    ld   a, $FFgb
    ldh  [rNR51], agb
    ld   a, $03gb
    ld   [wD355], agb
    xor  agb
    ld   [wActiveMusicIndex], agb

StopSquareAndWaveChannels_1B::
    xor  agb
    ld   [wD361], agb
    ld   [wD371], agb
    ld   [wD31F], agb
    ld   [wD320 + $0F], agb
    ld   [wD330 + $0F], agb
    ld   [wD39E], agb
    ld   [wD39F], agb
    ld   [wActiveMusicTableIndex], agb
    ld   [wD3DA], agb
    ld   [wD3B6], agb
    ld   [wD3B6+1], agb
    ld   [wD3B6+2], agb
    ld   [wD3B6+3], agb
    ld   [wD3B6+4], agb
    ld   [wD3B6+5], agb
    ld   [wD394], agb
    ld   [wD394+1], agb
    ld   [wD396], agb
    ld   [wD390], agb
    ld   [wD390+1], agb
    ld   [wD392], agb
    ld   [wD3C6], agb
    ld   [wD3C7], agb
    ld   [wD3C8], agb
    ld   [wD3A0], agb
    ld   [wD3A1], agb
    ld   [wD3A2], agb
    ld   [wD3CD], agb
    ld   [wD3D6], agb
    ld   [wD3D7], agb
    ld   [wD3D7+1], agb
    ld   [wD3DC], agb
    ld   [wD3E7], agb
    ld   [wD3E2], agb
    ld   [wD3E2+1], agb
    ld   [wD3E2+2], agb
    ld   a, $08gb
    ldh  [rNR12], agb
    ldh  [rNR22], agb
    ld   a, $80gb
    ldh  [rNR14], agb
    ldh  [rNR24], agb
    xor  agb
    ldh  [rNR10], agb
    ldh  [rNR30], agb
    retgb
