Scriptname LATH_Block_ElementalMitigation extends activemagiceffect  

Keyword Property  ArmorShield Auto 
Keyword property  WeapTypeStaff Auto

Float Property Fire_Resist Auto
Float Property Frost_Resist Auto
Float Property Electric_Resist Auto

Float appliedFrostResist = 0.0
Float appliedElectricResist = 0.0
Float appliedFireResist = 0.0

Bool resistApplied = false

Event OnEffectStart(Actor akTarget, Actor akCaster)


    if akTarget != Game.GetPlayer()
        return
    endif

    ;-------------------------
    ; RESISTÊNCIAS
    ;------------------------------
    appliedFrostResist = Frost_Resist
    appliedElectricResist = Electric_Resist
    appliedFireResist = Fire_Resist

    RegisterForAnimationEvent(akTarget as objectreference, "blockStartOut")
    RegisterForAnimationEvent(akTarget as objectreference, "blockStop")
EndEvent



function OnAnimationEvent(objectreference akSource, String asEventName)

    Actor selfActor = Game.GetPlayer()

    if !selfActor 
        return 
    endif 

    if asEventName == "blockStartOut"

        ;a verificação "isBlocking" será feita na spell/ability
        if !resistApplied && IsValidBlockItem(selfActor)
            selfActor.ModActorValue("FrostResist", appliedFrostResist)
            selfActor.ModActorValue("ElectricResist", appliedElectricResist)
            selfActor.ModActorValue("FireResist", appliedFireResist)

            resistApplied = true
        endif

    elseif asEventName == "blockStop"
        
        if resistApplied
            selfActor.ModActorValue("FrostResist", -appliedFrostResist)
            selfActor.ModActorValue("ElectricResist", -appliedElectricResist)
            selfActor.ModActorValue("FireResist", -appliedFireResist)

            resistApplied = false
        endif
    endif
endFunction



Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)


    Actor selfActor = GetTargetActor()
    if !selfActor
        return
    endif
    
    float block_magicka_cost = 10.0

    if abHitBlocked && resistApplied
        ;Debug.Notification("arma: " + enemy_weapon.getName())
        selfActor.DamageActorValue("Magicka", block_magicka_cost)
    endif
EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if resistApplied && akTarget
        akTarget.ModActorValue("FrostResist", -appliedFrostResist)
        akTarget.ModActorValue("ElectricResist", -appliedElectricResist)
        akTarget.ModActorValue("FireResist", -appliedFireResist)

        resistApplied = false
    endif

    appliedFrostResist = 0.0
    appliedElectricResist = 0.0
    appliedFireResist = 0.0

    UnregisterForAnimationEvent(akTarget as ObjectReference, "blockStartOut")
    UnregisterForAnimationEvent(akTarget as ObjectReference, "blockStop")

    
EndEvent

bool Function IsValidBlockItem(Actor a)
    if a.WornHasKeyword(ArmorShield)
        return true
    endif

    ; Cajado - mao direita
    Weapon w = a.GetEquippedWeapon(true)
    if w && w.HasKeyword(WeapTypeStaff)
        return true
    endif

    return false
EndFunction