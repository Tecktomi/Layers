function update_eficiencia(){
	with control{
		//Red Rojo
		for(var a = 0; a < ds_list_size(redes_recurso[0]); a++){
			var red = redes_recurso[0][|a]
			red.produccion = ds_list_size(red.edificios_index[8]) + 2 * ds_list_size(red.edificios_index[14])
			red.consumo = ds_list_size(red.edificios_index[11]) + ds_list_size(red.edificios_index[12]) + ds_list_size(red.edificios_index[15]) + ds_list_size(red.edificios_index[16])
			calcular_eficiencia(red)
		}
		//Red Verde
		for(var a = 0; a < ds_list_size(redes_recurso[1]); a++){
			var red = redes_recurso[1][|a]
			red.produccion = ds_list_size(red.edificios_index[9])
			for(var b = 0; b < ds_list_size(red.edificios_index[15]); b++){
				var edificio = red.edificios_index[15][|b]
				edificio.produccion = 2 * edificio.red[0].eficiencia
				red.produccion += edificio.produccion
			}
			red.consumo = ds_list_size(red.edificios_index[11]) + ds_list_size(red.edificios_index[13])
			calcular_eficiencia(red)
		}
		//Red Azul
		for(var a = 0; a < ds_list_size(redes_recurso[2]); a++){
			var red = redes_recurso[2][|a]
			red.produccion = 0
			for(var b = 0; b < ds_list_size(red.edificios_index[16]); b++){
				var edificio = red.edificios_index[16][|b]
				edificio.produccion = 2 * edificio.red[0].eficiencia
				red.produccion += edificio.produccion
			}
			red.consumo = ds_list_size(red.edificios_index[12]) + ds_list_size(red.edificios_index[13])
			calcular_eficiencia(red)
		}
		//Red Amarillo
		for(var a = 0; a < ds_list_size(redes_recurso[3]); a++){
			var red = redes_recurso[3][|a]
			red.produccion = 0
			for(var b = 0; b < ds_list_size(red.edificios_index[11]); b++){
				var edificio = red.edificios_index[11][|b]
				edificio.produccion = min(edificio.red[0].eficiencia, edificio.red[1].eficiencia)
				red.produccion += edificio.produccion
			}
			red.consumo = ds_list_size(red.edificios_index[17])
			calcular_eficiencia(red)
		}
		//Red Magenta
		for(var a = 0; a < ds_list_size(redes_recurso[4]); a++){
			var red = redes_recurso[4][|a]
			red.produccion = 0
			for(var b = 0; b < ds_list_size(red.edificios_index[12]); b++){
				var edificio = red.edificios_index[12][|b]
				edificio.produccion = min(edificio.red[0].eficiencia, edificio.red[2].eficiencia)
				red.produccion += edificio.produccion
			}
			red.consumo = ds_list_size(red.edificios_index[17])
			calcular_eficiencia(red)
		}
		//Red Cian
		for(var a = 0; a < ds_list_size(redes_recurso[5]); a++){
			var red = redes_recurso[5][|a]
			red.produccion = 0
			for(var b = 0; b < ds_list_size(red.edificios_index[13]); b++){
				var edificio = red.edificios_index[13][|b]
				edificio.produccion = min(edificio.red[1].eficiencia, edificio.red[2].eficiencia)
				red.produccion += edificio.produccion
			}
			red.consumo = ds_list_size(red.edificios_index[17]) + ds_list_size(red.edificios_index[18])
			calcular_eficiencia(red)
		}
		//Red Blanco
		for(var a = 0; a < ds_list_size(redes_recurso[6]); a++){
			var red = redes_recurso[6][|a]
			red.produccion = 0
			for(var b = 0; b < ds_list_size(red.edificios_index[17]); b++){
				var edificio = red.edificios_index[17][|b]
				edificio.produccion = min(edificio.red[3].eficiencia, edificio.red[4].eficiencia, edificio.red[5].eficiencia)
				red.produccion += edificio.produccion
			}
			red.consumo = 0
			calcular_eficiencia(red)
		}
	}
}