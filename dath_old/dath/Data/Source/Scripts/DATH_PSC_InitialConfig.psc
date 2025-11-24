Scriptname DATH_PSC_InitialConfig extends Quest  

 

; -------------------------------
; Properties de leitura (Races)
; -------------------------------
Race Property OrcRace Auto
Race Property HighElfRace Auto
Race Property NordRace Auto
Race Property DarkElfRace Auto
Race Property RedguardRace Auto
Race Property KhajiitRace Auto
Race Property WoodElfRace Auto

Perk Property DATH_BasicSmithing Auto

Event OnInit()

    RegisterForSingleUpdate(10.0)
EndEvent

Event OnUpdate()

    Actor PlayerRef = Game.GetPlayer()

    if !PlayerRef 
        RegisterForSingleUpdate(10.0)
    endif

    Config_RaceStats(PlayerRef)

    Debug.Notification("Status de Raças atualizados em OnUpdade")
EndEvent


Function Config_RaceStats(Actor PlayerRef)

; -------------------------------
; Stats por raça (proporcionais e equilibrados)
; -------------------------------
    Int  HP_Orc  = 150
    Int  MP_Orc  = 60
    Int  ST_Orc  = 120

    Int  HP_HighElf  = 100
    Int  MP_HighElf  = 150
    Int  ST_HighElf  = 90

    Int  HP_Nord  = 130
    Int  MP_Nord  = 80
    Int  ST_Nord  = 110

    Int  HP_Dunmer  = 120
    Int  MP_Dunmer  = 100
    Int  ST_Dunmer  = 110

    Int  HP_Redguard  = 120
    Int  MP_Redguard  = 80
    Int  ST_Redguard  = 120

    Int  HP_Khajiit  = 110
    Int  MP_Khajiit  = 90
    Int  ST_Khajiit  = 110

    Int  HP_Bosmer  = 110
    Int  MP_Bosmer  = 100
    Int  ST_Bosmer  = 100

   Race r = PlayerRef.GetRace()

    If r == OrcRace
        PlayerRef.SetActorValue("Health", HP_Orc)
        PlayerRef.SetActorValue("Magicka", MP_Orc)
        PlayerRef.SetActorValue("Stamina", ST_Orc)
    ElseIf r == HighElfRace
        PlayerRef.SetActorValue("Health", HP_HighElf)
        PlayerRef.SetActorValue("Magicka", MP_HighElf)
        PlayerRef.SetActorValue("Stamina", ST_HighElf)
    ElseIf r == NordRace
        PlayerRef.SetActorValue("Health", HP_Nord)
        PlayerRef.SetActorValue("Magicka", MP_Nord)
        PlayerRef.SetActorValue("Stamina", ST_Nord)
    ElseIf r == DarkElfRace
        PlayerRef.SetActorValue("Health", HP_Dunmer)
        PlayerRef.SetActorValue("Magicka", MP_Dunmer)
        PlayerRef.SetActorValue("Stamina", ST_Dunmer)
    ElseIf r == RedguardRace
        PlayerRef.SetActorValue("Health", HP_Redguard)
        PlayerRef.SetActorValue("Magicka", MP_Redguard)
        PlayerRef.SetActorValue("Stamina", ST_Redguard)
    ElseIf r == KhajiitRace
        Debug.Notification("Sou um kajit")
        PlayerRef.SetActorValue("Health", HP_Khajiit)
        PlayerRef.SetActorValue("Magicka", MP_Khajiit)
        PlayerRef.SetActorValue("Stamina", ST_Khajiit)

        ; +10% de velocidade
        PlayerRef.SetActorValue("SpeedMult", 110)

    ElseIf r == WoodElfRace
        PlayerRef.SetActorValue("Health", HP_Bosmer)
        PlayerRef.SetActorValue("Magicka", MP_Bosmer)
        PlayerRef.SetActorValue("Stamina", ST_Bosmer)
    EndIf

EndFunction

Function Config_ModifyTempererHealth(Actor PlayerRef)

    ;normaliza ModifyTemperHealth
    if !PlayerRef.HasPerk(DATH_BasicSmithing)
        PlayerRef.AddPerk(DATH_BasicSmithing)
    endif
EndFunction