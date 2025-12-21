Scriptname LATH_MGE_Alteration_Magicka extends activemagiceffect  

Float Property MagickaBonus Auto

Float applied_magicka_bonus= 0.0


Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == none 
        return
    endif

    Float baseline_magicka = akTarget.GetBaseActorValue("Magicka")


    applied_magicka_bonus = MagickaBonus 

   

    ; Aplica os bônus
    akTarget.ModActorValue("Magicka", applied_magicka_bonus)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ; Remove o bônus ao finalizar o efeito
    akTarget.ModActorValue("Magicka", -applied_magicka_bonus)


    applied_magicka_bonus = 0.0

EndEvent