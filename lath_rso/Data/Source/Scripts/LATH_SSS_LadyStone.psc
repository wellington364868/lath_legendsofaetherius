Scriptname LATH_SSS_LadyStone extends activemagiceffect  

Float appliedFlatHP = 0.0
Float appliedFlatMP = 0.0
Float appliedPercentHP = 0.0
Float appliedPercentMP = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return
    endif

    ; Percentuais
    Float PercentHP = 0.20
    Float PercentMP = 0.20

    ; Baseline antes de mods
    Float baselineHP = akTarget.GetBaseActorValue("Health")
    Float baselineMP = akTarget.GetBaseActorValue("Magicka")

    ; Flat baseado no nível
    appliedFlatHP = Math.Ceiling( akTarget.GetLevel() * 0.5)
    appliedFlatMP = akTarget.GetLevel() * 0.5 ; se quiser +1 MP por nível também

    ; Percentual sobre base
    appliedPercentHP = baselineHP * PercentHP
    appliedPercentMP = baselineMP * PercentMP

    ; Aplicar flat
    akTarget.ModActorValue("Health", appliedFlatHP)
    akTarget.ModActorValue("Magicka", appliedFlatMP)

    ; Aplicar percentual
    akTarget.ModActorValue("Health", appliedPercentHP)
    akTarget.ModActorValue("Magicka", appliedPercentMP)

    Debug.Notification("Lady Stone: +"+Math.Floor(appliedFlatHP)+" HP per level, +"+Math.Floor(appliedPercentHP)+"% HP base.")
    Debug.Notification("Lady Stone: +"+Math.Floor(appliedFlatMP)+" MP per level, +"+Math.Floor(appliedPercentMP)+"% MP base.")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Reverter exatamente o aplicado
    akTarget.ModActorValue("Health", -appliedPercentHP)
    akTarget.ModActorValue("Health", -appliedFlatHP)

    akTarget.ModActorValue("Magicka", -appliedPercentMP)
    akTarget.ModActorValue("Magicka", -appliedFlatMP)

    appliedFlatHP = 0.0
    appliedPercentHP = 0.0
    appliedFlatMP = 0.0
    appliedPercentMP = 0.0

    ;Debug.Notification("Lady Stone: blessing removed.")

EndEvent