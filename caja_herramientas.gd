extends Panel

@onready var mundo = get_node("/root/World")

@onready var top_por_defecto=offset_top
@onready var bottom_por_defecto=offset_bottom

func _ready() -> void:
	actualizar_tamaño()
	get_viewport().size_changed.connect(actualizar_tamaño)
	

func actualizar_tamaño()->void:
	offset_top=top_por_defecto+DisplayServer.get_display_safe_area().position.y
	offset_bottom=bottom_por_defecto+DisplayServer.get_display_safe_area().position.y

func _on_world_estado_cambiado(nuevoEstado:int) -> void:
	if nuevoEstado!=mundo.Estados.ESPERA:
		$Herramientas.hide()
		$Cancelar.show()
		if nuevoEstado==mundo.Estados.ADDARISTA:
			$Cancelar.text="Listo"
		else:
			$Cancelar.text="Cancelar"
	else:
		$Herramientas.show()
		$Cancelar.hide()


func _on_verificar_margen_timeout() -> void:
	actualizar_tamaño()
