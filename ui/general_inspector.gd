extends Control

func _init() -> void:
	Globals.general_inspector=self

func _on_back_pressed() -> void:
	get_parent().set_inspector("GraphInspection")

func inspect(obj):
	get_parent().set_inspector("GeneralInspector")
	
