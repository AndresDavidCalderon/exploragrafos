extends Node

signal estado_cambiado(nuevoEstado:Estados)
signal seleccion_cambiada(seleccion:Array)
signal grafo_cambiado()

enum Estados{
	ESPERA,
	ADDARISTA,
	ADDVERTICE,
	QUITARARISTA,
	QUITARVERTICE
}

@export var escenaVertice:PackedScene
@export var escenaArista:PackedScene

var multigrafo=false
var estado=Estados.ESPERA
var seleccion:Array=[Node]
var vertices=[]
var aristas=[]

func _init() -> void:
	Globals.grafo=self

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if estado==Estados.ADDVERTICE:
			var nuevoVertice=escenaVertice.instantiate()
			add_child(nuevoVertice)
			nuevoVertice.global_position=get_viewport().get_mouse_position()
			vertices.append(nuevoVertice)
			grafo_cambiado.emit()


func _on_add_arista_pressed() -> void:
	cambiar_estado(Estados.ADDARISTA)


func _on_add_vertice_pressed() -> void:
	cambiar_estado(Estados.ADDVERTICE)


func _on_cancelar_pressed() -> void:
	cambiar_estado(Estados.ESPERA)

func _on_quitar_vertice_pressed() -> void:
	cambiar_estado(Estados.QUITARVERTICE)


func cambiar_estado(nuevoEstado:Estados)->void:
	estado=nuevoEstado
	seleccion.clear()
	seleccion_cambiada.emit(seleccion)
	estado_cambiado.emit(nuevoEstado)

func limpiar_seleccion()->void:
	seleccion.clear()
	seleccion_cambiada.emit(seleccion)

func vertice_seleccionado(vertice:Vertice):
	if estado==Estados.QUITARVERTICE:
		vertices.erase(vertice)
		vertice.eliminar()
		grafo_cambiado.emit()
	if estado==Estados.ADDARISTA:
		if seleccion.has(vertice):
			seleccion.erase(vertice)
		else:
			seleccion.append(vertice)
		seleccion_cambiada.emit(seleccion)

		if seleccion.size()==2:
			var es_multiarista=seleccion[0].conectado_a(seleccion[1])
			if (not es_multiarista) or multigrafo:
				var arista=escenaArista.instantiate()
				add_child(arista)
				arista.configurar(seleccion[0],seleccion[1])
				aristas.append(arista)
				grafo_cambiado.emit()
			else:
				ToastParty.show({"text":"Un grafo simple no puede tener dos aristas entre los mismos vertices","duration":2})
			limpiar_seleccion()


func _on_multigrafo_toggled(toggled_on: bool) -> void:
	multigrafo=toggled_on

func obtener_componentes_conexos()->Array:
	var componentes_conexos=[]
	var vertices_por_explorar=vertices.duplicate()
	while vertices_por_explorar.size()>0:
		var vertice=vertices_por_explorar.pop_front()
		var componente_conexo=[vertice]
		añadir_vertice_y_vecinos_a_componente(vertice,componente_conexo)
		for explorado in componente_conexo:
			vertices_por_explorar.erase(explorado)
		componentes_conexos.append(componente_conexo)
	return componentes_conexos

func añadir_vertice_y_vecinos_a_componente(vertice,componente_conexo):
	for arista in vertice.aristas:
		var opuesto=arista.opuesto(vertice)
		if not componente_conexo.has(opuesto):
			componente_conexo.append(opuesto)
			añadir_vertice_y_vecinos_a_componente(opuesto,componente_conexo)
