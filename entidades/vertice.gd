class_name Vertice
extends Node

var aristas=[]
var nombre=""

func _ready() -> void:
	get_parent().seleccion_cambiada.connect(seleccion_cambiada)
	nombre=str(get_index())

func _on_seleccion_pressed() -> void:
	get_parent().vertice_seleccionado(self)

func seleccion_cambiada(seleccion:Array) -> void:
	if seleccion.has(self):
		$TickSeleccionado.show()
	else:
		$TickSeleccionado.hide()

func eliminar() -> void:
	for arista in aristas.duplicate():
		arista.eliminar()
	queue_free()

func conectado_a(vertice:Vertice) -> bool:
	for arista in aristas:
		if arista.inicio==vertice or arista.fin==vertice:
			return true
	return false

func aristas_a(vertice:Vertice) -> Array:
	var aristas_seleccionadas=[]
	for arista in aristas:
		if arista.inicio==vertice or arista.fin==vertice:
			aristas_seleccionadas.append(arista)
	return aristas_seleccionadas

func colorear(color:Color) -> void:
	$Sprite2D.modulate=color

func obtener_adyacentes() ->Array:
	var adyacentes=[]
	for arista in aristas:
		var contrario=arista.contrario(self)
		if not adyacentes.has(contrario):
			adyacentes.append(contrario)
	return adyacentes
	
