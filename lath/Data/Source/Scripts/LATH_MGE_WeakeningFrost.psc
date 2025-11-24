Scriptname LATH_MGE_WeakeningFrost extends activemagiceffect  



Float Property DamageReduction  Auto  ; 10%
Bool Property Applied = False Auto          ; flag interna para não reaplicar

Event OnEffectStart(Actor akTarget, Actor akCaster)
    if akTarget == None
        return
    endif

    Debug.Notification("Efeito iniciado")

    ; aplicar redução de dano apenas uma vez
    if !Applied
        Float current_stamina_percent = akTarget.GetActorValuePercentage("Stamina")


        akTarget.ModActorValue("AttackDamageMult", -DamageReduction)
        Applied = True
        Debug.Notification("Efeito aplicado: " + akTarget.GetActorValue("AttackDamageMult"))

    endif
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    if akTarget == None
        return
    endif
    

    ; restaurar AV
    if Applied
        akTarget.ModActorValue("AttackDamageMult", DamageReduction)
        Debug.Notification("Efeito encerrado: " + akTarget.GetActorValue("AttackDamageMult"))
        Applied = False
    endif
EndEvent

Event OnDying(Actor akKiller)
    Cleanup()
EndEvent

Event OnDeath(Actor akKiller)
    Cleanup()
EndEvent

Function Cleanup()
    Actor target = GetTargetActor()
    if target != None && Applied
        target.ModActorValue("AttackDamageMult", DamageReduction)
        Applied = False
    endif
EndFunction

