extends Control

var coloreado=true

func _ready() -> void:
    get_parent().set_tab_title(3,"Hamilton")
    Globals.grafo.grafo_cambiado.connect(actualizar)
    visibility_changed.connect(actualizar)
    actualizar()

func actualizar():
    $RichTextLabel.text="Un grafo es hamiltoniano si contiene un [b]circuito[/b] hamiltoniano, es decir, un ciclo que pase por todos los vertices del grafo exactamente una vez."
    if Globals.grafo.obtener_componentes_conexos().size()==1:
        var puede_tener_circuito=true
        var vertice_colgante=false
        for vertice in Globals.grafo.vertices:
            if vertice.aristas.size()==1:
                if not vertice_colgante:
                    $RichTextLabel.text+="\nEl grafo tiene un [color=#FC7D0D]vertice colgante[/color] (de grado 1) por tanto no tiene circuitos hamiltonianos"
                vertice.colorear(Color("#FC7D0D"))
                coloreado=true
                puede_tener_circuito=false
                vertice_colgante=true
        
        if Globals.grafo.es_bipartito():
            if Globals.grafo.vertices.size()%2!=0:
                $RichTextLabel.text+="\nEl grafo es bipartito y tiene un numero impar de vertices, por tanto no tiene circuitos hamiltonianos."
                puede_tener_circuito=false
        
        if puede_tener_circuito:
            $RichTextLabel.text+="\nEl grafo puede tener circuitos hamiltonianos, pero no tenemos manera de saber."

    else:
        $RichTextLabel.text="El grafo no es conexo, por tanto no tiene ni circuitos ni caminos hamiltonianos."
    
    if (not visible) and coloreado:
        for vertice in Globals.grafo.vertices:
            vertice.colorear(Color(1,1,1))
        coloreado=false