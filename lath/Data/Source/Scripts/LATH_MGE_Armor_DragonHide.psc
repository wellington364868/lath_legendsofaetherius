Scriptname LATH_MGE_Armor_DragonHide extends activemagiceffect  

;Dragon Hide concede:
;fire
;frost
;electric
;poison
;disease

Float Property FireResist Auto 
Float Property FrostResist Auto 
Float Property ElectricResist Auto 
Float Property PoisonResist Auto 
Float Property DiseaseResist Auto 

Float appliedFireResist = 0.0
Float appliedFrostResist = 0.0
Float appliedElectricResist = 0.0
Float appliedPoisonResist = 0.0
Float appliedDiseaseResist = 0.0

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
    appliedFireResist = FireResist
    appliedFrostResist = FrostResist
    appliedElectricResist = ElectricResist
    appliedPoisonResist = PoisonResist
    appliedDiseaseResist = DiseaseResist

    akTarget.ModActorValue("FireResist", appliedFireResist)
    akTarget.ModActorValue("FrostResist", appliedFrostResist)
    akTarget.ModActorValue("ElectricResist", appliedElectricResist)
    akTarget.ModActorValue("PoisonResist", appliedPoisonResist)
    akTarget.ModActorValue("DiseaseResist", appliedDiseaseResist)

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

    if akTarget == None
        return
    endif

    ; Remover exatamente o que foi aplicado
    akTarget.ModActorValue("FireResist", -appliedFireResist)
    akTarget.ModActorValue("FrostResist", -appliedFrostResist)
    akTarget.ModActorValue("ElectricResist", -appliedElectricResist)
    akTarget.ModActorValue("PoisonResist", -appliedPoisonResist)
    akTarget.ModActorValue("DiseaseResist", -appliedDiseaseResist)
 
    ; Reset variáveis
    appliedFireResist = 0.0
    appliedFrostResist = 0.0
    appliedElectricResist = 0.0
    appliedPoisonResist = 0.0
    appliedDiseaseResist = 0.0


EndEvent