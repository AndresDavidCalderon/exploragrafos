extends Node

var inicio:Vertice
var fin:Vertice

func configurar(inicio_nuevo:Vertice,fin_nuevo:Vertice)->void:
    inicio=inicio_nuevo if inicio_nuevo.get_index()<fin_nuevo.get_index() else fin_nuevo
    fin=fin_nuevo if inicio_nuevo.get_index()<fin_nuevo.get_index() else inicio_nuevo
    inicio.aristas.append(self)
    fin.aristas.append(self)


    var linea=$Linea as Line2D
    var direccion:Vector2=inicio.global_position.direction_to(fin.global_position).normalized()*10

    var indice=inicio.aristas_a(fin).find(self)
    var offset:Vector2
    if indice!=0:
        if indice %2==0:
            offset=Vector2(0,10)
        else:
            offset=Vector2(0,-10)
        if indice>2:
            if indice%2==0:
                offset+=Vector2(0,(indice-2)*5)
            else:
                offset+=Vector2(0,(indice-1)*-5)
    
    offset=offset.rotated(direccion.angle())
    linea.points=[inicio.global_position+direccion+offset,fin.global_position-direccion+offset]

func eliminar()->void:
    inicio.aristas.erase(self)
    fin.aristas.erase(self)
    queue_free()
