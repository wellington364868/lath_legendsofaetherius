Scriptname LATH_SSS_ThiefStone extends activemagiceffect  


Float appliedFlatHP = 0.0
Float appliedPercentHP = 0.0

Float appliedFlatMP = 0.0
Float appliedPercentMP = 0.0

Float appliedFlatStamina = 0.0
Float appliedPercentStamina = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return 
    endif

    Float PercentAmount = 0.15 ;+15%
    ; Baseline antes de qualquer mod
    Float baselineHP = akTarget.GetBaseActorValue("Health")
    Float baselineMP = akTarget.GetBaseActorValue("Magicka")
    Float baselineStamina = akTarget.GetBaseActorValue("Stamina")

    ; Calcular quanto será aplicado
    appliedFlatHP = Math.Ceiling( akTarget.GetLevel() * 0.5 )
    appliedPercentHP = baselineHP * PercentAmount

    appliedFlatMP = akTarget.GetLevel() * 0.5
    appliedPercentMP = baselineMP * PercentAmount

    appliedFlatStamina =  akTarget.GetLevel() * 0.5
    appliedPercentStamina = baselineStamina * PercentAmount

    ; Aplicar flat
    akTarget.ModActorValue("Health", appliedFlatHP)
        akTarget.ModActorValue("Magicka", appliedFlatMP)
    akTarget.ModActorValue("Stamina", appliedFlatStamina)

    ; Aplicar percentual (calculado no baseline)
    akTarget.ModActorValue("Health", appliedPercentHP)
    akTarget.ModActorValue("Magicka", appliedPercentMP)
    akTarget.ModActorValue("Stamina", appliedPercentStamina)

    ; Notificações legíveis
    ;Debug.Notification("Thief Stone Blessing: +" + Math.Floor(appliedFlatHP) + " HP and +" + Math.Floor(appliedFlatMP) + " MP and +" Math.Floor(appliedFlatStamina) + " Stamina by your level.")
    Debug.Notification("Thief Stone Blessing: +" + Math.Floor(appliedFlatHP) + " HP and +" + Math.Floor(appliedFlatMP) + " MP and +" + Math.Floor(appliedFlatStamina) + " Stamina ny your level.")
    Debug.Notification("Thief Stone Blessing: +" + Math.Floor(appliedPercentHP) + " HP and +" + Math.Floor(appliedPercentMP) + " MP and +" + Math.Floor(appliedPercentStamina) + " Stamina from base attributes.")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado,
    ; sem recalcular nada
    akTarget.ModActorValue("Health", -appliedPercentHP)
    akTarget.ModActorValue("Health", -appliedFlatHP)

    akTarget.ModActorValue("Magicka", -appliedPercentMP)
    akTarget.ModActorValue("Magicka", -appliedFlatMP)

    akTarget.ModActorValue("Stamina", -appliedPercentStamina)
    akTarget.ModActorValue("Stamina", -appliedFlatStamina)

    appliedFlatHP = 0.0
    appliedPercentHP = 0.0

    appliedFlatStamina = 0.0
    appliedPercentStamina = 0.0


EndEvent