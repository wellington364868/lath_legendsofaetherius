Scriptname DATH_SLS_Frostbite_ST extends ObjectReference  


Event OnRead()

    Actor PlayerRef = Game.GetPlayer()

    if !PlayerRef 
        return
    endif

    ;id usado no JFormDB
    String spell_id = "frostbite"
    ;tier atual da magia
    String current_spell_tier = JFormDB.getStr(PlayerRef, ".dath.sls.spells." + spell_id + ".tier.current")
    ;nome usado em mensagens para o usuario
    String spell_name = JFormDB.getStr(PlayerRef, ".dath.sls.spells." + spell_id + ".name")
    ;FormId da magia
    Int spell_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + current_spell_tier + ".form_id")
    ;Arquivo esm/esp/esl onde a magia está definida
    String skyrim_file = "Skyrim.esm"
    ;Arquivo .esp DATH
    String dath_file = "DATH_DawnOfAetherius.esp"

    ;Check if player has Max Magicka requiriment
    ;Novice - 80
    ;Apprentice - 160
    ;Adept - 280
    ;Expert - 400
    ;Master - 800
    ; Obtém o máximo de Magicka atual do jogador (incluindo buffs e equipamentos)
    Float player_magicka_max = PlayerRef.GetActorValue("Magicka")
    Float required_magicka = 80.0

    ;definição de variaveis de soul gems
    bool use_soul_gem = true
    int soul_gem_form_id = 0x02e4e2 
    int soul_gem_amount = 1
    String desc_required_soul_gem = "petty soul gem(empty)" 

    ;definição de variaveis de misc items
    bool use_misc_item = false
    int misc_item_form_id = 0x000000 
    int misc_item_amount = 1
    String desc_required_misc_item = "" 

    ;definição de ingredientes alquimicos
    bool use_ingredient = true
    int ingredient_form_id = 0x01b3bd 
    int ingredient_amount = 1
    String desc_required_ingredient = "snowberry" 

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

    bool has_night_bonus = true 
    bool has_day_bonus = true
    bool has_clear_weather_bonus = true
    bool has_rainy_weather_bonus = true
    bool has_snow_weather_bonus = true     

    ;o tempo de estudo é baseado no tier da magia
    ;tabela base
    ;novice     - 4h
    ;apprentice - 8h
    ;adept      - 12h
    ;expert     - 16h
    ;master     - 20h
    float base_study_hours = 4.0

    ;1- Novice
    ;2 - Apprentice
    ;3 - Adept
    ;4 - Expert
    ;5 - Master
    String base_spell_tier = "novice"

    bool can_study = false

    ;para pegar o FORMID pelo CK, exclua os 2 primeiros digitos
    ;ex: se no CK estiver 0205ab45, entao o codigo será: 05ab45
    Spell learning_spell = none

    ;Perk - Augumented Frost
    Perk  apprentice_upgrade_perk = Game.GetFormFromFile(0x0581ea, skyrim_file) as Perk

    ;Perk - Augumented Frost60
    Perk  adept_upgrade_perk = Game.GetFormFromFile(0x10fcf9, skyrim_file) as Perk


    if current_spell_tier == "novice"
        ;versao base definida em Skyrim.esm, por padrão pode estudar
        learning_spell = Game.GetFormFromFile(spell_form_id, skyrim_file) as Spell
        can_study = true
    elseif current_spell_tier == "apprentice"
        ;versao apprentice definida em DATH
        learning_spell = Game.GetFormFromFile(0x023f26, dath_file) as Spell

        ;se a perk necessaria estiver desbloqueada
        if PlayerRef.HasPerk(apprentice_upgrade_perk)
            can_study = true
        endif

    elseif current_spell_tier == "adept" 
        ;versao adept definida em DATH
        learning_spell = Game.GetFormFromFile(0x023f27, dath_file) as Spell
        
        ;se a perk necessaria estiver desbloqueada
        if PlayerRef.HasPerk(adept_upgrade_perk)
            can_study = true
        endif
    endif

    if PlayerRef.HasSpell(learning_spell)

        Debug.Notification("Voce sabe conjurar " + spell_name)
        Debug.Notification("Tier " + current_spell_tier)
        return 
     
    endif

        ; Checa se o jogador tem Magicka suficiente
    If player_magicka_max < required_magicka
        Debug.Notification("Você não possui energia arcana suficiente para aprender " + spell_name + ". (Requer: " + required_magicka + ")")
        Return
    EndIf

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
        Debug.Trace("Erro: Spell ID vazio")
        Return
    EndIf

    ;se o player tem a perk necessaria desbloqueada e se a magia alcançou o tier necessario
    ;a magia só mudará de tier na conclusao de um estudo. Ex: quando voce conclui o aprendizado da magia Novice,
    ;o current_tier da magia no JFormDB deve mudar de Novice para Apprentice
    ;ao abrir o livro novamente, ele verificará o tier e o requisito de perk e entao o estudo prossegue normalmente
    if can_study 
        float next_class_allowed = JFormDB.getFlt(PlayerRef, ".dath.sls.fatigue.next_class_allowed")

        ; inicializa se ainda não houver valor ou for inválido
        If next_class_allowed < 0.0
            next_class_allowed = 0.0
            JFormDB.setFlt(PlayerRef, ".dath.sls.fatigue.next_class_allowed", next_class_allowed)
        EndIf

        ;verifica o progresso atual de aprendizado
        float current_spell_progress = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + current_spell_tier + ".study.progress")
        ;obtem o total de horas necessarias para aprender a magia
        float graduate = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + current_spell_tier + ".study.graduate")


        if(current_spell_progress < 0.0)
            current_spell_progress = 0.0
        endif

        ;obtem a hora atual in-game
        float current_tamriel_time = Utility.GetCurrentGameTime()

        if current_tamriel_time < next_class_allowed

            float rest_time = Math.Floor( (next_class_allowed - current_tamriel_time) * 24.0) + 1
        
            ; --- obtém a hora do dia ---
            float current_hour = (current_tamriel_time - Math.Floor(current_tamriel_time)) * 24.0  ; hora do dia 0-24
        

            if rest_time > 12
                Debug.Notification("Você deve descansar até amanhã. Os estudos arcanos pesam sua mente.")
            else 
                if rest_time > 6
                    Debug.Notification("Você ainda se sente cansado mentalmente...")
                else
                    Debug.Notification("Em " + Math.Floor(rest_time)  + " horas você provavelmente estará bem disposto.")
                endif
            endif 
            Debug.Notification("Progresso total: " + Math.Floor( (current_spell_progress/graduate) * 100) + "%")
            return
        endif

        ;=========================================================
        ;VERIFICAR ITEMS
        ;========================================================

        if use_soul_gem

            SoulGem required_soul_gem = Game.GetFormFromFile(soul_gem_form_id, skyrim_file) as SoulGem
            if (PlayerRef.GetItemCount(required_soul_gem) < soul_gem_amount)
                Debug.Notification("Voce precisa de " + desc_required_soul_gem + " para iniciar o estudo.")
                return
            endif
        endif

        if use_misc_item

            MiscObject required_misc_item = Game.GetFormFromFile(misc_item_form_id, skyrim_file) as MiscObject
            if (PlayerRef.GetItemCount(required_misc_item) < misc_item_amount)
                Debug.Notification("Voce precisa de " + desc_required_misc_item + " para iniciar o estudo.")
                return
            endif
        endif

        if use_ingredient

            Ingredient required_ingredient = Game.GetFormFromFile(ingredient_form_id, skyrim_file) as Ingredient
            if (PlayerRef.GetItemCount(required_ingredient) < ingredient_amount)
                Debug.Notification("Voce precisa de " + desc_required_ingredient + " para iniciar o estudo.")
                return
            endif
        endif

        ; === Consumir ===
        if use_soul_gem
            SoulGem required_soul_gem = Game.GetFormFromFile(soul_gem_form_id, skyrim_file) as SoulGem
            PlayerRef.RemoveItem(required_soul_gem, soul_gem_amount, True)
        endif
        if use_misc_item
            MiscObject required_misc_item = Game.GetFormFromFile(misc_item_form_id, skyrim_file) as MiscObject
            PlayerRef.RemoveItem(required_misc_item, misc_item_amount, True)
        endIf
        if use_ingredient
            Ingredient required_ingredient = Game.GetFormFromFile(ingredient_form_id, skyrim_file) as Ingredient
            PlayerRef.RemoveItem(required_ingredient, ingredient_amount, True)
        endIf


        Debug.Notification("As runas antigas emitem um brilho suave...")

        if (current_spell_progress * 100) < 25.0
            Debug.Notification("Simbolos desconexos se embaralham...")
        else 
            Debug.Notification("Simbolos começam a fazer sentido...")
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

        ;o progresso real é um numero randomico entre 1 e 2
        float study_progress = Utility.RandomFloat(1.0, 2.0)

        ;bonus de tempo
        float bonus_time_sum = 1.0;

        if IsInApocrypha()
            ;Debug.Notification("Apocrypha")
            bonus_time_sum = bonus_time_sum + 1.0
        else 
            ; --- Bônus por localização ---
            ; exemplo: Winterhold dá +15%
            if IsInWinterhold()
                ;Debug.Notification("Winterhold")
                bonus_time_sum = bonus_time_sum + 0.3
            else
                ;Check if player is in an inn or an owned home
                ;encontrado em Miscellaneous->Keyword
                Keyword LocTypePlayerHouse = Game.GetFormFromFile(0x0fc1a3, skyrim_file) as Keyword
	            if PlayerRef.GetCurrentLocation().HasKeyword(LocTypePlayerHouse)
		            ;Debug.Notification("Playerhouse")
                    bonus_time_sum = bonus_time_sum + 0.1
                endif
	        endIf

            ; --- Bônus por hora do dia (noite) ---
            float current_time = Utility.GetCurrentGameTime()  ; dias decimais
            float current_hour = (current_time - Math.Floor(current_time)) * 24.0  ; hora do dia 0-24

            ;Debug.Notification("hora do dia: " + current_hour)
            if has_night_bonus 
                if ((current_hour >= 20.0  && current_hour <=24.0) || (current_hour >=0 && current_hour <= 4.0) )
                    ;Debug.Notification("Noite")
                    bonus_time_sum += 0.1
                endif
            endif

            if has_day_bonus
                if(current_hour >= 6.0 && current_hour <= 18.0)
                    ;Debug.Notification("Dia")
                    bonus_time_sum = bonus_time_sum + 0.1
            
                endif
            endif

            int current_weather = GetCurrentWeatherType()

            if has_clear_weather_bonus && current_weather == 0
                ;Debug.Notification("Sunny")
                bonus_time_sum = bonus_time_sum + 0.1
            elseif has_rainy_weather_bonus && current_weather == 2
                ;Debug.Notification("Rainy")
                bonus_time_sum = bonus_time_sum + 0.1
            elseif has_snow_weather_bonus && current_weather == 3
                ;Debug.Notification("Snow")
                bonus_time_sum = bonus_time_sum + 0.1
            endif 

        endif


        ; --- Bônus por estado do jogador ---
        ; Bem descansado +5%
        MagicEffect WellRestedEffect = Game.GetFormFromFile(0x10d96b, skyrim_file) as MagicEffect

        if PlayerRef.HasMagicEffect(WellRestedEffect)
            bonus_time_sum += 0.1

            ;Debug.Notification("Bem Descansado")
        endif

        ;o ganho real é um numero aleatorio mutiplicado pelo somatorio dos bonus(winterhold, bem-alimentado, bem-descansado, dia, noite, etc)
        float progress_gain = study_progress * bonus_time_sum

        ;Debug.Notification("Progresso: " + Math.Floor(progress_gain * 100.0) + "%")

        ;float cooldownNextTimeLesson = studyHours * 2.0
        ; o player deve esperar um dia para estudar denovo. Incetiva a exploração e progressao no game
        ;enquanto espera o cooldown passar
        float base_cooldown = 24.0 + Utility.RandomInt(1, 2)

        ;calcula a data permite para a proxima lição no tempo de tamriel
        ;o dias in-game são numeros fracionados ounde 1.0 representa 24h
        next_class_allowed = current_tamriel_time + base_cooldown / 24.0
        JFormDB.setFlt(PlayerRef, ".dath.sls.fatigue.next_class_allowed", next_class_allowed)

        Debug.Notification("Você sente a mente cansada, talvez deva estudar novamente amanhã...") 
    
        ;soma o progresso ganho nessa sessão de estudos ao que ja tinha antes
        float new_progress = current_spell_progress + progress_gain
        
        if new_progress > graduate 
            new_progress = graduate
        endif

        Debug.Notification("Progresso: " + Math.Floor( (new_progress /graduate) * 100) + "%")

        ;Fade back in again
	    FadeToBlackBackImod.Apply()
	    FadeToBlackHoldImod.Remove()
	    PlayerRef.PlayIdle(IdleStop_Loose)
        Utility.Wait(1.0)
        ; Reativa controles
        Game.EnablePlayerControls()


        ;verifica se o progresso total de horas é maior ou igual ao tempo de estudo necessário
        if new_progress >= graduate
            PlayerRef.AddSpell(learning_spell)

            Debug.Notification("Você finalmente compreendeu as runas e diagramas...")
            Debug.Notification("E agora sabe conjurar " + spell_name + "...")
            JFormDB.setFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + current_spell_tier + ".study.progress", new_progress)

            if current_spell_tier == "novice"
                ;aumenta o tier da magia
                JFormDB.setStr(PlayerRef, ".dath.sls.spells." + spell_id + ".tier.current", "apprentice")
                
            elseif current_spell_tier == "apprentice"
                ;aumenta o tier da magia
                JFormDB.setStr(PlayerRef, ".dath.sls.spells." + spell_id + ".tier.current", "adept")
                
                ;remove a frostbite vanilla, apos ter adicionado a frostbite apprentice
                Spell spell_to_remove = Game.GetFormFromFile(0x02b96b, skyrim_file) as Spell 
                PlayerRef.RemoveSpell(spell_to_remove)

            elseif current_spell_tier == "adept"
                ;remove a frostbite apprentice. Nao aumenta o tier, o maior upgrade possivel é "adept"
                Spell spell_to_remove = Game.GetFormFromFile(0x023f26, dath_file) as Spell 
                PlayerRef.RemoveSpell(spell_to_remove)
            endif 
        else 
            JFormDB.setFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + current_spell_tier + ".study.progress", new_progress)
        endif
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
