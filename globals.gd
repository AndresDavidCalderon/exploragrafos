extends Node

var grafo

func _ready() -> void:
	actualizar_tamaño()
	get_tree().root.size_changed.connect(actualizar_tamaño)

func actualizar_tamaño()->void:
	var dpi=DisplayServer.screen_get_dpi()
	if dpi>100:
		var escala=dpi/250.0
		get_tree().root.content_scale_factor=escala
