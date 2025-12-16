Scriptname LATH_SSS_AtronachStone extends activemagiceffect  

Float appliedFlatMP = 0.0
Float appliedPercentMP = 0.0
Float appliedResist = 0.0
Float appliedRegen = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return
    endif

    ; Percentuais
    Float PercentMP = 0.20          ; +20% of base Magicka
    Float MagicResist = 10.0      ; +10 Resist Magic
    Float PercentRegen = 0.10       ; +10% MagickaRegen

    ; Baseline antes de mods
    Float baselineMP = akTarget.GetBaseActorValue("Magicka")
    Float baselineResist = akTarget.GetBaseActorValue("MagicResist")
    Float baselineRegen = akTarget.GetBaseActorValue("MagickaRate")

    ; Flat baseado no nível
    appliedFlatMP = (Math.Ceiling(akTarget.GetLevel() * 0.5))

    ; Percentual sobre base
    appliedPercentMP = baselineMP * PercentMP
    appliedResist = MagicResist        ; ResistMagic é flat, não percentual
    ;appliedRegen = baselineRegen * (PercentRegen / 100.0)
    appliedRegen = PercentRegen * akTarget.GetBaseActorValue("MagickaRate")

    ; Aplicar modificadores
    akTarget.ModActorValue("Magicka", appliedFlatMP)
    akTarget.ModActorValue("Magicka", appliedPercentMP)

    akTarget.ModActorValue("MagicResist", MagicResist)
    akTarget.ModActorValue("MagickaRate", appliedRegen)

    Debug.Notification("Atronach Stone Blessing: +" + Math.Floor(appliedFlatMP) + " Magicka flat per level.")
    Debug.Notification("Atronach Stone Blessing: +" + Math.Floor(appliedPercentMP)  + " Magicka from base attributes.")
EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Reverter exatamente o aplicado
    akTarget.ModActorValue("Magicka", -appliedPercentMP)
    akTarget.ModActorValue("Magicka", -appliedFlatMP)

    akTarget.ModActorValue("MagicResist", -appliedResist)
    akTarget.ModActorValue("MagickaRate", -appliedRegen)

    appliedFlatMP = 0.0
    appliedPercentMP = 0.0
    appliedResist = 0.0
    appliedRegen = 0.0

EndEvent