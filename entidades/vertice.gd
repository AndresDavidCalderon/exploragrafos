class_name Vertice
extends Node

var aristas=[]

func _ready() -> void:
	get_parent().seleccion_cambiada.connect(seleccion_cambiada)

func _on_seleccion_pressed() -> void:
	get_parent().vertice_seleccionado(self)

func seleccion_cambiada(seleccion:Array) -> void:
	if seleccion.has(self):
		$TickSeleccionado.show()
	else:
		$TickSeleccionado.hide()

func eliminar() -> void:
	for arista in aristas:
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