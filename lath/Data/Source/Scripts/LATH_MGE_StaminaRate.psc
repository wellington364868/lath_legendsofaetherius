Scriptname LATH_MGE_StaminaRate extends activemagiceffect  

Float Property StaminaRegenBonus Auto

Float applied_stamina_regen_percent = 0.0


Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == none 
        return
    endif

    Float baselineStaminaRegen = akTarget.GetBaseActorValue("StaminaRate")


    applied_stamina_regen_percent = baselineStaminaRegen * StaminaRegenBonus 

   

    ; Aplica os bônus
    akTarget.ModActorValue("StaminaRate", applied_stamina_regen_percent)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ; Remove o bônus ao finalizar o efeito
    akTarget.ModActorValue("StaminaRate", -applied_stamina_regen_percent)


    applied_stamina_regen_percent = 0.0

EndEvent