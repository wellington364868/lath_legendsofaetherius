Scriptname LATH_MGE_FrostFreeze extends activemagiceffect  

; --------------------------------------------------------------------------------
; OBJETIVO: Implementa um efeito de estase rígida (congelamento total),
;           impedindo o alvo de mover, girar e planejar ações por completo.
;
; NOTA: A DURAÇÃO do efeito é definida no campo 'Duration' do Magic Effect no CK.
; --------------------------------------------------------------------------------

; Constante para zerar a energia de IA, impedindo o alvo de planejar ações (100% de redução)
Float Property AI_ENERGY_MODIFIER = -100.0 Auto ReadOnly


Event OnEffectStart(Actor akTarget, Actor akCaster)
 if !akTarget ; Garante que o alvo é válido
 return
 endif

    ; 1. CONGELAMENTO DE MOVIMENTO E ROTAÇÃO:
    ;    Impede que o ator mova ou gire (dá o aspecto de estátua rígida).
 akTarget.SetDontMove(True) 

    ; 2. RESTRIÇÃO DE AÇÕES:
    ;    Impede que o ator use certas habilidades ou ataques (camada de segurança).
 akTarget.SetRestrained(True) 

    ; 3. DESATIVAÇÃO DA IA (OPCIONAL, mas eficaz):
    ;    Zera a energia de IA para impedir que o NPC tente planejar o próximo movimento.
 akTarget.ModActorValue("AIEnergy", AI_ENERGY_MODIFIER) 
EndEvent


Event OnEffectFinish(Actor akTarget, Actor akCaster)
 if akTarget
        ; 1. LIBERA O MOVIMENTO E ROTAÇÃO
 akTarget.SetDontMove(False)

        ; 2. LIBERA A RESTRIÇÃO DE AÇÕES
 akTarget.SetRestrained(False)

        ; 3. RESTAURA A ENERGIA DE IA:
        ;    Remove o modificador de -100.0, aplicando o valor oposto (+100.0).
 akTarget.ModActorValue("AIEnergy", -AI_ENERGY_MODIFIER) 
 endif
EndEvent