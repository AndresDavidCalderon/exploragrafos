extends InspectorPropertyEditor



func _on_line_edit_text_submitted(new_text: String) -> void:
	value_changed.emit(property_name,new_text)

func set_value(value):
	$LineEdit.text=value
