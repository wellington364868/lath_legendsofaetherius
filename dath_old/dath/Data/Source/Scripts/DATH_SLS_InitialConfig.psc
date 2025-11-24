Scriptname DATH_SLS_InitialConfig extends Quest  

Import JFormDB
Import Utility

Event OnInit()
    

    ; agendar fallback para garantir que PlayerRef esteja pronto
    RegisterForSingleUpdate(10.0)
EndEvent

Function InitQuest()
    

    ; Aqui começa o setup real
    ;Config_Oakflesh("oakflesh")
    Config_Frostbite("Frostbite")
    Config_Flames("Flames")


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

    ;Debug_Config("flames")

EndEvent

;=========================================================================


Function Set_Name( String spell_id, String name)
    JFormDB.setStr(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".name", name)

EndFunction

Function Set_Tier_Base( String spell_id, String tier_base)
    JFormDB.setStr(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".tier.base", tier_base)

EndFunction

Function Set_Tier_Current( String spell_id, String tier_current)
    JFormDB.setStr(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".tier.current", tier_current)

EndFunction


;Ex de saida: .dath.sls.spells.oakflesh.study.graduate
Function Set_Study_Graduate( String spell_id, float graduate)
    JFormDB.setFlt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".study.graduate", graduate)

EndFunction

;Ex de saida: .dath.sls.spells.oakflesh.study.progress
Function Set_Study_Current_Progress( String spell_id,  float progress)
    JFormDB.setFlt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".study.current_progress", progress)

EndFunction

;Ex de saida: .dath.sls.spells.oakflesh.study.min_progress
Function Set_Study_Min_Progress( String spell_id,  float progress)
    JFormDB.setFlt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".study.min_progress", progress)

EndFunction

;Ex de saida: .dath.sls.spells.oakflesh.study.max_progress
Function Set_Study_Max_Progress( String spell_id,  float progress)
    JFormDB.setFlt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".study.max_progress", progress)

EndFunction


;o form_id das magias muda conforme o tier. Isso é especialmente importante para
;magias novice e apprentice que podem ter upgrade
Function Set_Tier_FormID( String spell_id, String tier_current, Int FormID)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".form_id", FormID)

EndFunction

Function Set_Tier_Required_Magicka( String spell_id, String tier_current, Float required_magicka)
    JFormDB.setFlt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".required_magicka", required_magicka)

EndFunction

;Usa soulgem? 0 - Nao; 1 - Sim
Function Set_Tier_Material_Soulgem_Use( String spell_id, String tier_current, Int can_use)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.use", can_use)

EndFunction


Function Set_Tier_Material_Soulgem_FormID( String spell_id, String tier_current, Int formID)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.form_id", formID)

EndFunction

Function Set_Tier_Material_Soulgem_Amount( String spell_id, String tier_current, Int amount)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.amount", amount)

EndFunction

;Usa item? 0 - Nao; 1 - Sim
Function Set_Tier_Material_Item_Use( String spell_id, String tier_current, Int can_use)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".material.item.use", can_use)

EndFunction

Function Set_Tier_Material_Item_FormID( String spell_id, String tier_current, Int formID)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".material.item.form_id", formID)

EndFunction

Function Set_Tier_Material_Item_Amount( String spell_id, String tier_current, Int amount)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".material.item.amount", amount)

EndFunction

;Usa imgredient? 0 - Nao; 1 - Sim
Function Set_Tier_Material_Ingredient_Use( String spell_id, String tier_current, Int can_use)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.use", can_use)

EndFunction

Function Set_Tier_Material_Ingredient_FormID( String spell_id, String tier_current, Int formID)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.form_id", formID)

EndFunction

Function Set_Tier_Material_Ingredient_Amount( String spell_id, String tier_current, Int amount)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.amount", amount)

EndFunction

Function Debug_Config(String spell_id)
    Actor PlayerRef = Game.GetPlayer()

    ; Ler os valores imediatamente
    String name = JFormDB.getStr(PlayerRef, ".dath.sls.spells." + spell_id + ".name")
    String tier_base = JFormDB.getStr(PlayerRef, ".dath.sls.spells." + spell_id + ".tier.base")
    String tier_current = JFormDB.getStr(PlayerRef, ".dath.sls.spells." + spell_id + ".tier.current")
    float graduate = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id +  ".study.graduate")
    float progress = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id +  ".study.current_progress")   

    Int form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".form_id")
    Float required_magicka = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".required_magicka")
    Int soulgem_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.form_id")
    Int item_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.item.form_id")
    Int ingredient_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.form_id")
    
    Int use_soulgem = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.use")
    if use_soulgem == 1 
        Debug.Notification("voce deve usar soulgem")
    else 
        Debug.Notification("voce NAO precisa usar soulgem")
    endif

    Int use_item = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.item.use")
    if use_item == 1 
        Debug.Notification("voce deve usar item")
    else 
        Debug.Notification("voce NAO precisa usar item")
    endif

    Int use_ingredient = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.use")
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
    Debug.Notification("graduate:" + graduate)
    Debug.Notification("current_progress:" + progress)

    Debug.Notification("form_id:" + form_id)
    Debug.Notification("required_magicka: " + required_magicka)
    Debug.Notification("soulgem_form_id:" + soulgem_form_id)
    Debug.Notification("soulgem_name:" + soulgem_name)
    Debug.Notification("item_name:" + item_name)
    Debug.Notification("ingredient_name:" + ingredient_name)

    tier_current = "apprentice"

    form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".form_id")
    required_magicka = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".required_magicka")
    soulgem_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.form_id")
    item_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.item.form_id")
    ingredient_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.form_id")

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

    tier_current = "adept"

    form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".form_id")
    required_magicka = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".required_magicka")
    soulgem_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.soulgem.form_id")
    item_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.item.form_id")
    ingredient_form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".material.ingredient.form_id")

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
;   .dath.sls.spells.[spell_id].name                            ;nome usado em mensagens - pode repetir
;   .dath.sls.spells.[spell_id].tier.base                       ;tier inicial da magia
;   .dath.sls.spells.[spell_id].tier.current                    ;tier atual em progressao
;   .dath.sls.spells.[spell_id].study.min_progress              ;minimo de horas de progresso
;   .dath.sls.spells.[spell_id].study.max_progress              ;maximo de horas de progresso
;   .dath.sls.spells.[spell_id].study.graduate                  ;horas totais para aprender
;   .dath.sls.spells.[spell_id].study.current_progress          ;quantidade de horas estudadas atualmente. deve ser resetada a cada upgrade de tier
;
;   .dath.sls.spells.[spell_id].[current_tier].form_id                          ;referencia ao form da magia
;   .dath.sls.spells.[spell_id].[current_tier].required_magicka                          ;magicka requerida para iniciar o estudo
;   .dath.sls.spells.[spell_id].[current_tier].material.soulgem.use             ;usa soulgem? 0 - nao - 1 sim
;   .dath.sls.spells.[spell_id].[current_tier].material.soulgem.form_id         ;form_id soulgem 
;   .dath.sls.spells.[spell_id].[current_tier].material.soulgem.amount         ;quantidade
;   .dath.sls.spells.[spell_id].[current_tier].material.item.use                ;usa item? 0 - nao - 1 sim
;   .dath.sls.spells.[spell_id].[current_tier].material.item.form_id            ;form_id item 
;   .dath.sls.spells.[spell_id].[current_tier].material.item.amount            ;quantidade
;   .dath.sls.spells.[spell_id].[current_tier].material.ingredient.use          ;usa soulgem? 0 - nao - 1 sim
;   .dath.sls.spells.[spell_id].[current_tier].material.ingredient.form_id      ;form_id soulgem 
;   .dath.sls.spells.[spell_id].[current_tier].material.ingredient.amount      ;quantidade

;=====================================================================
Function Config_Oakflesh(String spell_name)

    Actor PlayerRef = Game.GetPlayer()

endFunction


Function Config_Flames(String spell_name)
    Actor PlayerRef = Game.GetPlayer()

    String spell_id = "flames"
    String tier = "novice"

    Set_Name(spell_id, spell_name)
    Set_Tier_Base(spell_id, "novice")
    Set_Tier_Current( spell_id, "novice")
    Set_Study_Graduate(spell_id, 4.0) ;define o padrao de horas de estudo para cada tier por padrao
    Set_Study_Current_Progress(spell_id,  0.0) ;deve ser resetado a cada upgrade de tier(se houver)
    Set_Study_Min_Progress(spell_id,  1.0)
    Set_Study_Max_Progress(spell_id,  2.0)

    ;variaves para novice
    Set_Tier_FormID(spell_id, tier, 0x012fcd); id de flames vanilla
    Set_Tier_Required_Magicka(spell_id, tier, 80.0)
    Set_Tier_Material_Soulgem_Use(spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(spell_id, tier, 0x02e4e2) ;petty soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(spell_id, tier, 1)

    Set_Tier_Material_Item_Use(spell_id, tier, 1)
    Set_Tier_Material_Item_FormID(spell_id, tier, 0x033760) ;charcoal
    Set_Tier_Material_Item_Amount(spell_id, tier, 1)

    Set_Tier_Material_Ingredient_Use(spell_id, tier, 0)
    Set_Tier_Material_Ingredient_FormID(spell_id, tier, 0) ;
    Set_Tier_Material_Ingredient_Amount(spell_id, tier, 0)


    tier = "apprentice"
    ;variaveis para apprentice (upgrade)
    Set_Tier_FormID(spell_id, tier, 0x023f30); DATH flames apprentice 
    Set_Tier_Required_Magicka(spell_id, tier, 120.0)
    Set_Tier_Material_Soulgem_Use(spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(spell_id, tier, 0x02e4e4) ;Lesser soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(spell_id, tier, 1)

    Set_Tier_Material_Item_Use(spell_id, tier, 1)
    Set_Tier_Material_Item_FormID(spell_id, tier, 0x033760) ;charcoal
    Set_Tier_Material_Item_Amount(spell_id, tier, 1)

    Set_Tier_Material_Ingredient_Use(spell_id, tier, 0)
    Set_Tier_Material_Ingredient_FormID(spell_id, tier, 0) ;
    Set_Tier_Material_Ingredient_Amount(spell_id, tier, 0)

    tier = "adept"
    ;variaveis para adept(upgrade)
    Set_Tier_FormID(spell_id, tier, 0x023f31);DATH flames adept
    Set_Tier_Required_Magicka(spell_id, tier, 200.0)
    Set_Tier_Material_Soulgem_Use(spell_id, tier, 1)
    Set_Tier_Material_Soulgem_FormID(spell_id, tier, 0x02e4e6) ;Common soulgem(vazia)
    Set_Tier_Material_Soulgem_Amount(spell_id, tier, 1)

    Set_Tier_Material_Item_Use(spell_id, tier, 1)
    Set_Tier_Material_Item_FormID(spell_id, tier, 0x033760) ;charcoal
    Set_Tier_Material_Item_Amount(spell_id, tier, 1)

    Set_Tier_Material_Ingredient_Use(spell_id, tier, 0)
    Set_Tier_Material_Ingredient_FormID(spell_id, tier, 0) ;
    Set_Tier_Material_Ingredient_Amount(spell_id, tier, 0)
endFunction


Function Config_Frostbite(String spell_name)
    Actor PlayerRef = Game.GetPlayer()

    String spell_id = "frostbite"
    String tier_base = "novice"

    Set_Name(spell_id, spell_name)
    Set_Tier_Base(spell_id, "novice")
    Set_Tier_Current( spell_id, "novice")

    ;variaves para novice
    Set_Tier_FormID(spell_id, "novice", 0x02b96b)


    ;variaveis para apprentice (upgrade)
    Set_Tier_FormID(spell_id, "apprentice", 0x02b96c)


    ;variaveis para adept(upgrade)
    Set_Tier_FormID(spell_id, "adept", 0x02b96d)

EndFunction