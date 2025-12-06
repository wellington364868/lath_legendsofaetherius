Scriptname LATH_SSS_ShadowStone extends activemagiceffect  

Float appliedFlatStamina = 0.0
Float appliedFlatMagicka = 0.0
Float appliedPercentStamina = 0.0
Float appliedPercentMagicka = 0.0
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
    Float PercentMagicka = 0.20 ; 20% de Magicka base
    Float PercentSpeed   = 10.0 ; 10% de SpeedMult (velocidade de movimento)

    ; --- Baseline antes de mods ---
    Float baselineStamina = akTarget.GetBaseActorValue("Stamina")
    Float baselineMagicka = akTarget.GetBaseActorValue("Magicka")
    Float baselineSpeed   = akTarget.GetBaseActorValue("SpeedMult")

    ; --- Flat baseado no nível ---
    appliedFlatStamina = Math.Ceiling( akTarget.GetLevel() * 0.5) ; +1 Stamina por nível
    appliedFlatMagicka = akTarget.GetLevel() * 0.5 ; +1 Magicka por nível

    ; --- Percentual sobre base (convertido em valor absoluto a ser aplicado) ---
    appliedPercentStamina = baselineStamina * PercentStamina
    appliedPercentMagicka = baselineMagicka * PercentMagicka
    appliedPercentSpeed   = PercentSpeed

    ; --- Aplicar flat ---
    akTarget.ModActorValue("Stamina", appliedFlatStamina)
    akTarget.ModActorValue("Magicka", appliedFlatMagicka)

    ; --- Aplicar percentuais ---
    akTarget.ModActorValue("Stamina", appliedPercentStamina)
    akTarget.ModActorValue("Magicka", appliedPercentMagicka)
    akTarget.ModActorValue("SpeedMult", appliedPercentSpeed)

    Debug.Notification("Shadow Stone: +" + Math.Floor(appliedFlatStamina) + " Stamina per level, +" + Math.Floor(appliedPercentStamina) + " Stamina (base).")
    Debug.Notification("Shadow Stone: +" + Math.Floor(appliedFlatMagicka) + " Magicka per level, +" + Math.Floor(appliedPercentMagicka) + " Magicka (base).")
    Debug.Notification("Shadow Stone: +" + Math.Floor(appliedPercentSpeed) + " SpeedMult (" + (PercentSpeed * 100 as Int) + "%).")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Reverter exatamente o aplicado
    akTarget.ModActorValue("Stamina", -appliedFlatStamina)
    akTarget.ModActorValue("Stamina", -appliedPercentStamina)

    akTarget.ModActorValue("Magicka", -appliedFlatMagicka)
    akTarget.ModActorValue("Magicka", -appliedPercentMagicka)

    akTarget.ModActorValue("SpeedMult", -appliedPercentSpeed)

    ; Resetar variáveis
    appliedFlatStamina = 0.0
    appliedFlatMagicka = 0.0
    appliedPercentStamina = 0.0
    appliedPercentMagicka = 0.0
    appliedPercentSpeed = 0.0

    ;Debug.Notification("Shadow Stone: blessing removed.")

EndEvent