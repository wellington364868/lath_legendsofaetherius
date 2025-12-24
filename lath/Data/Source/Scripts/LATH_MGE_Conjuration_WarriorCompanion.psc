Scriptname LATH_MGE_Conjuration_WarriorCompanion extends activemagiceffect  

;sugestão Warrior Companion
;5% stamina regen
;50 HP
;50 MP

;------------------------------
; Configuração padrão (podem ser sobrescritas no CK)
;------------------------------

Perk Property FamiliarBonus_1 Auto
Perk Property FamiliarBonus_2 Auto
Perk Property FamiliarBonus_3 Auto
Perk Property FamiliarBonus_4 Auto
Perk Property FamiliarBonus_5 Auto

Float Property FlatStaminaBonus Auto        
Float Property FlatHPBonus Auto           

Float Property StaminaRegenBonus Auto


;------------------------------
; Variáveis de controle dos valores aplicados
;------------------------------
Float appliedFlatStamina = 0.0
Float appliedFlatHP = 0.0

Float appliedStaminaRegen = 0.0


;------------------------------
; Configuração padrão (podem ser sobrescritas no CK)
;------------------------------
Float RaceFlatStamina = 10.0        ;+10 Stamina
Float RaceFlatHP = 30.0             ;+30 HP


Float RaceStaminaRegen = 0.0



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
    Float baselineHP = akTarget.GetBaseActorValue("Health")
    Float baselineStaminaRegen = akTarget.GetBaseActorValue("StaminaRate")

    float mult_factor = 1.0
    
    if akTarget.HasPerk(FamiliarBonus_5)
        mult_factor = 3.0
    elseif akTarget.HasPerk(FamiliarBonus_4)
        mult_factor = 2.6
    elseif akTarget.HasPerk(FamiliarBonus_3)
        mult_factor = 2.2
    elseif akTarget.HasPerk(FamiliarBonus_2)
        mult_factor = 1.8
    elseif akTarget.HasPerk(FamiliarBonus_1)
        mult_factor = 1.4
    endif

    appliedFlatStamina = FlatStaminaBonus * mult_factor

    akTarget.ModActorValue("Stamina", appliedFlatStamina)


    ;------------------------------
    ; HP
    ;------------------------------
    
    appliedFlatHP = FlatHPBonus * mult_factor

    akTarget.ModActorValue("Health", appliedFlatHP)
   
    ;------------------------------
    ; REGENS
    ;------------------------------

    appliedStaminaRegen = baselineStaminaRegen  * StaminaRegenBonus * mult_factor


    akTarget.ModActorValue("StaminaRate", appliedStaminaRegen)

EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado

    akTarget.ModActorValue("Stamina", -appliedFlatStamina)

    akTarget.ModActorValue("Health", -appliedFlatHP)


    akTarget.ModActorValue("StaminaRate", -appliedStaminaRegen)

    ; Reset variáveis
    appliedFlatStamina = 0.0
    appliedFlatHP = 0.0
    appliedStaminaRegen = 0.0


EndEvent