Scriptname LATH_SLS_ConfigScript extends Quest  


Import JFormDB
Import Utility

Event OnInit()
    

    ; agendar fallback para garantir que PlayerRef esteja pronto
    RegisterForSingleUpdate(10.0)
EndEvent

Function InitQuest()
    Actor PlayerRef = Game.GetPlayer()
    ;variavel que guarda a data permitida para o proximo estudo
    JFormDB.setFlt(PlayerRef, ".lath.sls.fatigue.next_class_allowed", 0.0)
    
    ; Aqui começa o setup real
    ;Config_Oakflesh("oakflesh")
    
    Config_Embers(PlayerRef, "Embers")
    Config_Frostbite(PlayerRef, "Frostbite")
    Config_Sparks(PlayerRef, "Sparks")

    Config_Firebolt(PlayerRef, "Firebolt")


    Debug.Notification("[SLS] - Configurado")
EndFunction

Event OnUpdate()
    Actor PlayerRef = Game.GetPlayer()

    if !PlayerRef
        ; Player ainda não está pronto, tenta de novo em 10 segundos
        RegisterForSingleUpdate(10.0)
        return
    endif


    ; Chamada do fallback caso PlayerRef não estivesse pronto no OnInit
    InitQuest()

    Debug_Config("firebolt")

EndEvent

;=========================================================================


Function Set_Name(Actor PlayerRef,  String spell_id, String name)
    JFormDB.setStr(PlayerRef, ".lath.sls.spells." + spell_id + ".name", name)

EndFunction

Function Set_Tier_Base(Actor PlayerRef, String spell_id, int tier_base)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.base", tier_base)

EndFunction

Function Set_Tier_Current(Actor PlayerRef, String spell_id, int tier_current)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.current", tier_current)

EndFunction

Function Set_Tier_Max(Actor PlayerRef, String spell_id, int tier_max)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.max", tier_max)

EndFunction


;Ex de saida: .lath.sls.spells.oakflesh.study.graduate
Function Set_Study_Graduate(Actor PlayerRef, String spell_id, float graduate)
    JFormDB.setFlt(PlayerRef, ".lath.sls.spells." + spell_id + ".study.graduate", graduate)

EndFunction

;Ex de saida: .lath.sls.spells.oakflesh.study.progress
Function Set_Study_Current_Progress(Actor PlayerRef, String spell_id,  float progress)
    JFormDB.setFlt(PlayerRef, ".lath.sls.spells." + spell_id + ".study.current_progress", progress)

EndFunction

;Ex de saida: .lath.sls.spells.oakflesh.study.min_progress
Function Set_Study_Min_Progress(Actor PlayerRef, String spell_id,  float progress)
    JFormDB.setFlt(PlayerRef, ".lath.sls.spells." + spell_id + ".study.min_progress", progress)

EndFunction

;Ex de saida: .lath.sls.spells.oakflesh.study.max_progress
Function Set_Study_Max_Progress(Actor PlayerRef, String spell_id,  float progress)
    JFormDB.setFlt(PlayerRef, ".lath.sls.spells." + spell_id + ".study.max_progress", progress)

EndFunction


;o form_id das magias muda conforme o tier. Isso é especialmente importante para
;magias novice e apprentice que podem ter upgrade
Function Set_Tier_FormID(Actor PlayerRef, String spell_id, int tier_current, Int FormID)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".form_id", FormID)

EndFunction

Function Set_Tier_Required_Magicka(Actor PlayerRef, String spell_id, int tier_current, Float required_magicka)
    JFormDB.setFlt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".required_magicka", required_magicka)

EndFunction

;Usa soulgem? 0 - Nao; 1 - Sim
Function Set_Tier_Material_Soulgem_Use(Actor PlayerRef, String spell_id, int tier_current, Int can_use)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.use", can_use)

EndFunction


Function Set_Tier_Material_Soulgem_FormID(Actor PlayerRef, String spell_id, int tier_current, Int formID)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.form_id", formID)

EndFunction

Function Set_Tier_Material_Soulgem_Amount(Actor PlayerRef, String spell_id, int tier_current, Int amount)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.amount", amount)

EndFunction

;Usa item? 0 - Nao; 1 - Sim
Function Set_Tier_Material_Item_Use(Actor PlayerRef, String spell_id, int tier_current, Int can_use)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.item.use", can_use)

EndFunction

Function Set_Tier_Material_Item_FormID(Actor PlayerRef, String spell_id, int tier_current, Int formID)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.item.form_id", formID)

EndFunction

Function Set_Tier_Material_Item_Amount(Actor PlayerRef, String spell_id, int tier_current, Int amount)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.item.amount", amount)

EndFunction

;Usa imgredient? 0 - Nao; 1 - Sim
Function Set_Tier_Material_Ingredient_Use(Actor PlayerRef, String spell_id, int tier_current, Int can_use)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.use", can_use)

EndFunction

Function Set_Tier_Material_Ingredient_FormID(Actor PlayerRef, String spell_id, int tier_current, Int formID)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.form_id", formID)

EndFunction

Function Set_Tier_Material_Ingredient_Amount(Actor PlayerRef, String spell_id, int tier_current, Int amount)
    JFormDB.setInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.amount", amount)

EndFunction

Function Debug_Config(String spell_id)
    Actor PlayerRef = Game.GetPlayer()

    ; Ler os valores imediatamente
    String name = JFormDB.getStr(PlayerRef, ".lath.sls.spells." + spell_id + ".name")
    int tier_base = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.base")
    int tier_current = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.current")
    int tier_max = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + ".tier.max")

    float graduate = JFormDB.getFlt(PlayerRef, ".lath.sls.spells." + spell_id +  ".study.graduate")
    float progress = JFormDB.getFlt(PlayerRef, ".lath.sls.spells." + spell_id +  ".study.current_progress")   

    Int form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".form_id")
    Float required_magicka = JFormDB.getFlt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".required_magicka")
    Int soulgem_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.form_id")
    Int item_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.item.form_id")
    Int ingredient_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.form_id")
    
    Int use_soulgem = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.use")
    if use_soulgem == 1 
        Debug.Notification("voce deve usar soulgem")
    else 
        Debug.Notification("voce NAO precisa usar soulgem")
    endif

    Int use_item = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.item.use")
    if use_item == 1 
        Debug.Notification("voce deve usar item")
    else 
        Debug.Notification("voce NAO precisa usar item")
    endif

    Int use_ingredient = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.use")
    if use_ingredient == 1
        Debug.Notification("voce deve usar ingredient")
    else 
        Debug.Notification("voce NAO precisa usar ingredient")
    endif

    Soulgem sg = Game.GetFormFromFile(soulgem_form_id, "Skyrim.esm") as SoulGem
    String soulgem_name = sg.GetName()
    MiscObject item = Game.GetFormFromFile(item_form_id, "Skyrim.esm") as MiscObject
    String item_name = item.GetName()
    Ingredient ig = Game.GetFormFromFile(ingredient_form_id, "Skyrim.esm") as Ingredient
    String ingredient_name = ig.GetName()


    Debug.Notification("name:" + name)
    Debug.Notification("tier_base:" + tier_base)
    Debug.Notification("tier_current:" + tier_current)
    Debug.Notification("tier_max:" + tier_max)
    Debug.Notification("graduate:" + graduate)
    Debug.Notification("current_progress:" + progress)

    Debug.Notification("form_id:" + form_id)
    Debug.Notification("required_magicka: " + required_magicka)
    Debug.Notification("soulgem_form_id:" + soulgem_form_id)
    Debug.Notification("soulgem_name:" + soulgem_name)
    Debug.Notification("item_name:" + item_name)
    Debug.Notification("ingredient_name:" + ingredient_name)

    tier_current = 2;apprentice

    form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".form_id")
    required_magicka = JFormDB.getFlt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".required_magicka")
    soulgem_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.form_id")
    item_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.item.form_id")
    ingredient_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.form_id")

    sg = Game.GetFormFromFile(soulgem_form_id, "Skyrim.esm") as SoulGem
    soulgem_name = sg.GetName()
    item = Game.GetFormFromFile(item_form_id, "Skyrim.esm") as MiscObject
    item_name = item.GetName()
    ig = Game.GetFormFromFile(ingredient_form_id, "Skyrim.esm") as Ingredient
    ingredient_name = ig.GetName()

    Debug.Notification("form_id:" + form_id)
    Debug.Notification("required_magicka: " + required_magicka)
    Debug.Notification("soulgem_form_id:" + soulgem_form_id)
    Debug.Notification("soulgem_name:" + soulgem_name)
    Debug.Notification("item_name:" + item_name)
    Debug.Notification("ingredient_name:" + ingredient_name)

    tier_current = 3; adept

    form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".form_id")
    required_magicka = JFormDB.getFlt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".required_magicka")
    soulgem_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.form_id")
    item_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.item.form_id")
    ingredient_form_id = JFormDB.getInt(PlayerRef, ".lath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.form_id")

    sg = Game.GetFormFromFile(soulgem_form_id, "Skyrim.esm") as SoulGem
    soulgem_name = sg.GetName()
    item = Game.GetFormFromFile(item_form_id, "Skyrim.esm") as MiscObject
    item_name = item.GetName()
    ig = Game.GetFormFromFile(ingredient_form_id, "Skyrim.esm") as Ingredient
    ingredient_name = ig.GetName()

    Debug.Notification("form_id:" + form_id)
    Debug.Notification("required_magicka: " + required_magicka)
    Debug.Notification("soulgem_form_id:" + soulgem_form_id)
    Debug.Notification("soulgem_name:" + soulgem_name)
    Debug.Notification("item_name:" + item_name)
    Debug.Notification("ingredient_name:" + ingredient_name)

endFunction

;o tempo de estudo é baseado no tier da magia tabela base
;   novice     - 4h
;   apprentice - 8h
;   adept      - 12h
;   expert     - 16h
;   master     - 20h
;======================================================================
;LISTA DE SPELL TOMES
;
;   .lath.sls.spells.[spell_id].name                            ;nome usado em mensagens - pode repetir
;   .lath.sls.spells.[spell_id].tier.base                       ;tier inicial da magia
;   .lath.sls.spells.[spell_id].tier.current                    ;tier atual em progressao
;   .lath.sls.spells.[spell_id].tier.max                    ;tier máximo que a spell pode atingir
;   .lath.sls.spells.[spell_id].study.min_progress              ;minimo de horas de progresso
;   .lath.sls.spells.[spell_id].study.max_progress              ;maximo de horas de progresso
;   .lath.sls.spells.[spell_id].study.graduate                  ;horas totais para aprender
;   .lath.sls.spells.[spell_id].study.current_progress          ;quantidade de horas estudadas atualmente. deve ser resetada a cada upgrade de tier
;
;   .lath.sls.spells.[spell_id].[current_tier].form_id                          ;referencia ao form da magia
;   .lath.sls.spells.[spell_id].[current_tier].required_magicka                          ;magicka requerida para iniciar o estudo
;   .lath.sls.spells.[spell_id].[current_tier].material.soulgem.use             ;usa soulgem? 0 - nao - 1 sim
;   .lath.sls.spells.[spell_id].[current_tier].material.soulgem.form_id         ;form_id soulgem 
;   .lath.sls.spells.[spell_id].[current_tier].material.soulgem.amount         ;quantidade
;   .lath.sls.spells.[spell_id].[current_tier].material.item.use                ;usa item? 0 - nao - 1 sim
;   .lath.sls.spells.[spell_id].[current_tier].material.item.form_id            ;form_id item 
;   .lath.sls.spells.[spell_id].[current_tier].material.item.amount            ;quantidade
;   .lath.sls.spells.[spell_id].[current_tier].material.ingredient.use          ;usa soulgem? 0 - nao - 1 sim
;   .lath.sls.spells.[spell_id].[current_tier].material.ingredient.form_id      ;form_id soulgem 
;   .lath.sls.spells.[spell_id].[current_tier].material.ingredient.amount      ;quantidade

;=====================================================================
Function Config_Oakflesh(Actor PlayerRef, String spell_name)



endFunction

;magicka requerida 
;os valores a seguir são justamente para forçar o player a usar
;equipamentos e poçoes para atingir a magicka necessaria
;
;novice:        60
;apprentice:    160
;adept:         260
;expert         400
;master         600

;tiers 
;0 - indefinido
;1 - novice
;2 - apprentice
;3 - adept
;4 - expert
;5 - master
Function Config_Embers(Actor PlayerRef, String spell_name)

    String spell_id = "embers"
    Int tier = 1

    Set_Name(PlayerRef, spell_id, spell_name)
    Set_Tier_Base(PlayerRef, spell_id, 1)
    Set_Tier_Current(PlayerRef, spell_id, 1)
    Set_Tier_Max(PlayerRef, spell_id, 3)
    Set_Study_Graduate(PlayerRef, spell_id, 4.0) ;define o padrao de horas de estudo para cada tier por padrao
    Set_Study_Current_Progress(PlayerRef, spell_id,  0.0) ;deve ser resetado a cada upgrade de tier(se houver)
    Set_Study_Min_Progress(PlayerRef, spell_id,  1.0)
    Set_Study_Max_Progress(PlayerRef, spell_id,  2.0)

    ;variaves para novice
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x04254b); id de embers - novice
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 60.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e2) ;petty soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0x033760) ;charcoal
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0) ;
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 0)


    tier = 2 ;apprentice
    ;variaveis para apprentice (upgrade)
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x042544); embers apprentice 
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 160.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e4) ;Lesser soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0x033760) ;charcoal
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0) ;
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 0)

    tier = 3; adept
    ;variaveis para adept(upgrade)
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x04254c);embers adept
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 260.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e6) ;Common soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0x033760) ;charcoal
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0) ;
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 0)
endFunction


Function Config_Frostbite(Actor PlayerRef, String spell_name)

    String spell_id = "frostbite"
    Int tier = 1

    Set_Name(PlayerRef, spell_id, spell_name)
    Set_Tier_Base(PlayerRef, spell_id, 1)
    Set_Tier_Current(PlayerRef, spell_id, 1)
    Set_Tier_Max(PlayerRef, spell_id, 3)
    Set_Study_Graduate(PlayerRef, spell_id, 4.0) ;define o padrao de horas de estudo para cada tier por padrao
    Set_Study_Current_Progress(PlayerRef, spell_id,  0.0) ;deve ser resetado a cada upgrade de tier(se houver)
    Set_Study_Min_Progress(PlayerRef, spell_id,  1.0)
    Set_Study_Max_Progress(PlayerRef, spell_id,  2.0)

    ;variaves para novice
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x02b96b); id de frostbite - vanilla
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 60.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e2) ;petty soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0) 
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 0)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 1) 
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0x01b3bd) ; snowberry
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 1)


    tier = 2 ;apprentice
    ;variaveis para apprentice (upgrade)
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x042550); frostbite apprentice 
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 160.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e4) ;Lesser soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0) 
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 0)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 1) 
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0x01b3bd) ; snowberry
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 1)

    tier = 3; adept
    ;variaveis para adept(upgrade)
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x042551);frostbite adept
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 260.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e6) ;Common soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0) 
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 0)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 1) 
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0x01b3bd) ; snowberry
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 1)

EndFunction


Function Config_Sparks(Actor PlayerRef, String spell_name)

    String spell_id = "sparks"
    Int tier = 1

    Set_Name(PlayerRef, spell_id, spell_name)
    Set_Tier_Base(PlayerRef, spell_id, 1)
    Set_Tier_Current(PlayerRef, spell_id, 1)
    Set_Tier_Max(PlayerRef, spell_id, 3)
    Set_Study_Graduate(PlayerRef, spell_id, 4.0) ;define o padrao de horas de estudo para cada tier por padrao
    Set_Study_Current_Progress(PlayerRef, spell_id,  0.0) ;deve ser resetado a cada upgrade de tier(se houver)
    Set_Study_Min_Progress(PlayerRef, spell_id,  1.0)
    Set_Study_Max_Progress(PlayerRef, spell_id,  2.0)

    ;variaves para novice
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x02dd2a); id de sparks - vanilla
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 60.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e2) ;petty soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0) 
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 0)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 1) 
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0x034cdf) ; salt pile
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 1)


    tier = 2 ;apprentice
    ;variaveis para apprentice (upgrade)
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x047655);  apprentice - LATH
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 160.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e4) ;Lesser soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0) 
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 0)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 1) 
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0x034cdf) ; salt pile
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 1)

    tier = 3; adept
    ;variaveis para adept(upgrade)
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x047656); adept - LATH
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 260.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e6) ;Common soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0) 
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 0)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 1) 
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0x034cdf) ; salt pile
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 1)

EndFunction


Function Config_Firebolt(Actor PlayerRef, String spell_name)

    String spell_id = "firebolt"
    Int tier = 2; apprentice

    Set_Name(PlayerRef, spell_id, spell_name)
    Set_Tier_Base(PlayerRef, spell_id, 2) ;apprentice
    Set_Tier_Current(PlayerRef, spell_id, 2)
    Set_Tier_Max(PlayerRef, spell_id, 3)
    Set_Study_Graduate(PlayerRef, spell_id, 8.0) ;define o padrao de horas de estudo para cada tier por padrao
    Set_Study_Current_Progress(PlayerRef, spell_id,  0.0) ;deve ser resetado a cada upgrade de tier(se houver)
    Set_Study_Min_Progress(PlayerRef, spell_id,  1.0)
    Set_Study_Max_Progress(PlayerRef, spell_id,  2.0)


    ;variaveis para apprentice (upgrade)
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x012fd0);  apprentice - vanilla
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 160.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e4) ;Lesser soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0) 
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 0)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 1) 
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0x05076e) ; Juniper Berries
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 1)

    tier = 3; adept
    ;variaveis para adept(upgrade)
    Set_Tier_FormID(PlayerRef, spell_id, tier, 0x04765b); adept - LATH
    Set_Tier_Required_Magicka(PlayerRef, spell_id, tier, 260.0)
    Set_Tier_Material_Soulgem_Use(PlayerRef, spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(PlayerRef, spell_id, tier, 0x02e4e6) ;Common soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(PlayerRef, spell_id, tier, 1)

    Set_Tier_Material_Item_Use(PlayerRef, spell_id, tier, 0)
    Set_Tier_Material_Item_FormID(PlayerRef, spell_id, tier, 0) 
    Set_Tier_Material_Item_Amount(PlayerRef, spell_id, tier, 0)

    Set_Tier_Material_Ingredient_Use(PlayerRef, spell_id, tier, 1) 
    Set_Tier_Material_Ingredient_FormID(PlayerRef, spell_id, tier, 0x05076e) ; Juniper Berries
    Set_Tier_Material_Ingredient_Amount(PlayerRef, spell_id, tier, 1)

EndFunction