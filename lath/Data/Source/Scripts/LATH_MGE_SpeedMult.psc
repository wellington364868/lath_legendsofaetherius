Scriptname LATH_MGE_SpeedMult extends activemagiceffect  


Float Property SpeedMultBonus Auto ;10 = 10%

Float applied_speed_mult = 0.0


Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == none 
        return
    endif

    Float baselineStaminaRegen = akTarget.GetBaseActorValue("SpeedMult")


    applied_speed_mult = SpeedMultBonus

   

    ; Aplica os bônus
    akTarget.ModActorValue("SpeedMult", applied_speed_mult)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ; Remove o bônus ao finalizar o efeito
    akTarget.ModActorValue("SpeedMult", -applied_speed_mult)


    applied_speed_mult = 0.0

EndEvent