extends Control

var coloreado=false


func _ready() -> void:
    get_parent().set_tab_title(1,"Numero cromatico")
    Globals.grafo.grafo_cambiado.connect(actualizarContenido)
    visibility_changed.connect(actualizarContenido)


func actualizarContenido():
    for vertice in Globals.grafo.vertices:
        vertice.colorear(Color(1,1,1))
        vertice.get_node("ErrorBipartito").hide()
    
    if visible:
        if Globals.grafo.es_bipartito():
            $RichTextLabel.text="El grafo es bipartito."
        else:
            $RichTextLabel.text="El grafo no es bipartito."
        
        for vertice in Globals.grafo.vertices_rojos:
            vertice.colorear(Color(1,0,0))
        for vertice in Globals.grafo.vertices_azules:
            vertice.colorear(Color(0,0,1))
        for vertice in Globals.grafo.no_bipartito_por:
            vertice.get_node("ErrorBipartito").show()
        coloreado=true
    else:
        if coloreado:
            coloreado=false
