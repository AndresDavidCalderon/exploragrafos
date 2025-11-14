extends Panel

func set_inspector(which:String):
	for i in get_children():
		i.hide()
	get_node(which).show()
