Scriptname LATH_PlayerCharacterMonitorScript extends activemagiceffect  


Import JFormDB

; --- Propriedades opcionais de debug ---
Bool Property DebugEnabled = True Auto

Event OnInit()
    Debug.Notification("[PCM] - Iniciado")

    Actor selfActor = GetTargetActor()
    if !selfActor
        return
    endif

    JFormDB.setFlt(selfActor, ".lath.debug.damage.value.third", 0.0)
    JFormDB.setFlt(selfActor, ".lath.debug.damage.value.second", 0.0)
    JFormDB.setFlt(selfActor, ".lath.debug.damage.value.last", 0.0)

    JFormDB.setFlt(selfActor, ".lath.debug.hp.value.third", 0.0)
    JFormDB.setFlt(selfActor, ".lath.debug.hp.value.second", 0.0)
    JFormDB.setFlt(selfActor, ".lath.debug.hp.value.last", 0.0)
EndEvent

Event OnEffectStart(Actor akTarget, Actor akCaster)
    ; Nada aqui. Apenas necessário para rodar OnHit.
EndEvent


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)
    float third_value = 0.0
    float second_value = 0.0
    float last_value = 0.0


    if !DebugEnabled
        return
    endif

    Actor selfActor = GetTargetActor()
    if !selfActor
        return
    endif

    third_value = JFormDB.getFlt(selfActor,".lath.debug.hp.value.third")
    second_value = JFormDB.getFlt(selfActor,".lath.debug.hp.value.second")
    last_value = JFormDB.getFlt(selfActor,".lath.debug.hp.value.last")

    ; -----------------------------------------------
    ; HP antes
    ; -----------------------------------------------
    float hp = selfActor.GetActorValue("Health")

    ;atualização das ultimas entradas
    JFormDB.setFlt(selfActor, ".lath.debug.hp.value.third", second_value)
    JFormDB.setFlt(selfActor, ".lath.debug.hp.value.second", last_value)
    JFormDB.setFlt(selfActor, ".lath.debug.hp.value.last", hp)

    float delta_hp = hp - last_value

    if delta_hp < -1.0 ;recebeu dano significativo
        Debug.Notification("Dano: " + Math.Floor(delta_hp))

        third_value = JFormDB.getFlt(selfActor,".lath.debug.damage.value.third")
        second_value = JFormDB.getFlt(selfActor,".lath.debug.damage.value.second")
        last_value = JFormDB.getFlt(selfActor,".lath.debug.damage.value.last")

        JFormDB.setFlt(selfActor, ".lath.debug.damage.value.third", second_value)
        JFormDB.setFlt(selfActor, ".lath.debug.damage.value.second", last_value)
        JFormDB.setFlt(selfActor, ".lath.debug.damage.value.last", delta_hp)

        float damage_variation = ( delta_hp / last_value ) * 100

        ;Debug.Notification("Variacao de: " + Math.Floor(damage_variation) + "%")
    endif

    

    
EndEvent
