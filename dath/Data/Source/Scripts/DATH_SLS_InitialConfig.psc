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
    Config_Icebite("Frostbite")


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

    Debug_Config("frostbite")

EndEvent

;=========================================================================


Function Set_SLS_Spell_Name( String spell_id, String name)
    JFormDB.setStr(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".name", name)

EndFunction

Function Set_SLS_Spell_Tier_Base( String spell_id, String tier_base)
    JFormDB.setStr(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".tier.base", tier_base)

EndFunction

Function Set_SLS_Spell_Tier_Current( String spell_id, String tier_current)
    JFormDB.setStr(Game.GetPlayer(), ".dath.sls.spells." + spell_id + ".tier.current", tier_current)

EndFunction



Function Set_SLS_Spell_Tier_FormID( String spell_id, String tier_current, Int FormID)
    JFormDB.setInt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".form_id", FormID)

EndFunction
;Ex de saida: .dath.sls.spells.oakflesh.novice.study.graduate
Function Set_SLS_Spell_Tier_Study_Graduate( String spell_id, String tier_current, float graduate)
    JFormDB.setFlt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".study.graduate", graduate)

EndFunction

;Ex de saida: .dath.sls.spells.oakflesh.novice.study.progress
Function Set_SLS_Spell_Tier_Study_Progress( String spell_id, String tier_current, float progress)
    JFormDB.setFlt(Game.GetPlayer(), ".dath.sls.spells." + spell_id + "." + tier_current + ".study.progress", progress)

EndFunction

Function Debug_Config(String spell_id)
    Actor PlayerRef = Game.GetPlayer()

    ; Ler os valores imediatamente
    String name = JFormDB.getStr(PlayerRef, ".dath.sls.spells." + spell_id + ".name")
    String tier_base = JFormDB.getStr(PlayerRef, ".dath.sls.spells." + spell_id + ".tier.base")
    String tier_current = JFormDB.getStr(PlayerRef, ".dath.sls.spells." + spell_id + ".tier.current")

    Int form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".form_id")
    float graduate = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".study.graduate")
    float progress = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".study.progress")

    Debug.Notification("name:" + name)
    Debug.Notification("tier_base:" + tier_base)
    Debug.Notification("tier_current:" + tier_current)
    Debug.Notification("form_id:" + form_id)
    Debug.Notification("graduate:" + graduate)
    Debug.Notification("progress:" + progress)

    tier_current = "apprentice"

    form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".form_id")
    graduate = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".study.graduate")
    progress = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".study.progress")

    Debug.Notification("name:" + name)
    Debug.Notification("tier_base:" + tier_base)
    Debug.Notification("tier_current:" + tier_current)
    Debug.Notification("form_id:" + form_id)
    Debug.Notification("graduate:" + graduate)
    Debug.Notification("progress:" + progress)

    tier_current = "adept"

    form_id = JFormDB.getInt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".form_id")
    graduate = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".study.graduate")
    progress = JFormDB.getFlt(PlayerRef, ".dath.sls.spells." + spell_id + "." + tier_current + ".study.progress")

    Debug.Notification("name:" + name)
    Debug.Notification("tier_base:" + tier_base)
    Debug.Notification("tier_current:" + tier_current)
    Debug.Notification("form_id:" + form_id)
    Debug.Notification("graduate:" + graduate)
    Debug.Notification("progress:" + progress)
endFunction

;======================================================================
;LISTA DE SPELL TOMES
;
;   .dath.sls.spells.[spell_id].name                            ;nome usado em mensagens - pode repetir
;   .dath.sls.spells.[spell_id].tier.base                       ;tier inicial da magia
;   .dath.sls.spells.[spell_id].tier.current                    ;tier atual em progressao

;   .dath.sls.spells.[spell_id].[current_tier].form_id          ;referencia ao form da magia
;   .dath.sls.spells.[spell_id].[current_tier].study.graduate      ;horas totais para aprender
;   .dath.sls.spells.[spell_id].[current_tier].study.progress   ;quantidade de horas estudadas atualmente
;=====================================================================
Function Config_Oakflesh(String spell_name)

    Actor PlayerRef = Game.GetPlayer()

endFunction


Function Config_Icebite(String spell_name)
    Actor PlayerRef = Game.GetPlayer()

    String spell_id = "frostbite"
    String tier_base = "novice"

    Set_SLS_Spell_Name(spell_id, spell_name)
    Set_SLS_Spell_Tier_Base(spell_id, "novice")
    Set_SLS_Spell_Tier_Current( spell_id, "novice")

    ;variaves para novice
    Set_SLS_Spell_Tier_FormID(spell_id, "novice", 0x02b96b)
    Set_SLS_Spell_Tier_Study_graduate(spell_id, "novice", 4.0)
    Set_SLS_Spell_Tier_Study_Progress(spell_id, "novice", 0.0)

    ;variaveis para apprentice (upgrade)
    Set_SLS_Spell_Tier_FormID(spell_id, "apprentice", 0x02b96c)
    Set_SLS_Spell_Tier_Study_graduate(spell_id, "apprentice", 8.0)
    Set_SLS_Spell_Tier_Study_Progress(spell_id, "apprentice", 4.0)

    ;variaveis para adept(upgrade)
    Set_SLS_Spell_Tier_FormID(spell_id, "adept", 0x02b96d)
    Set_SLS_Spell_Tier_Study_graduate(spell_id, "adept", 12.0)
    Set_SLS_Spell_Tier_Study_Progress(spell_id, "adept", 8.0)
endFunction