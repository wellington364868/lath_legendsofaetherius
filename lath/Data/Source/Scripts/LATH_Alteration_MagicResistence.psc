Scriptname LATH_Alteration_MagicResistence extends activemagiceffect  


Float Property MagicResist Auto 

Float appliedMagicResist = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    if akTarget != Game.GetPlayer()
        return
    endif


    ;------------------------------
    ; RESISTÊNCIAS
    ;------------------------------
    appliedMagicResist = MagicResist

    akTarget.ModActorValue("MagicResist", appliedMagicResist)

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado
    akTarget.ModActorValue("MagicResist", -appliedMagicResist)
 
    ; Reset variáveis
    appliedMagicResist = 0.0


EndEvent