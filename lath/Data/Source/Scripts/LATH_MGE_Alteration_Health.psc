Scriptname LATH_MGE_Alteration_Health extends activemagiceffect  

Float Property HealthBonus Auto

Float applied_health_bonus= 0.0


Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == none 
        return
    endif

    Float baseline_health = akTarget.GetBaseActorValue("Health")


    applied_health_bonus = HealthBonus 

   

    ; Aplica os bônus
    akTarget.ModActorValue("Health", applied_health_bonus)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ; Remove o bônus ao finalizar o efeito
    akTarget.ModActorValue("Health", -applied_health_bonus)


    applied_health_bonus = 0.0

EndEvent