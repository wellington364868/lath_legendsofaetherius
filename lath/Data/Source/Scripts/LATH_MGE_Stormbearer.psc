Scriptname LATH_MGE_Stormbearer extends activemagiceffect  


;Augmented ranks
Perk Property Augmented_1 Auto 
Perk Property Augmented_2 Auto
Perk Property Augmented_3 Auto
Perk Property Augmented_4 Auto
Perk Property Augmented_5 Auto

Perk Property Weather_1 Auto
Perk Property Weather_2 Auto

Float Property BaseDamage Auto

;simulação de dano
;FinalDamage = BaseDamage * (1 + (DestructionSkill * 0.5) / 100) * (1 + Perks)


Event OnEffectStart(Actor akTarget, Actor akCaster)

    Actor PlayerRef = Game.GetPlayer()

    if !PlayerRef
        return
    endif

    int current_weather = GetCurrentWeatherType()
    if current_weather == 0
        Debug.Notification("Sunny")
    elseif current_weather == 1
        Debug.Notification("Cloudy")
    elseif current_weather == 2
        Debug.Notification("Rain")
    elseif current_weather == 3
        Debug.Notification("Snow")
    elseif current_weather == 4
        Debug.Notification("Storm")
    elseif current_weather == 5
        Debug.Notification("Blizzard")
    elseif current_weather == 6
        Debug.Notification("Fog")
    endif


    float weather_factor = 0.0

    if current_weather == 2
        if PlayerRef.HasPerk(Weather_2)
            weather_factor =  0.5
        elseif PlayerRef.HasPerk(Weather_1)
            weather_factor =  0.2
        endif

        
        Debug.Notification("bonus: " +  weather_factor)
    
    elseif current_weather == 4
        if PlayerRef.HasPerk(Weather_2)
            weather_factor =  0.6
        elseif PlayerRef.HasPerk(Weather_1)
            weather_factor =  0.3
        endif

        Debug.Notification("bonus: " +  weather_factor)
    endif

    ;em celulas interiores o bonus é mais fraco
    if PlayerRef.IsInInterior()
        if PlayerRef.HasPerk(Weather_2) ;bonus 25% mais fraco
            weather_factor =  weather_factor * 0.75
        elseif PlayerRef.HasPerk(Weather_1); bonua 50% mais fraco
            weather_factor =  weather_factor * 0.5
        endif
        Debug.Notification("Interior")
    endif

    Debug.Notification("weather bonus: " +  weather_factor)

    if weather_factor <= 0.0
        return
    endif

    float destruction_level = PlayerRef.GetActorValue("Destruction")
    float skillMult = 1.0 + (destruction_level * 0.5) / 100.0

    float perk_bonus = 0.0

    if PlayerRef.HasPerk(Augmented_5)
        perk_bonus = 1.0
    elseif PlayerRef.HasPerk(Augmented_4)
        perk_bonus = 0.8
    elseif PlayerRef.HasPerk(Augmented_3)
        perk_bonus = 0.6
    elseif PlayerRef.HasPerk(Augmented_2)
        perk_bonus = 0.4 
    elseif PlayerRef.HasPerk(Augmented_1)
        perk_bonus = 0.2
    endif

    float perkMult = 1.0 + perk_bonus


    Debug.Notification("Base=" + BaseDamage + " | SkillMult=" + skillMult + " | PerkMult=" + perkMult + " | WeatherMult=" +  weather_factor)


    float shock_resist = akTarget.GetAV("ResistShock")
    float magic_resist = akTarget.GetAV("ResistMagic")

    float shock_resist_mult =  (1.0 - (shock_resist / 100.0)) 
    float magic_resist_mult = (1.0 - (magic_resist / 100.0))
    ;Debug.Notification("fire res: " + fire_resist_mult + "," + "magic res:" + magic_resist_mult)

    ;float game_difficulty = Game.GetGameSettingFloat("iDifficulty")
    ;Debug.Notification("difficulty: " + game_difficulty)

    float final_damage = BaseDamage * skillMult * perkMult * weather_factor * shock_resist_mult * magic_resist_mult

    ;fator de aleatoriedade - ALTO
    ;RAIO: RANK1-> 35%   RANK2-> 20%

    float random_final_damage = 0.0
    if PlayerRef.HasPerk(Weather_2)
        random_final_damage = Utility.RandomFloat(final_damage * 0.80, final_damage)
    elseif PlayerRef.HasPerk(Weather_1)
        random_final_damage = Utility.RandomFloat(final_damage * 0.65, final_damage)
    endif

    akTarget.DamageActorValue("Health", random_final_damage)
    Debug.Notification("final damage: " + final_damage + "random final damage: " + random_final_damage)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    float third_value = 0.0
    float second_value = 0.0
    float last_value = 0.0

    Actor selfActor = Game.GetPlayer()
    if !selfActor
        return
    endif

    third_value = JFormDB.getFlt(selfActor,".lath.debug.target.hp.value.third")
    second_value = JFormDB.getFlt(selfActor,".lath.debug.target.hp.value.second")
    last_value = JFormDB.getFlt(selfActor,".lath.debug.target.hp.value.last")

    float target_hp = akTarget.GetActorValue("Health")

    ;atualização das ultimas entradas
    JFormDB.setFlt(selfActor, ".lath.debug.target.hp.value.third", second_value)
    JFormDB.setFlt(selfActor, ".lath.debug.target.hp.value.second", last_value)
    JFormDB.setFlt(selfActor, ".lath.debug.target.hp.value.last", target_hp)

    Float damageDealt = target_hp - last_value

        if damageDealt < -1.0 ;recebeu dano significativo
            Debug.Notification("Dano [RAIO]: " + Math.Floor(damageDealt))
        endif
EndEvent


Int Function GetCurrentWeatherType()
    Weather current_weather = Weather.GetCurrentWeather()

        if current_weather != None
            if current_weather.GetClassification() == 0
                ;Clear/sunny
                return 0
            elseif current_weather.GetClassification() == 1
                ;Cloudy
                return 1
            elseif current_weather.GetClassification() == 2
                ;Rain
                return 2
            elseif current_weather.GetClassification() == 3
                ;Snow
                return 3
            elseif current_weather.GetClassification() == 4
                ;Storm
                return 4
            elseif current_weather.GetClassification() == 5
                ;Blizzard
                return 5
            elseif current_weather.GetClassification() == 6
                ;Fog
                return 6
            endif
        endif


EndFunction