Scriptname LATH_MGE_Alteration_Stamina extends activemagiceffect  

Float Property StaminaBonus Auto

Float applied_stamina_bonus= 0.0


Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == none 
        return
    endif

    Float baseline_stamina = akTarget.GetBaseActorValue("Stamina")


    applied_stamina_bonus = StaminaBonus 

   

    ; Aplica os bônus
    akTarget.ModActorValue("Stamina", applied_stamina_bonus)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ; Remove o bônus ao finalizar o efeito
    akTarget.ModActorValue("Stamina", -applied_stamina_bonus)


    applied_stamina_bonus = 0.0

EndEvent