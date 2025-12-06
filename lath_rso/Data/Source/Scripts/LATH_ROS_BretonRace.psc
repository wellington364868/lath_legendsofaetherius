Scriptname LATH_ROS_BretonRace extends activemagiceffect  


;------------------------------
; Variáveis de controle dos valores aplicados
;------------------------------
Float appliedFlatStamina = 0.0
Float appliedPercentStamina = 0.0
Float appliedFlatHP = 0.0
Float appliedPercentHP = 0.0
Float appliedFlatMagicka = 0.0
Float appliedPercentMagicka = 0.0
Float appliedMagicResist = 0.0
Float appliedFrostResist = 0.0
Float appliedShockResist = 0.0
Float appliedFireResist = 0.0
Float appliedPoisonResist = 0.0
Float appliedSpeedMult = 0.0
Float appliedCarryWeight = 0.0
Float appliedHPRegen = 0.0
Float appliedStaminaRegen = 0.0
Float appliedMagickaRegen = 0.0

;------------------------------
; Configuração padrão (podem ser sobrescritas no CK)
;------------------------------
Float RaceFlatStamina = 0.0        ;
Float RacePercentStamina = 0.0
Float RaceFlatHP = 20.0             ;+20 HP
Float RacePercentHP = 0.0
Float RaceFlatMagicka = 30.0        ;+30 MP
Float RacePercentMagicka = 0.0
Float RaceMagicResist = 20.0        ;+20% Magic Resist
Float RaceFrostResist = 0.0        ;
Float RaceShockResist = 0.0
Float RaceFireResist = 0.0
Float RacePoisonResist = 0.0
Float RaceSpeedMult = 0.0
Float RaceCarryWeight = 0.0
Float RaceHPRegen = 0.0
Float RaceStaminaRegen = 0.0
Float RaceMagickaRegen = 0.2       ;+20% Magicka regen.

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
    Float baselineStamina = akTarget.GetBaseActorValue("Stamina")
    appliedFlatStamina = RaceFlatStamina * akTarget.GetLevel()
    appliedPercentStamina = baselineStamina * RacePercentStamina
    akTarget.ModActorValue("Stamina", appliedFlatStamina)
    akTarget.ModActorValue("Stamina", appliedPercentStamina)

    ;------------------------------
    ; HP
    ;------------------------------
    Float baselineHP = akTarget.GetBaseActorValue("Health")
    appliedFlatHP = RaceFlatHP
    appliedPercentHP = baselineHP * RacePercentHP
    akTarget.ModActorValue("Health", appliedFlatHP)
    akTarget.ModActorValue("Health", appliedPercentHP)

    ;------------------------------
    ; MAGICKA
    ;------------------------------
    Float baselineMagicka = akTarget.GetBaseActorValue("Magicka")
    appliedFlatMagicka = RaceFlatMagicka
    appliedPercentMagicka = baselineMagicka * RacePercentMagicka
    akTarget.ModActorValue("Magicka", appliedFlatMagicka)
    akTarget.ModActorValue("Magicka", appliedPercentMagicka)

    ;------------------------------
    ; RESISTÊNCIAS
    ;------------------------------
    appliedMagicResist = RaceMagicResist
    appliedFrostResist = RaceFrostResist
    appliedShockResist = RaceShockResist
    appliedFireResist = RaceFireResist
    appliedPoisonResist = RacePoisonResist

    akTarget.ModActorValue("MagicResist", appliedMagicResist)
    akTarget.ModActorValue("FrostResist", appliedFrostResist)
    akTarget.ModActorValue("ShockResist", appliedShockResist)
    akTarget.ModActorValue("FireResist", appliedFireResist)
    akTarget.ModActorValue("PoisonResist", appliedPoisonResist)

    ;------------------------------
    ; SPEED MULTIPLIER e CARRY WEIGHT
    ;------------------------------
    appliedSpeedMult = RaceSpeedMult
    appliedCarryWeight = RaceCarryWeight
    akTarget.ModActorValue("SpeedMult", appliedSpeedMult)
    akTarget.ModActorValue("CarryWeight", appliedCarryWeight)

    ;------------------------------
    ; REGENS
    ;------------------------------
    appliedHPRegen = akTarget.GetBaseActorValue("HealRate") + RaceHPRegen
    appliedStaminaRegen = akTarget.GetBaseActorValue("StaminaRate")  * RaceStaminaRegen
    appliedMagickaRegen = akTarget.GetBaseActorValue("MagickaRate") * RaceMagickaRegen
    akTarget.ModActorValue("HealRate", appliedHPRegen)
    akTarget.ModActorValue("StaminaRate", appliedStaminaRegen)
    akTarget.ModActorValue("MagickaRate", appliedMagickaRegen)

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado
    akTarget.ModActorValue("Stamina", -appliedPercentStamina)
    akTarget.ModActorValue("Stamina", -appliedFlatStamina)
    akTarget.ModActorValue("Health", -appliedPercentHP)
    akTarget.ModActorValue("Health", -appliedFlatHP)
    akTarget.ModActorValue("Magicka", -appliedPercentMagicka)
    akTarget.ModActorValue("Magicka", -appliedFlatMagicka)

    akTarget.ModActorValue("MagicResist", -appliedMagicResist)
    akTarget.ModActorValue("FrostResist", -appliedFrostResist)
    akTarget.ModActorValue("ShockResist", -appliedShockResist)
    akTarget.ModActorValue("FireResist", -appliedFireResist)
    akTarget.ModActorValue("PoisonResist", -appliedPoisonResist)

    akTarget.ModActorValue("SpeedMult", -appliedSpeedMult)
    akTarget.ModActorValue("CarryWeight", -appliedCarryWeight)

    akTarget.ModActorValue("HealRate", -appliedHPRegen)
    akTarget.ModActorValue("StaminaRate", -appliedStaminaRegen)
    akTarget.ModActorValue("MagickaRate", -appliedMagickaRegen)

    ; Reset variáveis
    appliedFlatStamina = 0.0
    appliedPercentStamina = 0.0
    appliedFlatHP = 0.0
    appliedPercentHP = 0.0
    appliedFlatMagicka = 0.0
    appliedPercentMagicka = 0.0
    appliedMagicResist = 0.0
    appliedFrostResist = 0.0
    appliedShockResist = 0.0
    appliedFireResist = 0.0
    appliedPoisonResist = 0.0
    appliedSpeedMult = 0.0
    appliedCarryWeight = 0.0
    appliedHPRegen = 0.0
    appliedStaminaRegen = 0.0
    appliedMagickaRegen = 0.0

EndEvent