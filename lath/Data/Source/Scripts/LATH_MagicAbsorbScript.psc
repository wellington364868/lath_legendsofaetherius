Scriptname LATH_MagicAbsorbScript extends activemagiceffect  
Float Property BaseCost Auto           ; valor base da spell
Float Property MaxPercent = 0.5 Auto  ; 50% por padrão

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akCaster == None || akTarget == None
        return
    endif

    ; ===========================================================
    ; 1) Cálculo do valor máximo do efeito
    ; ===========================================================
    float maxValue = BaseCost * MaxPercent
    if maxValue <= 0
        return
    endif

    ; ===========================================================
    ; 2) Geração de valores aleatórios
    ; ===========================================================
    float refundToPlayer = Utility.RandomFloat(1.0, maxValue)
    float damageHealth = Utility.RandomFloat(1.0, BaseCost)

    ; ===========================================================
    ; 3) Aplicação dos efeitos
    ; ===========================================================
    akCaster.RestoreActorValue("Magicka", refundToPlayer)
    akTarget.DamageActorValue("Health", damageHealth)

    Debug.Notification("Player: " + refundToPlayer)
    Debug.Notification("Target: " + damageHealth)
EndEvent