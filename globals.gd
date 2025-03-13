extends Node

var grafo

func _ready() -> void:
	var dpi=DisplayServer.screen_get_dpi()
	if dpi>100:
		var escala=dpi/250.0
		get_tree().root.content_scale_factor=escala
