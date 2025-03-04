extends Control

var coloreado=false

var vertices_rojos:Array[Vertice]=[]
var vertices_azules:Array[Vertice]=[]
var no_bipartito_por:Array[Vertice]=[]

func _ready() -> void:
    get_parent().set_tab_title(1,"Numero cromatico")
    Globals.grafo.grafo_cambiado.connect(actualizarContenido)
    visibility_changed.connect(actualizarContenido)


func actualizarContenido():
    for vertice in Globals.grafo.vertices:
        vertice.colorear(Color(1,1,1))
        vertice.get_node("ErrorBipartito").hide()
    
    if visible:
        if es_bipartito():
            $RichTextLabel.text="El grafo es bipartito."
        else:
            $RichTextLabel.text="El grafo no es bipartito."
        
        for vertice in vertices_rojos:
            vertice.colorear(Color(1,0,0))
        for vertice in vertices_azules:
            vertice.colorear(Color(0,0,1))
        for vertice in no_bipartito_por:
            vertice.get_node("ErrorBipartito").show()
        coloreado=true
    else:
        if coloreado:
            coloreado=false

func es_bipartito():
    vertices_azules.clear()
    vertices_rojos.clear()
    no_bipartito_por.clear()
    for componente_conexo in Globals.grafo.obtener_componentes_conexos():
        var vertice_inicial:Vertice=componente_conexo[0]
        vertices_rojos.append(vertice_inicial)
        if not colorear_bipartito(vertice_inicial):
            return false
    return true

func colorear_bipartito(vertice:Vertice):
    if vertices_rojos.has(vertice):
        for arista in vertice.aristas:
            var vertice_opuesto=arista.opuesto(vertice)
            if vertices_rojos.has(vertice_opuesto):
                no_bipartito_por.append(vertice)
                no_bipartito_por.append(vertice_opuesto)
                return false
            if not vertices_azules.has(vertice_opuesto):
                vertices_azules.append(vertice_opuesto)
                if not colorear_bipartito(vertice_opuesto):
                    return false
    
    if vertices_azules.has(vertice):
        for arista in vertice.aristas:
            var vertice_opuesto=arista.opuesto(vertice)
            if vertices_azules.has(vertice_opuesto):
                no_bipartito_por.append(vertice)
                no_bipartito_por.append(vertice_opuesto)
                return false
            if not vertices_rojos.has(vertice_opuesto):
                vertices_rojos.append(vertice_opuesto)
                if not colorear_bipartito(vertice_opuesto):
                    return false
    
    return true