Scriptname LATH_MGE_FireDesintegrate extends activemagiceffect  


import debug
import FormList

;======================================================================================;
;  PROPERTIES
;======================================================================================;

Float Property BurnDuration  Auto         ; tempo que o corpo “queima” antes de virar cinzas
EffectShader Property FireShader Auto         ; shader visual de fogo
EffectShader Property MagicEffectShader Auto         ; shader visual de fogo
Activator Property AshPileObject Auto         ; objeto Ash Pile
Bool Property bSetAlphaZero = True Auto       ; se true, corpo fica invisível no final
Bool Property bSetAlphaToZeroEarly = False Auto
FormList Property ImmunityList Auto           ; alvos imunes à desintegração
Float Property FadeStep = 0.05 Auto           ; decremento alpha por step
Float Property FadeDelay = 0.1 Auto           ; tempo entre passos de fade

;======================================================================================;
;  VARIABLES
;======================================================================================;

Actor Victim
Race VictimRace
Bool TargetIsImmune = True

;======================================================================================;
;  EVENTS
;======================================================================================;

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Victim = akTarget
    trace("Victim == " + Victim)
EndEvent

Event OnDying(Actor akKiller)
    if Victim == None
        return
    endif

    ; Checar imunidade
    TargetIsImmune = False
    if ImmunityList != None
        ActorBase VictimBase = Victim.GetBaseObject() as ActorBase
        VictimRace = VictimBase.GetRace()
        if ImmunityList.HasForm(VictimRace) || ImmunityList.HasForm(VictimBase)
            TargetIsImmune = True
        endif
    endif

    if TargetIsImmune
        return
    endif

    trace("Victim just died - starting burn sequence")

    ; Iniciar shader
    if FireShader != None
        FireShader.Play(Victim, BurnDuration)
    endif

    

    ; Fade gradual do corpo durante BurnDuration
    Float alpha = 1.0
    Float steps = BurnDuration / FadeDelay
    Float decrement = alpha / steps

    While alpha > 0.0
        Victim.SetAlpha(alpha, True)
        alpha -= decrement
        Utility.Wait(FadeDelay)

        if alpha == 0.8
            if	MagicEffectShader != none
			    MagicEffectShader.play(Victim, BurnDuration / 2.0)
		    endif
        endif
        if alpha == 0.7
            Victim.AttachAshPile(AshPileObject)
        endif

        if alpha == 0.5
            decrement = 0.1
        endif

        if alpha == 0.1
            decrement = 0.02
        endif

        if alpha < 0.05
            decrement = 0.01
        endif
    EndWhile

    ; Garantir corpo invisível no final
    if bSetAlphaZero
        Victim.SetAlpha(0.0, True)
    endif
    
    ; Parar shader
    if FireShader != None
        FireShader.Stop(Victim)
    endif

    if MagicEffectShader != None
        MagicEffectShader.Stop(Victim)
    endif

    
    

    ; Finalizar CriticalStage
    Victim.SetCriticalStage(Victim.CritStage_DisintegrateEnd)
EndEvent