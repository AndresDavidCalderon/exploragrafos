extends Panel

@onready var mundo = get_node("/root/World")

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