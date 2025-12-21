Scriptname LATH_MGE_Alteration_MagickaRate extends activemagiceffect  

Float Property MagickaRegenPercent Auto

Float applied_magicka_regen_percent = 0.0


Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == none 
        return
    endif

    Float baselineMagickaRegen = akTarget.GetBaseActorValue("MagickaRate")


    applied_magicka_regen_percent = (baselineMagickaRegen * MagickaRegenPercent ) /10.0

   

    ; Aplica os bônus
    akTarget.ModActorValue("MagickaRate", applied_magicka_regen_percent)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ; Remove o bônus ao finalizar o efeito
    akTarget.ModActorValue("MagickaRate", -applied_magicka_regen_percent)


    applied_magicka_regen_percent = 0.0

EndEvent