Scriptname LATH_SSS_SteedStone extends activemagiceffect  


Float appliedFlatStamina = 0.0
Float appliedFlatHP = 0.0
Float appliedPercentStamina = 0.0
Float appliedPercentHP = 0.0
Float appliedPercentSpeed = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return
    endif

    ; --- Percentuais ---
    Float PercentStamina = 0.20 ; 20% de Stamina base
    Float PercentHP = 0.20 ; 20% de HP base
    Float PercentSpeed   = 10.0 ; 10% de SpeedMult (velocidade de movimento)

    ; --- Baseline antes de mods ---
    Float baselineStamina = akTarget.GetBaseActorValue("Stamina")
    Float baselineHP = akTarget.GetBaseActorValue("Health")
    Float baselineSpeed   = akTarget.GetBaseActorValue("SpeedMult")

    ; --- Flat baseado no nível ---
    appliedFlatHP = Math.Ceiling( akTarget.GetLevel() * 0.5) ; +1 Health por nível
    appliedFlatHP = akTarget.GetLevel() * 0.5 ; +1 Magicka por nível

    ; --- Percentual sobre base (convertido em valor absoluto a ser aplicado) ---
    appliedPercentStamina = baselineStamina * PercentStamina
    appliedPercentHP = baselineHP * PercentHP
    appliedPercentSpeed   = PercentSpeed

    ; --- Aplicar flat ---
    akTarget.ModActorValue("Stamina", appliedFlatStamina)
    akTarget.ModActorValue("Health", appliedFlatHP)

    ; --- Aplicar percentuais ---
    akTarget.ModActorValue("Stamina", appliedPercentStamina)
    akTarget.ModActorValue("Health", appliedPercentHP)
    akTarget.ModActorValue("SpeedMult", appliedPercentSpeed)

    Debug.Notification("Shadow Stone: +" + Math.Floor(appliedFlatStamina) + " Stamina per level, +" + Math.Floor(appliedPercentStamina) + " Stamina (base).")
    Debug.Notification("Shadow Stone: +" + Math.Floor(appliedFlatHP) + " Health per level, +" + Math.Floor(appliedPercentHP) + " Health (base).")
    Debug.Notification("Shadow Stone: +" + Math.Floor(appliedPercentSpeed) + " SpeedMult (" + (PercentSpeed * 100 as Int) + "%).")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Reverter exatamente o aplicado
    akTarget.ModActorValue("Stamina", -appliedFlatStamina)
    akTarget.ModActorValue("Stamina", -appliedPercentStamina)

    akTarget.ModActorValue("Health", -appliedFlatHP)
    akTarget.ModActorValue("Health", -appliedPercentHP)

    akTarget.ModActorValue("SpeedMult", -appliedPercentSpeed)

    ; Resetar variáveis
    appliedFlatStamina = 0.0
    appliedFlatHP = 0.0
    appliedPercentStamina = 0.0
    appliedPercentHP = 0.0
    appliedPercentSpeed = 0.0

    ;Debug.Notification("Shadow Stone: blessing removed.")

EndEvent