/*
═══════════════════════════════════════════════════════════════════════════════
                            SELECTOR DE TEXTO INTELIGENTE
                                  AutoHotkey v2.0
═══════════════════════════════════════════════════════════════════════════════

📋 DESCRIPCIÓN:
   Script que proporciona un selector de texto de doble nivel para insertar
   rápidamente textos predefinidos en cualquier aplicación. Ideal para respuestas
   frecuentes, firmas, datos de contacto, enlaces y cualquier texto repetitivo.

🎯 FUNCIONALIDADES:
   • Activación global con Win + Espacio desde cualquier aplicación
   • Interfaz de doble nivel: Categoría → Opción específica  
   • Carga automática de textos desde archivo CSV editable
   • Soporte completo para saltos de línea y formato
   • Pegado inteligente usando clipboard del sistema
   • Interfaz Always-On-Top para uso sin interrupciones

🚀 USO RÁPIDO:
   1. Presiona Win + Espacio en cualquier aplicación
   2. Selecciona una categoría (ej: Saludo, Cierre, Datos)
   3. Elige una opción específica (ej: Email Formal, Chat, Teléfono)
   4. Presiona "Pegar" o Enter
   5. El texto se inserta automáticamente con formato correcto

📁 ESTRUCTURA DE DATOS:
   Los textos se almacenan en "Textos.csv" con formato:
   Categoría|Opción|Texto
   
   Para saltos de línea usar: `r`n
   Ejemplo: "Hola,`r`n`r`nSaludos"

🔧 PERSONALIZACIÓN:
   • Edita Textos.csv para agregar/modificar contenido
   • Cambia el hotkey modificando la línea #Space::
   • Ajusta el archivo de datos en la variable ArchivoDatos

📝 AUTOR: Script desarrollado para automatizar textos frecuentes
📅 VERSIÓN: 1.0 - AutoHotkey v2.0 compatible
═══════════════════════════════════════════════════════════════════════════════
*/

#Requires AutoHotkey v2.0
#SingleInstance Force

; --- Variables Globales (solo las necesarias) ---
global ArchivoDatos := ".\Textos.csv"
global TextosEstructurados := Map()
global DDL_Opt := ""
global DDL_Cat := ""
global MyGui := ""

; --- Hotkey (Tecla de Acceso Rápido) ---
#Space:: MostrarSelectorDeTexto() ; Win + Barra Espaciadora

; --- Función 1: Cargar los datos (sin cambios) ---
CargarDatosDesdeArchivo() {
    global TextosEstructurados
    TextosEstructurados := Map() ; Limpiar el mapa
    try {
        if !FileExist(ArchivoDatos) {
            MsgBox("El archivo " ArchivoDatos " no existe.", "Error de Archivo", "IconX")
            return
        }
        
        LineasLeidas := 0
        Loop Read, ArchivoDatos
        {
            LineasLeidas++
            Fields := StrSplit(A_LoopReadLine, "|")
            if (Fields.Length >= 3) {
                Categoria := Fields[1]
                Opcion := Fields[2]
                Valor := Fields[3]  ; Dejar el valor tal como está en el CSV
                
                if !TextosEstructurados.Has(Categoria)
                    TextosEstructurados[Categoria] := Map()
                
                TextosEstructurados[Categoria][Opcion] := Valor
            }
        }
        
        ; Debug: Mostrar información de carga
        ; MsgBox("Líneas leídas: " LineasLeidas "`nCategorías cargadas: " TextosEstructurados.Count, "Debug Info", "Iconi")
        
    } catch as Error {
        MsgBox("Error al leer el archivo " ArchivoDatos ":`n" . Error.Message, "Error de Archivo", "IconX")
    }
}

; --- Función auxiliar para actualizar opciones ---
DoActualizarOpciones(Control, *) {
    global TextosEstructurados, DDL_Opt
    
    ; Crear array de opciones para la categoría seleccionada
    Opciones := []
    for Opcion in TextosEstructurados[Control.Text]
        Opciones.Push(Opcion)
    
    DDL_Opt.Delete()
    DDL_Opt.Add(Opciones)
    DDL_Opt.Choose(1)
    DDL_Opt.Enabled := true
}

; --- Función auxiliar para pegar texto ---
DoPegar(*) {
    global TextosEstructurados, DDL_Opt, DDL_Cat, MyGui
    
    CategoriaSeleccionada := DDL_Cat.Text
    OpcionSeleccionada := DDL_Opt.Text
    
    if !CategoriaSeleccionada || !OpcionSeleccionada {
        MyGui.Destroy()
        return
    }

    TextoFinal := TextosEstructurados[CategoriaSeleccionada][OpcionSeleccionada]
    
    ; CLAVE: Procesar el texto para que AutoHotkey interprete los caracteres especiales
    ; Cuando leemos del CSV, `r`n se guarda como texto literal, necesitamos convertirlo
    TextoFinal := StrReplace(TextoFinal, "``r``n", "`r`n")  ; Convertir texto literal a caracteres especiales reales
    
    ; Cerrar la GUI primero para devolver el foco a la ventana anterior
    MyGui.Destroy()
    
    ; Esperar un momento para que se procese el cierre y se devuelva el foco
    Sleep(300)
    
    ; Seguir el patrón de la documentación oficial
    A_Clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
    A_Clipboard := TextoFinal  ; AutoHotkey interpretará automáticamente `r`n como saltos de línea
    ClipWait  ; Wait for the clipboard to contain text.
    Send("^v")  ; Pegar el contenido
}

; --- Función 2: Lógica y GUI (Optimizada) ---
MostrarSelectorDeTexto() {
    global TextosEstructurados, DDL_Opt, DDL_Cat, MyGui
    CargarDatosDesdeArchivo()

    if (TextosEstructurados.Count == 0) {
        MsgBox("No se pudieron cargar categorías de texto.", "Error de Carga", "IconX")
        return
    }

    MyGui := Gui("+AlwaysOnTop", "Selector de Texto de 2 Niveles")
    
    ; Crear array de categorías para el DropDownList
    Categorias := []
    for Categoria in TextosEstructurados
        Categorias.Push(Categoria)
    
    ; Nivel 1: Categorías
    DDL_Cat := MyGui.Add("DropDownList", "vCategoria w150 Choose1", Categorias)
    
    ; Nivel 2: Opciones (inicialmente deshabilitado)
    DDL_Opt := MyGui.Add("DropDownList", "vTextoSeleccionado w250 Choose1 disabled x+10")

    ; --- DEFINICIÓN DE EVENTOS (Aquí está la magia) ---

    ; Evento 1: Qué hacer cuando la Categoría (DDL_Cat) cambia
    DDL_Cat.OnEvent("Change", DoActualizarOpciones)

    ; Evento 2: Qué hacer al pulsar "Pegar"
    MyGui.Add("Button", "Default y+10 w100", "Pegar").OnEvent("Click", DoPegar)

    ; --- Eventos de Cierre ---
    MyGui.Add("Button", "x+10", "Cancelar").OnEvent("Click", (*) => MyGui.Destroy())
    MyGui.OnEvent("Close", (*) => MyGui.Destroy())
    MyGui.OnEvent("Escape", (*) => MyGui.Destroy())

    ; --- Inicialización ---
    DoActualizarOpciones(DDL_Cat) ; Llama a la función una vez para llenar la 2ª lista al inicio
    MyGui.Show()
}