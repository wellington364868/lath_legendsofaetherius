Scriptname LATH_ROS_Config extends Quest  


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


;---------------------------------
;POWERS AND ABILITIES TO REMOVE
;---------------------------------

;ARGONIAN
spell Property RaceArgonianResistPoison Auto
spell Property RaceArgonianResistDisease Auto



;Breton
spell Property AbRaceBreton Auto
spell Property ConjureFamiliar Auto

;DarkElf - Dunmer
Spell Property AbRaceDarkElf Auto
spell Property Sparks Auto

;HighElf - Altmer
Spell Property AbHighElfMagicka Auto
spell Property Fury Auto

;WoodElf - Bosmer
Spell Property AbWoodElf Auto

;IMPERIAL
spell Property AbRaceImperial Auto


;NORD
Spell Property PowerNordBattleCry Auto
spell Property AbRaceNord Auto

;ORC
;NÃO TEM

Event OnInit() 

    RegisterForSingleUpdate(5.0)
EndEvent


Event OnUpdate()

    Actor PlayerRef = Game.GetPlayer()

    if !PlayerRef 
        RegisterForSingleUpdate(5.0)
        return
    endif

    Config_Argonian_Abilities(PlayerRef)
    Config_DarkElf_Abilities(PlayerRef)
    Config_HighElf_Abilities(PlayerRef)
    Config_WoodElf_Abilities(PlayerRef)
    Config_Breton_Abilities(PlayerRef)
    Config_Imperial_Abilities(PlayerRef)
    Config_Nord_Abilities(PlayerRef)
    

    Debug.Notification("Races configured")

EndEvent


Function Config_Argonian_Abilities(Actor PlayerRef)

    if PlayerRef.HasSpell(RaceArgonianResistDisease)
        PlayerRef.removeSpell(RaceArgonianResistDisease)
    
    endif 

    if PlayerRef.HasSpell(RaceArgonianResistPoison)
        PlayerRef.removeSpell(RaceArgonianResistPoison)
    
    endif 
EndFunction

Function Config_DarkElf_Abilities(Actor PlayerRef)

    if PlayerRef.HasSpell(AbRaceDarkElf)
        PlayerRef.removeSpell(AbRaceDarkElf)
    
    endif 

    if PlayerRef.HasSpell(Sparks)
        PlayerRef.removeSpell(Sparks)
    endif 
EndFunction

Function Config_HighElf_Abilities(Actor PlayerRef)

    if PlayerRef.HasSpell(AbHighElfMagicka)
        PlayerRef.removeSpell(AbHighElfMagicka)
    
    endif 

    if PlayerRef.HasSpell(Fury)
        PlayerRef.removeSpell(Fury)
    endif 
EndFunction

Function Config_WoodElf_Abilities(Actor PlayerRef)

    if PlayerRef.HasSpell(AbWoodElf)
        PlayerRef.removeSpell(AbWoodElf)
    
    endif 

EndFunction

Function Config_Breton_Abilities(Actor PlayerRef)

    if PlayerRef.HasSpell(AbRaceBreton)
        PlayerRef.removeSpell(AbRaceBreton)
    endif 

    if PlayerRef.HasSpell(ConjureFamiliar)
        PlayerRef.removeSpell(ConjureFamiliar)
    endif 
EndFunction

Function Config_Imperial_Abilities(Actor PlayerRef)

    if PlayerRef.getRace() == ImperialRace
        ;imperials começam com 4 perk points
        Game.AddPerkPoints(4)
    endif

    if PlayerRef.HasSpell(AbRaceImperial)
        PlayerRef.removeSpell(AbRaceImperial)
    endif 
EndFunction

Function Config_Nord_Abilities(Actor PlayerRef)

    if PlayerRef.HasSpell(AbRaceNord)
        PlayerRef.removeSpell(AbRaceNord)
    endif 
EndFunction

