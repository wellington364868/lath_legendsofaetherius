Scriptname LATH_PCI_ConfigScript extends Quest  


; -------------------------------
; Properties de leitura (Races)
; -------------------------------
Race Property OrcRace Auto
Race Property HighElfRace Auto
Race Property DarkElfRace Auto
Race Property WoodElfRace Auto
Race Property NordRace Auto
Race Property ImperialRace Auto
Race Property BretonRace Auto
Race Property RedguardRace Auto
Race Property KhajiitRace Auto
Race Property ArgonianRace Auto

Perk Property DATH_BasicSmithing Auto

Spell Property PlayerMonitorAbility Auto

Event OnInit() 

    RegisterForSingleUpdate(10.0)
EndEvent


Event OnUpdate()

    Actor PlayerRef = Game.GetPlayer()

    if !PlayerRef 
        RegisterForSingleUpdate(10.0)
        return
    endif

    Config_RaceStats(PlayerRef)

    PlayerRef.AddSpell(PlayerMonitorAbility, false)
EndEvent


Function Config_RaceStats(Actor PlayerRef)

; -------------------------------
; Stats por raça (proporcionais e equilibrados)
; -------------------------------
    Int  HP_Orc  = 110
    Int  MP_Orc  = 100
    Int  ST_Orc  = 140

    Int  HP_Nord  = 120
    Int  MP_Nord  = 100
    Int  ST_Nord  = 130

    Int  HP_Imperial  = 150
    Int  MP_Imperial  = 100
    Int  ST_Imperial  = 100

    Int  HP_Breton  = 120
    Int  MP_Breton  = 130
    Int  ST_Breton  = 100

    Int  HP_Redguard  = 100
    Int  MP_Redguard  = 100
    Int  ST_Redguard  = 150

    Int  HP_HighElf  = 100
    Int  MP_HighElf  = 150
    Int  ST_HighElf  = 100

    Int  HP_DarkElf  = 110
    Int  MP_DarkElf  = 130
    Int  ST_DarkElf  = 110

    Int  HP_WoodElf  = 110
    Int  MP_WoodElf  = 110
    Int  ST_WoodElf  = 130

    Int  HP_Khajiit  = 110
    Int  MP_Khajiit  = 100
    Int  ST_Khajiit  = 110
    Int Speed_Khajiit = 110

    Int  HP_Argonian  = 130
    Int  MP_Argonian  = 110
    Int  ST_Argonian  = 110

   Race player_race = PlayerRef.GetRace()

   Float delta_HP = 0
   Float delta_MP = 0
   Float delta_Stamina = 0

    If player_race == OrcRace

        delta_HP = HP_Orc - PlayerRef.GetActorValue("Health")
        delta_MP = MP_Orc - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_Orc - PlayerRef.GetActorValue("Stamina")

        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)
    
    ElseIf player_race == NordRace
        delta_HP = HP_Nord - PlayerRef.GetActorValue("Health")
        delta_MP = MP_Nord - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_Nord - PlayerRef.GetActorValue("Stamina")

        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)    

    ElseIf player_race == ImperialRace
        delta_HP = HP_Imperial - PlayerRef.GetActorValue("Health")
        delta_MP = MP_Imperial - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_Imperial - PlayerRef.GetActorValue("Stamina")

        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)  
    ElseIf player_race == BretonRace
        delta_HP = HP_Breton - PlayerRef.GetActorValue("Health")
        delta_MP = MP_Breton - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_Breton - PlayerRef.GetActorValue("Stamina")

        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)  

    ElseIf player_race == RedguardRace
        delta_HP = HP_Redguard - PlayerRef.GetActorValue("Health")
        delta_MP = MP_Redguard - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_Redguard - PlayerRef.GetActorValue("Stamina")

        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)  


    ElseIf player_race == HighElfRace
        delta_HP = HP_HighElf - PlayerRef.GetActorValue("Health")
        delta_MP = MP_HighElf - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_HighElf - PlayerRef.GetActorValue("Stamina")

        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)

    ElseIf player_race == DarkElfRace
        delta_HP = HP_DarkElf - PlayerRef.GetActorValue("Health")
        delta_MP = MP_DarkElf - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_DarkElf - PlayerRef.GetActorValue("Stamina")

        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)  

    ElseIf player_race == WoodElfRace
        delta_HP = HP_WoodElf - PlayerRef.GetActorValue("Health")
        delta_MP = MP_WoodElf - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_WoodElf - PlayerRef.GetActorValue("Stamina")

        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)  

    ElseIf player_race == KhajiitRace
        delta_HP = HP_Khajiit - PlayerRef.GetActorValue("Health")
        delta_MP = MP_Khajiit - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_Khajiit - PlayerRef.GetActorValue("Stamina")
        Float delta_speed = Speed_Khajiit - PlayerRef.GetActorValue("SpeedMult")
        
        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)  

        ; +10% de velocidade
        PlayerRef.ModActorValue("SpeedMult", delta_speed)

    ElseIf player_race == ArgonianRace
        delta_HP = HP_Argonian - PlayerRef.GetActorValue("Health")
        delta_MP = MP_Argonian - PlayerRef.GetActorValue("Magicka")
        delta_Stamina = ST_Argonian - PlayerRef.GetActorValue("Stamina")

        PlayerRef.ModActorValue("Health", delta_HP)
        PlayerRef.ModActorValue("Magicka", delta_MP)
        PlayerRef.ModActorValue("Stamina", delta_Stamina)  

    EndIf

EndFunction