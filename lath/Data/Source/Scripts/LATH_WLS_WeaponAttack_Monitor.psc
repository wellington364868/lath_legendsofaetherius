Scriptname LATH_WLS_WeaponAttack_Monitor extends activemagiceffect  


Keyword Property WeapTypeSword Auto
Keyword Property WeapTypeWarAxe Auto
Keyword Property WeapTypeMace Auto
Keyword Property WeapTypeDagger Auto
Keyword Property WeapTypeGreatsword Auto
Keyword Property WeapTypeBattleaxe Auto
Keyword Property WeapTypeWarhammer Auto

Perk Property Dagger_1 Auto 
Perk Property Dagger_2 Auto 

Float baselineStaminaRegen = 0.0

float base_stamina_cost = 10.0
float attack_stamina_cost = 0.0

float base_stamina_block = 10.0

function OnEffectStart(Actor akTarget, Actor akCaster)

	self.RegisterForAnimationEvent(akTarget as objectreference, "weaponSwing")
	self.RegisterForAnimationEvent(akTarget as objectreference, "weaponLeftSwing")

    self.RegisterForAnimationEvent(akTarget as objectreference, "BowDrawn")
    self.RegisterForAnimationEvent(akTarget as objectreference, "BowRelease")

    self.RegisterForAnimationEvent(akTarget as objectreference, "blockStartOut")
    self.RegisterForAnimationEvent(akTarget as objectreference, "blockStop")

    Debug.Notification("WLS - Attack Monitor Iniciado")
endFunction

function OnRaceSwitchComplete()

	utility.Wait(2.00000)
	Actor TheTarget = self.GetTargetActor()
	self.RegisterForAnimationEvent(TheTarget as objectreference, "weaponSwing")
	self.RegisterForAnimationEvent(TheTarget as objectreference, "weaponLeftSwing")

    self.RegisterForAnimationEvent(TheTarget as objectreference, "BowDrawn")
    self.RegisterForAnimationEvent(TheTarget as objectreference, "BowRelease")

    self.RegisterForAnimationEvent(TheTarget as objectreference, "blockStartOut")
    self.RegisterForAnimationEvent(TheTarget as objectreference, "blockStop")

endFunction

function OnAnimationEvent(objectreference akSource, String asEventName)

	if asEventName == "weaponSwing" || asEventName == "weaponLeftSwing"

        Actor PlayerRef = akSource as Actor
        Weapon left_weapon = PlayerRef.GetEquippedWeapon(true)
        Weapon right_weapon = PlayerRef.GetEquippedWeapon(false)

        float right_cost = 0 ;serve para one-handed e two handed
        float left_cost = 0 ;serve para one-handed


        if right_weapon.HasKeyword(WeapTypeSword)
            right_cost = base_stamina_cost
        elseif right_weapon.HasKeyword(WeapTypeWarAxe)
            right_cost = base_stamina_cost
        elseif right_weapon.HasKeyword(WeapTypeMace)
            right_cost = base_stamina_cost
        elseif right_weapon.HasKeyword(WeapTypeDagger)
            right_cost = base_stamina_cost

            ;perk: Swift Assault
            if PlayerRef.HasPerk(Dagger_2)
                right_cost = base_stamina_cost * 0.6
            elseif PlayerRef.HasPerk(Dagger_1)
                right_cost = base_stamina_cost * 0.8
            endif

        elseif right_weapon.HasKeyword(WeapTypeGreatsword)
            right_cost = base_stamina_cost * 2.0
        elseif right_weapon.HasKeyword(WeapTypeBattleaxe)
            right_cost = base_stamina_cost * 2.0
        elseif right_weapon.HasKeyword(WeapTypeWarhammer)
            right_cost = base_stamina_cost * 2.0
        endif

        if left_weapon.HasKeyword(WeapTypeSword)
            left_cost = base_stamina_cost
        elseif left_weapon.HasKeyword(WeapTypeWarAxe)
            left_cost = base_stamina_cost
        elseif left_weapon.HasKeyword(WeapTypeMace)
            left_cost = base_stamina_cost
        elseif left_weapon.HasKeyword(WeapTypeDagger)
            left_cost = base_stamina_cost

            ;perk: Swift Assault
            if PlayerRef.HasPerk(Dagger_2)
                left_cost = base_stamina_cost * 0.6
            elseif PlayerRef.HasPerk(Dagger_1)
                left_cost = base_stamina_cost * 0.8
            endif
        endif

        ;Debug.Notification("left Weapon Name: " + left_weapon.GetName())
        ;Debug.Notification("Weapon FormID: " + left_weapon.GetFormID())

        ;Debug.Notification("right Weapon Name: " + right_weapon.GetName())
        ;Debug.Notification("Weapon FormID: " + right_weapon.GetFormID())

        attack_stamina_cost = right_cost + left_cost

        Debug.Notification("Weapon stamina cost: " + attack_stamina_cost)

		self.GetTargetActor().DamageActorValue("Stamina", attack_stamina_cost)

    elseif asEventName == "BowDrawn"
        
        attack_stamina_cost = base_stamina_cost * 1.5

        baselineStaminaRegen = self.GetTargetActor().GetBaseActorValue("StaminaRate")
        self.GetTargetActor().ModActorValue("StaminaRate", -baselineStaminaRegen)
		
        self.GetTargetActor().DamageActorValue("Stamina", attack_stamina_cost)
    
    elseif asEventName == "BowRelease"
        ;Debug.Notification("Flecha disparada!")
        
        self.GetTargetActor().ModActorValue("StaminaRate", baselineStaminaRegen)
        baselineStaminaRegen = 0.0

    elseif asEventName == "blockStartOut"
        if baselineStaminaRegen == 0.0
            baselineStaminaRegen = self.GetTargetActor().GetActorValue("StaminaRate")
            self.GetTargetActor().ModActorValue("StaminaRate", -baselineStaminaRegen)
        endif

    elseif asEventName == "blockStop"
        self.GetTargetActor().ModActorValue("StaminaRate", baselineStaminaRegen)
        
        baselineStaminaRegen = 0.0
	endIf

    attack_stamina_cost = 0.0

endFunction


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)


    Actor selfActor = GetTargetActor()
    if !selfActor
        return
    endif

    
    float block_stamina_cost = base_stamina_block

    Weapon enemy_weapon = akSource as Weapon

        if enemy_weapon.HasKeyword(WeapTypeSword)
            block_stamina_cost = block_stamina_cost * 1.0
        elseif enemy_weapon.HasKeyword(WeapTypeWarAxe)
            block_stamina_cost = block_stamina_cost * 1.0
        elseif enemy_weapon.HasKeyword(WeapTypeMace)
            block_stamina_cost = block_stamina_cost * 1.0
        elseif enemy_weapon.HasKeyword(WeapTypeDagger)
            block_stamina_cost = block_stamina_cost * 1.0
        elseif enemy_weapon.HasKeyword(WeapTypeGreatsword)
            block_stamina_cost = base_stamina_block * 2.0
        elseif enemy_weapon.HasKeyword(WeapTypeBattleaxe)
            block_stamina_cost = base_stamina_block * 2.0
        elseif enemy_weapon.HasKeyword(WeapTypeWarhammer)
            block_stamina_cost = base_stamina_block * 2.0
        endif

    if abPowerAttack 
        block_stamina_cost = block_stamina_cost * 2.0
    endif
    
    if abHitBlocked 


        Debug.Notification("arma: " + enemy_weapon.getName())
        selfActor.DamageActorValue("Stamina", block_stamina_cost)
    endif
EndEvent