extends Node

var grafo

func _ready() -> void:
    if OS.get_name()=="Android":
        load("res://main.tres").default_font_size=20