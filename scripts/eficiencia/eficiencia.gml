function eficiencia(red = control.null_red){
	with control{
		if red.recurso_consumo = 0
			return 1
		else
			return clamp(red.recurso_produccion / red.recurso_consumo, 0, 1)
	}
}