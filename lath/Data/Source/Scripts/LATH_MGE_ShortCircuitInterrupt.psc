Scriptname LATH_MGE_ShortCircuitInterrupt extends activemagiceffect  


Event OnEffectStart(Actor akTarget, Actor akCaster)

; Intensidade do "espasmo" (ajuste fino)
Float  InterruptDuration = 0.25 
Float  StaggerPower = 0.15 

    if akTarget == None || akTarget == akCaster
        return
    endif

    ; 1) Mini-stagger instantâneo ? isso interrompe ataque/cast
    akTarget.PushActorAway(akTarget, StaggerPower)

    ; 2) Micro "curto-circuito" — cai e volta o SpeedMult
    ;    força o alvo a recomeçar animação sem causar slow real
    akTarget.ModActorValue("SpeedMult", -100)
    Utility.Wait(InterruptDuration)
    akTarget.ModActorValue("SpeedMult", 100)
EndEvent