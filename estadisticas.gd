extends Control

func _ready() -> void:
    get_parent().set_tab_title(0,"Estadisticas")
    Globals.grafo.grafo_cambiado.connect(actualizar)
    actualizar()
    visibility_changed.connect(actualizar)

func actualizar():
    $RichTextLabel.text="Este grafo tiene " + str(Globals.grafo.vertices.size()) + " vertices y " + str(Globals.grafo.aristas.size()) + " aristas."
    $RichTextLabel.text+="\n"
    $RichTextLabel.text+="Tiene " + str(Globals.grafo.obtener_componentes_conexos().size()) + " componentes conexos."