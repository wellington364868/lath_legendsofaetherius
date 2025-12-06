Scriptname LATH_SSS_WarriorStone extends activemagiceffect  


Float appliedFlatStamina = 0.0
Float appliedPercentStamina = 0.0
Float appliedPercentHP = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return
    endif

    ;------------------------------
    ; STAMINA
    ;------------------------------
    Float PercentStamina = 0.40 ; +40% da base
    Float baselineStamina = akTarget.GetBaseActorValue("Stamina")

    appliedFlatStamina = akTarget.GetLevel() * 1.0  ; +1 por nível
    appliedPercentStamina = baselineStamina * PercentStamina

    ; Aplicar Stamina
    akTarget.ModActorValue("Stamina", appliedFlatStamina)
    akTarget.ModActorValue("Stamina", appliedPercentStamina)

    Debug.Notification("Warrior Stone: +" + Math.Floor(appliedFlatStamina) + " Stamina by level.")
    Debug.Notification("Warrior Stone: +" + Math.Floor(appliedPercentStamina) + " Stamina by base.")

    ;------------------------------
    ; HP
    ;------------------------------
    ;Float PercentHP = 0.10 ; +10% HP base
    ;Float baselineHP = akTarget.GetBaseActorValue("Health")
    ;appliedPercentHP = baselineHP * PercentHP
    ;akTarget.ModActorValue("Health", appliedPercentHP)

    ;Debug.Notification("Warrior Stone: +" + Math.Floor(appliedPercentHP) + " HP by base.")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado
    akTarget.ModActorValue("Stamina", -appliedPercentStamina)
    akTarget.ModActorValue("Stamina", -appliedFlatStamina)
    ;akTarget.ModActorValue("Health", -appliedPercentHP)

    appliedFlatStamina = 0.0
    appliedPercentStamina = 0.0
    appliedPercentHP = 0.0

EndEvent