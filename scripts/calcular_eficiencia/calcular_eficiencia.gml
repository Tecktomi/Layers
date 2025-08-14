function calcular_eficiencia(red = control.null_red){
	if red.consumo = 0
		red.eficiencia = real(red.produccion > 0)
	else
		red.eficiencia = clamp(red.produccion / red.consumo, 0, 1)
}