Scriptname LATH_WLS_WeaponAttack_Monitor extends activemagiceffect  


Keyword Property WeapTypeSword Auto
Keyword Property WeapTypeWarAxe Auto
Keyword Property WeapTypeMace Auto
Keyword Property WeapTypeDagger Auto
Keyword Property WeapTypeGreatsword Auto
Keyword Property WeapTypeBattleaxe Auto
Keyword Property WeapTypeWarhammer Auto

Float baselineStaminaRegen = 0.0


float attack_stamina_cost = 10.0

function OnEffectStart(Actor akTarget, Actor akCaster)

	self.RegisterForAnimationEvent(akTarget as objectreference, "weaponSwing")
	self.RegisterForAnimationEvent(akTarget as objectreference, "weaponLeftSwing")

    self.RegisterForAnimationEvent(akTarget as objectreference, "BowDrawn")
    self.RegisterForAnimationEvent(akTarget as objectreference, "BowRelease")

    Debug.Notification("WLS - Attack Monitor Iniciado")
endFunction

function OnRaceSwitchComplete()

	utility.Wait(2.00000)
	Actor TheTarget = self.GetTargetActor()
	self.RegisterForAnimationEvent(TheTarget as objectreference, "weaponSwing")
	self.RegisterForAnimationEvent(TheTarget as objectreference, "weaponLeftSwing")

    self.RegisterForAnimationEvent(TheTarget as objectreference, "BowDrawn")
    self.RegisterForAnimationEvent(TheTarget as objectreference, "BowRelease")
endFunction

function OnAnimationEvent(objectreference akSource, String asEventName)

	if asEventName == "weaponSwing" || asEventName == "weaponLeftSwing"

        Actor PlayerRef = akSource as Actor
        Weapon left_weapon = PlayerRef.GetEquippedWeapon(true)
        Weapon right_weapon = PlayerRef.GetEquippedWeapon(false)

        float right_cost = 0 ;serve para one-handed e two handed
        float left_cost = 0 ;serve para one-handed


        if right_weapon.HasKeyword(WeapTypeSword)
            right_cost = 10.0
        elseif right_weapon.HasKeyword(WeapTypeWarAxe)
            right_cost = 10.0
        elseif right_weapon.HasKeyword(WeapTypeMace)
            right_cost = 10.0
        elseif right_weapon.HasKeyword(WeapTypeDagger)
            right_cost = 10.0
        elseif right_weapon.HasKeyword(WeapTypeGreatsword)
            right_cost = 20.0
        elseif right_weapon.HasKeyword(WeapTypeBattleaxe)
            right_cost = 20.0
        elseif right_weapon.HasKeyword(WeapTypeWarhammer)
            right_cost = 20.0
        endif

        if left_weapon.HasKeyword(WeapTypeSword)
            left_cost = 10.0
        elseif left_weapon.HasKeyword(WeapTypeWarAxe)
            left_cost = 10.0
        elseif left_weapon.HasKeyword(WeapTypeMace)
            left_cost = 10.0
        elseif left_weapon.HasKeyword(WeapTypeDagger)
            left_cost = 10.0
        endif

        ;Debug.Notification("left Weapon Name: " + left_weapon.GetName())
        ;Debug.Notification("Weapon FormID: " + left_weapon.GetFormID())

        ;Debug.Notification("right Weapon Name: " + right_weapon.GetName())
        ;Debug.Notification("Weapon FormID: " + right_weapon.GetFormID())

        attack_stamina_cost = right_cost + left_cost

        Debug.Notification("Weapon stamina cost: " + attack_stamina_cost)

		self.GetTargetActor().DamageActorValue("Stamina", attack_stamina_cost)

    elseif asEventName == "BowDrawn"
        
        attack_stamina_cost = 40.0

        baselineStaminaRegen = self.GetTargetActor().GetBaseActorValue("StaminaRate")
        self.GetTargetActor().ModActorValue("StaminaRate", -baselineStaminaRegen)
		
        self.GetTargetActor().DamageActorValue("Stamina", attack_stamina_cost)
    
    elseif asEventName == "BowRelease"
        ;Debug.Notification("Flecha disparada!")
        
        self.GetTargetActor().ModActorValue("StaminaRate", baselineStaminaRegen)
        baselineStaminaRegen = 0.0
	endIf

    attack_stamina_cost = 0.0
endFunction