Scriptname LATH_PCI_ConfigScript extends Quest  


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

    PlayerRef.AddSpell(PlayerMonitorAbility, false)
EndEvent