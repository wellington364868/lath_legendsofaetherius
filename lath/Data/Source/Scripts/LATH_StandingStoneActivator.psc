Scriptname LATH_StandingStoneActivator extends ObjectReference  


import game
import utility

String property graphVariable auto

; //which stone are we
BOOL PROPERTY bApprentice AUTO
BOOL PROPERTY bAtronach AUTO
BOOL PROPERTY bLady AUTO
BOOL PROPERTY bLord AUTO
BOOL PROPERTY bLover AUTO
BOOL PROPERTY bMage AUTO
BOOL PROPERTY bRitual AUTO
BOOL PROPERTY bSerpent AUTO
BOOL PROPERTY bShadow AUTO
BOOL PROPERTY bSteed AUTO
BOOL PROPERTY bThief AUTO
BOOL PROPERTY bTower AUTO
BOOL PROPERTY bWarrior AUTO

; //list of the effects
SPELL PROPERTY ApprenticeStoneAbility AUTO
SPELL PROPERTY AtronachStoneAbility AUTO
SPELL PROPERTY LadyStoneAbility AUTO
SPELL PROPERTY LordStoneAbility AUTO
SPELL PROPERTY LoverStoneAbility AUTO
SPELL PROPERTY MageStoneAbility AUTO
SPELL PROPERTY RitualStoneAbility AUTO
SPELL PROPERTY SerpentStoneAbility AUTO
SPELL PROPERTY ShadowStoneAbility AUTO
SPELL PROPERTY SteedStoneAbility AUTO
SPELL PROPERTY ThiefStoneAbility AUTO
SPELL PROPERTY TowerStoneAbility AUTO
SPELL PROPERTY WarriorStoneAbility AUTO

; //list of the messages
MESSAGE PROPERTY StandingStoneActivateMsg AUTO


; //list of Rested spells -- need to remove just for the Lover
Spell Property pRested Auto
Spell Property pWellRested Auto
Spell Property pMarriageRested Auto

; //the perk for Ritual
PERK PROPERTY pDoomRitualPerk AUTO

; //the already have message
MESSAGE PROPERTY pDoomAlreadyHaveMSG AUTO

;************************************


Auto State base
	
	EVENT OnActivate(ObjectReference obj)
		
		; //check to see if the player is the activator and we havent already activated
		if(obj AS Actor == Game.getPlayer())
			
            Actor PlayerRef = Game.GetPlayer()
			
			; //if we already have the power and this is the stone then kick the player out
			IF(PlayerRef.hasSpell(ApprenticeStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)
		
			ELSEIF(PlayerRef.hasSpell(AtronachStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)
			
			ELSEIF(PlayerRef.hasSpell(LadyStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)
	
			ELSEIF(PlayerRef.hasSpell(LordStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				
			
			ELSEIF(PlayerRef.hasSpell(LoverStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				
	
			ELSEIF(PlayerRef.hasSpell(MageStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				

			ELSEIF(PlayerRef.hasSpell(RitualStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				

			ELSEIF(PlayerRef.hasSpell(SerpentStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				

			ELSEIF(PlayerRef.hasSpell(ShadowStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				

			ELSEIF(PlayerRef.hasSpell(SteedStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				

			ELSEIF(PlayerRef.hasSpell(ThiefStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				

			ELSEIF(PlayerRef.hasSpell(TowerStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				

			ELSEIF(PlayerRef.hasSpell(WarriorStoneAbility))
				pDoomAlreadyHaveMSG.show()
				utility.wait(2)				

			ENDIF

			; // present them with the choice
			IF(showSign() == 0)
				removeSign()
				addSign()
					
				SELF.playAnimation("playanim01")
					
				utility.wait(15)
					
			ENDIF
			
		ENDIF
	endEvent
	
endState


Int Function showSign()
	
	int signHolder = StandingStoneActivateMsg.show()
	
	return signHolder
		
EndFunction

; //FUNCTION: addSign
; //
; // adds the sign of the stone to the player
FUNCTION addSign()
	game.AddAchievement(29)
	IF(bApprentice)
		Game.getPlayer().addSpell(ApprenticeStoneAbility)

	ELSEIF(bAtronach)
		game.getPlayer().addSpell(AtronachStoneAbility)
	ELSEIF(bLady)
		game.getPlayer().addSpell(LadyStoneAbility)
	ELSEIF(bLord)
		game.getPlayer().addSpell(LordStoneAbility)
	ELSeIF(bLover)
		game.getPlayer().addSpell(LoverStoneAbility)
	ELSEIF(bMage)
		game.getPlayer().addSpell(MageStoneAbility)
	ELSEIF(bRitual)
		game.getPlayer().addSpell(RitualStoneAbility)
		;game.getPlayer().addPerk(pdoomRitualPerk)
	ELSEIF(bSerpent)
		game.getPlayer().addSpell(SerpentStoneAbility)
	ELSEIF(bShadow)
		game.getPlayer().addSpell(ShadowStoneAbility)
	ELSEIF(bSteed)
		game.getPlayer().addSpell(SteedStoneAbility)
	ELSEIF(bThief)
		game.getPlayer().addSpell(ThiefStoneAbility)
	ELSEIF(bTower)
		game.getPlayer().addSpell(TowerStoneAbility)
	ELSEIF(bWarrior)
		game.getPlayer().addSpell(WarriorStoneAbility)
	ENDIF

EndFunction

; //FUNCTION: removeSign
; //
; // Removes all of the signs currently on the player
FUNCTION removeSign()
		
	IF(Game.getPlayer().hasSpell(ApprenticeStoneAbility))
		Game.getPlayer().removeSpell(ApprenticeStoneAbility)
	
	ELSEIF(game.getPlayer().hasSpell(AtronachStoneAbility))
		game.getPlayer().removeSpell(AtronachStoneAbility)		
	
	ELSEIF(game.getPlayer().hasSpell(LadyStoneAbility))
		game.getPlayer().removeSpell(LadyStoneAbility)	
	
	ELSEIF(game.getPlayer().hasSpell(LordStoneAbility))
		game.getPlayer().removeSpell(LordStoneAbility)	
	
	ELSEIF(game.getPlayer().hasSpell(LoverStoneAbility))
		game.getPlayer().removeSpell(LoverStoneAbility)
	
	ELSEIF(game.getPlayer().hasSpell(MageStoneAbility))
		game.getPlayer().removeSpell(MageStoneAbility)	
	
	ELSEIF(game.getPlayer().hasSpell(RitualStoneAbility))
		game.getPlayer().removeSpell(RitualStoneAbility)	
	
	ELSEIF(game.getPlayer().hasSpell(SerpentStoneAbility))
		game.getPlayer().removeSpell(SerpentStoneAbility)	
	
	ELSEIF(game.getPlayer().hasSpell(ShadowStoneAbility))
		game.getPlayer().removeSpell(ShadowStoneAbility)	
	
	ELSEIF(game.getPlayer().hasSpell(SteedStoneAbility))
		game.getPlayer().removeSpell(SteedStoneAbility)	
	
	ELSEIF(game.getPlayer().hasSpell(ThiefStoneAbility))
		game.getPlayer().removeSpell(ThiefStoneAbility)	
	
	ELSEIF(game.getPlayer().hasSpell(TowerStoneAbility))
		game.getPlayer().removeSpell(TowerStoneAbility)	
	
	ELSEIF(game.getPlayer().hasSpell(WarriorStoneAbility))
		game.getPlayer().removeSpell(WarriorStoneAbility)	
	
	ENDIF
	
endFUNCTION

;************************************

State waiting
	;do nothing
endState

;************************************