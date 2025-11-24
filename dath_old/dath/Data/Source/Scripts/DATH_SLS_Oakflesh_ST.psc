Scriptname DATH_SLS_Oakflesh_ST extends ObjectReference  


Event OnRead()
    Actor PlayerRef = Game.GetPlayer()

    if !PlayerRef 
        return
    endif

    ; Ler os valores imediatamente
    ;String readEditor = JFormDB.getStr(PlayerRef, ".dath.sls.spells.oakflesh.editor_id")
    ;Float readHours = JFormDB.getFlt(PlayerRef, ".dath.sls.spells.oakflesh.study_hours")

    ;id usado no JFormDB
    String spell_id = "oakflesh"
    ;nome usado em mensagens para o usuario
    String spell_name = "Oakflesh"
    ;FormId da magia
    Int spell_form_id = 0x05ad5c
    ;Arquivo esm/esp/esl onde a magia está definida
    String master_file = "Skyrim.esm"

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
    String desc_required_soul_gem = "uma pequenina pedra de alma vazia" 

    ;definição de variaveis de misc items
    bool use_misc_item = true
    int misc_item_form_id = 0x06f993 
    int misc_item_amount = 1
    String desc_required_misc_item = "um pedaço de madeira" 

    ;definição de ingredientes alquimicos
    bool use_ingredient = false
    int ingredient_form_id = 0x000000 
    int ingredient_amount = 1
    String desc_required_ingredient = "" 

    ;encontrado em Special Effect-> ImageSpace Modifier
    ImageSpaceModifier  FadeToBlackBackImod = Game.GetFormFromFile(0x0f756f, master_file) as ImageSpaceModifier
    ImageSpaceModifier  FadeToBlackImod = Game.GetFormFromFile(0x0f756d, master_file) as ImageSpaceModifier 
    ImageSpaceModifier  FadeToBlackHoldImod  = Game.GetFormFromFile(0x0f756e, master_file) as ImageSpaceModifier

    ;encontrado em Miscellaneous -> Idlle Marker
    Idle  IdleBook_Reading = Game.GetFormFromFile(0x0bb052, master_file) as Idle
    Idle  IdleBookSitting_Reading = Game.GetFormFromFile(0x03505c, master_file) as Idle
    Idle  IdleBook_TurnManyPages = Game.GetFormFromFile(0x0bb053, master_file) as Idle
    Idle  IdleBookSitting_TurnManyPages = Game.GetFormFromFile(0x03505d, master_file) as Idle
    Idle  IdleStop_Loose = Game.GetFormFromFile(0x10d9ee, master_file) as Idle

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

    ;para pegar o FORMID pelo CK, exclua os 2 primeiros digitos
    ;ex: se no CK estiver 0205ab45, entao o codigo será: 05ab45
    Spell learning_spell = Game.GetFormFromFile(spell_form_id, master_file) as Spell
    
    ;[APENAS PARA TESTE]verificar se Game.GetFormFile traz a referencia correta da spell
    ;String spell_name_test = learning_spell.GetName()
    ;Debug.Notification("Nome da magia: " + spell_name_test)

    ;Check if player knows the spell
	if (Game.GetPlayer().HasSpell(learning_spell))
			Debug.Notification("Voce sabe conjurar " + spell_name)
            
            ; Mostra apenas informações estáticas que podemos acessar via script
            ;String msg = "Efeito: Aumenta a defesa física."
            ;Debug.MessageBox(msg)
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

    float next_class_allowed = JFormDB.getFlt(PlayerRef, ".dath.sls.fatigue.next_class_allowed")

    ; inicializa se ainda não houver valor ou for inválido
    If next_class_allowed < 0.0
        next_class_allowed = 0.0
        JFormDB.setFlt(PlayerRef, ".dath.sls.fatigue.next_class_allowed", next_class_allowed)
    EndIf

    ;verifica o progresso atual de aprendizado
    float current_spell_progress = JFormDB.getFlt(PlayerRef,".dath.sls.spells." + spell_id + ".progress")

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
        Debug.Notification("Progresso total: " + Math.Floor( current_spell_progress * 100.0) + "%")
        return
    endif

    ;=========================================================
    ;VERIFICAR ITEMS
    ;========================================================

    if use_soul_gem

        SoulGem required_soul_gem = Game.GetFormFromFile(soul_gem_form_id, master_file) as SoulGem
         if (PlayerRef.GetItemCount(required_soul_gem) < soul_gem_amount)
            Debug.Notification("Voce precisa de " + desc_required_soul_gem + " para iniciar o estudo.")
            return
         endif
    endif

    if use_misc_item

        MiscObject required_misc_item = Game.GetFormFromFile(misc_item_form_id, master_file) as MiscObject
         if (PlayerRef.GetItemCount(required_misc_item) < misc_item_amount)
            Debug.Notification("Voce precisa de " + desc_required_misc_item + " para iniciar o estudo.")
            return
         endif
    endif

    if use_ingredient

        Ingredient required_ingredient = Game.GetFormFromFile(ingredient_form_id, master_file) as Ingredient
         if (PlayerRef.GetItemCount(required_ingredient) < ingredient_amount)
            Debug.Notification("Voce precisa de " + desc_required_ingredient + " para iniciar o estudo.")
            return
         endif
    endif


    ; === Consumir ===
    if use_soul_gem
        SoulGem required_soul_gem = Game.GetFormFromFile(soul_gem_form_id, master_file) as SoulGem
        PlayerRef.RemoveItem(required_soul_gem, soul_gem_amount, True)
    endif
    if use_misc_item
        MiscObject required_misc_item = Game.GetFormFromFile(misc_item_form_id, master_file) as MiscObject
        PlayerRef.RemoveItem(required_misc_item, misc_item_amount, True)
    endIf
    if use_ingredient
        Ingredient required_ingredient = Game.GetFormFromFile(ingredient_form_id, master_file) as Ingredient
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


 
    ;mas o progresso real é um numero randomico entre 1 e 2
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
            Keyword LocTypePlayerHouse = Game.GetFormFromFile(0x0fc1a3, "Skyrim.esm") as Keyword
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
    MagicEffect WellRestedEffect = Game.GetFormFromFile(0x10d96b, "Skyrim.esm") as MagicEffect

    if PlayerRef.HasMagicEffect(WellRestedEffect)
        bonus_time_sum += 0.1

        ;Debug.Notification("Bem Descansado")
    endif
    
    
    ;Debug.Notification("Bonus: " + (bonus_time_sum * 100) + "%")

    ;o ganho real é um numero aleatorio somado aos bonus(winterhold, bem-alimentado, bem-descansado, dia, noite, etc)
    ;o valor é uma fraçao entre 0 e 1 que representa uma porcentagem entre 0 e 100%
    float progress_gain = (study_progress * bonus_time_sum)/base_study_hours

    ;Debug.Notification("Progresso: " + Math.Floor(progress_gain * 100.0) + "%")

    ;float cooldownNextTimeLesson = studyHours * 2.0
    ; o player deve esperar um dia para estudar denovo. Incetiva a exploração e progressao no game
    ;enquanto espera o cooldown passar
    float base_cooldown = 24.0 + Utility.RandomInt(1, 2)

    
    
    ;calcula a data permite para a proxima lição no tempo de tamriel
    ;na verdade, definimos o cooldown padrão em 24horas de tempo in-game

    next_class_allowed = current_tamriel_time + base_cooldown / 24.0
    JFormDB.setFlt(PlayerRef, ".dath.sls.fatigue.next_class_allowed", next_class_allowed)

    ;Debug.Notification("Proxima aula em: " + Math.Floor( (next_class_allowed - current_tamriel_time) * 24.0 ) + " horas")
    Debug.Notification("Estudar consumiu sua energia. Você poderá estudar novamente amanhã.") 
    
    ;progress é um valor entre 0.0 e 1.0 onde 1.0 indica 100%
    ;current_progress = JFormDB.getFlt(PlayerRef,".dath.sls.spells." + spell_id + ".progress")
    float new_progress = current_spell_progress + progress_gain

    if new_progress > 1.0 
        new_progress = 1.0
    endif

    Debug.Notification("Progresso: " + Math.Floor( new_progress * 100.0) + "%")
    
    ;Fade back in again
	FadeToBlackBackImod.Apply()
	FadeToBlackHoldImod.Remove()
	PlayerRef.PlayIdle(IdleStop_Loose)
    Utility.Wait(1.0)
    ; Reativa controles
    Game.EnablePlayerControls()

    ;verifica se o progresso total de horas é maior ou igual ao tempo de estudo necessário
    if new_progress >= 1.0
            PlayerRef.AddSpell(learning_spell)

            Debug.Notification("Você finalmente compreendeu as runas e diagramas...")
            Debug.Notification("E agora sabe conjurar " + spell_name + "...")
            JFormDB.setFlt(PlayerRef,".dath.sls.spells." + spell_name + ".progress", 1.0)
    else 
        JFormDB.setFlt(PlayerRef,".dath.sls.spells." + spell_name + ".progress", new_progress)
    endif

EndEvent

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