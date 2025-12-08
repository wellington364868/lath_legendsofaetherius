Scriptname LATH_Smithing_MaterialSteel extends activemagiceffect  


Float Property MagicResistBonus Auto
Float Property FireResistBonus Auto
Float Property FrostResistBonus Auto
Float Property ElectricResistBonus Auto
Float Property PoisonResistBonus Auto
Float Property DiseaseResistBonus Auto
Float Property DamageResistBonus Auto

Float Property StaminaRegenBonus Auto
Float Property MagickaRegenBonus Auto

Float applied_magic_resist = 0.0
Float applied_fire_resist = 0.0
Float applied_frost_resist = 0.0
Float applied_electric_resist = 0.0
Float applied_poison_resist = 0.0
Float applied_disease_resist = 0.0

Float applied_damage_resist = 0.0

Float applied_stamina_regen_percent = 0.0
Float applied_magicka_regen_percent = 0.0


Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == none 
        return
    endif

    Float baselineStaminaRegen = akTarget.GetBaseActorValue("StaminaRate")
    Float baselineMagickaRegen = akTarget.GetBaseActorValue("MagickaRate")


    applied_magic_resist = MagicResistBonus 
    applied_fire_resist = FireResistBonus 
    applied_frost_resist = FrostResistBonus 
    applied_electric_resist = ElectricResistBonus 
    applied_poison_resist = PoisonResistBonus 
    applied_disease_resist = DiseaseResistBonus 

    ;AR = DamageResistBonus * 5.67 => 10% ~= 10 * 5.67
    ;applied_damage_resist = Math.Floor( DamageResistBonus * 5.67  )
    ;applied_damage_resist = DamageResistBonus * (akTarget.GetBaseActorValue("Smithing") / 100)

    applied_stamina_regen_percent = baselineStaminaRegen * StaminaRegenBonus 
    applied_magicka_regen_percent = baselineMagickaRegen * MagickaRegenBonus 
   

    ; Aplica os bônus
    akTarget.ModActorValue("MagicResist", applied_magic_resist)
    akTarget.ModActorValue("FireResist", applied_fire_resist)
    akTarget.ModActorValue("FrostResist", applied_frost_resist)
    akTarget.ModActorValue("ElectricResist", applied_electric_resist)
    akTarget.ModActorValue("PoisonResist", applied_poison_resist)
    akTarget.ModActorValue("DiseaseResist", applied_disease_resist)

    akTarget.ModActorValue("DamageResist", applied_damage_resist)

    akTarget.ModActorValue("StaminaRate", applied_stamina_regen_percent)
    akTarget.ModActorValue("MagickaRate", applied_magicka_regen_percent)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    ; Remove o bônus ao finalizar o efeito
    akTarget.ModActorValue("MagicResist", -applied_magic_resist)
    akTarget.ModActorValue("FireResist", -applied_fire_resist)
    akTarget.ModActorValue("FrostResist", -applied_frost_resist)
    akTarget.ModActorValue("ElectricResist", -applied_electric_resist)
    akTarget.ModActorValue("PoisonResist", -applied_poison_resist)
    akTarget.ModActorValue("DiseaseResist", -applied_disease_resist)

    akTarget.ModActorValue("DamageResist", -applied_damage_resist)

    akTarget.ModActorValue("StaminaRate", -applied_stamina_regen_percent)
    akTarget.ModActorValue("MagickaRate", -applied_magicka_regen_percent)

    applied_magic_resist = 0.0
    applied_fire_resist = 0.0
    applied_frost_resist = 0.0
    applied_electric_resist = 0.0
    applied_poison_resist = 0.0
    applied_disease_resist = 0.0

    applied_damage_resist = 0.0

    applied_stamina_regen_percent = 0.0
    applied_magicka_regen_percent = 0.0
EndEvent