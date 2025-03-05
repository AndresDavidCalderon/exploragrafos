extends Control

func _ready() -> void:
    get_parent().set_tab_title(2,"Euler")
    Globals.grafo.grafo_cambiado.connect(actualizar)
    visibility_changed.connect(actualizar)
    actualizar()

func actualizar():
    if Globals.grafo.obtener_componentes_conexos().size()==1:
        var grados_impares=0
        for vertice in Globals.grafo.vertices:
            if vertice.aristas.size()%2!=0:
                grados_impares+=1
        if grados_impares==0:
            $RichTextLabel.text="El grafo es conexo y tiene un circuito y camino euleriano."
        elif grados_impares==2:
            $RichTextLabel.text="El grafo es conexo y tiene un camino euleriano, pero no circuito."
        else:
            $RichTextLabel.text="El grafo es conexo, pero no tiene circuitos ni caminos eulerianos."
    else:
        $RichTextLabel.text="El grafo no es conexo, por tanto no tiene circuitos ni caminos eulerianos."