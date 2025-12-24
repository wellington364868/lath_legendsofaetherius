Scriptname LATH_Conjuration_ServantManagerScript extends Quest  



Activator property actEmpty auto
Activator property actSummonFX auto

int max_summon = 3
int count_summon = 0

Actor[]  ServantArray 

;---------------------------------------------------------------------------------------------------------------------------------------------------------
;---START UP---
;por padrão vamos permitir até 5 servants desbloqueados via perks
;---------------------------------------------------------------------------------------------------------------------------------------------------------
Function Initialize()
    ServantArray = new Actor[8]
    int i =0

    while(i < ServantArray.Length)
        ServantArray[i] = NONE
        i = i+1
    endWhile
	Debug.Notification("[Bonecraft] Skele Manager Quest initialized!")
EndFunction


Actor Function SpawnServant(Int servant_type, ActorBase summon_base, int spawn_dist)


    Actor PlayerRef = Game.GetPlayer()
    Actor servant = NONE

    ;verifica summons validos e atualiza limite de summons
    VerifySummonLimit()

    if count_summon < max_summon
        ObjectReference marker = PlayerRef.PlaceAtMe(actEmpty)
        
        marker.MoveTo(PlayerRef, Math.Sin(PlayerRef.GetAngleZ()) * spawn_dist, Math.Cos(PlayerRef.GetAngleZ()) * spawn_dist, 0)
	    marker.SetAngle(marker.GetAngleX(), marker.GetAngleY(), marker.GetAngleZ() +  marker.GetHeadingAngle(PlayerRef))

        ;servant =  marker.PlaceAtMe(summon_base) as Actor

        Int i = 0
        bool alocated = false
        int servant_index = 0

        While (i < ServantArray.Length)
            if !alocated
                if ServantArray[i] == NONE
                    ServantArray[i] = marker.PlaceAtMe(summon_base) as Actor
                    servant_index = i
                    alocated = true
                endif
            endif
            i += 1
        EndWhile

        ServantArray[servant_index].PlaceAtMe(actSummonFX) 
	    ServantArray[servant_index].SetPlayerTeammate()
	    ServantArray[servant_index].IgnoreFriendlyHits()

        marker.DisableNoWait()
	    marker.Delete()

        ;AddServantToArray(servant)
    
    else 
        	Debug.Notification("[Servant] Warning! Failed to add skeleton to array, you already have reached summon's limit!")
    endif

    Return servant
endFunction

Function AddServantToArray(Actor servant)
    Int i = 0

    While (i < ServantArray.Length)
        if ServantArray[i] == NONE
            ServantArray[i] = servant
            return
        endif
        i += 1
    EndWhile
EndFunction


Function VerifySummonLimit()
    Int i = 0
    count_summon = 0

    While (i < ServantArray.Length)

        if ServantArray[i]
            if ServantArray[i].IsDead()
                ServantArray[i] = NONE
                Debug.Notification("Alguem morreu")
            else
                count_summon = count_summon + 1
            endif
        endif

        i += 1
    EndWhile

    Debug.Notification("Servant count: " + count_summon)
endFunction