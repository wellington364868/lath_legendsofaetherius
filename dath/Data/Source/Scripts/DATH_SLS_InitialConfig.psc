Scriptname DATH_SLS_InitialConfig extends Quest  

Import JFormDB
Import Utility

Event OnInit()
    

    ; agendar fallback para garantir que PlayerRef esteja pronto
    RegisterForSingleUpdate(10.0)
EndEvent

Function InitQuest()
    

    ; Aqui começa o setup real
    Config_Oakflesh("oakflesh")

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

    ; Ler os valores imediatamente
    String readEditor = JFormDB.getStr(PlayerRef, ".dath.sls.spells.oakflesh.editor_id")
    Float readHours = JFormDB.getFlt(PlayerRef, ".dath.sls.spells.oakflesh.study_hours")

    Debug.Notification("editor_id:" + readEditor)
    Debug.Notification("study_hours:" + readHours)
EndEvent



Function Set_Spelltome_EditorID( String spell_name, String editor_id)
    JFormDB.setStr(Game.GetPlayer(), ".dath.sls.spells." + spell_name + ".editor_id", editor_id)

EndFunction
Function Set_Spelltome_StudyHours(Actor PlayerRef, String spell_name, float study_hours)
    JFormDB.setFlt(Game.GetPlayer(), ".dath.sls.spells." + spell_name + ".study_hours", study_hours)

EndFunction



;======================================================================
;LISTA DE SPELL TOMES
;=====================================================================
Function Config_Oakflesh(String spell_name)

    Actor PlayerRef = Game.GetPlayer()

    Set_Spelltome_EditorID( spell_name, "oakflesh_spell_01")
    Set_Spelltome_StudyHours(PlayerRef, spell_name, 4.0)
endFunction