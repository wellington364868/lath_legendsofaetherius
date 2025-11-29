Scriptname LATH_SLS_SpellTomeFrostbite extends ObjectReference  

Event OnRead()
    Actor PlayerRef = Game.GetPlayer()

    if !PlayerRef 
        return
    endif

    ;obtem o form id da spell de acordo com o tier de upgrade atual
    ;Int spell_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + current_spell_tier + ".form_id")
    ;Arquivo esm/esp/esl onde a magia está definida
    String skyrim_file = "Skyrim.esm"
    ;Arquivo .esp DATH
    String lath_file = "LATH_LegendsOfAetherius.esp"

     ;id usado no JFormDB
    String spell_id = "frostbite"

    bool can_study = false

    ;para pegar o FORMID pelo CK, exclua os 2 primeiros digitos
    ;ex: se no CK estiver 0205ab45, entao o codigo será: 05ab45
    Spell learning_spell = none

    ;tier atual da magia
    Int current_spell_tier = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.current")
    ;tier maximo disponivel para upgrade
    Int max_spell_tier = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.max")



    int base_spell_form_id = 0
    string tier_key = ""

    ;0 - sem definicao de tier
    ;1 - novice
    ;2 - apprentice
    ;3 - adept
    ;4 - expert
    ;5 - master
    if current_spell_tier == 1
       base_spell_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".1.form_id")

       learning_spell = Game.GetFormFromFile(base_spell_form_id, skyrim_file) as Spell


    elseif current_spell_tier == 2
       base_spell_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".2.form_id")

       learning_spell = Game.GetFormFromFile(base_spell_form_id, lath_file) as Spell

    elseif current_spell_tier == 3 
       base_spell_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".3.form_id")
    
       ;o form_id de Embers está definido em LATH
       learning_spell = Game.GetFormFromFile(base_spell_form_id, lath_file) as Spell
    endif 

    ;se o player ja sabe a spell
    if PlayerRef.HasSpell(learning_spell)
        ;o tier de aprendizado é aumentado em 1
        current_spell_tier = current_spell_tier + 1
    endif

    ;se a spell ainda permite upgrade
    if current_spell_tier <= max_spell_tier
        can_study = true

    else 
        Debug.Notification("Você já sabe tudo o que é possivel saber sobre " + spell_id)
        return 
    endif
 
    Debug.Notification("current_spell_tier: " + current_spell_tier)

    ;nome usado em mensagens para o usuario
    String spell_name = JFormDB.getStr(PlayerRef, ".lath.sls.spells." + spell_id + ".name")
    

    
    ;Check if player has Max Magicka requiriment
    ;Novice - 80
    ;Apprentice - 120 a 160
    ;Adept - 180 a 250
    ;Expert - 400(???)
    ;Master - 600(???)
    ; Obtém o máximo de Magicka atual do jogador (incluindo buffs e equipamentos)
    Float player_max_magicka = PlayerRef.GetActorValue("Magicka")

    float required_magicka = JFormDB.getFlt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".required_magicka")

    if required_magicka > player_max_magicka
        Debug.Notification("você precisa ter pelo menos " + Math.Floor(required_magicka) + " magicka")
        return
    endif

    ;definição de variaveis de soul gems
    Int use_soul_gem = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".material.soulgem.use")
    int soul_gem_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".material.soulgem.form_id") 
    int soul_gem_amount = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".material.soulgem.amount")
    ;String desc_required_soul_gem = "petty soul gem(empty)" 

    ;definição de variaveis de item (encotrado em miscitem)
    Int use_misc_item = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".material.item.use")
    int misc_item_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".material.item.form_id")
    int misc_item_amount = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".material.item.amount")
    ;String desc_required_misc_item = "charcoal" 

    ;definição de ingredientes alquimicos
    Int use_ingredient = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".material.ingredient.use")
    int ingredient_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".material.ingredient.form_id")
    int ingredient_amount = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + current_spell_tier + ".material.ingredient.amount")
    ;String desc_required_ingredient = "" 

    ;encontrado em Special Effect-> ImageSpace Modifier
    ImageSpaceModifier  FadeToBlackBackImod = Game.GetFormFromFile(0x0f756f, skyrim_file) as ImageSpaceModifier
    ImageSpaceModifier  FadeToBlackImod = Game.GetFormFromFile(0x0f756d, skyrim_file) as ImageSpaceModifier 
    ImageSpaceModifier  FadeToBlackHoldImod  = Game.GetFormFromFile(0x0f756e, skyrim_file) as ImageSpaceModifier

    ;encontrado em Miscellaneous -> Idlle Marker
    Idle  IdleBook_Reading = Game.GetFormFromFile(0x0bb052, skyrim_file) as Idle
    Idle  IdleBookSitting_Reading = Game.GetFormFromFile(0x03505c, skyrim_file) as Idle
    Idle  IdleBook_TurnManyPages = Game.GetFormFromFile(0x0bb053, skyrim_file) as Idle
    Idle  IdleBookSitting_TurnManyPages = Game.GetFormFromFile(0x03505d, skyrim_file) as Idle
    Idle  IdleStop_Loose = Game.GetFormFromFile(0x10d9ee, skyrim_file) as Idle

    bool has_night_bonus = false 
    bool has_day_bonus = false
    bool has_clear_weather_bonus = false
    bool has_rainy_weather_bonus = false
    bool has_snow_weather_bonus = true   
    
    ;Check if player is in combat
	if (PlayerRef.IsInCombat())
		Debug.Notification("Voce nao pode estudar em combate")
        return
    endif

    ; Verifica se o jogador está nadando
    If PlayerRef.IsSwimming()
        Debug.Notification("Você não pode estudar enquanto está nadando.")
        Return
    EndIf

        ; Verifica se o jogador está nadando
    If PlayerRef.IsOnMount()
        Debug.Notification("Você não pode estudar enquanto está em uma montaria.")
        Return
    EndIf

        ; Verifica se o jogador está nadando
    If PlayerRef.IsFlying()
        Debug.Notification("Você não pode estudar enquanto está voando.")
        Return
    EndIf

    ; Checa se o jogador está invadindo área privada
    If PlayerRef.IsTrespassing()
        Debug.Notification("Você não pode estudar magia em propriedades alheias sem permissão.")
        Return
    EndIf

    ;se o spellId não estiver definido
    If spell_id == ""
        Debug.Notification("Erro: Spell ID vazio")
        Return
    EndIf

    if can_study
        float next_class_allowed = JFormDB.getFlt(PlayerRef, ".lath.sls.fatigue.next_class_allowed")

        ; inicializa se ainda não houver valor ou for inválido
        If next_class_allowed < 0.0
            next_class_allowed = 0.0
            JFormDB.setFlt(PlayerRef, ".lath.sls.fatigue.next_class_allowed", next_class_allowed)
        EndIf

        ;verifica o progresso atual de aprendizado. 
        ;IMPORTANTE: deve ser resetada ao subir de tier
        float current_spell_progress = JFormDB.getFlt(PlayerRef, ".lath.sls.spells." + spell_id +  ".study.current_progress")   
        ;obtem o total de horas necessarias para aprender a magia
        ;este valor é fixo em qualquer upgrade
        float graduate = JFormDB.getFlt(PlayerRef, ".lath.sls.spells." + spell_id +  ".study.graduate")

        if(current_spell_progress < 0.0)
            current_spell_progress = 0.0
        endif

        ;obtem a hora atual in-game
        float current_tamriel_time = Utility.GetCurrentGameTime()

        if current_tamriel_time < next_class_allowed

            float rest_time = Math.Floor( (next_class_allowed - current_tamriel_time) * 24.0) + 1
        
            ; --- obtém a hora do dia ---
            float current_hour = (current_tamriel_time - Math.Floor(current_tamriel_time)) * 24.0  ; hora do dia 0-24
        

            if rest_time > 48.0
                Debug.Notification("Você precisa de pelo menos tres dias de descanso.")
            elseif rest_time > 24.0
                Debug.Notification("Você precisa de pelo menos dois dias de descanso.")
            elseif rest_time > 12.0
                Debug.Notification("Você precisa de pelo menos um dia de descanso.")
            else 
                if rest_time > 5
                    Debug.Notification("Em algumas horas sua mente terá se recuperado.")
                elseif rest_time > 1
                    Debug.Notification("Talvez em " + Math.Floor(rest_time)  + " horas você esteja pronto para continuar.")
                else 
                    Debug.Notification("Em 1 hora você estará plenamente disposto.")
                endif
            endif 
            
            Debug.Notification("Progresso do estudo: " + Math.Floor( (current_spell_progress/graduate) * 100) + "%")
            return
        endif

        ;=========================================================
        ;VERIFICAR ITEMS
        ;========================================================

        if use_soul_gem

            SoulGem required_soul_gem = Game.GetFormFromFile(soul_gem_form_id, skyrim_file) as SoulGem
            if (PlayerRef.GetItemCount(required_soul_gem) < soul_gem_amount)
                Debug.Notification("Voce precisa de " + required_soul_gem.GetName() + " para iniciar o estudo.")
                return
            endif
        endif

        if use_misc_item

            MiscObject required_misc_item = Game.GetFormFromFile(misc_item_form_id, skyrim_file) as MiscObject
            if (PlayerRef.GetItemCount(required_misc_item) < misc_item_amount)
                Debug.Notification("Voce precisa de " + required_misc_item.GetName() + " para iniciar o estudo.")
                return
            endif
        endif

        if use_ingredient

            Ingredient required_ingredient = Game.GetFormFromFile(ingredient_form_id, skyrim_file) as Ingredient

            if (PlayerRef.GetItemCount(required_ingredient) < ingredient_amount)
                Debug.Notification("Voce precisa de " + required_ingredient.GetName() + " para iniciar o estudo.")
                return
            endif
        endif

        ; === Consumir ===
        if use_soul_gem == 1 ;0: FALSE, 1: TRUE
            SoulGem required_soul_gem = Game.GetFormFromFile(soul_gem_form_id, skyrim_file) as SoulGem
            PlayerRef.RemoveItem(required_soul_gem, soul_gem_amount, True)
        endif
        if use_misc_item == 1 ;0: FALSE, 1: TRUE
            MiscObject required_misc_item = Game.GetFormFromFile(misc_item_form_id, skyrim_file) as MiscObject
            PlayerRef.RemoveItem(required_misc_item, misc_item_amount, True)
        endIf
        if use_ingredient == 1 ;0: FALSE, 1: TRUE
            Ingredient required_ingredient = Game.GetFormFromFile(ingredient_form_id, skyrim_file) as Ingredient
            PlayerRef.RemoveItem(required_ingredient, ingredient_amount, True)
        endIf


        Debug.Notification("As runas antigas emitem um brilho suave...")

        if (current_spell_progress * 100) < 25.0
            Debug.Notification("Simbolos desconexos se embaralham...")
        elseif (current_spell_progress * 100) < 60.0
            Debug.Notification("Simbolos começam a fazer sentido...")
        else 
            Debug.Notification("Você sente uma estranha energia fluir pelo seu corpo...")
        endif

        ;==============================================================
        ;ANIMAÇÕES DE ESTUDO
        ;==============================================================
        ; Desativa controles durante a animação
        Game.DisablePlayerControls()
        Game.ForceThirdPerson()

        if PlayerRef.GetSitState() >= 3
            PlayerRef.PlayIdle(IdleBookSitting_Reading)
            Utility.Wait(3.0)
            PlayerRef.PlayIdle(IdleBookSitting_TurnManyPages)
            Utility.Wait(4.0)
            PlayerRef.PlayIdle(IdleBookSitting_Reading)
            Utility.Wait(1.0)
        else
            PlayerRef.PlayIdle(IdleBook_Reading)
            Utility.Wait(3.0)
            PlayerRef.PlayIdle(IdleBook_TurnManyPages)
            Utility.Wait(4.0)
            PlayerRef.PlayIdle(IdleBook_Reading)
            Utility.Wait(1.0)
        endif

        ; Fade para efeito visual
        FadeToBlackImod.Apply()
        Utility.Wait(2.5)
        FadeToBlackHoldImod.Apply()

        float min_progress = JFormDB.getFlt(Game.GetPlayer(), ".lath.sls.spells." + spell_id + ".study.min_progress")
        float max_progress = JFormDB.getFlt(Game.GetPlayer(), ".lath.sls.spells." + spell_id + ".study.max_progress")
        ;o progresso real é um numero aleatorio entre min_progress e max_progress
        float study_progress = Utility.RandomFloat(min_progress, max_progress)

        ;bonus de tempo
        float study_bonus_mult = 1.0;

        if IsInApocrypha()
            ;Debug.Notification("Apocrypha")
            study_bonus_mult = study_bonus_mult + 1.0
        else 
            ; --- Bônus por localização ---
            ; exemplo: Winterhold dá +15%
            if IsInWinterhold()
                ;Debug.Notification("Winterhold")
                study_bonus_mult = study_bonus_mult + 0.3
            else
                ;Check if player is in an inn or an owned home
                ;encontrado em Miscellaneous->Keyword
                Keyword LocTypePlayerHouse = Game.GetFormFromFile(0x0fc1a3, skyrim_file) as Keyword
	            if PlayerRef.GetCurrentLocation().HasKeyword(LocTypePlayerHouse)
		            ;Debug.Notification("Playerhouse")
                    study_bonus_mult = study_bonus_mult + 0.1
                endif
	        endIf

            ; --- Bônus por hora do dia (noite) ---
            float current_time = Utility.GetCurrentGameTime()  ; dias decimais
            float current_hour = (current_time - Math.Floor(current_time)) * 24.0  ; hora do dia 0-24

            ;Debug.Notification("hora do dia: " + current_hour)
            if has_night_bonus 
                if ((current_hour >= 20.0  && current_hour <=24.0) || (current_hour >=0 && current_hour <= 4.0) )
                    ;Debug.Notification("Noite")
                    study_bonus_mult += 0.1
                endif
            endif

            if has_day_bonus
                if(current_hour >= 6.0 && current_hour <= 18.0)
                    ;Debug.Notification("Dia")
                    study_bonus_mult = study_bonus_mult + 0.1
            
                endif
            endif

            int current_weather = GetCurrentWeatherType()

            if has_clear_weather_bonus
                ;Debug.Notification("Sunny")
                if current_weather == 0
                    study_bonus_mult = study_bonus_mult + 0.1
                endif
                
            elseif has_rainy_weather_bonus 
                ;Debug.Notification("Rainy")
                if current_weather == 2  || current_weather == 4
                    study_bonus_mult = study_bonus_mult + 0.1
                endif
                
            elseif has_snow_weather_bonus 
                ;Debug.Notification("Snow")
                if current_weather == 3 || current_weather == 5
                    study_bonus_mult = study_bonus_mult + 0.1
                endif
                
            endif 

        endif

        ; --- Bônus por estado do jogador ---
        ; Bem descansado +5%
        MagicEffect WellRestedEffect = Game.GetFormFromFile(0x10d96b, skyrim_file) as MagicEffect

        if PlayerRef.HasMagicEffect(WellRestedEffect)
            study_bonus_mult = study_bonus_mult + 0.1

            ;Debug.Notification("Bem Descansado")
        endif

        ;o ganho real é um numero aleatorio mutiplicado pelo somatorio dos bonus(winterhold, bem-alimentado, bem-descansado, dia, noite, etc)
        float progress_gain = study_progress * study_bonus_mult    
        
        ;Debug.Notification("Progresso: " + Math.Floor(progress_gain * 100.0) + "%")

        ;float cooldownNextTimeLesson = studyHours * 2.0
        ; o player deve esperar um dia para estudar denovo. Incetiva a exploração e progressao no game
        ;enquanto espera o cooldown passar
        float base_cooldown = 0.0

        if current_spell_tier <= 1
            base_cooldown = 20.0
        elseif current_spell_tier == 2 ;1 dia
            base_cooldown = 20.0
        elseif current_spell_tier == 3 ;2 dias
            base_cooldown = 44.0
        elseif current_spell_tier == 4; 2 dias
            base_cooldown = 44.0
        elseif current_spell_tier == 5 ;3dias
            base_cooldown = 68.0
        endif

        base_cooldown = base_cooldown + Utility.RandomInt(1, 4)

        ;calcula a data permite para a proxima lição no tempo de tamriel
        ;o dias in-game são numeros fracionados ounde 1.0 representa 24h
        next_class_allowed = current_tamriel_time + base_cooldown / 24.0
        JFormDB.setFlt(PlayerRef, ".lath.sls.fatigue.next_class_allowed", next_class_allowed)

        ;Debug.Notification("Estudar cansou sua mente, talvez deva estudar novamente amanhã...") 
    
        ;soma o progresso ganho nessa sessão de estudos ao que ja tinha antes
        float new_progress = current_spell_progress + progress_gain


        ;Fade back in again
	    FadeToBlackBackImod.Apply()
	    FadeToBlackHoldImod.Remove()
	    PlayerRef.PlayIdle(IdleStop_Loose)
        Utility.Wait(1.0)
        ; Reativa controles
        Game.EnablePlayerControls()

        if new_progress >= graduate
            new_progress = graduate

            Debug.Notification("Você finalmente compreendeu as runas e diagramas...")
            Debug.Notification("E agora sabe como usar " + spell_name + "...")
            
            ;reseta o progresso
            JFormDB.setFlt(PlayerRef, ".lath.sls.spells." + spell_id + ".study.current_progress", 0.0)

            if current_spell_tier == 1
                Int new_spell_id =  JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".1.form_id")
                Debug.Notification("spell form_id: " + new_spell_id)
                Spell spell_to_add = Game.GetFormFromFile(new_spell_id, skyrim_file) as Spell 
                
                Debug.Notification("spell to add: " + spell_to_add.GetName())
                PlayerRef.AddSpell(spell_to_add)

                ;aumenta o tier da magia
                JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.current", 2) ;apprentice
            elseif current_spell_tier == 2
                ;remove a magia novice, apos ter adicionado a magia apprentice
                Int spell_to_remove_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".1.form_id")
                Spell spell_to_remove = Game.GetFormFromFile(spell_to_remove_id, skyrim_file) as Spell 
                Debug.Notification("spell to remove: " + spell_to_remove.GetName())
                PlayerRef.RemoveSpell(spell_to_remove)

                Int new_spell_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".2.form_id")
                Spell spell_to_add = Game.GetFormFromFile(new_spell_id, lath_file) as Spell 
                                
                PlayerRef.AddSpell(spell_to_add)

                ;aumenta o tier da magia - adept
                JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.current", 3);adept

            elseif current_spell_tier == 3
                ;remove a magia LATH versao apprentice, apos ter adicionado a magia DATH versao adept
                Int spell_to_remove_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".2.form_id") ;apprentice
                Spell spell_to_remove = Game.GetFormFromFile(spell_to_remove_id, lath_file) as Spell 
                PlayerRef.RemoveSpell(spell_to_remove)

                Int new_spell_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".3.form_id")
                Spell spell_to_add = Game.GetFormFromFile(new_spell_id, lath_file) as Spell 
                        
                PlayerRef.AddSpell(spell_to_add)
            endif

        else 
            JFormDB.setFlt(PlayerRef, ".lath.sls.spells." + spell_id + ".study.current_progress", new_progress)
        endif
  
        Debug.Notification("Progresso: " + Math.Floor( (new_progress /graduate) * 100) + "%")

    endif

EndEvent

;==================================================================
;WorldData -> Location
Bool Function IsInApocrypha()
    Actor PlayerRef = Game.GetPlayer()
    If !PlayerRef
        return false
    EndIf

    ; FormID de Apocrypha no DLC2Dragonborn.esm
    Int apocryphaFormID = 0x016e2b
    Location apocrypha = Game.GetFormFromFile(apocryphaFormID, "DLC2Dragonborn.esm") as Location

    ; Checa se o jogador está na Apocrypha
    return (PlayerRef.IsInLocation(apocrypha))
EndFunction

Bool Function IsInWinterhold()
    Actor PlayerRef = Game.GetPlayer()
    If !PlayerRef
        return false
    EndIf

    ; FormID de Winterhold WorldSpace no Skyrim.esm 
    Int winterholdFormID = 0x076f3a  ; 
    Location winterhold = Game.GetFormFromFile(winterholdFormID, "Skyrim.esm") as Location

    ; Checa se o jogador está em Winterhold
    return (PlayerRef.IsInLocation( winterhold) )
EndFunction

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
