extends Control

func _ready() -> void:
    Globals.grafo.grafo_cambiado.connect(actualizar)
    actualizar()
    visibility_changed.connect(actualizar)

func actualizar():
    pass