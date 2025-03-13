extends Camera2D

@export var velocidad_pan=1
@export var velocidad_zoom:float=1.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventPanGesture:
		position+=event.delta*velocidad_pan
	if event is InputEventMagnifyGesture:
		if event.factor>1.02 or event.factor<0.98:
			var eje_zoom=zoom.x
			var cambio = event.factor if event.factor>1 else -event.factor
			eje_zoom+=(cambio*velocidad_zoom)*0.01
			zoom=Vector2(eje_zoom,eje_zoom)

	if event is InputEventMouseMotion and Input.is_action_pressed("pan"):
		position-=event.relative*velocidad_pan
