Scriptname LATH_CreateUndead_Requirements extends ActiveMagicEffect  

Ingredient Property RequiredIngredient Auto ;bone meal
SoulGem Property RequiredSoulGem Auto
Int Property SoulGemCost Auto
Int Property IngredientCost Auto

;Float Property HPPernality Auto
;Float appliedFlatHP = 0.0

Event OnEffectStart(Actor akTarget, Actor akCaster)

    if akCaster.GetItemCount(RequiredSoulGem) < SoulGemCost
        Debug.Notification("You need " + SoulGemCost + " " + RequiredSoulGem.GetName() + " filled with a soul.")
        
        akCaster.InterruptCast()
        Dispel()
        return
    endif

    if akCaster.GetItemCount(RequiredIngredient) < IngredientCost 
                Debug.Notification("You need " + IngredientCost + " " + RequiredIngredient.GetName())
        akCaster.InterruptCast()
        Dispel()
        return
    endif

    akCaster.RemoveItem(RequiredIngredient, IngredientCost, true)
    akCaster.RemoveItem(RequiredSoulGem, SoulGemCost, true)


    ;------------------------------
    ; HP
    ;------------------------------
;    Float baselineHP = akTarget.GetBaseActorValue("Health")
;    appliedFlatHP = HPPernality

 ;   akTarget.ModActorValue("Health", -appliedFlatHP)


EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado

    ;akTarget.ModActorValue("Health", appliedFlatHP)

    ; Reset variáveis
    ;appliedFlatHP = 0.0


EndEvent