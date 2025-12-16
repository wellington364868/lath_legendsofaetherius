Scriptname LATH_SSS_SerpentStone extends activemagiceffect  


Float appliedFlatHP = 0.0
Float appliedFlatMP = 0.0
Float appliedPercentHP = 0.0
Float appliedPercentMP = 0.0
Float appliedPercentStamina = 0.0
Float appliedPoisonResist = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return
    endif

    ; --- Percentuais ---
    Float PercentHP = 0.10
    Float PercentMP = 0.10
    Float PercentStamina = 0.10
    Float PoisonResistBonus = 10.0

    ; --- Baseline antes de mods ---
    Float baselineHP = akTarget.GetBaseActorValue("Health")
    Float baselineMP = akTarget.GetBaseActorValue("Magicka")
    Float baselineStamina = akTarget.GetBaseActorValue("Stamina")

    ; --- Flat baseado no nível ---
    appliedFlatHP = akTarget.GetLevel() * 1.0 ; +1 HP por nível
    appliedFlatMP = 0.0 ; nenhum flat MP adicional por nível

    ; --- Percentual sobre base ---
    appliedPercentHP = baselineHP * PercentHP
    appliedPercentMP = baselineMP * PercentMP
    appliedPercentStamina = baselineStamina * PercentStamina
    appliedPoisonResist = PoisonResistBonus

    ; --- Aplicar flat ---
    akTarget.ModActorValue("Health", appliedFlatHP)
    ;akTarget.ModActorValue("Magicka", appliedFlatMP) ; não aplicando flat MP

    ; --- Aplicar percentual ---
    akTarget.ModActorValue("Health", appliedPercentHP)
    akTarget.ModActorValue("Magicka", appliedPercentMP)
    akTarget.ModActorValue("Stamina", appliedPercentStamina)
    akTarget.ModActorValue("PoisonResist", appliedPoisonResist)

    Debug.Notification("Serpent Stone: +"+Math.Floor(appliedFlatHP)+" HP per level, +"+Math.Floor(appliedPercentHP)+"% HP base.")
    Debug.Notification("Serpent Stone: +"+Math.Floor(appliedPercentMP)+"% MP base, +"+Math.Floor(appliedPercentStamina)+"% Stamina base.")
    Debug.Notification("Serpent Stone: +"+Math.Floor(appliedPoisonResist)+"% ResistPoison.")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Reverter exatamente o aplicado
    akTarget.ModActorValue("Health", -appliedFlatHP)
    akTarget.ModActorValue("Health", -appliedPercentHP)
    akTarget.ModActorValue("Magicka", -appliedPercentMP)
    akTarget.ModActorValue("Stamina", -appliedPercentStamina)
    akTarget.ModActorValue("PoisonResist", -appliedPoisonResist)

    ; Resetar variáveis
    appliedFlatHP = 0.0
    appliedPercentHP = 0.0
    appliedFlatMP = 0.0
    appliedPercentMP = 0.0
    appliedPercentStamina = 0.0
    appliedPoisonResist = 0.0

    ;Debug.Notification("Serpent Stone: blessing removed.")

EndEvent