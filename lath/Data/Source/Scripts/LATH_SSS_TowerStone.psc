Scriptname LATH_SSS_TowerStone extends activemagiceffect  


Float appliedFlatHP = 0.0
Float appliedPercentHP = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return 
    endif

    Float PercentAmount = 0.40 ;+40% base HP
    ; Baseline antes de qualquer mod
    Float baseline = akTarget.GetBaseActorValue("Health")

    ; Calcular quanto será aplicado
    appliedFlatHP = akTarget.GetLevel() * 1.0
    appliedPercentHP = baseline * PercentAmount

  ; Aplicar flat
    akTarget.ModActorValue("Health", appliedFlatHP)

    ; Aplicar percentual (calculado no baseline)
    akTarget.ModActorValue("Health", appliedPercentHP)

    Debug.Notification("Tower Stone Blessing: +" + Math.Floor(appliedFlatHP) + " HP by your level.")
    Debug.Notification("Tower Stone Blessing: +" + Math.Floor(appliedPercentHP)  + " HP from base attributes.")
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado,
    ; sem recalcular nada
    akTarget.ModActorValue("Health", -appliedPercentHP)
    akTarget.ModActorValue("Health", -appliedFlatHP)

    appliedFlatHP = 0.0
    appliedPercentHP = 0.0


EndEvent