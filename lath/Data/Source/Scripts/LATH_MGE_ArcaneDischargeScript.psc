Scriptname LATH_MGE_ArcaneDischargeScript extends activemagiceffect  


Float Property BaseCost Auto           ; valor base da spell
Float Property MaxPercent = 0.5 Auto  ; 50% por padrão

Perk Property Rank1 Auto 
Perk Property Rank2 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akCaster == None || akTarget == None
        return
    endif

    ; ===========================================================
    ; 1) Cálculo do valor máximo do efeito
    ; ===========================================================
    float maxValue = BaseCost
    if maxValue <= 0
        return
    endif

    ; ===========================================================
    ; 2) Geração de valores aleatórios
    ; ===========================================================
    float refundToPlayer = Utility.RandomFloat(1.0, maxValue)

    ; ===========================================================
    ; 3) Aplicação dos efeitos
    ; ===========================================================
    akCaster.RestoreActorValue("Magicka", refundToPlayer)

    Debug.Notification("Player: " + refundToPlayer)
EndEvent