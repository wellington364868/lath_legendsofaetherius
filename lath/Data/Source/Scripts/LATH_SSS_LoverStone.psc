Scriptname LATH_SSS_LoverStone extends activemagiceffect  

Float appliedFlatHP = 0.0
Float appliedPercentHP = 0.0
Float appliedPhysRes = 0.0
Float appliedMagRes = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return 
    endif

    ; Percentuais
    Float PercentHP = 0.20  ; 20% do HP base

    ; Base antes de aplicar
    Float baselineHP = akTarget.GetBaseActorValue("Health")
    ;Float baselinePhys = akTarget.GetBaseActorValue("DamageResist")
    Float baselineMag = akTarget.GetBaseActorValue("MagicResist")

    ; Flat baseado no level
    appliedFlatHP = akTarget.GetLevel() * 1.0

    ; Percentual baseado na base
    appliedPercentHP = baselineHP * PercentHP
    ;appliedPhysRes = baselinePhys * PercentPhysRes
    appliedMagRes = 10.0; 10% de resistencia magica

    ; Aplicar flat e percentual
    akTarget.ModActorValue("Health", appliedFlatHP)
    akTarget.ModActorValue("Health", appliedPercentHP)
    ;akTarget.ModActorValue("DamageResist", appliedPhysRes)
    akTarget.ModActorValue("MagicResist", appliedMagRes)

    Debug.Notification("LoverStone: +" + Math.Floor(appliedFlatHP) + " HP by level, +" + Math.Floor(appliedPercentHP) + " HP, +"  + Math.Floor(appliedMagRes) + " Magic Res.")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado
    akTarget.ModActorValue("Health", -appliedPercentHP)
    akTarget.ModActorValue("Health", -appliedFlatHP)
    ;akTarget.ModActorValue("DamageResist", -appliedPhysRes)
    akTarget.ModActorValue("MagicResist", -appliedMagRes)

    ; Resetar variáveis
    appliedFlatHP = 0.0
    appliedPercentHP = 0.0
    appliedPhysRes = 0.0

EndEvent