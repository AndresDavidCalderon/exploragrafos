extends Control

enum Criterio{
	CANTIDAD_VERTICES,
	GRADOS,
	EULER,
	EULER_SIN_TRIANGULOS,
	NINGUNO
}

enum Resultado{
	PLANAR,
	NO_PLANAR,
	NO_SE_PUEDE_DETERMINAR
}

func _ready() -> void:
	Globals.grafo.grafo_cambiado.connect(actualizar)
	actualizar()
	visibility_changed.connect(actualizar)

func actualizar():
	$RichTextLabel.text="Un grafo es planar si se pudiese dibujar sin cruzar aristas."

	if Globals.grafo.vertices.size()==0:
		$RichTextLabel.text+="\nNo hay vertices en el grafo, es planar."
		return
	
	if Globals.grafo.vertices.size()<5:
		$RichTextLabel.text+="\nUn grafo con menos de 5 vertices es planar."
		return
	
	if Globals.grafo.multigrafo:
		$RichTextLabel.text+="\nEl analisis de planaridad para multigrafos no esta implementado."
		return
	
	var puede_ser_planar=true
	var seguro_planar=true
	for componente in Globals.grafo.obtener_componentes_conexos():
		var consulta = es_componente_planar(componente)
		var respuesta=consulta[0]
		var criterio=consulta[1]
		if respuesta==Resultado.NO_PLANAR:
			puede_ser_planar=false
			seguro_planar=false
			$RichTextLabel.text+="\nEl componente conexo con "+str(componente.size())+" vertices es no planar:"
			match criterio:
				Criterio.GRADOS:
					$RichTextLabel.text+="\nTodos los grados son mayores a 6."
				Criterio.EULER:
					$RichTextLabel.text+="\nEl componente no cumple con que la cantidad de aristas sea menor o igual a 3*vertices-6."
				Criterio.EULER_SIN_TRIANGULOS:
					$RichTextLabel.text+="\nEl componente no cumple con que la cantidad de aristas sea menor o igual a 2*vertices-4, sabiendo que no tiene triangulos"
		
		if respuesta==Resultado.NO_SE_PUEDE_DETERMINAR:
			seguro_planar=false
	
	if seguro_planar:
		$RichTextLabel.text+="\nEl grafo es planar."
	elif puede_ser_planar:
		$RichTextLabel.text+="\nEl grafo puede ser planar."
	else:
		$RichTextLabel.text+="\nEl grafo no es planar."


func es_componente_planar(componente: Array) -> Array:
	var respuesta=""

	if componente.size()<5:
		respuesta=[Resultado.PLANAR,Criterio.CANTIDAD_VERTICES]
		return respuesta

	var aristas=Globals.grafo.aristas_de_componente_conexo(componente)
	if (not vertice_grado_menor_a_6(componente)) and not Globals.grafo.multigrafo:
		return [Resultado.PLANAR,Criterio.GRADOS]

	if aristas.size()>3*componente.size()-6 and (not Globals.grafo.multigrafo) and componente.size()>3:
		return [Resultado.NO_PLANAR,Criterio.EULER]

	if (not contiene_triangulos(componente)) and (not aristas.size()<=2*componente.size()-4) and componente.size()>3 and not Globals.grafo.multigrafo:
		return [Resultado.NO_PLANAR,Criterio.EULER_SIN_TRIANGULOS]
	
	return [Resultado.NO_SE_PUEDE_DETERMINAR,Criterio.NINGUNO]


# Esto significa que el grafo contiene 2 grupos de al menos 3 vertices, donde vertice en el grupo no se conecta con otro del grupo, y cada vertice de un grupo se conecta con todos los vertices del otro grupo.
# En otras palabras, el grafo contiene a K3,3.
func contiene_a_k33():
	pass

func contiene_triangulos(componente:Array):
	for vertice in componente:
		for adyacente in vertice.obtener_adyacentes():
			if son_vertices_de_triangulo(vertice,adyacente):
				return true
	return false

func vertice_grado_menor_a_6(componente:Array):
	for vertice in componente:
		if vertice.aristas.size()<6:
			return true
	return false

func son_vertices_de_triangulo(a:Vertice,b:Vertice):
	for adyacente in a.obtener_adyacentes():
		if b.obtener_adyacentes().has(adyacente):
			return true
	return false
