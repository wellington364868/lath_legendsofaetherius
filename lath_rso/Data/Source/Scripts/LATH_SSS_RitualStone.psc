Scriptname LATH_SSS_RitualStone extends activemagiceffect  

Float appliedFlatAR = 0.0
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
    appliedFlatAR = akTarget.GetLevel() * 1.0  ; +1 Armor Rating por nível
    appliedFlatHP = Math.Ceiling(akTarget.GetLevel() * 0.5) ;valor arredondado para mais
    appliedFlatMP = akTarget.GetLevel() * 0.5

    ; Percentual sobre base
    appliedPercentHP = baselineHP * PercentHP
    appliedPercentMP = baselineMP * PercentMP

    ; --- Aplicar flat ---
    akTarget.ModActorValue("Health", appliedFlatHP)
    akTarget.ModActorValue("Magicka", appliedFlatMP)
    
    ; Aplicar modificadores
    akTarget.ModActorValue("DamageResist", appliedFlatAR)
    akTarget.ModActorValue("Health", appliedPercentHP)
    akTarget.ModActorValue("Magicka", appliedPercentMP)

    Debug.Notification("Ritual Stone Blessing: +" + Math.Floor(appliedFlatAR) + " Armor Rating for level.")
    Debug.Notification("Ritual Stone Blessing: +" + Math.Floor(appliedFlatHP) + " Health," + Math.Floor(appliedFlatMP) + " Magicka by level.")
    Debug.Notification("Ritual Stone Blessing: +"+ Math.Floor(appliedPercentHP) + " Health," + Math.Floor(appliedPercentMP) + " Magicka from base attributes.")
EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Reverter exatamente o aplicado
    akTarget.ModActorValue("DamageResist", -appliedFlatAR)
    akTarget.ModActorValue("Health", -appliedPercentHP)
    akTarget.ModActorValue("Magicka", -appliedPercentMP)
    akTarget.ModActorValue("Health", -appliedFlatHP)
    akTarget.ModActorValue("Magicka", -appliedFlatMP)
    appliedFlatAR = 0.0
    appliedPercentHP = 0.0
    appliedPercentMP = 0.0
    appliedFlatHP = 0.0
    appliedFlatMP = 0.0

EndEvent