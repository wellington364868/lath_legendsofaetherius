Scriptname LATH_SSS_ApprenticeStone extends activemagiceffect  

Float appliedFlatMP = 0.0
Float appliedPercentMP = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return
    endif

    ;------------------------------
    ; MAGICKA
    ;------------------------------
    Float PercentAmount = 0.10 ; +10% da base
    Float baselineMP = akTarget.GetBaseActorValue("Magicka")

    ; Flat aplicado: 50 + 1.0 por nível
    appliedFlatMP = 50.0 + (akTarget.GetLevel() * 1.0)

    ; Percentual aplicado apenas sobre o baseline
    appliedPercentMP = baselineMP * PercentAmount

    ; Aplicar valores
    akTarget.ModActorValue("Magicka", appliedFlatMP)
    akTarget.ModActorValue("Magicka", appliedPercentMP)

    Debug.Notification("Apprentice Stone Blessing: +" + Math.Floor(appliedFlatMP) + " Magicka flat per level.")
    Debug.Notification("Apprentice Stone Blessing: +" + Math.Floor(appliedPercentMP)  + " Magicka from base attributes.")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado
    akTarget.ModActorValue("Magicka", -appliedPercentMP)
    akTarget.ModActorValue("Magicka", -appliedFlatMP)

    appliedFlatMP = 0.0
    appliedPercentMP = 0.0

EndEvent