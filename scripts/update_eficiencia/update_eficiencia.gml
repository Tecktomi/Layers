function update_eficiencia(d = 0, capa = 0, index = 0, red = control.null_red){
	with control{
		if in(index, 8, 9) and d = capa
			red.recurso_produccion++
		else if in(index, 14) and d = 0
			red.recurso_produccion += 2
		else if in(index, 15, 16) and d = 0
			red.recurso_consumo++
		else if index = 17{
			if in(d, 3, 4, 5)
				red.recurso_consumo++
		}
		else{
			if in(index, 11, 12) and d = 0
				red.recurso_consumo++
			if in(index, 11, 13) and d = 1
				red.recurso_consumo++
			if in(index, 12, 13) and d = 2
				red.recurso_consumo++
		}
		for(var c = 0; c < ds_list_size(red.edificios_index[11]); c++){
			var temp_edificio = red.edificios_index[11][|c], e0 = eficiencia(temp_edificio.red[0]), e1 = eficiencia(temp_edificio.red[1])
			temp_edificio.red[3].recurso_produccion -= temp_edificio.produccion
			temp_edificio.produccion = min(e0, e1)
			temp_edificio.red[3].recurso_produccion += temp_edificio.produccion
		}
		for(var c = 0; c < ds_list_size(red.edificios_index[12]); c++){
			var temp_edificio = red.edificios_index[12][|c], e0 = eficiencia(temp_edificio.red[0]), e2 = eficiencia(temp_edificio.red[2])
			temp_edificio.red[4].recurso_produccion -= temp_edificio.produccion
			temp_edificio.produccion = min(e0, e2)
			temp_edificio.red[4].recurso_produccion += temp_edificio.produccion
		}
		for(var c = 0; c < ds_list_size(red.edificios_index[13]); c++){
			var temp_edificio = red.edificios_index[13][|c], e1 = eficiencia(temp_edificio.red[1]), e2 = eficiencia(temp_edificio.red[2])
			temp_edificio.red[5].recurso_produccion -= temp_edificio.produccion
			temp_edificio.produccion = min(e1, e2)
			temp_edificio.red[5].recurso_produccion += temp_edificio.produccion
		}
		for(var c = 0; c < ds_list_size(red.edificios_index[15]); c++){
			var temp_edificio = red.edificios_index[15][|c]
			temp_edificio.red[1].recurso_produccion -= temp_edificio.produccion
			temp_edificio.produccion = 3 * eficiencia(temp_edificio.red[0])
			temp_edificio.red[1].recurso_produccion += temp_edificio.produccion
		}
		for(var c = 0; c < ds_list_size(red.edificios_index[16]); c++){
			var temp_edificio = red.edificios_index[16][|c]
			temp_edificio.red[2].recurso_produccion -= temp_edificio.produccion
			temp_edificio.produccion = 3 * eficiencia(temp_edificio.red[0])
			temp_edificio.red[2].recurso_produccion += temp_edificio.produccion
		}
		for(var c = 0; c < ds_list_size(red.edificios_index[17]); c++){
			var temp_edificio = red.edificios_index[17][|c], c3 = eficiencia(temp_edificio.red[3]), c4 = eficiencia(temp_edificio.red[4]), c5 = eficiencia(temp_edificio.red[5])
			temp_edificio.red[6].recurso_produccion -= temp_edificio.produccion
			temp_edificio.produccion = min(c3, c4, c5)
			temp_edificio.red[6].recurso_produccion += temp_edificio.produccion
		}
	}
}