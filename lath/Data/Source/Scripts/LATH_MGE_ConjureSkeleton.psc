Scriptname LATH_MGE_ConjureSkeleton extends activemagiceffect  

ActorBase Property SummonActorBase Auto


Quest Property ServantManagerQuest Auto


Actor Servant 


Event OnEffectStart(Actor akTarget, Actor akCaster)

    ;Actor PlayerRef = Game.GetPlayer()

    ;LATH_Conjuration_ServantManagerScript manager = ServantManagerQuest as LATH_Conjuration_ServantManagerScript
    ;if manager == None
    ;    Debug.Notification("ServantManager not found")
    ;    return
    ;endif

    ;int spawn_dist = 1

    ;Servant = manager.SpawnServant(1, SummonActorBase, spawn_dist) 
EndEvent