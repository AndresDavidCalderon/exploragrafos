extends Control

func _ready() -> void:
	Globals.grafo.grafo_cambiado.connect(actualizar)
	actualizar()
	visibility_changed.connect(actualizar)

func actualizar():
	$RichTextLabel.text="Un grafo es planar si se pudiese dibujar sin cruzar aristas."
	var puede_ser_planar=true
	if (not vertice_grado_menor_a_6()) and not Globals.grafo.multigrafo:
		$RichTextLabel.text+="\nEl grafo no es planar, ya que todos sus vertices tienen grado mayor o igual a 6 y es simple."
		puede_ser_planar=false
	if puede_ser_planar:
		$RichTextLabel.text+="\nEl grafo puede ser planar, pero no sabemos."


# Esto significa que el grafo contiene 2 grupos de al menos 3 vertices, donde vertice en el grupo no se conecta con otro del grupo, y cada vertice de un grupo se conecta con todos los vertices del otro grupo.
# En otras palabras, el grafo contiene a K3,3.
func contiene_a_k33():
	pass

func vertice_grado_menor_a_6():
	for vertice in Globals.grafo.vertices:
		if vertice.aristas.size()<6:
			return true
	return false

func son_vertices_de_triangulo(a:Vertice,b:Vertice):
	for adyacente in a.obtener_adyacentes():
	   if b.obtener_adyacentes().has(adyacente):
			return true
	return false
