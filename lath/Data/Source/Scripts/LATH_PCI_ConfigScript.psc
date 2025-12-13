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

Perk Property LATH_BasicSmithing Auto

Spell Property PlayerMonitorAbility Auto
Spell Property AttackMonitorAbility Auto

Event OnInit() 

    RegisterForSingleUpdate(10.0)
EndEvent


Event OnUpdate()

    Actor PlayerRef = Game.GetPlayer()

    if !PlayerRef 
        RegisterForSingleUpdate(10.0)
        return
    endif

    Config_PlayerMonitor(PlayerRef)
    Config_Smithing(PlayerRef)
    Config_AttackMonitor(PlayerRef)
    
EndEvent


Function Config_PlayerMonitor(Actor PlayerRef)
    PlayerRef.AddSpell(PlayerMonitorAbility, false)
endFunction

Function Config_AttackMonitor(Actor PlayerRef)

    if !PlayerRef.HasSpell(AttackMonitorAbility)
        PlayerRef.AddSpell(AttackMonitorAbility, false)
    endif
endFunction


Function Config_Smithing(Actor PlayerRef)
    if !PlayerRef.HasPerk(LATH_BasicSmithing)
        PlayerRef.AddPerk(LATH_BasicSmithing)
    endif

    if PlayerRef.HasPerk(LATH_BasicSmithing)
        Debug.Notification("Basic Smithing")
    endif
EndFunction