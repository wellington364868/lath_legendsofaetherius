Scriptname LATH_SSS_LordStone extends activemagiceffect  


Float appliedFlatHP = 0.0
Float appliedPercentHP = 0.0
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
    Float baselinePhys = akTarget.GetBaseActorValue("DamageResist")
    ;Float baselineMag = akTarget.GetBaseActorValue("MagicResist")

    ; Flat baseado no level
    appliedFlatHP = 100.0
    appliedFlatHP = appliedFlatHP + akTarget.GetLevel() * 1.0

    ; Percentual baseado na base
    appliedPercentHP = baselineHP * PercentHP
    ;appliedMagRes = 5.0; 5% de resistencia magica

    ; Aplicar flat e percentual
    akTarget.ModActorValue("Health", appliedFlatHP)
    akTarget.ModActorValue("Health", appliedPercentHP)

    ;akTarget.ModActorValue("MagicResist", appliedMagRes)

    Debug.Notification("LordStone: +100 Health, + " + akTarget.GetLevel() + " HP by level, +" + Math.Floor(appliedPercentHP) + " HP")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado
    akTarget.ModActorValue("Health", -appliedPercentHP)
    akTarget.ModActorValue("Health", -appliedFlatHP)

    ;akTarget.ModActorValue("MagicResist", -appliedMagRes)

    ; Resetar variáveis
    appliedFlatHP = 0.0
    appliedPercentHP = 0.0

EndEvent